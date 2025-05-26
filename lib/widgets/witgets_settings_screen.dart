import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:app_settings/app_settings.dart';

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

class BluetoothWidget extends StatefulWidget {
  const BluetoothWidget({super.key});

  @override
  BluetoothWidgetState createState() => BluetoothWidgetState();
}

class BluetoothWidgetState extends State<BluetoothWidget> {
  bool _isBluetoothOn = false;
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();

    // Escuchar el estado del Bluetooth
    FlutterBluePlus.adapterState.listen((state) {
      setState(() {
        _isBluetoothOn = state == BluetoothAdapterState.on;
      });
    });

    // Consultar estado inicial
    FlutterBluePlus.adapterState.first.then((state) {
      setState(() {
        _isBluetoothOn = state == BluetoothAdapterState.on;
      });

      if (_isBluetoothOn) {
        _startScan();
      }
    });
  }

  void _openBluetoothSettings() {
    AppSettings.openAppSettings(type: AppSettingsType.bluetooth);
  }

  void _startScan() async {
    if (_isScanning) return;

    setState(() {
      _scanResults.clear();
      _isScanning = true;
    });

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        _scanResults = results;
      });
    });

    FlutterBluePlus.isScanning.listen((scanning) {
      setState(() {
        _isScanning = scanning;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Bluetooth', style: TextStyle(fontSize: 16)),
            Switch(
              value: _isBluetoothOn,
              onChanged: (value) {
                if (!_isBluetoothOn) {
                  _openBluetoothSettings();
                }
              },
            ),
          ],
        ),
        const Divider(),
        if (_isBluetoothOn) ...[
          TextButton.icon(
            onPressed: _isScanning ? null : _startScan,
            icon: const Icon(Icons.search),
            label: const Text("Buscar dispositivos"),
          ),
          _scanResults.isEmpty
              ? const Text('No se encontraron dispositivos aún.')
              : Expanded(
                child: ListView.builder(
                  itemCount: _scanResults.length,
                  itemBuilder: (context, index) {
                    final device = _scanResults[index].device;
                    return ListTile(
                      leading: const Icon(Icons.bluetooth),
                      title: Text(
                        device.advName.isNotEmpty
                            ? device.advName
                            : 'Dispositivo sin nombre',
                      ),
                      subtitle: Text(device.remoteId.str),

                      onTap: () {
                        // Aquí puedes manejar la selección del dispositivo
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Seleccionaste: ${device.advName}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
        ] else
          const Text(
            'Bluetooth está apagado. Enciéndelo para buscar dispositivos.',
          ),
      ],
    );
  }
}
