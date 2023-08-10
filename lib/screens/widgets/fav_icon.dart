// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stargazer_app/constants/const.dart';
import 'package:stargazer_app/functions/fav_functions.dart';
import 'package:stargazer_app/model/song_model.dart';

class FavIcon extends StatefulWidget {
  AllSongModel currentSong;
  bool isFavorite;

  FavIcon({super.key, required this.currentSong, required this.isFavorite});

  @override
  State<FavIcon> createState() => _FavIconState();
}

class _FavIconState extends State<FavIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          setState(
            () {
              if (widget.isFavorite) {
                widget.isFavorite = false;
                removeFavorite(widget.currentSong);
                showCustomSnackBar(context, "Removed From ❤️",
                    textColor: Colors.white,
                    backgroundColor: Colors.black54.withAlpha(100));
                //add a snackbar here
              } else {
                widget.isFavorite = true;
                addToFavorite(widget.currentSong);
                //add a snackbar here
                showCustomSnackBar(context, "Added to ❤️",
                    textColor: Colors.white,
                    backgroundColor: Colors.redAccent.withAlpha(100));
              }
            },
          );
        },
        child: (widget.isFavorite)
            ? const Icon(
                FontAwesomeIcons.heartCircleCheck,
                color: Color.fromARGB(255, 244, 116, 116),
              )
            : const Icon(
                FontAwesomeIcons.heartCircleCheck,
                color: Color.fromARGB(255, 244, 116, 116),
              ),
      ),
    );
  }

  void showCustomSnackBar(BuildContext context, String message,
      {Color backgroundColor = Colors.black54,
      Color textColor = Colors.white}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(width: 1, color: bgColor2)),
        backgroundColor: backgroundColor,
        duration: const Duration(milliseconds: 500),
        content: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            message,
            style: GoogleFonts.inconsolata(
                color: textColor, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
