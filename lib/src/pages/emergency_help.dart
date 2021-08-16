import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ui_flutter/src/models/model_boton_panico.dart';
import 'package:ui_flutter/src/models/model_usuario.dart';
import 'package:ui_flutter/src/services/services_usuario.dart';
import 'package:ui_flutter/src/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class PageEmergencyHelp extends StatefulWidget {
  var data;
  PageEmergencyHelp(this.data, {Key key}) : super(key: key);

  @override
  _PageEmergencyHelpState createState() => _PageEmergencyHelpState();
}

Completer<GoogleMapController> _controller = Completer();
Future<Usuario> searchUsuario;
Usuario usuario;
double latitud = 0;
double longitud = 0;
BotonPanico dataPanico = new BotonPanico();

final Set<Marker> _markers = Set();
const urlMaps =
    'https://www.google.com/maps/dir/?api=1&origin=43.7967876,-79.5331616&destination=43.5184049,-79.8473993&waypoints=43.1941283,-79.59179|43.7991083,-79.5339667|43.8387033,-79.3453417|43.836424,-79.3024487&travelmode=driving&dir_action=navigate';

@override
class _PageEmergencyHelpState extends State<PageEmergencyHelp> {
  @override
  void initState() {
    super.initState();
    dataPanico = widget.data;
    print(dataPanico.longitud);
    setState(() {
      print(App.localStorage.getString('token'));
      longitud = double.parse(dataPanico.longitud);
      latitud = double.parse(dataPanico.latitud);
      _markers.add(
        Marker(
          markerId: MarkerId('newyork'),
          position: LatLng(latitud, longitud),
          infoWindow: InfoWindow(
              title: '¡Ayuda!', snippet: 'Ubicación del usuario en problemas'),
        ),
      );
      searchUsuario = ServicioUsuario().searchUsuario(dataPanico.us_cdgo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Boton de Panico'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Emergencia',
                style: (TextStyle(
                    color: Colors.red[400],
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                  'Un integrante se encuentra en una situacion de emergencia:'),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: FutureBuilder<Usuario>(
                    future: searchUsuario,
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      if (snapshot.hasData) {
                        usuario = snapshot.data;
                        print(usuario);
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(15),
                              child: WidgetsGenericos.imagen_perfil(
                                  context, usuario.us_logo),
                            ),
                            Text(
                              usuario.us_nombres + ' ' + usuario.us_apellidos,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            Text(usuario.us_sd_desc,
                                style: TextStyle(color: Colors.grey)),
                            WidgetsGenericos.personalData(usuario),
                            Column(
                              children: [
                                Text(
                                  'Ubicación Actual',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  height: 250,
                                  child: Center(
                                    child: GoogleMap(
                                        mapType: MapType.hybrid,
                                        markers: _markers,
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(latitud, longitud),
                                          bearing: 192.8334901395799,
                                          zoom: 13,
                                        ),
                                        onMapCreated:
                                            (GoogleMapController controller) {
                                          if (!_controller.isCompleted) {
                                            //first calling is false
                                            //call "completer()"
                                            _controller.complete(controller);
                                          } else {
                                            //other calling, later is true,
                                            //don't call again completer()
                                            print('');
                                          }
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake(),
      //   label: Text('Ir a GoogleMaps'),
      //   icon: Icon(Icons.maps_ugc_outlined),
      // ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_goToTheLake() {
  // _launchURL(urlMaps);
  // await launch(urlMaps);
}
