import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soul_humidity_app/widgets/app_state.dart';

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

    await caracteristica.setNotifyValue(true);
    caracteristica.onValueReceived.listen((value) {
  final texto = String.fromCharCodes(value).trim();
  final lineas = texto.split(RegExp(r'[\r\n]+'));

  for (final linea in lineas) {
    if (linea.startsWith("HUM:")) {
      final valor = linea.replaceFirst("HUM:", "").trim();
      AppState.humedad.value = "$valor%";
    } else if (linea.startsWith("TEMP:")) {
      final valor = linea.replaceFirst("TEMP:", "").trim();
      AppState.temperatura.value = "$valor°C";
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