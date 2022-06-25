import 'package:examencl3/View/listado.dart';
import 'package:flutter/material.dart';
import '../service/servicio.dart';
import '../service/servicio_provider.dart';

class NuevoClien_Servicio extends StatefulWidget {
  // NuevoClien_Servicio({Key? key}) : super(key: key);

  String titulo;
  Servicio oServicio = Servicio();
  final _provider = ServicioProvider();
  int codigo_servicioSeleccionado = 0;
  String mensaje = "";
  bool validacion = false;
  NuevoClien_Servicio(this.titulo, this.codigo_servicioSeleccionado);

  @override
  State<NuevoClien_Servicio> createState() => _NuevoClien_ServicioState();
}

class _NuevoClien_ServicioState extends State<NuevoClien_Servicio> {
  void _volverListado() {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext pContexto) {
      return servicioCLi("");
    }));
  }

  final _tfCodigoServicio = TextEditingController();
  final _tfNombreCliente = TextEditingController();
  final _tfNumeroOrdenServicio = TextEditingController();
  final _tfFechaProgramada = TextEditingController();
  final _tfLinea = TextEditingController();
  final _tfEstado = TextEditingController();
  final _tfObservaciones = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.oServicio.inicializar();
    if (widget.codigo_servicioSeleccionado > 0) {
      _litarKeyProvider();
    }
  }

  Future<String> _litarKeyProvider() async {
    Servicio oServicio = Servicio();
    oServicio.inicializar();
    var oServicioModel =
        await widget._provider.listarKey(widget.codigo_servicioSeleccionado);
    print(oServicioModel);
    setState(() {
      widget.oServicio = oServicioModel;
      if (widget.oServicio.codigo != 0) {
        widget.mensaje = "Actualizado";
        _mostrarDatos();
      }
    });
    return "Terminado";
  }

  //----Datatos
  void _mostrarDatos() {
    _tfCodigoServicio.text = widget.oServicio.codigo.toString();
    _tfNombreCliente.text = widget.oServicio.nombreCliente.toString();
    _tfNumeroOrdenServicio.text = widget.oServicio.numeroOrden.toString();
    _tfFechaProgramada.text = widget.oServicio.fechaProgramada.toString();
    _tfLinea.text = widget.oServicio.linea.toString();
    _tfEstado.text = widget.oServicio.estado.toString();
    _tfObservaciones.text = widget.oServicio.observacion.toString();
  }

  void _cargarEntidades() {
    widget.oServicio.codigo = int.parse(_tfCodigoServicio.text);
    widget.oServicio.nombreCliente = _tfNombreCliente.text;
    widget.oServicio.numeroOrden = _tfNumeroOrdenServicio.text;
    widget.oServicio.fechaProgramada = _tfFechaProgramada.text;
    widget.oServicio.linea = _tfLinea.text;
    widget.oServicio.estado = _tfEstado.text;
    widget.oServicio.observacion = _tfObservaciones.text;
  }

  //-fin
  //-----boton de registro
  bool _validarRegistro() {
    if (_tfCodigoServicio.text.toString() == "") {
      widget.validacion = false;
      setState(() {
        widget.mensaje = "Falta completar CodigoServicio ";
      });
      return false;
    }
    if (_tfNombreCliente.text.toString() == "") {
      widget.validacion = false;
      setState(() {
        widget.mensaje = "Falta completar NombreCliente..";
      });
      return false;
    }
    if (_tfNumeroOrdenServicio.text.toString() == "") {
      widget.validacion = false;
      setState(() {
        widget.mensaje = "Falta completar Numero de Orden de Servicio...";
      });
      return false;
    }
    if (_tfFechaProgramada.text.toString() == "") {
      widget.validacion = false;
      setState(() {
        widget.mensaje = "Falta completar Fecha Programada...";
      });
      return false;
    }
    if (_tfLinea.text.toString() == "") {
      widget.validacion = false;
      setState(() {
        widget.mensaje = "Falta completar Linea...";
      });
      return false;
    }
    if (_tfEstado.text.toString() == "") {
      widget.validacion = false;
      setState(() {
        widget.mensaje = "Falta completar Estado...";
      });
      return false;
    }
    if (_tfObservaciones.text.toString() == "") {
      widget.validacion = false;
      setState(() {
        widget.mensaje = "Falta completar Observaciones...";
      });
      return false;
    }

    return true;
  }

  void _grabarRegistro() {
    if (_validarRegistro()) {
      _ejecutar_Servicio();
    }
  } //finn

  Future<String> _ejecutar_Servicio() async {
    String accion = "A";
    if (widget.oServicio.codigo! > 0) {
      accion = "B";
    }
    _cargarEntidades();
    Servicio oServicioModeltmp = Servicio();
    oServicioModeltmp.inicializar();
    var oServicioModel =
        await widget._provider.registra(widget.oServicio, accion);

    print(oServicioModel);
    setState(() {
      widget.oServicio = oServicioModel;
      if (widget.oServicio.codigo! > 0) {
        widget.mensaje = "Grabado correctamente...";
      }
      print(widget.oServicio);
    });
    return "Procesado";
  }

  /// fin

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Registro de Servicios " + widget.titulo),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                  " Código de Servicio:" + widget.oServicio.codigo.toString()),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                children: <Widget>[
                  TextField(
                      controller: _tfCodigoServicio,
                      decoration: const InputDecoration(
                        hintText: "Ingrese CodigoServicio ",
                        labelText: "CodigoServicio",
                      )),
                  TextField(
                      controller: _tfNombreCliente,
                      decoration: const InputDecoration(
                        hintText: "Ingrese NombreCliente ",
                        labelText: "NombreCliente",
                      )),
                  TextField(
                      controller: _tfNumeroOrdenServicio,
                      decoration: const InputDecoration(
                        hintText: "Ingrese NumeroOrdenServicio ",
                        labelText: "NumeroOrdenServicio",
                      )),
                  TextField(
                      controller: _tfFechaProgramada,
                      decoration: const InputDecoration(
                        hintText: "Ingrese FechaProgramada ",
                        labelText: "FechaProgramada",
                      )),
                  TextField(
                      controller: _tfLinea,
                      decoration: const InputDecoration(
                        hintText: "Ingrese Linea ",
                        labelText: "Linea",
                      )),
                  TextField(
                      controller: _tfEstado,
                      decoration: const InputDecoration(
                        hintText: "Ingrese Estado ",
                        labelText: "Estado",
                      )),
                  TextField(
                      controller: _tfObservaciones,
                      decoration: const InputDecoration(
                        hintText: "Ingrese Observaciones ",
                        labelText: "Observacion",
                      )),
                  Text("Mensaje:" + widget.mensaje),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //
                MaterialButton(
                  minWidth: 180.0,
                  height: 40.0,
                  onPressed: _grabarRegistro,
                  color: Colors.redAccent,
                  child: const Text('Gravar'),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //
                MaterialButton(
                  minWidth: 180.0,
                  height: 40.0,
                  onPressed: _volverListado,
                  color: Colors.redAccent,
                  child: const Text('Regresar'),
                ),
              ]),
            ),
          ],
        ));
  }
}
