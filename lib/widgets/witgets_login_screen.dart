import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soul_humidity_app/ui/aparience_app.dart';
import 'package:soul_humidity_app/ui/screens/home_page.dart';

/*
###########################################################
#                                                         #
#       Widget que muestra La imagen del logo             #
#                                                         #
########################################################### 
*/

class LoginImage extends StatelessWidget {
  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Image.asset(
        "assets/images/logo 1 transparente.png",
        width: 350,
        height: 350,
        color: ColorMyApp.accentColor,
      ),
    );
  }
}

/*
###########################################################
#                                                         #
#       Widget que muestra El boton de login              #
#                                                         #
########################################################### 
*/

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
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => const HomePage()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorMyApp.accentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text("LOGIN", style: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }
}

/*
###########################################################
#                                                         #
#     Widget que muestra La caja de texto "Email"         #
#                                                         #
########################################################### 
*/

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
        prefixIcon: Icon(Icons.email, color: ColorMyApp.accentColor),
        labelStyle: TextStyle(color: ColorMyApp.textColorPrimary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ColorMyApp.accentColor, width: 2),
        ),
      ),
    );
  }
}

/*
###########################################################
#                                                         #
#    Widget que muestra La caja de texto "Password"       #
#                                                         #
########################################################### 
*/

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
        prefixIcon: Icon(Icons.lock, color: ColorMyApp.accentColor),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          color: ColorMyApp.accentColor,
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),

        labelStyle: TextStyle(color: ColorMyApp.textColorPrimary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
