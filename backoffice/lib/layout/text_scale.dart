import 'dart:math';
import 'package:flutter/material.dart';

double cappedTextScale(BuildContext context) {
  final textScaleFactor = MediaQuery.of(context).textScaleFactor;
  return max(textScaleFactor, 1);
}

double reducedTextScale(BuildContext context) {
  final textScaleFactor = MediaQuery.of(context).textScaleFactor;
  return textScaleFactor >= 1 ? (1 + textScaleFactor) / 2 : 1;
}