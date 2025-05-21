import 'package:flutter/material.dart';
import 'package:soul_humidity_app/ui/aparience_app.dart';
import 'package:soul_humidity_app/widgets/witgets_home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorMyApp.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorMyApp.accentColor,
        toolbarHeight: 80,
        title: Text('Soil Humidity', style: TextStyles.encabezados),
        actions: [SettingBotton()],
      ),

      body: SizedBox(
        width: double.infinity,
        height: 700,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 60)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Humidity(), Temperatura()],
            ),

            Plant(),

            Spacer(),

            SizedBox(
              height: 100,
              width: 350,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.large(
                  onPressed: () {
                    // Accion al precionar el boton!!
                  },
                  backgroundColor: ColorMyApp.accentColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Riego Manual', style: TextStyles.subtitulos2),

                      Icon(
                        Icons.water_drop,
                        color: ColorMyApp.secondaryColor,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
