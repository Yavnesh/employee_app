import 'package:intl/intl.dart';

import '../../domain/entities/employee.dart';

class EmployeeModel extends EmployeeEntity{
  const EmployeeModel({
    String? id,
    required String name,
    required String designation,
    required DateTime startDate,
    DateTime? endDate,
  }): super(
    id:  id,
    name: name,
    designation: designation,
    startDate: startDate,
    endDate: endDate,
  );

  factory EmployeeModel.fromJson(Map<dynamic,dynamic> map){
    return EmployeeModel(
      id: map['_id'],
      name: map['employee_name'] ?? "",
      designation: map['employee_designation'] ?? "",
      startDate: DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['start_date'] ?? "").toLocal(),
      endDate: map['end_date'] != null ? DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['end_date'] ?? "").toLocal() : null,
    );
  }

  factory EmployeeModel.fromEntity(EmployeeEntity entity) {
    return EmployeeModel(
      id: entity.id,
        name: entity.name,
        designation: entity.designation,
        startDate: entity.startDate,
        endDate: entity.endDate,
    );
  }
}