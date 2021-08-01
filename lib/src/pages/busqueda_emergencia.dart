import 'package:flutter/material.dart';
import 'package:ui_flutter/src/widgets/nav_bar/nav_drawer.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class PageBusquedaEmergencia extends StatefulWidget {
  PageBusquedaEmergencia({Key key}) : super(key: key);

  @override
  _PageBusquedaEmergenciaState createState() => _PageBusquedaEmergenciaState();
}

@immutable
class User {
  const User({
    this.email,
    this.name,
  });

  final String email;
  final String name;

  @override
  String toString() {
    return '$name, $email';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is User && other.name == name && other.email == email;
  }

  @override
  int get hashCode => hashValues(email, name);
}

class _PageBusquedaEmergenciaState extends State<PageBusquedaEmergencia> {
  Widget _appBarTitle = new Text('Búsqueda de emergencia');
  static const List<User> _userOptions = <User>[
    User(name: 'Alice', email: 'alice@example.com'),
    User(name: 'Bob', email: 'bob@example.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
    User(name: 'Charlie', email: 'charlie123@gmail.com'),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
              decoration: InputDecoration(border: OutlineInputBorder())),
          suggestionsCallback: (pattern) async {
            var data = _userOptions.where((element) {
              print(element.name == pattern);
              return element.name == pattern;
            });
            print(data);
            return data;
          },
          itemBuilder: (context, suggestion) {
            print(suggestion);
            return ListTile(
              leading: Icon(Icons.motorcycle),
              title: Text(suggestion['name']),
              /* subtitle: Text('\$${suggestion['price']}'), */
            );
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
