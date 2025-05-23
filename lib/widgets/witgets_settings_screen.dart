import 'package:flutter/material.dart';

/*
###########################################################
#                                                         #
#  Witget que muestra El selector de rango de la humedad  #
#                                                         #
########################################################### 
*/

class RangedHumid extends StatefulWidget {
  const RangedHumid({super.key});

  @override
  State<RangedHumid> createState() => _RangedHumidState();
}

class _RangedHumidState extends State<RangedHumid> {
  double _lowerValue = 25;
  double _upperValue = 50;

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: RangeValues(_lowerValue, _upperValue),
      min: 10,
      max: 95,
      divisions: 100,
      labels: RangeLabels('${_lowerValue.round()}%', '${_upperValue.round()}%'),
      onChanged: (values) {
        setState(() {
          _lowerValue = values.start;
          _upperValue = values.end;
        });
      },
    );
  }
}

/*
###########################################################
#                                                         #
#Witget que muestra El selector de rango de la Temperatura#
#                                                         #
########################################################### 
*/

class RangedTemp extends StatefulWidget {
  const RangedTemp({super.key});

  @override
  State<RangedTemp> createState() => _RangedTempState();
}

class _RangedTempState extends State<RangedTemp> {
  double _lowerValue = 38;
  double _upperValue = 50;

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: RangeValues(_lowerValue, _upperValue),
      min: 5,
      max: 50,
      divisions: 100,
      labels: RangeLabels(
        '${_lowerValue.round()}°C',
        '${_upperValue.round()}°C',
      ),
      onChanged: (values) {
        setState(() {
          _lowerValue = values.start;
          _upperValue = values.end;
        });
      },
    );
  }
}

/*
###########################################################
#                                                         #
#    Witget que muestra El Boton del tema del programa    #
#                                                         #
########################################################### 
*/

class ThemeBottom extends StatefulWidget {
  const ThemeBottom({super.key});

  @override
  State<ThemeBottom> createState() => _ThemeBottomState();
}

class _ThemeBottomState extends State<ThemeBottom> {
  bool _isDarkMode = false; // Estado del switch

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text('Modo oscuro'),
      value: _isDarkMode,
      onChanged: (value) {
        setState(() {
          _isDarkMode = value;
        });
        if (value) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('EPA DIEGO'),
                content: Text('ME MIERDA DIEGO'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Aceptar'),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}

/*
###########################################################
#                                                         #
#       Witget que muestra El Boton del bluethoot         #
#                                                         #
########################################################### 
*/

class BluethootBottom extends StatefulWidget {
  const BluethootBottom({super.key});

  @override
  State<BluethootBottom> createState() => _BluethootBottomState();
}

class _BluethootBottomState extends State<BluethootBottom> {
  bool _isOffTheBluetooth = false; // Estado del switch

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text('Bluetooth'),
      value: _isOffTheBluetooth,
      onChanged: (value) {
        setState(() {
          _isOffTheBluetooth = value;
        });
        if (value) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('EPA DIEGO'),
                content: Text('ME MIERDA DIEGO'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Aceptar'),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
