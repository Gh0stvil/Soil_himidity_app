import 'package:flutter/material.dart';
import 'package:soul_humidity_app/ui/aparience_app.dart';

class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print("Botón presionado");
      },
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        backgroundColor: ColorMyApp.accentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      ),
      child: Text("data"),
    );
  }
}
