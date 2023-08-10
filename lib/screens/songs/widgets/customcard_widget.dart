import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StarGazerCustomCard extends StatelessWidget {
  const StarGazerCustomCard({
    super.key,
    required this.name,
    required this.imgPath,
  });

  final String name;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * .25,
        height: MediaQuery.of(context).size.height * .18,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 6,
              child: Container(
                  width: 66,
                  height: 74,
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
                      width: 1,
                    ),
                    image: DecorationImage(
                        image: AssetImage(imgPath), fit: BoxFit.cover),
                  ))),
          Positioned(
              top: 88,
              left: 0,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: GoogleFonts.inconsolata(
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 16,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
        ]));
  }
}
