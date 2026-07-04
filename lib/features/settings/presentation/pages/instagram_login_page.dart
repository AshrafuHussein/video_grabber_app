import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            if (url.contains('instagram.com/') && !url.contains('accounts/login')) {
              // Potential successful login
              final cookieManager = WebViewCookieManager();
              final cookies = await cookieManager.getCookies(
                domain: Uri.parse('https://www.instagram.com'),
              );

              if (cookies.any((c) => c.name == 'sessionid')) {
                if (mounted) {
                  context.read<InstagramAuthBloc>().add(LoginCompleted(cookies));
                }
              }
            }
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.instagram.com/accounts/login/'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InstagramAuthBloc, InstagramAuthState>(
      listener: (context, state) {
        if (state is AuthComplete) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Instagram Login Successful')),
          );
          context.pop();
        } else if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Failed: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Instagram Login'),
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
