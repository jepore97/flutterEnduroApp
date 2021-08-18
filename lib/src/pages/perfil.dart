import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_flutter/src/models/model_usuario.dart';
import 'package:ui_flutter/src/providers/push_notification_provider.dart';
import 'package:ui_flutter/src/services/services_usuario.dart';
import 'package:ui_flutter/src/widgets/widgets.dart';

import 'login.dart';

class PagePerfil extends StatefulWidget {
  int usCdgo;
  PagePerfil(this.usCdgo, {Key key}) : super(key: key);

  @override
  _PagePerfilState createState() => _PagePerfilState();
}

class _PagePerfilState extends State<PagePerfil> {
  Future<Usuario> searchUsuario;
  Usuario usuario;
  String sexoSelecionado = '';
  String rhSelecionado = '';

  String textEror;

  TextEditingController datoTextController = new TextEditingController();
  @override
  void initState() {
    searchUsuario = ServicioUsuario().searchUsuario(widget.usCdgo.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.4;
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              FutureBuilder<Usuario>(
                future: searchUsuario,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    usuario = snapshot.data;
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: WidgetsGenericos.imagen_perfil(
                              context, usuario.us_logo, 200),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        usuario.us_nombres + ' ',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        usuario.us_apellidos,
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // ---------alias-----------
                              Container(
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Alias'),
                                    datoUsuario(usuario.us_alias, 'us_alias'),
                                  ],
                                ),
                              ),
                              // ------------------sede---------
                              Container(
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Sede'),
                                    datoUsuario(usuario.us_sd_desc),
                                  ],
                                ),
                              ),
                              // -------------correo---------
                              Container(
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Email'),
                                    datoUsuario(usuario.us_correo, 'us_correo'),
                                  ],
                                ),
                              ),
                              // ----------telefono------------
                              Container(
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Telefono'),
                                    datoUsuario(
                                        usuario.us_telefono, 'us_telefono'),
                                  ],
                                ),
                              ),
                              // --------sexo---------rh---------------
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Sexo'),
                                        datoUsuario(usuario.us_sexo, 'us_sexo'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('R-H'),
                                        datoUsuario(usuario.us_rh, 'us_rh'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              // ---------direccion------
                              Container(
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text('Dirección'),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(usuario.us_direccion,
                                            style: TextStyle(fontSize: 20),
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            maxLines: 5),
                                        InkWell(
                                          onTap: () {
                                            dialogRenovar(usuario.us_direccion,
                                                'us_direccion');
                                          },
                                          child: Icon(Icons.edit_outlined),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  datoUsuario(dato, [String tipo]) {
    print(tipo);
    return Container(
      child: Row(
        children: [
          tipo != 'us_sexo'
              ? dato != ''
                  ? Text(dato, style: TextStyle(fontSize: 20))
                  : Text('')
              : dato == 'M'
                  ? Text('MASCULINO', style: TextStyle(fontSize: 20))
                  : dato == 'F'
                      ? Text('FEMENINO', style: TextStyle(fontSize: 20))
                      : Text('OTRO', style: TextStyle(fontSize: 20)),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () {
                dialogRenovar(dato, tipo);
              },
              child: Icon(Icons.edit_outlined),
            ),
          )
        ],
      ),
    );
  }

  dropdownRh(rhSel) {
    rhSelecionado = rhSel;
    return DropdownButton(
      value: rhSel,
      onChanged: (value) {
        setState(() {
          rhSel = value;
          rhSelecionado = rhSel;
        });
      },
      items: ["O+", "O-", "A+", "A-", "B+", "B-", "AB+", "AB-"].map((value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      hint: Text('RH *'),
      isExpanded: true,
    );
  }

  dropdownSexo(sexoSel) {
    sexoSelecionado = sexoSel;
    return WidgetsGenericos.formItemsDesign(
        Icons.person,
        DropdownButton(
          value: sexoSel,
          onChanged: (value) {
            setState(() {
              sexoSel = value;
              sexoSelecionado = sexoSel;
            });
          },
          items: [
            DropdownMenuItem(
              value: "F",
              child: Text("Femenino"),
            ),
            DropdownMenuItem(
              value: "M",
              child: Text("Masculino"),
            ),
            DropdownMenuItem(
              value: "O",
              child: Text("Otro"),
            )
          ],
          hint: Text('Sexo *'),
        ));
  }

  dialogRenovar(value, [key]) {
    datoTextController.text = value;
    AlertDialog alert1 = AlertDialog(
      title: Text('Editar'),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            key == 'us_correo'
                ? Text(
                    'Intentas modificar una credencial de acceso, si realizas este cambio seras redirigido al login')
                : Text(''),
            key != 'us_sexo' && key != 'us_rh'
                ? TextFormField(
                    autofocus: false,
                    controller: datoTextController,
                    maxLength: 500,
                    maxLines: 2,
                    decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 0.5,
                        ),
                      ),
                      labelStyle: TextStyle(fontSize: 15),
                      suffixStyle: TextStyle(fontSize: 15),
                    ),
                    buildCounter: null,
                  )
                : key != 'us_rh'
                    ? dropdownSexo(value)
                    : dropdownRh(value),
            // mensaje error
            Center(
              child: Text(textEror == null ? '' : textEror,
                  style: TextStyle(color: Colors.red, fontSize: 12)),
            )
          ],
        ),
      ),
      actions: [
        GFButton(
          color: Theme.of(context).accentColor,
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        // ----------------------------Actualizar----------------------------
        GFButton(
          color: Theme.of(context).accentColor,
          child: Text(
            'Actualizar',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            bool res = false;
            print(sexoSelecionado);
            WidgetsGenericos.showLoaderDialog(context, true, 'Cargando...',
                null, Theme.of(context).accentColor);
            res = await ServicioUsuario().updateData(
                key,
                key != 'us_sexo' && key != 'us_rh'
                    ? datoTextController.text
                    : key != 'us_rh'
                        ? sexoSelecionado
                        : rhSelecionado);
            if (res) {
              // si modifica el correo se reiniciara la sesion
              if (key == 'us_correo') {
                if (value != datoTextController.text) {
                  print('por aqui ');
                  final pushNotificationProvider =
                      new PushNotificationProvider();
                  pushNotificationProvider.initNotifications();
                  SharedPreferences prefes =
                      await SharedPreferences.getInstance();
                  await prefes.clear();
                  return Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => PageLogin()));
                }
              }
              Navigator.pop(context);
              datoTextController.text = '';

              WidgetsGenericos.showLoaderDialog(
                  context,
                  false,
                  'Registrado Exitosamente',
                  Icons.check_circle_outlined,
                  Colors.green);
              await Future.delayed(Duration(milliseconds: 500));
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PagePerfil(widget.usCdgo),
                ),
              );
            } else {
              Navigator.pop(context);
              WidgetsGenericos.showLoaderDialog(
                  context,
                  false,
                  'Ha ocurrido un error',
                  Icons.check_circle_outlined,
                  Colors.red);
              await Future.delayed(Duration(milliseconds: 500));
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
        )
      ],
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert1;
      },
    );
  }
}
