package com.ashtek.grabit

import com.chaquo.python.Python
import com.chaquo.python.android.AndroidPlatform
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.ashtek.grabit/extractor"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Initialize Python
        if (!Python.isStarted()) {
            Python.start(AndroidPlatform(this))
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "extract") {
                val url = call.argument<String>("url")
                val cookiePath = call.argument<String?>("cookiePath")

                if (url == null) {
                    result.error("INVALID_URL", "URL cannot be null", null)
                    return@setMethodCallHandler
                }

                // Run Python call on background thread
                CoroutineScope(Dispatchers.IO).launch {
                    try {
                        val py = Python.getInstance()
                        val module = py.getModule("extractor")
                        val pyResult = module.callAttr("extract", url, cookiePath)
                        
                        val mapResult = pyResult.asMap()
                        val resultMap = mutableMapOf<String, Any?>()
                        
                        for (entry in mapResult.entries) {
                            resultMap[entry.key.toString()] = entry.value?.toString()
                        }

                        // Success callback on main thread
                        withContext(Dispatchers.Main) {
                            if (resultMap.containsKey("error") && resultMap["error"] != null) {
                                result.error("EXTRACTION_ERROR", resultMap["error"] as String, null)
                            } else {
                                result.success(resultMap)
                            }
                        }
                    } catch (e: Exception) {
                        withContext(Dispatchers.Main) {
                            result.error("NATIVE_ERROR", e.message, null)
                        }
                    }
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
