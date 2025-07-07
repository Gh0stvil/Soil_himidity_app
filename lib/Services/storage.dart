import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<void> guardarRango(int min, int max) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('humMin', min);
    await prefs.setInt('humMax', max);
  }

  static Future<RangeValues?> cargarRango() async {
    final prefs = await SharedPreferences.getInstance();
    final min = prefs.getInt('humMin');
    final max = prefs.getInt('humMax');
    if (min != null && max != null) {
      return RangeValues(min.toDouble(), max.toDouble());
    }
    return null;
  }
}
