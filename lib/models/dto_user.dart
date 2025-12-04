import '../app/core.dart';

class EmpListDTO {
  final int id;
  final String name;
  final String department;
  final String position;

  EmpListDTO({
    required this.id,
    required this.name,
    required this.department,
    required this.position,
  });

  factory EmpListDTO.fromJson(Map<String, dynamic> json) {
    log('fromjson: $json');
    return EmpListDTO(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      department: json['department'] ?? '',
      position: json['position'] ?? '',
    );
  }

  @override
  String toString() {
    return 'EmpListDTO{id: $id, name: $name, department: $department, position: $position}';
  }
}
