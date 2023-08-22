import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/employee.dart';
import '../../repository/employee_repo.dart';

class AddEmployeeUseCase implements UseCase<DataState<List<EmployeeEntity>>, EmployeeEntity>{
  final EmployeeRepository _employeeRepository;

  AddEmployeeUseCase(this._employeeRepository);
  @override
  Future<DataState<List<EmployeeEntity>>> call({ EmployeeEntity? params}) async {
    print("params in add employee usecase");
    print(params);
    return await _employeeRepository.addEmployee(params!);
  }
}