import 'package:http/http.dart' as http;
import 'servicio.dart';
import 'dart:convert';
import 'Util.dart' as util;
import 'dart:async' show Future;

class ServicioProvider {
  String urlRegistrar = "Registrar";
  String urlListado = "Listado";
  String urlListarKey = "ListarKey";
  String urlEliminar = "Eliminar";
  String jsonResultado = "";

  Future<List<Servicio>> listar(Servicio pServicio) async {
    final urlListadoCli = '${util.urlBase}/${util.controllerServicios}/' +
        '${this.urlListado}?${pServicio.toParameter()}';

    var respuesta = await http.get(Uri.parse(urlListadoCli));
    var data = respuesta.body;
    jsonResultado = "[${Servicio().toModelString()}]";
    print(jsonResultado);
    List<Servicio> oLista_Servicio = [];
    if (data != '') {
      oLista_Servicio = List<Servicio>.from(
          json.decode(data).map((x) => Servicio.fromJson(x)));
      jsonResultado = data;
    }
    return oLista_Servicio;
  }

  Future<Servicio> listarKey(int pCodigoServicio) async {
    Servicio oServicio = Servicio();
    oServicio.inicializar();
    final urlquery = '${util.urlBase}/${util.controllerServicios}/' +
        urlListarKey +
        '?pCodigoServicio' +
        pCodigoServicio.toString();
    final response = await http.get(Uri.parse(urlquery));
    final data = response.body;
    jsonResultado = data;
    if (data != '') {
      oServicio = Servicio.fromJson(json.decode(data));
    }
    return oServicio;
  }

  //registra
  Future<Servicio> registra(Servicio pServicio, String pTipoTransaccion) async {
    Servicio oServicio = Servicio();
    oServicio.inicializar();
    final urlquery = '${util.urlBase}/${util.controllerServicios}/' +
        urlRegistrar +
        '?Accion=' +
        pTipoTransaccion +
        "&" +
        pServicio.toParameter();
    final response = await http.get(Uri.parse(urlquery));
    final data = response.body;
    jsonResultado = data;
    if (data != '') {
      pServicio = Servicio.fromJson(json.decode(data));
    }
    return pServicio;
  } //fin

  //elimina
  Future<Servicio> elimina(int pcodigo) async {
    Servicio oServicio = Servicio();
    oServicio.inicializar();
    final urlquery = '${util.urlBase}/${util.controllerServicios}/' +
        urlEliminar +
        '?' +
        "&pcodigo=" +
        pcodigo.toString();
    final response = await http.get(Uri.parse(urlquery));
    final data = response.body;
    jsonResultado = data;
    if (data != '') {
      oServicio = Servicio.fromJson(json.decode(data));
    }
    return oServicio;
  } //fin

  Future<Servicio> ListarValidaciones(int pcodigo) async {
    Servicio oServicio = Servicio();
    oServicio.inicializar();
    final urlquery = '${util.urlBase}/${util.controllerServicios}/' +
        urlListarKey +
        '?' +
        "&pcodigo=" +
        pcodigo.toString();
    final response = await http.get(Uri.parse(urlquery));
    final data = response.body;
    jsonResultado = data;
    if (data != '') {
      oServicio = Servicio.fromJson(json.decode(data));
    }
    return oServicio;
  }
}
