import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'employee.g.dart';

@HiveType(typeId: 0)
class EmployeeEntity extends Equatable{
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String designation;
  @HiveField(3)
  final DateTime startDate;
  @HiveField(4)
  final DateTime? endDate;

  const EmployeeEntity({this.id, required this.name, required this.designation, required this.startDate, this.endDate,});

  @override
  // TODO: implement props
  List<Object?> get props {
    return [
      id,
      name,
      designation,
      startDate,
      endDate,
    ];
  }
}