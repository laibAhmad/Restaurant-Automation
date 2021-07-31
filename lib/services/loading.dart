import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: Center(
        child: SpinKitFadingFour(
          color: Colors.white,
          shape: BoxShape.rectangle,
          size: 70.0,
        ),
      ),
    );
  }
}
