import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stargazer_app/screens/settings/screen_about.dart';
import 'package:stargazer_app/screens/settings/screen_privacy_policy.dart';

import '../../constants/const.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: GoogleFonts.inconsolata(),
        ),
        backgroundColor: bgColor,
        leading: IconButton(
            onPressed: () {}, icon: const Icon(FontAwesomeIcons.chevronLeft)),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/image/Stargazer_logo-bg.png'),
            backgroundColor: bgColor,
            radius: 32,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text(
                  'About StarGazer',
                  style: GoogleFonts.inconsolata(
                      fontSize: 15, color: Colors.black38),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Version',
              style: GoogleFonts.inconsolata(),
            ),
            subtitle: Text(
              '0.0.1',
              style: GoogleFonts.inconsolata(color: Colors.red),
            ),
          ),
          ListTile(
            title: Text(
              'Privacy Policy',
              style: GoogleFonts.inconsolata(),
            ),
            trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const ScreenPrivacyPolicy();
                    },
                  ));
                },
                icon: const Icon(FontAwesomeIcons.chevronRight)),
          ),
          ListTile(
            title: Text(
              'About Us',
              style: GoogleFonts.inconsolata(),
            ),
            trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const ScreenAboutUs();
                    },
                  ));
                },
                icon: const Icon(FontAwesomeIcons.chevronRight)),
          ),
          ListTile(
            title: Text(
              'Share App',
              style: GoogleFonts.inconsolata(),
            ),
            trailing: IconButton(
              onPressed: () async {
                try {
                  const appUrl =
                      'https://play.google.com/store/apps/details?id=in.sharath.stargazer_audio';
                  await Share.share(appUrl, subject: "stargazer app");
                } on Exception catch (e) {
                  log(
                    e.toString(),
                  );
                }
              },
              icon: const Icon(FontAwesomeIcons.shareNodes),
            ),
          ),
        ],
      ),
    );
  }
}
