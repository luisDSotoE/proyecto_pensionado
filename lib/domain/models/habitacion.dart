class Habitacion {
  final String id;
  final String nombre;
  final String direccion;
  final String descripcion;
  final double mensualidad;

  Habitacion( {
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.mensualidad,
    required this.direccion
  });

  factory Habitacion.desdeDoc(
      String id, Map<String, dynamic> json) {
    return Habitacion(
      id: id,
      nombre: json["nombre"] ?? '',
      descripcion: json["descripcion"] ?? '',
      direccion: json["direccion"] ?? 'N/A',
      mensualidad: (json["mensualidad"] as num?)?.toDouble() ?? 0.0,
    );
  }

  toJson() {
    throw UnimplementedError();
  }
}
