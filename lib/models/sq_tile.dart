import 'package:flutter/material.dart';

class SqTile extends StatelessWidget {
    final String imagePath;
    const SqTile({
      super.key,
      required this.imagePath,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(139, 180, 179, 173)
        ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}