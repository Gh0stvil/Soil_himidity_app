import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soul_humidity_app/ui/aparience_app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorMyApp.backgroundColor,
      appBar: AppBar(
        title: Text(
          'SoildHumidiy',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.dancingScript().fontFamily,
          ),
        ),
        backgroundColor: ColorMyApp.accentColor,
        toolbarHeight: 80,
        actions: [SettingBotton()],
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 60)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Humidity(), Temperatura()],
          ),
        ],
      ),
    );
  }
}

/// Widget para el botón de configuración
/// que se encuentra en la parte superior derecha de la pantalla.
class SettingBotton extends StatelessWidget {
  const SettingBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings, color: ColorMyApp.secondaryColor, size: 30),
      onPressed: () {
        // Acción al presionar el botón de configuración
      },
    );
  }
}

/// Widget que representa la pantalla principal de la aplicación
/// donde se muestra la humedad y la temperatura.
class Humidity extends StatefulWidget {
  const Humidity({super.key});

  @override
  State<Humidity> createState() => _HumidityState();
}

class _HumidityState extends State<Humidity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 170,
      decoration: BoxDecoration(
        color: ColorMyApp.secondaryColor,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Humedad',
              style: TextStyle(
                color: ColorMyApp.accentColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.abel().fontFamily,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              '60%',
              style: TextStyle(
                color: ColorMyApp.accentColor,
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.abel().fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Temperatura extends StatefulWidget {
  const Temperatura({super.key});

  @override
  State<Temperatura> createState() => _TemperaturaState();
}

class _TemperaturaState extends State<Temperatura> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 170,
      decoration: BoxDecoration(
        color: ColorMyApp.secondaryColor,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Temperatura',
              style: TextStyle(
                color: ColorMyApp.accentColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.abel().fontFamily,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              '60°c',
              style: TextStyle(
                color: ColorMyApp.accentColor,
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.abel().fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
