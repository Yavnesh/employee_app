import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../../domain/entities/employee.dart';
import '../../../domain/usecases/employee/addEmployee.dart';
import '../../../domain/usecases/employee/deleteEmployee.dart';
import '../../../domain/usecases/employee/getAllEmployeeFromServer.dart';
import '../../../domain/usecases/employee/getAllEmployeeFromDb.dart';
import '../../../domain/usecases/employee/updateEmployee.dart';
import '../bottom_sheet/bottom_sheet_bloc.dart';
import '../date/date_bloc.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState>{

  final GetAllEmployeeFromServerUseCase getAllEmployeeFromServerUseCase;
  final AddEmployeeUseCase addEmployeeUseCase;
  final UpdateEmployeeUseCase updateEmployeeUseCase;
  final DeleteEmployeeUseCase deleteEmployeeUseCase;
  final GetAllEmployeeFromDbUseCase getAllEmployeeFromDbUseCase;
  final BottomSheetBloc bottomSheetBloc;
  final DateBloc dateBloc;

  EmployeeBloc({
    required this.getAllEmployeeFromServerUseCase,
    required this.addEmployeeUseCase,
    required this.updateEmployeeUseCase,
    required this.deleteEmployeeUseCase,
    required this.getAllEmployeeFromDbUseCase,
    required this.bottomSheetBloc,
    required this.dateBloc,
  }): super(EmployeeListInitial(currentEmployee: [], previousEmployee: [])){
    on<GetAllEmployeeEvent>(_getAllEmployee);
    on<AddEmployeeEvent>(_addEmployee);
    on<UpdateEmployeeEvent>(_updateEmployee);
    on<DeleteEmployeeEvent>(_deleteEmployee);
  }


  void _getAllEmployee(GetAllEmployeeEvent event, Emitter<EmployeeState> emit) async {
    try {


print("called");
      final fetchedEmployees = await getAllEmployeeFromServerUseCase();
      print("fetchedEmployees");
      print(fetchedEmployees.data);
      if(fetchedEmployees is DataSuccess && fetchedEmployees.data!.isNotEmpty){
        List<EmployeeEntity> allEmployee = fetchedEmployees.data!;
        List<EmployeeEntity> currentEmployee = allEmployee.where((employee) => employee.endDate == null).toList();
        List<EmployeeEntity> previousEmployee = allEmployee.where((employee) => employee.endDate != null).toList();
        emit(EmployeeListUpdatedFromServer(currentEmployee: currentEmployee, previousEmployee: previousEmployee));
      }else if(fetchedEmployees is DataSuccess && fetchedEmployees.data!.isEmpty){
        emit(EmployeeListInitial(currentEmployee: [], previousEmployee: []));
      }


    } catch (e) {
      print(e.toString());
      print("e.toString()");
      emit(EmployeeListError(error: e.toString()));
    }

  }

  void _addEmployee(AddEmployeeEvent event, Emitter<EmployeeState> emit) async {
    final dataState = await addEmployeeUseCase.call(params: event.employeeModel);
    print("_addEmployee employee bloc");
    print(dataState.data);


    // final fetchedEmployees = await fetchEmployeesFromServer();
    // if(fetchedEmployees.isNotEmpty){
    //   List<EmployeeEntity> currentEmployee = fetchedEmployees.where((employee) => employee.endDate == null).toList();
    //   List<EmployeeEntity> previousEmployee = fetchedEmployees.where((employee) => employee.endDate != null).toList();
    //   emit(EmployeeListUpdatedFromServer(currentEmployee: currentEmployee, previousEmployee: previousEmployee));
    // }

    // final dataState = await getAllEmployeeFromServerUseCase();
    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      print(dataState.data);
      List<EmployeeEntity> allEmployee = dataState.data!;
      List<EmployeeEntity> currentEmployee = allEmployee.where((employee) => employee.endDate == null).toList();
      List<EmployeeEntity> previousEmployee = allEmployee.where((employee) => employee.endDate != null).toList();
      print(currentEmployee);
      print(previousEmployee);
      emit(EmployeeAddedToServer(currentEmployee: currentEmployee, previousEmployee: previousEmployee));
    }else if(dataState is DataSuccess && dataState.data!.isEmpty){
      emit(EmployeeListInitial(currentEmployee: [], previousEmployee: []));
    }
  }

  void _updateEmployee(UpdateEmployeeEvent event, Emitter<EmployeeState> emit) async {
    final dataState = await updateEmployeeUseCase.call(id: event.id ,params: event.employeeModel);
    print("_updateEmployee employee bloc");
    // print(resp);
    // final fetchedEmployees = await fetchEmployeesFromServer();
    // if(fetchedEmployees.isNotEmpty){
    //   List<EmployeeEntity> currentEmployee = fetchedEmployees.where((employee) => employee.endDate == null).toList();
    //   List<EmployeeEntity> previousEmployee = fetchedEmployees.where((employee) => employee.endDate != null).toList();
    //   emit(EmployeeListUpdatedFromServer(currentEmployee: currentEmployee, previousEmployee: previousEmployee));
    // }
    // final dataState = await getAllEmployeeFromServerUseCase();
    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      print(dataState.data);
      List<EmployeeEntity> allEmployee = dataState.data!;
      List<EmployeeEntity> currentEmployee = allEmployee.where((employee) => employee.endDate == null).toList();
      List<EmployeeEntity> previousEmployee = allEmployee.where((employee) => employee.endDate != null).toList();
      emit(EmployeeListUpdatedFromServer(currentEmployee: currentEmployee, previousEmployee: previousEmployee));
    }else if(dataState is DataSuccess && dataState.data!.isEmpty){
      emit(EmployeeListInitial(currentEmployee: [], previousEmployee: []));
    }
  }

  void _deleteEmployee(DeleteEmployeeEvent event, Emitter<EmployeeState> emit) async {
    final dataState = await deleteEmployeeUseCase.call(params: event.id);
    print("_deleteEmployee employee bloc");
    print(dataState);
    // final fetchedEmployees = await fetchEmployeesFromServer();
    // if(fetchedEmployees.isNotEmpty){
    //   List<EmployeeEntity> currentEmployee = fetchedEmployees.where((employee) => employee.endDate == null).toList();
    //   List<EmployeeEntity> previousEmployee = fetchedEmployees.where((employee) => employee.endDate != null).toList();
    //   emit(EmployeeListUpdatedFromServer(currentEmployee: currentEmployee, previousEmployee: previousEmployee));
    // }else{
    //   emit(EmployeeListInitial(currentEmployee: [], previousEmployee: []));
    // }
    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      print(dataState.data);
      List<EmployeeEntity> allEmployee = dataState.data!;
      List<EmployeeEntity> currentEmployee = allEmployee.where((employee) => employee.endDate == null).toList();
      List<EmployeeEntity> previousEmployee = allEmployee.where((employee) => employee.endDate != null).toList();
      emit(EmployeeDeletedFromServer(currentEmployee: currentEmployee, previousEmployee: previousEmployee));
    }else if(dataState is DataSuccess && dataState.data!.isEmpty){
      emit(EmployeeListInitial(currentEmployee: [], previousEmployee: []));
    }
  }

  Future<List<EmployeeEntity>> fetchEmployeesFromServer() async {
    final dataState = await getAllEmployeeFromServerUseCase();
    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      List<EmployeeEntity> allEmployee = dataState.data!;
      return allEmployee;
    }else {
      return [];
    }
  }

  fetchEmployeesFromCache() async {
    final cachedEmployees = await getAllEmployeeFromDbUseCase();
    if(cachedEmployees.isNotEmpty){
      List<EmployeeEntity> currentEmployee = cachedEmployees.where((employee) => employee.endDate == null).toList();
      List<EmployeeEntity> previousEmployee = cachedEmployees.where((employee) => employee.endDate != null).toList();
      return AllEmployees(currentEmployee: currentEmployee, previousEmployee: previousEmployee);
    }else{
      return AllEmployees(currentEmployee: [], previousEmployee: []);
    }
  }
}

class AllEmployees{
  final List<EmployeeEntity> currentEmployee;
  final List<EmployeeEntity> previousEmployee;

  AllEmployees({required this.currentEmployee, required this.previousEmployee});
}