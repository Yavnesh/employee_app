import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/employee.dart';
import '../../repository/employee_repo.dart';

class DeleteEmployeeUseCase implements UseCase<DataState<List<EmployeeEntity>>, String>{
  final EmployeeRepository _employeeRepository;

  DeleteEmployeeUseCase(this._employeeRepository);
  @override
  Future<DataState<List<EmployeeEntity>>> call({String? params}) async {
    print("params in delete employee usecase");
    return await _employeeRepository.deleteEmployee(params!);
  }
}