import 'package:flutter/material.dart';
import 'package:soul_humidity_app/ui/aparience_app.dart';
import 'package:soul_humidity_app/ui/screens/home_page.dart';
import 'package:soul_humidity_app/widgets/witgets_settings_screen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyles.encabezados),
        centerTitle: true,
        backgroundColor: ColorMyApp.accentColor,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),

        child: Column(
          children: [
            Spacer(),

            Row(
              spacing: 2,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.water_drop, size: 25),
                Text(
                  'Rango de humedad',
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ],
            ),

            RangedHumid(),

            Spacer(flex: 1),

            Row(
              spacing: 2,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.thermostat, size: 30),
                Text(
                  'Rango de temperaturas',
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ],
            ),

            RangedTemp(),

            Spacer(flex: 3),

            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Column(children: [BluethootBottom(), ThemeBottom()]),
            ),
          ],
        ),
      ),
    );
  }
}
