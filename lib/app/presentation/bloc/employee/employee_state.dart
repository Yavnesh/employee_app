part of 'employee_bloc.dart';

abstract class EmployeeState{
  EmployeeState();
}

class EmployeeListInitial extends EmployeeState{
  final List<EmployeeEntity> currentEmployee;
  final List<EmployeeEntity> previousEmployee;
  EmployeeListInitial({
    required this.currentEmployee,
    required this.previousEmployee
  });
}

class EmployeeAddedToServer extends EmployeeState{
  final List<EmployeeEntity> currentEmployee;
  final List<EmployeeEntity> previousEmployee;
  EmployeeAddedToServer({
    required this.currentEmployee,
    required this.previousEmployee
  });
}

class EmployeeListUpdatedFromCached extends EmployeeState{
  final List<EmployeeEntity> currentEmployee;
  final List<EmployeeEntity> previousEmployee;
  EmployeeListUpdatedFromCached({
    required this.currentEmployee,
    required this.previousEmployee
  });
}

class EmployeeListLoadedFromServer extends EmployeeState{
  final List<EmployeeEntity> currentEmployee;
  final List<EmployeeEntity> previousEmployee;
  EmployeeListLoadedFromServer({
    required this.currentEmployee,
    required this.previousEmployee
  });
}

class EmployeeListUpdatedFromServer extends EmployeeState{
  final List<EmployeeEntity> currentEmployee;
  final List<EmployeeEntity> previousEmployee;
  EmployeeListUpdatedFromServer({
    required this.currentEmployee,
    required this.previousEmployee
  });
}

class EmployeeDeletedFromServer extends EmployeeState{
  final List<EmployeeEntity> currentEmployee;
  final List<EmployeeEntity> previousEmployee;
  EmployeeDeletedFromServer({
    required this.currentEmployee,
    required this.previousEmployee
  });
}

class EmployeeListError extends EmployeeState{
  final String error;
  EmployeeListError({required this.error});
}
