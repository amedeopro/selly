import 'package:flutter/material.dart';
import 'package:selly/page/login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(64.0),
      child: Column(
        children: [_welcomeWidget(), _signInButton(context)],
      ),
    ));
  }

  Widget _welcomeWidget() => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/logo_welcome.png'),
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsets.only(top: 48),
              child: Text(
                'Selly',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );

  Widget _signInButton(BuildContext context) => ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 48.0,
          ),
          child: Text(
            'INIZIA',
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        ),
      );
}
