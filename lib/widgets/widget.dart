import 'package:flutter/material.dart';
import 'package:soul_humidity_app/ui/aparience_app.dart';

class EmailBox extends StatefulWidget {
  const EmailBox({super.key});

  @override
  State<EmailBox> createState() => _EmailBoxState();
}

class _EmailBoxState extends State<EmailBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Email",
        prefix: Padding(padding: EdgeInsets.only(right: 1)),
        prefixIcon: Icon(Icons.email),
        labelStyle: TextStyle(color: ColorMyApp.textColorPrimary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class PasswordBox extends StatefulWidget {
  const PasswordBox({super.key});

  @override
  State<PasswordBox> createState() => _PasswordBoxState();
}

class _PasswordBoxState extends State<PasswordBox> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: "Password",
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        labelStyle: TextStyle(color: ColorMyApp.textColorPrimary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
