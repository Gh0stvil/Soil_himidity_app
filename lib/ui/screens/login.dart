import 'package:flutter/material.dart';
import 'package:soul_humidity_app/ui/aparience_app.dart';
import 'package:soul_humidity_app/widgets/witgets_login_screen.dart';

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
                  LoginImage(),

                  Text("SoildHumidity", style: TextStyles.tituloApp),

                  Spacer(),

                  Column(
                    spacing: 20,
                    children: [
                      EmailBox(),
                      PasswordBox(),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: SingIn(),
                      ),
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
