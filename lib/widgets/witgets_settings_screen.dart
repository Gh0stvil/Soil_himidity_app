import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

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
Future<void> botonBT(BuildContext context, void Function(String nuevoNombre) onDispositivoConectado)
 async {
  // Solicitar permisos necesarios
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.bluetoothScan,
    Permission.bluetoothConnect,
  ].request();

  bool permisosOk = statuses.values.every((status) => status.isGranted);
  if (!permisosOk) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Faltan permisos Bluetooth y ubicación")),
    );
    return;
  }

  // Verificar si el Bluetooth está encendido antes de escanear
final adapterState = await FlutterBluePlus.adapterState.first;
if (adapterState != BluetoothAdapterState.on) {
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Por favor, activa el Bluetooth antes de continuar")),
  );
  return;
}


  // Escanear dispositivos BLE
  await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
  List<ScanResult> dispositivos = [];

  // Escuchar resultados
  final subscription = FlutterBluePlus.scanResults.listen((results) {
    dispositivos = results;
  });

  // Esperar mientras escanea
  await Future.delayed(Duration(seconds: 6));
  await FlutterBluePlus.stopScan();
  await subscription.cancel();

  if (!context.mounted) return;

  // Mostrar ventana emergente con lista
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Selecciona tu módulo BLE"),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: dispositivos.length,
            itemBuilder: (context, index) {
              final dispositivo = dispositivos[index].device;
              final nombre = dispositivo.platformName.isNotEmpty
                  ? dispositivo.platformName
                  : dispositivo.remoteId.str;

              return ListTile(
                title: Text(nombre),
                subtitle: Text("ID: ${dispositivo.remoteId.str}"),
                onTap: () async {
                  if (!context.mounted) return;
                  Navigator.of(context).pop(); // Cerrar diálogo

                  try {
                    await dispositivo.connect();
                    if (!context.mounted) return;

                    // Actualizar nombre en la interfaz
                    onDispositivoConectado(nombre);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Conectado a $nombre")),
                    );
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error al conectar: $e")),
                    );
                  }
                },
              );
            },
          ),
        ),
      );
  },
);
}
