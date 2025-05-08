import 'package:flutter/material.dart';
import 'package:soul_humidity_app/ui/aparience_app.dart';
import 'package:soul_humidity_app/widgets/botones.dart';
import 'package:soul_humidity_app/widgets/cajas_de_texto.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 320,
              height: 670,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginImage(),Text("SoildHumidity", style: TextStyle(color: ColorMyApp.accentColor, fontSize: 35, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.dancingScript().fontFamily),),
                  Spacer(),
                  Column(
                    spacing: 20,
                    children: [
                      EmailBox(),PasswordBox(),
                      SizedBox(width: double.infinity, height: 55, child: SingIn()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LoginImage extends StatelessWidget {
  const LoginImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Image.asset("assets/images/logo 1 transparente.png", width: 350, height: 350, color: ColorMyApp.accentColor),
    );
  }
}
