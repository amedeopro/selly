import 'package:flutter/material.dart';
import 'package:selly/page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../resources/api_provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {

  VideoPlayerController? _controller;

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
  void initState() {
    super.initState();
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset("assets/video/coffee.mp4")
      ..initialize().then((_) {

        _controller?.play();
        _controller?.setLooping(true);

        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.fill,
                child: SizedBox(
                  width: _controller?.value.size.width ?? 0,
                  height: _controller?.value.size.height ?? 0,
                  child: VideoPlayer(_controller!),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(64.0),
              child: Column(
                children: [_welcomeWidget(), _signInButton(context)],
              ),
            ),
          ]
        ));
  }

  Widget _welcomeWidget() => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      );

  Widget _signInButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 2,
          backgroundColor: Colors.yellow.shade700,
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
