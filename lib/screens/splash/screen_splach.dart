import 'package:flutter/material.dart';

import '../../constants/const.dart';
import '../../functions/get_permission.dart';
import '../../functions/song_fetch.dart';
import '../home/screen_home.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    appInitialization();
    checkAndRequestPermissions(retry: true);
    fetchSongFromDevice();
  }

  Future<void> appInitialization() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return const ScreenHome();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/image/Stargazer_logo-bg.png',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
