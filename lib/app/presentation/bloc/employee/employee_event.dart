part of 'employee_bloc.dart';

abstract class EmployeeEvent{
  const EmployeeEvent();
}

class GetAllEmployeeEvent extends EmployeeEvent{
  const GetAllEmployeeEvent();
}

class AddEmployeeEvent extends EmployeeEvent{
  final EmployeeEntity employeeModel;
  const AddEmployeeEvent({required this.employeeModel});
}

class UpdateEmployeeEvent extends EmployeeEvent{
  final String? id;
  final EmployeeEntity employeeModel;
  const UpdateEmployeeEvent({this.id, required this.employeeModel});
}

class DeleteEmployeeEvent extends EmployeeEvent{
  final String? id;
  const DeleteEmployeeEvent({this.id});
}