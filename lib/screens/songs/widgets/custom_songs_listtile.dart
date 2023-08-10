import 'package:flutter/material.dart';

import '../../../constants/const.dart';

// ignore: must_be_immutable
class StarGazerListTile extends StatelessWidget {
  final int index;
  final BuildContext context;
  Widget? leading;
  Widget? title;
  Widget? subtitle;
  Widget? trailFavIcon;
  IconButton? trailListIcon;
  Widget? viz;
  StarGazerListTile({
    super.key,
    required this.index,
    required this.context,
    this.leading,
    this.title,
    this.subtitle,
    this.trailFavIcon,
    this.trailListIcon,
    this.viz,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: Wrap(
          spacing: 8,
          children: [
            trailFavIcon!,
            trailListIcon!,
          ],
        ),
      ),
    );
  }
}
