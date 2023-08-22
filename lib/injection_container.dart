import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'app/data/data_sources/remote/employee_api_service.dart';
import 'app/data/repository/employee_repo_impl.dart';
import 'app/domain/entities/employee.dart';
import 'app/domain/repository/employee_repo.dart';
import 'app/domain/usecases/employee/addEmployee.dart';
import 'app/domain/usecases/employee/deleteEmployee.dart';
import 'app/domain/usecases/employee/getAllEmployeeFromServer.dart';
import 'app/domain/usecases/employee/getAllEmployeeFromDb.dart';
import 'app/domain/usecases/employee/updateEmployee.dart';
import 'app/presentation/bloc/bottom_sheet/bottom_sheet_bloc.dart';
import 'app/presentation/bloc/date/date_bloc.dart';
import 'app/presentation/bloc/employee/employee_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Dio
  sl.registerSingleton<Dio>(Dio());

  //Hive
  final employeeDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(employeeDirectory.path);
  Hive.registerAdapter(EmployeeEntityAdapter());

  // Dependencies
  sl.registerSingleton<EmployeeApiService>(EmployeeApiService(sl()));

  sl.registerSingleton<EmployeeRepository>(EmployeeRepositoryImpl(sl()));

  sl.registerSingleton<GetAllEmployeeFromServerUseCase>(GetAllEmployeeFromServerUseCase(sl()));

  sl.registerSingleton<AddEmployeeUseCase>(AddEmployeeUseCase(sl()));

  sl.registerSingleton<UpdateEmployeeUseCase>(UpdateEmployeeUseCase(sl()));

  sl.registerSingleton<DeleteEmployeeUseCase>(DeleteEmployeeUseCase(sl()));

  sl.registerSingleton<GetAllEmployeeFromDbUseCase>(GetAllEmployeeFromDbUseCase(sl()));

  sl.registerSingleton<BottomSheetBloc>(BottomSheetBloc());

  sl.registerSingleton<DateBloc>(DateBloc());

  sl.registerFactory<EmployeeBloc>(() => EmployeeBloc(
      getAllEmployeeFromServerUseCase: sl(),
      addEmployeeUseCase: sl(),
      updateEmployeeUseCase: sl(),
      deleteEmployeeUseCase: sl(),
      getAllEmployeeFromDbUseCase: sl(),
      bottomSheetBloc: sl(),
      dateBloc: sl(),
  ));
}
