import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/employee.dart';
import '../../repository/employee_repo.dart';

class GetAllEmployeeFromServerUseCase implements UseCase<DataState<List<EmployeeEntity>>, void>{
  final EmployeeRepository _employeeRepository;

  GetAllEmployeeFromServerUseCase(this._employeeRepository);
  @override
  Future<DataState<List<EmployeeEntity>>> call({void params}) async {
    return await _employeeRepository.getAllEmployeeFromServer();
  }
}