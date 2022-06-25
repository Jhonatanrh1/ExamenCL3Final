String urlBase = 'http://wscibertec2022.somee.com';
String controllerServicios = "Servicio";

double checkDouble(dynamic value) {
  if (value is String) {
    return double.parse(value);
  } else if (value is int) {
    return 0.0 + value;
  } else {
    return value;
  }
}

bool isNumeric(String e) {
  if (e.isEmpty) return false;
  final n = num.tryParse(e);
  return (n == null) ? false : true;
}
