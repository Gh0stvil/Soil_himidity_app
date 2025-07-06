import 'package:flutter/material.dart';

class AppState {
  static final ValueNotifier<String> humedad = ValueNotifier("0%");
  static final ValueNotifier<String> temperatura = ValueNotifier("0°C");
  static final ValueNotifier<String> dispositivo = ValueNotifier("Sin conexión");
}
