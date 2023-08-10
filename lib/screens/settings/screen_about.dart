import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/const.dart';

class ScreenAboutUs extends StatelessWidget {
  const ScreenAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'StarGazer',
          style: GoogleFonts.inconsolata(),
        ),
        backgroundColor: bgColor,
      ),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  text:
                      'Stargazer is an audio player app created by Sharath Kumar. Our goal is to provide users with an immersive and engaging audio experience through a simple and interactive user interface.\n\n',
                  style: GoogleFonts.inconsolata(color: Colors.black54),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'We believe that music and audio can be a powerful tool for relaxation, inspiration, and learning. We want to make it easy for users to discover new music and podcasts, and to enjoy their favorite audio content in a way that is both enjoyable and productive.\n\n',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                    TextSpan(
                      text:
                          'Stargazer features a variety of features that are designed to enhance the user experience, including:\n\n',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                    TextSpan(
                      text:
                          '- A simple and intuitive user interface that is easy to use and navigate.\n',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                    TextSpan(
                      text:
                          '- A powerful search engine that makes it easy to find new music and podcasts.\n',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                    TextSpan(
                      text:
                          '- A variety of playback options, including shuffle, repeat, and crossfade.\n',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                    TextSpan(
                      text:
                          '- A sleep timer that allows users to fall asleep to their favorite music.\n',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                    TextSpan(
                      text:
                          '- A lyrics feature that displays the lyrics of songs as they are playing.\n\n',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                    TextSpan(
                      text:
                          'We are constantly working to improve Stargazer and to add new features that our users will love. We believe that Stargazer is the best audio player app on the market, and we are committed to providing our users with the best possible experience.\n\n',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                    TextSpan(
                      text: 'Thank you for choosing Stargazer!\n\n',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                    TextSpan(
                      text:
                          'Here are some additional details about Stargazer:\n\n',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                    TextSpan(
                      text:
                          '- Stargazer is available for free on iOS and Android devices.\n',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                    TextSpan(
                      text: '- Stargazer is ad-free.\n',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                    TextSpan(
                      text:
                          '- Stargazer supports a variety of audio formats, including MP3, AAC, and FLAC.\n',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                    TextSpan(
                      text:
                          '- Stargazer can be used to stream music from a variety of sources, including Spotify, Apple Music, and SoundCloud.\n',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                    TextSpan(
                      text:
                          '- Stargazer can also be used to play local music files.\n\n',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                    TextSpan(
                      text: 'We hope you enjoy using Stargazer!',
                      style: GoogleFonts.inconsolata(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
