import 'package:flutter/material.dart';

class PageEmergencyHelp extends StatefulWidget {
  String data;
  PageEmergencyHelp(this.data, {Key key}) : super(key: key);

  @override
  _PageEmergencyHelpState createState() => _PageEmergencyHelpState();
}

class _PageEmergencyHelpState extends State<PageEmergencyHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Boton de Panico'),
      ),
      body: Container(
        child: Center(
          child: Text(widget.data ?? 'vacio'),
        ),
      ),
    );
  }
}
