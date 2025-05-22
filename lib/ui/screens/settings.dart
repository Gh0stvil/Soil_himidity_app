import 'package:flutter/cupertino.dart';
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

      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Spacer(),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            Text(
              'Rango de humedad',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),

            RangedHumid(),

            Text(
              'Rango de temperaturas',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),

            RangedTemp(),

            Spacer(),
          ],
        ),
      ),
    );
  }
}
