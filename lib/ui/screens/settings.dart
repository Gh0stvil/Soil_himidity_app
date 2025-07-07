import 'package:flutter/material.dart';
import 'package:soul_humidity_app/Services/storage.dart';
import 'package:soul_humidity_app/ui/aparience_app.dart';
import 'package:soul_humidity_app/widgets/app_state.dart';
import 'package:soul_humidity_app/widgets/witgets_settings_screen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String nombreDispositivo = "Sin conectar";
@override
void initState() {
  super.initState();

  // 🔁 Cargar rango desde caché local si el Arduino no lo ha sincronizado aún
  Storage.cargarRango().then((rango) {
    if (rango != null && !AppState.rangoSincronizado.value) {
      AppState.rango.value = rango;
      AppState.rangoSincronizado.value = true;
      debugPrint("💾 Rango restaurado desde caché");
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes', style: TextStyles.encabezados),
        centerTitle: true,
        backgroundColor: ColorMyApp.accentColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // 🔗 Estado de conexión
            Row(
              children: [
                Icon(Icons.bluetooth, size: 20),
                SizedBox(width: 8),
                ValueListenableBuilder<String>(
                  valueListenable: AppState.dispositivo,
                  builder: (_, nombre, __) {
                    return Text(
                      'Dispositivo: $nombre',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ],
            ),

            const Spacer(flex: 1),

            //  Rango de humedad
            Row(
              children: [
                Icon(Icons.water_drop, size: 25),
                SizedBox(width: 8),
                Text(
                  'Rango de humedad',
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ],
            ),

            //  Sincronización del slider
            ValueListenableBuilder<bool>(
              valueListenable: AppState.rangoSincronizado,
              builder: (context, sincronizado, _) {
                if (!sincronizado) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 12),
                        Text(
                          "Sincronizando rango...",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  );
                } else {
                  return RangedHumid();
                }
              },
            ),

            const Spacer(flex: 2),

            //  Botón de conexión
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorMyApp.accentColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: TextStyle(
                    fontSize: 20,
                    foreground: Paint()..color = Colors.white,
                  ),
                ),
                onPressed: () {
                  botonBT(context, (String nuevoNombre) {
                    setState(() {
                      nombreDispositivo = nuevoNombre;
                    });
                  });
                },
                child: Text('Bluetooth'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
