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
      body: SizedBox(
        width: double.infinity,
        height: 700,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 60)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Humidity(), Temperatura()],
            ),
            Animation(),
            Spacer(),
            // Padding para el botón de agua
            Container(
              height: 100,
              width: 350,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.large(
                  onPressed: () {},
                  backgroundColor: ColorMyApp.accentColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Riego Manual',
                        style: TextStyle(
                          color: ColorMyApp.secondaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.abel().fontFamily,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.water_drop,
                        color: ColorMyApp.secondaryColor,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
          // Padding para el título de la temperatura
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
          // Padding para separar el texto de la temperatura
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

class Animation extends StatefulWidget {
  const Animation({super.key});

  @override
  State<Animation> createState() => _AnimationState();
}

class _AnimationState extends State<Animation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorMyApp.secondaryColor,
          borderRadius: BorderRadius.circular(35),
        ),
        width: double.infinity,
        height: 300,
        child: Center(
          child: Align(
            alignment: Alignment(-0.25, 0.1),
            child: Image.asset(
              "assets/images/raf-rafs.gif",
              width: 250,
              height: 250,
            ),
          ),
        ),
      ),
    );
  }
}
