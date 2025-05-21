import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*
###########################################################
#                                                         #
#           Clases de Colores para estilizar              #
#                                                         #
########################################################### 
*/

class ColorMyApp {
  static const Color primaryColor = Color(0xFFA8D5BA);
  static const Color secondaryColor = Color(0xFFF2F2EB);
  static const Color accentColor = Color(0xFF3B7A57);
  static const Color backgroundColor = Color(0xFFA8D5BA);
  static const Color textColorPrimary = Color(0xFF333333);
  static const Color textColorSecondary = Color(0xFF666666);
  static const Color errorColor = Color(0xFFFF6B6B);
}

/*
###########################################################
#                                                         #
#           Clases de texto para estilizar                #
#                                                         #
########################################################### 
*/

class TextStyles {
  //Texto de el logo para las appbar
  static TextStyle encabezados = TextStyle(
    color: Colors.white,
    fontSize: 35,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.dancingScript().fontFamily,
  );

  //Texto para los porcentajes
  static TextStyle subtitulos = TextStyle(
    color: ColorMyApp.accentColor,
    fontSize: 25,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.abel().fontFamily,
  );
  //Texto para los botones, esta en color blanco
  static TextStyle subtitulos2 = TextStyle(
    color: ColorMyApp.secondaryColor,
    fontSize: 25,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.abel().fontFamily,
  );
  //Texto para los porcentajes
  static TextStyle numeros = TextStyle(
    color: ColorMyApp.accentColor,
    fontSize: 50,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.abel().fontFamily,
  );
  // texto exclusio del logo
  static TextStyle tituloApp = TextStyle(
    color: ColorMyApp.accentColor,
    fontSize: 35,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.dancingScript().fontFamily,
  );
}
