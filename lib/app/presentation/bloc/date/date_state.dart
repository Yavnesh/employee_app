part of 'date_bloc.dart';

abstract class DateState{
  final DateTime fromDate;
  final DateTime? toDate;
  DateState({required this.fromDate, this.toDate});
}

class DateInitial extends DateState{
  DateInitial({required DateTime fromDate, DateTime? toDate}): super(fromDate: fromDate, toDate: toDate);
}

class DateUpdated extends DateState{
  DateUpdated({required DateTime fromDate, DateTime? toDate}): super(fromDate: fromDate, toDate: toDate);
}