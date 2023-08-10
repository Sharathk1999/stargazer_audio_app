import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stargazer_app/screens/settings/widgets/rich_text_widget.dart';

import '../../constants/const.dart';

class ScreenPrivacyPolicy extends StatelessWidget {
  const ScreenPrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.inconsolata(),
        ),
        backgroundColor: bgColor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(FontAwesomeIcons.chevronLeft)),
      ),
      backgroundColor: bgColor,
      body: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/image/privacy_img.jpg'),
                radius: 50.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: StarGazerRichTextWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
