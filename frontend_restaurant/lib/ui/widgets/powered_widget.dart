import 'package:flutter/material.dart';
import 'package:frontend/config/exports.dart';

getPoweredWidget() {
  return Container(
    width: double.infinity,
    color: colors.colorBlack,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          config.fonlesPowered,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
        ),
      ),
    ),
  );
}
