import '../../../core/resources/data_state.dart';
import '../entities/employee.dart';

abstract class EmployeeRepository{
  Future<DataState<List<EmployeeEntity>>> getAllEmployeeFromServer();
  Future<DataState<List<EmployeeEntity>>> addEmployee(EmployeeEntity employeeEntity);
  Future<DataState<List<EmployeeEntity>>> updateEmployee(String id, EmployeeEntity employeeEntity);
  Future<DataState<List<EmployeeEntity>>> deleteEmployee(String id);
  Future<List<EmployeeEntity>> getAllEmployeeFromDb();
}