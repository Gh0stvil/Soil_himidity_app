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
        filled: true,
        hintText: "Email",
        prefix: Padding(padding: EdgeInsets.only(right: 1)),
        prefixIcon: Icon(Icons.email),
        labelStyle: TextStyle(color: ColorMyApp.textColorPrimary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ColorMyApp.accentColor, width: 2),
        ),
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ColorMyApp.accentColor, width: 2),
        ),
        filled: true,
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
