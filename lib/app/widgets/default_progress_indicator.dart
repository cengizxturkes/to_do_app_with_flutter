import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/constants.dart';

class DefaultProgressIndicator extends StatelessWidget {
  final Color color;

  DefaultProgressIndicator({this.color = kPrimaryColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? CupertinoActivityIndicator(radius: 15)
          : CircularProgressIndicator(color: color),
    );
  }
}
