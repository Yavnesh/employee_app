import 'package:flutter/material.dart';

import '../../app/domain/entities/employee.dart';
import '../../app/presentation/pages/add_employee.dart';
import '../../app/presentation/pages/dashboard.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {

      case '/Dashboard':
        return _materialRoute(Dashboard());

      case '/Add':
        return _materialRoute(
            AddEmployee()
        );

      case '/Update':
        return _materialRoute(
            AddEmployee(employeeEntity: settings.arguments as EmployeeEntity)
        );
      //
      // case '/BookDetails':
      //   return _materialRoute(BookDetailsView(bookEntity: settings.arguments as BookEntity));

      default:
        return _materialRoute(Dashboard());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}