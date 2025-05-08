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
        backgroundColor: ColorMyApp.accentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),        
      ),
      child: Text("data"),
    );
  }
}
