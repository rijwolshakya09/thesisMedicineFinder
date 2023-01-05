import 'package:flutter/cupertino.dart';

class CustomAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(width / 4, height - 40, width / 2, height - 20);
    path.quadraticBezierTo(3 / 4 * width, height, width, height - 20);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
