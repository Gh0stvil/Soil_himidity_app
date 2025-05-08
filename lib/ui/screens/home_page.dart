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
        title: Text('SoildHumidiy',style: TextStyle(color: Colors.white,fontSize: 35, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.dancingScript().fontFamily)),
        backgroundColor: ColorMyApp.accentColor,
        toolbarHeight: 80,
       actions: [IconButton(
          icon: Icon(Icons.settings, color:ColorMyApp.secondaryColor, size: 30),
          onPressed: () {
            // Acción al presionar el botón de configuración
          },
        ),],
        ),
        body: Humidity(),
        );
  }
}

class Humidity extends StatefulWidget {
  const Humidity({super.key});

  @override
  State<Humidity> createState() => _HumidityState();
}

class _HumidityState extends State<Humidity>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    
      children: [
       Text("Humedad progeso"),
        Text("temperatura indicador"),
      ],
    ));
  }
}