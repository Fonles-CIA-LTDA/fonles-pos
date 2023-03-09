import 'package:flutter/material.dart';

getScreenActions(child) {
  return SafeArea(
    child: Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 25,
            color: Colors.white,
          ),
          Expanded(
              child: Container(
            color: Colors.white,
            child: child,
          ))
        ],
      ),
    ),
  );
}
