import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class PageEmergencyHelp extends StatefulWidget {
  String data;
  PageEmergencyHelp(this.data, {Key key}) : super(key: key);

  @override
  _PageEmergencyHelpState createState() => _PageEmergencyHelpState();
}

Completer<GoogleMapController> _controller = Completer();

CameraPosition _kGooglePlex = CameraPosition(
  target: LatLng(latitud, -122.085749655962),
  bearing: 192.8334901395799,
  zoom: 20,
);
double latitud;
double longitud;
CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.4219983, -122.084),
    tilt: 59.440717697143555,
    zoom: 10);
const urlMaps =
    'https://www.google.com/maps/dir/?api=1&origin=43.7967876,-79.5331616&destination=43.5184049,-79.8473993&waypoints=43.1941283,-79.59179|43.7991083,-79.5339667|43.8387033,-79.3453417|43.836424,-79.3024487&travelmode=driving&dir_action=navigate';

@override
class _PageEmergencyHelpState extends State<PageEmergencyHelp> {
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitud = geoposition.latitude;
      longitud = geoposition.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Boton de Panico'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            height: 300,
            child: Center(
              child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                  target: LatLng(latitud, longitud),
                  bearing: 192.8334901395799,
                  zoom: 20,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ),
          Container(
            child: Text(latitud.toString() + '    ' + longitud.toString()),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake(),
        label: Text('Ir a GoogleMaps'),
        icon: Icon(Icons.maps_ugc_outlined),
      ),
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
  _launchURL(urlMaps);
}
