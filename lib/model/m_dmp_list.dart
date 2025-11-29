import 'dart:developer';

class EmpListModel {
  final int id;
  final String name;
  final String department;
  final String position;

  EmpListModel({
    required this.id,
    required this.name,
    required this.department,
    required this.position,
  });

  factory EmpListModel.fromJson(Map<String, dynamic> json) {
    log('fromjson: $json');
    return EmpListModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      department: json['department'] ?? '',
      position: json['position'] ?? '',
    );
  }

  @override
  String toString() {
    return 'EmpListModel{id: $id, name: $name, department: $department, position: $position}';
  }
}
