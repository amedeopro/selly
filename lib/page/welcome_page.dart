import 'package:flutter/material.dart';
import 'package:selly/page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/api_provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  final _provider = ApiProvider();

  Future<void> getToken() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    var token;
    await Future.delayed(Duration.zero, () {
      return SharedPreferences.getInstance().then((prefs) {
        return token = prefs.getString('token').toString();
      });
    });
    if (token != "") {
      _provider.checkIfUserIsLogged(context);
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ));
    }
  }

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: controller?.value,
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            /*Padding(
              padding: EdgeInsets.only(top: 48),
              child: Text(
                'Selly',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )*/
          ],
        ),
      );

  Widget _signInButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 2,
          backgroundColor: Colors.orange,
        ),
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
        onPressed: () async {
          /*Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          )*/

          await getToken();
        },
      );
}
