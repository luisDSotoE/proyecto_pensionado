class UserData {
  String id;
  String nombre;
  String cedula;
  String telefono;
  String correo;

  UserData(
      {required this.id,
      required this.nombre,
      required this.cedula,
      required this.telefono,
      required this.correo});

  // Constructor adicional para crear una instancia desde un mapa
  UserData.fromMap(String id, Map<String, dynamic> map)
      : id = id,
        nombre = map['nombre'],
        cedula = map['edad'],
        telefono = map['telefono'],
        correo = map['correo'];

  // Método para convertir la instancia a un mapa
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'cedula': cedula,
      'telefono': telefono,
      'correo': correo,
    };
  }
}
