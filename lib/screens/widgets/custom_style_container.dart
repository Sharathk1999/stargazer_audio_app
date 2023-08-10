import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StarGazerCustomStyleContainer extends StatelessWidget {
  const StarGazerCustomStyleContainer(
      {super.key, required this.name, required this.imgPath});
  final String name;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.92,
        height: MediaQuery.of(context).size.height * 0.32,
        child: Stack(children: <Widget>[
          Container(
            width: 320,
            height: 152,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(39),
                topRight: Radius.circular(39),
                bottomLeft: Radius.circular(39),
                bottomRight: Radius.circular(39),
              ),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, 4),
                    blurRadius: 4)
              ],
              border: Border.all(
                color: const Color.fromRGBO(0, 0, 0, 1),
                width: 4,
              ),
              image: DecorationImage(
                  image: AssetImage(imgPath), fit: BoxFit.fitWidth),
            ),
          ),
          Positioned(
              top: 80,
              left: 30,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: GoogleFonts.inconsolata(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 24,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Positioned(
              top: 190,
              left: 20,
              child: Text(
                "Music is the food of love - Shakespeare",
                style: GoogleFonts.inconsolata(color: Colors.black),
              ))
        ]));
  }
}
