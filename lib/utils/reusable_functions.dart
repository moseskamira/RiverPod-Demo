import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReUsableFunctions {
  static SnackBar awesomeSnackBar(
      String? title, String message, type, BuildContext context) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 4),
      padding: EdgeInsets.zero,
      width: MediaQuery.sizeOf(context).width,
      content: AwesomeSnackbarContent(
        message: message,
        contentType: type,
        title: title ?? '',
        color: Colors.blue,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        messageTextStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
