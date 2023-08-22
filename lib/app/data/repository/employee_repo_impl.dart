import 'package:dio/dio.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/resources/hive_service.dart';
import '../../domain/entities/employee.dart';
import '../../domain/repository/employee_repo.dart';
import '../data_sources/remote/employee_api_service.dart';
import '../models/employee.dart';

class EmployeeRepositoryImpl implements EmployeeRepository{
  final EmployeeApiService _employeeApiService;

  EmployeeRepositoryImpl(this._employeeApiService);

  @override
  Future<DataState<List<EmployeeModel>>> getAllEmployeeFromServer() async {
    try {
      print("before get api call");
      final httpResponse = await _employeeApiService.getAllEmployee();

      if (httpResponse.response.statusCode == 200) {
        await HiveService.getHive().addBoxes(httpResponse.data, "allEmployee");
        return DataSuccess(httpResponse.data);
      } else {
        print("http response for get api call");
        print(httpResponse);
        return DataFailed(
            DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions,
            )
        );
      }
    } on DioException catch (e) {
      print(e.message);
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<EmployeeModel>>> addEmployee(EmployeeEntity employeeEntity) async {
    try {
      print("before http call request");
      print(employeeEntity);
      final httpResponse = await _employeeApiService.addEmployee(employeeEntity);
      print("httpResponse");
      print(httpResponse);
      if (httpResponse.response.statusCode == 201) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions,
            )
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<EmployeeModel>>> updateEmployee(String id, EmployeeEntity employeeEntity) async {
    try {
      final httpResponse = await _employeeApiService.updateEmployee(id, employeeEntity);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions,
            )
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<EmployeeModel>>> deleteEmployee(String id) async {
    try {
      final httpResponse = await _employeeApiService.deleteEmployee(id);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions,
            )
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<EmployeeEntity>> getAllEmployeeFromDb() async {
    List<EmployeeEntity> employeeList = [];
    String boxname = "allEmployee";
    print("hive db boxname");
    print(boxname);
    await HiveService.getHive().isExists(boxName: boxname).then((value) async {
      print("hive db isExists");
      print(value);
      if (value) {
        await HiveService.getHive().getBoxes(boxname).then((value) {
          print("hive db value");
          value.forEach((item){

            print(item);
          });
          // for (dynamic item in value) {
          //   print(value[0]);
          //   if (item is Map<String, dynamic>) {
          //     EmployeeEntity employeeEntity = EmployeeEntity(
          //       id: item['id'],
          //       name: item['name'],
          //       designation: item['designation'],
          //       startDate: DateTime.parse(item['startDate']),
          //       endDate: item['endDate'] != null ? DateTime.parse(item['endDate']) : null,
          //     );
          //     print("employeeEntity");
          //     print(employeeEntity);
          //     employeeList.add(employeeEntity);
          //   }
          // }
          // employeeEntity = value as List<EmployeeEntity>;
          print("employeeList of get fromdb 1");
          print(employeeList);
        });
      }
    });
print("employeeEntity of get fromdb 2");
print(employeeList);
    return employeeList;
  }
}