import 'package:flutter/material.dart';
import 'package:ui_flutter/src/services/services_boton_panico.dart';

import 'package:geolocator/geolocator.dart';
import 'package:ui_flutter/src/widgets/widgets.dart';

class PageBotonPanico extends StatefulWidget {
  PageBotonPanico({Key key}) : super(key: key);

  @override
  _PageBotonPanicoState createState() => _PageBotonPanicoState();
}

double latitud;
double longitud;

class _PageBotonPanicoState extends State<PageBotonPanico> {
  bool res = false;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      latitud = geoposition.latitude;
      longitud = geoposition.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pedir ayuda')),
      body: Container(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                '¡Recomendación!',
                style: (TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Esta opción fue diseñada solo para ocasiones de emergencia o aquellos momentos en carretera  donde consideres que tu vida se encuentra en riesgo y necesites una mano amiga\n \n' +
                  'Si pulsas el boton todos los lideres a nivel nacional seran notificados, a su vez estos se comunicaran contigo para brindarte apoyo ',
              style: (TextStyle(fontSize: 18)),
              textAlign: TextAlign.justify,
            ),
          ),
          // boton de ayuda
          Container(
            decoration: BoxDecoration(
              border: new Border.all(color: Colors.grey),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            margin: EdgeInsets.only(top: 50),
            width: 200,
            height: 200,
            child: InkWell(
              onTap: () async {
                WidgetsGenericos.showLoaderDialog(
                    context, true, 'Cargando...', null, Colors.blue);
                res = await ServicioBotonPanico()
                    .getNotificacion(latitud, longitud);
                if (res) {
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                  WidgetsGenericos.showLoaderDialog(context, false,
                      'Ha ocurrido un error', Icons.error_outline, Colors.red);

                  await Future.delayed(Duration(milliseconds: 500));
                  Navigator.pop(context);
                }
              },
              child: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text(
                  'Ayuda!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
