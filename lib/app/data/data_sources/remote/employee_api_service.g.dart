// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _EmployeeApiService implements EmployeeApiService {
  _EmployeeApiService(
      this._dio, {
        this.baseUrl,
      }) {
    baseUrl ??= 'https://employee-app-server.onrender.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<List<EmployeeModel>>> getAllEmployee() async {
    print("api get called in .g.dart");
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<List<EmployeeModel>>>(Options(
          method: 'GET',
          headers: _headers,
          extra: _extra,
        )
            .compose(
          _dio.options,
          '/employee',
          queryParameters: queryParameters,
          data: _data,
        )
            .copyWith(
            baseUrl: baseUrl ?? _dio.options.baseUrl)));
    List<EmployeeModel> value = _result.data!['allEmployees']
        .map<EmployeeModel>((dynamic i) => EmployeeModel.fromJson(i as Map<dynamic, dynamic>)).toList();
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<List<EmployeeModel>>> addEmployee(
      EmployeeEntity employeeEntity) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic> _data = {"id":employeeEntity.id, "employee_name": employeeEntity.name, "employee_designation": employeeEntity.designation, "start_date": employeeEntity.startDate.toIso8601String(), "end_date": employeeEntity.endDate?.toIso8601String()};
    final _result =
    await _dio.fetch<Map<String, dynamic>>(_setStreamType<HttpResponse<List<EmployeeModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
      _dio.options,
      '/employee/add',
      queryParameters: queryParameters,
      data: _data,
    )
        .copyWith(
        baseUrl: baseUrl ?? _dio.options.baseUrl)));
    print("inside add");
    List<EmployeeModel> value = _result.data!['allEmployees']
        .map<EmployeeModel>((dynamic i) => EmployeeModel.fromJson(i as Map<dynamic, dynamic>)).toList();
    print(value);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<List<EmployeeModel>>> updateEmployee(
      String id,
      EmployeeEntity employeeEntity,
      ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic> _data = {"employee_name": employeeEntity.name, "employee_designation": employeeEntity.designation, "start_date": employeeEntity.startDate.toIso8601String(), "end_date": employeeEntity.endDate?.toIso8601String()};
    final _result =
    await _dio.fetch<Map<String, dynamic>>(_setStreamType<HttpResponse<List<EmployeeModel>>>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
        .compose(
      _dio.options,
      '/employee/update/${id}',
      queryParameters: queryParameters,
      data: _data,
    )
        .copyWith(
        baseUrl: baseUrl ?? _dio.options.baseUrl)));
    List<EmployeeModel> value = _result.data!['allEmployees']
        .map<EmployeeModel>((dynamic i) => EmployeeModel.fromJson(i as Map<dynamic, dynamic>)).toList();
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<List<EmployeeModel>>> deleteEmployee(String id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result =
    await _dio.fetch<Map<String, dynamic>>(_setStreamType<HttpResponse<List<EmployeeModel>>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
        .compose(
      _dio.options,
      '/employee/delete/${id}',
      queryParameters: queryParameters,
      data: _data,
    )
        .copyWith(
        baseUrl: baseUrl ?? _dio.options.baseUrl)));
    List<EmployeeModel> value = _result.data!['allEmployees']
        .map<EmployeeModel>((dynamic i) => EmployeeModel.fromJson(i as Map<dynamic, dynamic>)).toList();
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}