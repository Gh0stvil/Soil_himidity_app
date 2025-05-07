import 'package:flutter/material.dart';
import 'package:soul_humidity_app/ui/aparience_app.dart';
import 'package:soul_humidity_app/widgets/widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 320,
          height: 670,
          decoration: BoxDecoration(color: ColorMyApp.accentColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 24,
                  color: ColorMyApp.textColorPrimary,
                ),
              ),
              Spacer(),
              EmailBox(),
              PasswordBox(),
              Text("data"),
            ],
          ),
        ),
      ),
    );
  }
}
