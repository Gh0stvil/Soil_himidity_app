import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soul_humidity_app/widgets/app_state.dart';

/*
###########################################################
#                                                         #
#  Wistra El selector de rango de la humedad  #
#                                                         #
########################################################### 
*/

class RangedHumid extends StatelessWidget {
  const RangedHumid({super.key});

  void _enviarRango(RangeValues values) {
    final caracteristica = AppState.caracteristicaBLE;
    if (caracteristica != null) {
      final mensaje = "SET:HUM:${values.start.toInt()}-${values.end.toInt()}";
      caracteristica.write(mensaje.codeUnits);
      AppState.rango.value = values; // actualizar estado global
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RangeValues>(
      valueListenable: AppState.rango,
      builder: (context, valores, _) {
        return Column(
          children: [
            RangeSlider(
              values: valores,
              min: 10,
              max: 95,
              divisions: 85,
              labels: RangeLabels(
                '${valores.start.round()}%',
                '${valores.end.round()}%',
              ),
              onChanged: (nuevo) {
                AppState.rango.value = nuevo;
              },
              onChangeEnd: _enviarRango,
            ),
            Text(
              'Encender < ${valores.start.round()}% • Apagar > ${valores.end.round() - 5}%',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        );
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
Future<void> botonBT(BuildContext context, void Function(String nuevoNombre) onDispositivoConectado) async {
  final servicioUART = Guid("0000ffe0-0000-1000-8000-00805f9b34fb");
  final caracteristicaUART = Guid("0000ffe1-0000-1000-8000-00805f9b34fb");

  final permisos = await [
    Permission.bluetoothScan,
    Permission.bluetoothConnect,
    Permission.location,
  ].request();

  if (permisos.values.any((status) => !status.isGranted)) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Faltan permisos")),
    );
    return;
  }

  final estado = await FlutterBluePlus.adapterState.first;
  if (estado != BluetoothAdapterState.on) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Bluetooth desactivado")),
    );
    return;
  }

  await FlutterBluePlus.startScan(timeout: Duration(seconds: 5));
  List<ScanResult> resultados = [];
  final sub = FlutterBluePlus.scanResults.listen((r) => resultados = r);

  await Future.delayed(Duration(seconds: 6));
  await FlutterBluePlus.stopScan();
  await sub.cancel();
  if (!context.mounted) return;

  final seleccionado = await showDialog<BluetoothDevice>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("Dispositivos BLE encontrados"),
      content: SizedBox(
        height: 300,
        width: double.maxFinite,
        child: ListView(
          children: resultados.map((r) {
            final d = r.device;
            final nombre = d.platformName.isNotEmpty ? d.platformName : d.remoteId.str;
            return ListTile(
              title: Text(nombre),
              subtitle: Text(d.remoteId.str),
              onTap: () => Navigator.pop(context, d),
            );
          }).toList(),
        ),
      ),
    ),
  );

  if (seleccionado == null) return;

  try {
    await seleccionado.connect(timeout: Duration(seconds: 10));
    
    seleccionado.connectionState.listen((estado) {
  if (estado == BluetoothConnectionState.disconnected) {
    AppState.dispositivo.value = "Sin conexión";
    AppState.humedad.value = "0%";
    AppState.temperatura.value = "0°C";

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Dispositivo desconectado")),
      );
    }
  }
});

    final servicios = await seleccionado.discoverServices();
    final servicio = servicios.firstWhere((s) => s.uuid == servicioUART);
    final caracteristica = servicio.characteristics.firstWhere((c) => c.uuid == caracteristicaUART);
    AppState.caracteristicaBLE = caracteristica;
    await caracteristica.setNotifyValue(true);

// Enviar comando GET al microcontrolador
await caracteristica.write("GET\n".codeUnits); // modo seguro (sin 'withoutResponse')

// Escuchar toda la respuesta BLE (una sola vez, limpio y estructurado)
caracteristica.onValueReceived.listen((value) {
  final texto = String.fromCharCodes(value).trim();
  final lineas = texto.split(RegExp(r'[\r\n]+'));

  for (final linea in lineas) {
    if (linea.startsWith("RANGO_HUM:")) {
      final contenido = linea.replaceFirst("RANGO_HUM:", "");
      final partes = contenido.split("-");
      if (partes.length == 2) {
        final min = int.tryParse(partes[0]);
        final max = int.tryParse(partes[1]);
        if (min != null && max != null) {
          AppState.rango.value = RangeValues(min.toDouble(), max.toDouble());
        }
      }
    } else if (linea.startsWith("HUM:")) {
      AppState.humedad.value = "${linea.replaceFirst("HUM:", "").trim()}%";
    } else if (linea.startsWith("TEMP:")) {
      AppState.temperatura.value = "${linea.replaceFirst("TEMP:", "").trim()}°C";
    } else if (linea == "BOMBA:ON") {
      AppState.bombaActiva.value = true;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("💧 Bomba encendida durante 5s")),
        );
      }
    } else if (linea == "BOMBA:OFF") {
      AppState.bombaActiva.value = false;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ Bomba apagada")),
        );
      }
    } else if (linea == "BOMBA:YAACTIVA") {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("⚠️ La bomba ya está activa")),
        );
      }
    }
  }
});


    if (!context.mounted) return;
    onDispositivoConectado(seleccionado.platformName);
    AppState.dispositivo.value = seleccionado.platformName;
    onDispositivoConectado(seleccionado.platformName);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Conectado a ${seleccionado.platformName}")),
    );
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}

/*
###########################################################
#                                                         #
#       Witget que muestra El estado de la bomba          #
#                                                         #
########################################################### 
*/

class EstadoBomba extends StatelessWidget {
  const EstadoBomba({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppState.bombaActiva,
      builder: (context, activa, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.water_drop,
              color: activa ? Colors.blueAccent : Colors.grey,
              size: 28,
            ),
            SizedBox(width: 8),
            Text(
              activa ? "Bomba activa" : "Bomba apagada",
              style: TextStyle(
                fontSize: 16,
                color: activa ? Colors.blueAccent : Colors.grey.shade600,
              ),
            ),
          ],
        );
      },
    );
  }
}
