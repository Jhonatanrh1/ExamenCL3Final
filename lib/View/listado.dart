import 'package:flutter/material.dart';
import '../service/servicio.dart';
import '../service/servicio_provider.dart';
import '../View/nuevo_servicio.dart';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:json_table/json_table.dart';

class servicioCLi extends StatefulWidget {
  // servicioCLi({Key? key}) : super(key: key);

  String titulo;
  final _provider = new ServicioProvider();
  List<Servicio> oListaServicio = [];
  int codigo = 0;
  Servicio oServicio = Servicio();
  String json_Servicio = "";
  servicioCLi(this.titulo);

  @override
  State<servicioCLi> createState() => _servicioCLiState();
}

class _servicioCLiState extends State<servicioCLi> {
  final _tfCliente = TextEditingController();
  final _tfOrder = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.oServicio.inicializar();
    widget.json_Servicio = '[${widget.oServicio.toModelString()}]';
  }

  Future<String> _consultaRegistro() async {
    Servicio pServicio = Servicio();
    pServicio.inicializar();
    pServicio.nombreCliente = _tfCliente.text;
    pServicio.numeroOrden = _tfOrder.text;
    var OLista_Servicio = await widget._provider.listar(pServicio);
    print(OLista_Servicio);
    setState(() {
      widget.oListaServicio = OLista_Servicio;
      widget.json_Servicio = widget._provider.jsonResultado;
      if (widget.oListaServicio.length == 0) {
        widget.json_Servicio = '[${widget.oServicio.toModelString()}]';
      }
    });
    return "Terminar";
  } //fin

  void _nuevoRegistro() {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext pContexto) {
      return NuevoClien_Servicio("", 0);
    }));
  }

  void _VerRegistro(int pCodigo) {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext pContexto) {
      return NuevoClien_Servicio("", pCodigo);
    }));
  }

  @override
  Widget build(BuildContext context) {
    var json = jsonDecode(widget.json_Servicio);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consulta"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Para consultar! Complete el nombre",
              style: TextStyle(fontSize: 12),
            ),
            TextField(
                controller: _tfCliente,
                decoration: const InputDecoration(
                  hintText: "Ingrese Cliente",
                  labelText: "Cliente",
                )),
            TextField(
                controller: _tfOrder,
                decoration: const InputDecoration(
                  hintText: "Ingrese Orden",
                  labelText: "Orden",
                )),
            Text(
              "Se encontraron" +
                  widget.oListaServicio.length.toString() +
                  "Cliente",
              style: const TextStyle(fontSize: 9),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      minWidth: 180.0,
                      height: 40.0,
                      onPressed: _consultaRegistro,
                      color: Colors.blueAccent,
                      child: const Text('Consulta'),
                    ),
                    MaterialButton(
                      minWidth: 180.0,
                      height: 40.0,
                      onPressed: _nuevoRegistro,
                      color: Colors.blueAccent,
                      child: const Text('Nuevo'),
                    ),
                  ],
                )),
            JsonTable(
              json,
              columns: [
                JsonTableColumn("CodigoServicio", label: "codigo"),
              ],
              showColumnToggle: false,
              allowRowHighlight: true,
              rowHighlightColor: Colors.greenAccent[500]!.withOpacity(0.7),
              paginationRowCount: 10,
              onRowSelect: (index, map) {
                _VerRegistro(int.parse(map["codigo"].toString()));
              },
            )
          ],
        ),
      ),
    );
  }
}
