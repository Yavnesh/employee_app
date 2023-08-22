import 'package:flutter_bloc/flutter_bloc.dart';

part 'date_event.dart';
part 'date_state.dart';

class DateBloc extends Bloc<DateEvent, DateState>{
  DateBloc(): super(DateInitial(fromDate: DateTime.now(), toDate: null)){
    on<OnTapEvent>(_onTap);
  }

  void _onTap(OnTapEvent event, Emitter<DateState> emit) {
    emit(DateUpdated(fromDate: event.fromDate, toDate: event.toDate));
  }
}