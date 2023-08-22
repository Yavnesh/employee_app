import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../injection_container.dart';
import '../../data/models/employee.dart';
import '../../domain/entities/employee.dart';
import '../bloc/employee/employee_bloc.dart';
import 'add_employee.dart';

class Dashboard extends StatefulWidget {

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  // @override
  // void initState() {
  //   // initializing states
  //   _demoData = [
  //     "Flutter",
  //     "React Native",
  //     "Cordova/ PhoneGap",
  //     "Native Script"
  //   ];
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Employee List",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        body: BlocProvider<EmployeeBloc>(
          create: (context) => sl()..add(const GetAllEmployeeEvent()),
          child: BlocBuilder<EmployeeBloc, EmployeeState>(
            builder: (context, state) {
              print("state of emp bloc");
              print(state);
              if (state is EmployeeListUpdatedFromServer) {
                print(state.currentEmployee);
                print("state.currentEmployee");
                print(state.previousEmployee);
                print("loaded");
                final currentEmployee = state.currentEmployee;
                final previousEmployee = state.previousEmployee;
                return _buildEmployeeList(context, currentEmployee, previousEmployee);
              }
              // if(state is EmployeeAddedToServer){
              //   print(state.currentEmployee);
              //   print("state.currentEmployee");
              //   print(state.previousEmployee);
              //   print("added");
              //   final currentEmployee = state.currentEmployee;
              //   final previousEmployee = state.previousEmployee;
              //   return _buildEmployeeList(context, currentEmployee, previousEmployee);
              // }
              // if(state is EmployeeDeletedFromServer){
              //   print(state.currentEmployee);
              //   print("state.currentEmployee");
              //   print(state.previousEmployee);
              //   print("deleted");
              //   final currentEmployee = state.currentEmployee;
              //   final previousEmployee = state.previousEmployee;
              //   return _buildEmployeeList(context, currentEmployee, previousEmployee);
              // }
              // if(state is EmployeeListUpdatedFromServer){
              //   print(state.currentEmployee);
              //   print("state.currentEmployee");
              //   print(state.previousEmployee);
              //   print("updated");
              //   final currentEmployee = state.currentEmployee;
              //   final previousEmployee = state.previousEmployee;
              //   return _buildEmployeeList(context, currentEmployee, previousEmployee);
              // }
              if (state is EmployeeListInitial) {
                print("initial");
                return Container(
                  color: Colors.grey.shade200,
                  child: Center(
                    child: SvgPicture.asset(
                        "assets/images/no_employee_records.svg"),
                  ),
                );
              }
              return Container(
                color: Colors.grey.shade200,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddEmployee()),);
          },
        ),
      ),
    );
  }

  Widget _buildEmployeeList(BuildContext context, List<EmployeeEntity> currentEmployee, List<EmployeeEntity> previousEmployee ){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 56.0,
                color: Colors.grey.shade300,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Current employees",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0),
                  ),
                ),
              ),
              SizedBox(
                height:
                (MediaQuery.of(context).size.height - 250) * .5,
                child: ListView.builder(
                    itemCount: currentEmployee.length,
                    itemBuilder: (context, index) {
                      final employee = currentEmployee[index];
                      return _buildEmployeeTile(context, employee);
                    }),
              )
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 56.0,
                color: Colors.grey.shade300,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Previous employees",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0),
                  ),
                ),
              ),
              SizedBox(
                height:
                (MediaQuery.of(context).size.height - 250) * .5,
                child: ListView.builder(
                    itemCount: previousEmployee.length,
                    itemBuilder: (context, index) {
                      final employee = previousEmployee[index];
                      return _buildEmployeeTile(context, employee);
                    }),
              ),
            ],
          ),
        ),
        const Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Swipe left to delete",
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
        )
      ],
    );
  }

  Widget _buildEmployeeTile(BuildContext context, EmployeeEntity employee) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/Update', arguments: employee);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Dismissible(
          key: Key(employee.id!),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            sl<EmployeeBloc>().add(DeleteEmployeeEvent(id: employee.id));
            Fluttertoast.showToast(
              msg: "Employee data has been deleted.",
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: const Icon(Icons.delete_outline, color: Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  employee.designation,
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.w400),
                ),
                employee.endDate != null
                    ? Text(
                        "${DateFormat('d MMM yyyy').format(employee.startDate)} - ${DateFormat('d MMM yyyy').format(employee.endDate!)}",
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.w400),
                      )
                    : Text(
                        "From ${DateFormat('d MMM yyyy').format(employee.startDate)}",
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.w400),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
