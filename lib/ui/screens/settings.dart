import 'package:flutter/material.dart';
import 'package:soul_humidity_app/ui/aparience_app.dart';
import 'package:soul_humidity_app/widgets/app_state.dart';
import 'package:soul_humidity_app/widgets/witgets_settings_screen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

String nombreDispositivo = "Sin conectar";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes', style: TextStyles.encabezados),
        centerTitle: true,
        backgroundColor: ColorMyApp.accentColor,
      ),


      body: 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          
          children: [
            SizedBox(
              width: 500,

              child: Row(
                children: [
                  Icon(Icons.bluetooth, size: 20),
                  ValueListenableBuilder<String>(
                    valueListenable: AppState.dispositivo,
                    builder: (_, nombre, __) {
                      return Text(
                        'Dispositivo: $nombre',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        textAlign: TextAlign.center,
                        );
                      },
                    )
                ],
              ),
            ),

            Spacer(flex: 2),

            Row(
              
              children: [
                Icon(Icons.water_drop, size: 25),
                SizedBox(width: 8), // Add spacing between icon and text
                Text(
                  'Rango de humedad',
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ],
            ),

            RangedHumid(),

            Spacer(flex: 1),
            
            Spacer(flex: 4),

            Padding(
  padding: const EdgeInsets.only(bottom: 30.0),
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorMyApp.accentColor,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      textStyle: TextStyle(fontSize: 20,foreground: Paint()..color = Colors.white),
    ),
    onPressed: () {
      botonBT(context, (String nuevoNombre) {
        setState(() {
          nombreDispositivo = nuevoNombre;
        });
      });
    },
    child: Text('Bluetooth'),
  ),
)
          ],
        ),
      ),
    );
  }
}
