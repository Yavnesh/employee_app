import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/constants.dart';
import '../../../domain/entities/employee.dart';
import '../../models/employee.dart';

part 'employee_api_service.g.dart';

@RestApi(baseUrl: employeeAppAPIBaseURL)
abstract class EmployeeApiService{
  factory EmployeeApiService(Dio dio) = _EmployeeApiService;

  @GET('/employee')
  Future<HttpResponse<List<EmployeeModel>>> getAllEmployee();

  @POST('/employee/add')
  Future<HttpResponse<List<EmployeeModel>>> addEmployee(EmployeeEntity employeeEntity);

  @PUT('/employee/update/{id}')
  Future<HttpResponse<List<EmployeeModel>>> updateEmployee(@Path() String id, @Body() EmployeeEntity employeeEntity);

  @DELETE('/employee/delete/{id}')
  Future<HttpResponse<List<EmployeeModel>>> deleteEmployee(@Path() String id);
}
