import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bluetooth_classic/bluetooth_classic.dart';

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
class BluetoothDeviceSelector extends StatefulWidget {
  const BluetoothDeviceSelector({Key? key}) : super(key: key);

  @override
  State<BluetoothDeviceSelector> createState() =>
      _BluetoothDeviceSelectorState();
}

class _BluetoothDeviceSelectorState extends State<BluetoothDeviceSelector> {
  Future<void> _requestBluetoothPermissions() async {
    Map<Permission, PermissionStatus> statuses =
        await [
          Permission.bluetooth,
          Permission.bluetoothScan,
          Permission.bluetoothConnect,
          Permission.location,
        ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);
    if (!allGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes conceder los permisos para continuar'),
        ),
      );
      return;
    }

    _showPairedDevicesDialog();
  }

  Future<void> _showPairedDevicesDialog() async {
    try {
      List<BluetoothDevice> devices =
          await BluetoothConnection.getBondedDevices();

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Dispositivos emparejados"),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final device = devices[index];
                  return ListTile(
                    title: Text(device.name ?? "Sin nombre"),
                    subtitle: Text(device.address),
                    onTap: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Seleccionaste: ${device.name}'),
                        ),
                      );
                      // Aquí puedes iniciar la conexión si lo deseas
                    },
                  );
                },
              ),
            ),
          );
        },
      );
    } catch (e) {
      print("Error al obtener dispositivos: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al listar dispositivos")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bluetooth Emparejados")),
      body: Center(
        child: ElevatedButton(
          onPressed: _requestBluetoothPermissions,
          child: const Text("Mostrar dispositivos emparejados"),
        ),
      ),
    );
  }
}
