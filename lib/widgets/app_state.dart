import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class AppState {
  
  static final ValueNotifier<String> humedad = ValueNotifier("0%");
  static final ValueNotifier<String> temperatura = ValueNotifier("0°C");
  static final ValueNotifier<String> dispositivo = ValueNotifier("Sin conexión");
  static final ValueNotifier<RangeValues> rango = ValueNotifier(RangeValues(40, 80));
  static BluetoothCharacteristic? caracteristicaBLE;
  static final ValueNotifier<bool> bombaActiva = ValueNotifier(false);
  static final ValueNotifier<bool> rangoSincronizado = ValueNotifier(false);

}
