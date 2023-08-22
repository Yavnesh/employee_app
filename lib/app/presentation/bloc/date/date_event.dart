part of 'date_bloc.dart';

abstract class DateEvent{
  final DateTime fromDate;
  final DateTime? toDate;
  DateEvent({required this.fromDate, required this.toDate});
}

class OnTapEvent extends DateEvent{
  OnTapEvent({required DateTime fromDate, DateTime? toDate}): super(fromDate: fromDate, toDate: toDate);
}