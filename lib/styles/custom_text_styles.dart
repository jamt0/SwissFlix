import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle {
  static TextStyle title(Color color) {
    return GoogleFonts.nunito().copyWith(
      color: color,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    );
  }

  static TextStyle body(Color color) {
    return GoogleFonts.nunito().copyWith(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    );
  }
}
