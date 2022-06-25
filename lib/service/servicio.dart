class Servicio {
  int? codigo;
  String? nombreCliente;
  String? numeroOrden;
  String? fechaProgramada;
  String? linea;
  String? estado;
  String? observacion;

  ///contructor
  Servicio({
    this.codigo,
    this.nombreCliente,
    this.numeroOrden,
    this.fechaProgramada,
    this.linea,
    this.estado,
    this.observacion,
  });

  //mapear
  Servicio.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    nombreCliente = json['nombreCliente'];
    numeroOrden = json['numeroOrden'];
    fechaProgramada = json['fechaProgramada'];
    linea = json['linea'];
    estado = json['estado'];
    observacion = json['observacion'];
  }

  //
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codigo'] = codigo;
    data['nombreCliente'] = nombreCliente;
    data['numeroOrden'] = numeroOrden;
    data['fechaProgramada'] = fechaProgramada;
    data['linea'] = linea;
    data['estado'] = estado;
    data['observacion'] = observacion;
    return data;
  }

  String toParameter() {
    return "codigo=${codigo.toString()}" +
        "&NombreCliente=${nombreCliente.toString()}" +
        "&numeroOrden=${numeroOrden.toString()}" +
        "&fechaProgramada=${fechaProgramada.toString()}" +
        "&linea=${linea.toString()}" +
        "&estado=${estado.toString()}" +
        "&observacion=${observacion.toString()}";
  }

  String toModelString() {
    return '{"CodigoServicio":"${codigo.toString()}",' +
        '"NombreCliente":"${nombreCliente.toString()}",' +
        '"NumeroOrdenServicio":"${numeroOrden.toString()}",' +
        '"FechaProgramada":"${fechaProgramada.toString()}",' +
        '"Linea":"${linea.toString()}",' +
        '"Estado":"${estado.toString()}",' +
        '"Observaciones":"${observacion.toString()}"' +
        '}';
  }

  void inicializar() {
    codigo = 0;
    nombreCliente = "";
    numeroOrden = "";
    fechaProgramada = "";
    linea = "";
    estado = "";
    observacion = "";
  }
}
