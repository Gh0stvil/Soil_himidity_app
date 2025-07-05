import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soul_humidity_app/ui/aparience_app.dart';
import 'package:soul_humidity_app/ui/screens/settings.dart';
import 'package:soul_humidity_app/widgets/app_state.dart';

/*
###########################################################
#                                                         #
#             Widget que muestra la Humedad               #
#                                                         #
########################################################### 
*/

class Humidity extends StatelessWidget {
  const Humidity({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 170,
      decoration: BoxDecoration(
        color: ColorMyApp.secondaryColor,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Text('Humedad', style: TextStyles.subtitulos),
          SizedBox(height: 20),
          ValueListenableBuilder<String>(
            valueListenable: AppState.humedad,
            builder: (context, valor, _) {
              return Text(valor, style: TextStyles.numeros);
            },
          ),
        ],
      ),
    );
  }
}

/*
###########################################################
#                                                         #
#             Widget que muestra la temperatura           #
#                                                         #
########################################################### 
*/

class Temperatura extends StatelessWidget {
  const Temperatura({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 170,
      decoration: BoxDecoration(
        color: ColorMyApp.secondaryColor,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Text('Tempeatura', style: TextStyles.subtitulos),
          SizedBox(height: 20),
          ValueListenableBuilder<String>(
          valueListenable: AppState.temperatura,
          builder: (context, valor, _) {
          return Text(valor, style: TextStyles.numeros);
  },
),

        ],
      ),
    );
  }
}

/*
###########################################################
#                                                         #
#       Widget que muestra la Animacion de la planta      #
#                                                         #
########################################################### 
*/

class Plant extends StatefulWidget {
  const Plant({super.key});

  @override
  State<Plant> createState() => _AnimationsState();
}

class _AnimationsState extends State<Plant> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: ColorMyApp.secondaryColor,
          borderRadius: BorderRadius.circular(35),
        ),

        //Contenedor de la imagen
        child: Center(
          child: Align(
            alignment: Alignment(-0.25, 0.1),
            child: Image.asset(
              "assets/images/raf-rafs.gif",
              width: 250,
              height: 250,
            ),
          ),
        ),
      ),
    );
  }
}

/*
###########################################################
#                                                         #
#       Widget que muestra El boton de settings           #
#                                                         #
########################################################### 
*/

class SettingBotton extends StatelessWidget {
  const SettingBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings, color: ColorMyApp.secondaryColor, size: 30),
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const Settings()),
        );
      },
    );
  }
}
