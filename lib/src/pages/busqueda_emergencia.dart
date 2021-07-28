import 'package:flutter/material.dart';
import 'package:ui_flutter/src/widgets/nav_bar/nav_drawer.dart';

class PageBusquedaEmergencia extends StatefulWidget {
  PageBusquedaEmergencia({Key key}) : super(key: key);

  @override
  _PageBusquedaEmergenciaState createState() => _PageBusquedaEmergenciaState();
}

class _PageBusquedaEmergenciaState extends State<PageBusquedaEmergencia> {
  Widget _appBarTitle = new Text('Búsqueda de emergencia');
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController buscarTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: _appBarTitle,
        ),
        body: Container(
          child: Center(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      formItemsDesign(
                        Icons.description,
                        TextFormField(
                          autofocus: false,
                          controller: buscarTextController,
                          decoration: new InputDecoration(
                            labelText: 'Buscar placa',
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor ingrese la placa del vehiculo';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ))),
        ));
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: Card(
        child: ListTile(
          leading: Icon(icon),
          title: item,
        ),
      ),
    );
  }
}
