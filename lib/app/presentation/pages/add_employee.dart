import 'package:employee_app/app/presentation/widgets/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../injection_container.dart';
import '../../domain/entities/employee.dart';
import '../bloc/bottom_sheet/bottom_sheet_bloc.dart';
import '../bloc/date/date_bloc.dart';
import '../bloc/employee/employee_bloc.dart';

class AddEmployee extends StatelessWidget {
  final EmployeeEntity? employeeEntity;

  AddEmployee({Key? key, this.employeeEntity}) : super(key: key);

  final nameController = TextEditingController();
  final List<String> designationArray = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner"
  ];
  final bottomSheetBloc = sl<BottomSheetBloc>();
  final dateBloc = sl<DateBloc>();
  final employeeBloc = sl<EmployeeBloc>();

  @override
  Widget build(BuildContext context) {
    String role = "";
    DateTime fromDate = DateTime.now();
    DateTime? toDate;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          title: Text(
            employeeEntity != null
                ? "Edit Employee Details"
                : "Add Employee Details",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                      top: 16.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: employeeEntity != null
                          ? TextFormField(
                              controller: TextEditingController(
                                  text: employeeEntity?.name),
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Employee name",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade500),
                                prefixIcon: const Icon(
                                  Icons.person_2_outlined,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          : TextFormField(
                              controller: nameController,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Employee name",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade500),
                                prefixIcon: const Icon(
                                  Icons.person_2_outlined,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                    ),
                  ),
                  BlocProvider<BottomSheetBloc>(
                    create: (_) => bottomSheetBloc,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 12.0,
                        top: 16.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: BlocBuilder<BottomSheetBloc, BottomSheetState>(
                          builder: (context, state) {
                            if (state is BottomSheetUpdated) {
                              role = state.item;
                              return TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: role,
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  prefixIcon: const Icon(
                                    Icons.business_center_outlined,
                                    color: Colors.blue,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.blue,
                                  ),
                                ),
                                onTap: () {
                                  showBottomSheet(context);
                                },
                              );
                            } else if (state is BottomSheetInitial) {
                              print(state.item);
                              print("state.item");
                              print(role);
                              role = state.item;
                              return employeeEntity != null
                                  ? TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: employeeEntity?.designation,
                                        hintStyle: const TextStyle(
                                            color: Colors.black),
                                        prefixIcon: const Icon(
                                          Icons.business_center_outlined,
                                          color: Colors.blue,
                                        ),
                                        suffixIcon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      onTap: () {
                                        showBottomSheet(context);
                                      },
                                    )
                                  : TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: role,
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade500),
                                        prefixIcon: const Icon(
                                          Icons.business_center_outlined,
                                          color: Colors.blue,
                                        ),
                                        suffixIcon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      onTap: () {
                                        showBottomSheet(context);
                                      },
                                    );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ),
                  ),
                  BlocProvider<DateBloc>(
                    create: (_) => dateBloc,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, top: 12.0),
                            child: BlocBuilder<DateBloc, DateState>(
                              builder: (context, state) {
                                if (state is DateUpdated) {
                                  String today = DateFormat('d MMM yyyy')
                                      .format(DateTime.now());
                                  String extractedDate =
                                      DateFormat('d MMM yyyy')
                                          .format(state.fromDate);
                                  if (today == extractedDate) {
                                    extractedDate = "Today";
                                  }
                                  print("extractedDate from update");
                                  print(extractedDate);
                                  return ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0),
                                        side: BorderSide(
                                            color: Colors.grey.shade300),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        elevation: 0.0),
                                    onPressed: () async {
                                      DateTime? selected = await showCustomDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                        isFromDate: true,
                                      );
                                      if (selected != null) {
                                        fromDate = selected;
                                        dateBloc.add(
                                            OnTapEvent(fromDate: selected, toDate: state.toDate));
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.event,
                                      color: Colors.blue,
                                    ),
                                    label: Text(
                                      extractedDate,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  );
                                } else if (state is DateInitial) {
                                  String today = DateFormat('d MMM yyyy')
                                      .format(DateTime.now());
                                  String extractedDate =
                                      DateFormat('d MMM yyyy')
                                          .format(state.fromDate);
                                  if (today == extractedDate) {
                                    extractedDate = "Today";
                                  }
                                  print("extractedDate from initial");
                                  print(extractedDate);
                                  return ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0),
                                        side: BorderSide(
                                            color: Colors.grey.shade300),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        elevation: 0.0),
                                    onPressed: () async {
                                      DateTime? selected = await showCustomDatePicker(
                                        context: context,
                                        initialDate: employeeEntity != null
                                            ? employeeEntity!.startDate
                                            : DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                        isFromDate: true,
                                      );
                                      if (selected != null) {
                                        fromDate = selected;
                                        dateBloc.add(
                                            OnTapEvent(fromDate: selected, toDate: state.toDate));
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.event,
                                      color: Colors.blue,
                                    ),
                                    label: Text(
                                      employeeEntity != null
                                          ? DateFormat('d MMM yyyy')
                                              .format(employeeEntity!.startDate)
                                          : extractedDate,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 16.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 12.0, top: 12.0),
                            child: BlocBuilder<DateBloc, DateState>(
                                builder: (context, state) {
                              if (state is DateUpdated &&
                                  state.toDate != null) {
                                toDate = state.toDate;
                                String extractedDate = DateFormat('d MMM yyyy')
                                    .format(state.toDate!);
                                print("extractedDate to update");
                                print(extractedDate);
                                return ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      side: BorderSide(
                                          color: Colors.grey.shade300),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      elevation: 0.0),
                                  onPressed: () async {
                                    DateTime? selected = await showCustomDatePicker(
                                      context: context,
                                        initialDate: toDate!,
                                      firstDate: state.fromDate,
                                      lastDate: DateTime(2101),
                                      isFromDate: false,
                                    );
                                    if (selected != null) {
                                      dateBloc.add(OnTapEvent(
                                          fromDate: state.fromDate,
                                          toDate: selected));
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.event,
                                    color: Colors.blue,
                                  ),
                                  label: Text(
                                    extractedDate,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              } else if(state is DateInitial) {
                                // String today = DateFormat('d MMM yyyy')
                                //     .format(DateTime.now());
                                // String extractedDate =
                                // DateFormat('d MMM yyyy')
                                //     .format(state.fromDate);
                                //
                                print("extractedDate to initial");
                                print(state.toDate);
                                // print(extractedDate);
                                return ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      side: BorderSide(
                                          color: Colors.grey.shade300),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      elevation: 0.0),
                                  onPressed: () async {
                                    DateTime? selected = await showCustomDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: state.fromDate,
                                      lastDate: DateTime(2101),
                                      isFromDate: false,
                                    );
                                    if (selected != null) {
                                      dateBloc.add(OnTapEvent(
                                          fromDate: state.fromDate,
                                          toDate: selected));
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.event,
                                    color: Colors.blue,
                                  ),
                                  label: Text(
                                    "No date",
                                    style:
                                        TextStyle(color: Colors.grey.shade300),
                                  ),
                                );
                              }
                              return SizedBox();

                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.grey.shade300))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          foregroundColor: Colors.blue,
                        ),
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Save"),
                        onPressed: () {
                          print(nameController.text);
                          print("nameController.text");
                          print(employeeEntity?.name);
                          print(DateTime.now());

                          print(role);
                          print(fromDate);
                          print(toDate);

                          if (employeeEntity != null) {
                            final employeeModel = EmployeeEntity(
                                name: nameController.text.isEmpty ? employeeEntity!.name : nameController.text,
                                designation: employeeEntity!.designation != "Select role" ? employeeEntity!.designation : role,
                                startDate: fromDate,
                                endDate: toDate);
                            print("update employee model");
                            print(employeeModel);
                            employeeBloc.add(UpdateEmployeeEvent(
                                id: employeeEntity!.id,
                                employeeModel: employeeModel));
                            Fluttertoast.showToast(
                              msg: "Employee details have been updated.",
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                            );
                            Navigator.pop(context);
                          }else{
                            if (nameController.text.isNotEmpty){
                              if (role != "Select role"){
                                final employeeModel = EmployeeEntity(
                                    name: nameController.text,
                                    designation: role,
                                    startDate: fromDate,
                                    endDate: toDate);
                                print("add employeeModel");
                                print(employeeModel);
                                employeeBloc.add(AddEmployeeEvent(
                                    employeeModel: employeeModel));

                                Fluttertoast.showToast(
                                  msg: "Employee details have been added.",
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                );
                                nameController.clear();
                                dateBloc.add(OnTapEvent(fromDate: DateTime.now(), toDate: null));
                                bottomSheetBloc.add(BottomSheetItemTap(item: "Select role"));
                                Navigator.pop(context);
                              }else{
                                Fluttertoast.showToast(
                                  msg: "Please select employee role.",
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                );
                              }
                            }else{
                              Fluttertoast.showToast(
                                msg: "Please enter employee name.",
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: Wrap(
              children: designationArray.asMap().entries.map(
                (entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return _buildListTile(item, index, context);
                },
              ).toList(),
            ),
          );
        },
      );

  Widget _buildListTile(String title, int index, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
        title: Center(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
          ),
        ),
        onTap: () {
          bottomSheetBloc.add(BottomSheetItemTap(item: title));
          Navigator.pop(context);
        },
      ),
    );
  }
}

