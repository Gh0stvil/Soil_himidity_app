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
