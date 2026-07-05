import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:go_router/go_router.dart';
import '../bloc/instagram_auth_bloc.dart';

class InstagramLoginPage extends StatefulWidget {
  const InstagramLoginPage({super.key});

  @override
  State<InstagramLoginPage> createState() => _InstagramLoginPageState();
}

class _InstagramLoginPageState extends State<InstagramLoginPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) async {
            if (url.contains('instagram.com/')) {
              await _checkAndExtractCookies();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.instagram.com/accounts/login/'));
  }

  Future<void> _checkAndExtractCookies() async {
    final cookies = await _controller.runJavaScriptReturningResult('document.cookie') as String;
    
    // Simple check if sessionid is present
    if (cookies.contains('sessionid')) {
      // In a real app, we'd parse and format as Netscape here or in Bloc
      // For now, passing raw cookies to Bloc
      if (mounted) {
        context.read<InstagramAuthBloc>().add(LoginCompleted(cookies));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InstagramAuthBloc, InstagramAuthState>(
      listener: (context, state) {
        if (state is AuthComplete) {
          context.pop();
        } else if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Login to Instagram')),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
