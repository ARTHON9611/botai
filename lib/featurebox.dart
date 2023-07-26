import 'package:flutter/material.dart';
import 'pallete.dart';

Widget featurebox(String title, String text, String color) {
  dynamic paint;
  switch (color) {
    // ignore: constant_pattern_never_matches_value_type
    case 'first':
      {
        paint = Pallete.firstSuggestionBoxColor;
      }
    case 'second':
      {
        paint = Pallete.secondSuggestionBoxColor;
      }
    case 'third':
      {
        paint = Pallete.thirdSuggestionBoxColor;
      }
  }
  Pallete.firstSuggestionBoxColor;
  return Container(
    width: 300,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        border: Border.all(),
        color: paint,
        borderRadius: BorderRadius.circular(13)),
    child: Column(children: [
      Align(
          alignment: Alignment.topLeft,
          child: Text(title,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: text,
                  fontWeight: FontWeight.w600))),
      Text(
        text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      )
    ]),
  );
}
