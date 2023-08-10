import 'package:flutter/material.dart';

class StarGazerCustomCircleWidget extends StatelessWidget {
  const StarGazerCustomCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 74,
        height: 76,
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
            image: const DecorationImage(
                image: AssetImage('assets/image/vinyl-player.jpg'),
                fit: BoxFit.cover)));
  }
}
