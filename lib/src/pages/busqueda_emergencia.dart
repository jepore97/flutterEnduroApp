import 'package:flutter/material.dart';
import 'package:ui_flutter/src/services/services_usuario.dart';
import 'package:ui_flutter/src/widgets/nav_bar/nav_drawer.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class PageBusquedaEmergencia extends StatefulWidget {
  PageBusquedaEmergencia({Key key}) : super(key: key);

  @override
  _PageBusquedaEmergenciaState createState() => _PageBusquedaEmergenciaState();
}

class _PageBusquedaEmergenciaState extends State<PageBusquedaEmergencia> {
  Widget _appBarTitle = new Text('Búsqueda de emergencia');
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(title: _appBarTitle),
        body: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontStyle: FontStyle.italic),
              decoration: InputDecoration(border: OutlineInputBorder()),
              controller: this._typeAheadController),
          suggestionsCallback: (pattern) async {
            var data = await ServicioUsuario().getUsuarioPlaca(pattern);
            return data;
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
                leading: Icon(Icons.motorcycle),
                title: Text(suggestion['ve_placa']));
          },
          noItemsFoundBuilder: (context) {
            return Center(child: Text('Dato no encontrado'));
          },
          onSuggestionSelected: (suggestion) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Text('hola')));
          },
        ));
    /* Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Autocomplete<User>(
              displayStringForOption: _displayStringForOption,
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<User>.empty();
                }
                return _userOptions.where((User option) {
                  return option
                      .toString()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (User selection) {
                print(
                    'You just selected ${_displayStringForOption(selection)}');
              },
            ) */
  }
}
