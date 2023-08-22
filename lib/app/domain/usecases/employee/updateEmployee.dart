import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/employee.dart';
import '../../repository/employee_repo.dart';

class UpdateEmployeeUseCase implements UseCase<DataState<List<EmployeeEntity>>, EmployeeEntity>{
  final EmployeeRepository _employeeRepository;

  UpdateEmployeeUseCase(this._employeeRepository);
  @override
  Future<DataState<List<EmployeeEntity>>> call({String? id, EmployeeEntity? params}) async {
    print("params in update employee usecase");
    print(params);
    return await _employeeRepository.updateEmployee(id!,params!);
  }
}