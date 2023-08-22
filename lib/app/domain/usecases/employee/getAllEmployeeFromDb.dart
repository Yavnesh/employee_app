import '../../../../core/resources/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/employee.dart';
import '../../repository/employee_repo.dart';

class GetAllEmployeeFromDbUseCase implements UseCase<List<EmployeeEntity>, void>{
  final EmployeeRepository _employeeRepository;

  GetAllEmployeeFromDbUseCase(this._employeeRepository);
  @override
  Future<List<EmployeeEntity>> call({void params}) async {
    return await _employeeRepository.getAllEmployeeFromDb();
  }
}