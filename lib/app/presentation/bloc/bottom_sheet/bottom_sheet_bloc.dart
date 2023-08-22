import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_sheet_event.dart';
part 'bottom_sheet_state.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  BottomSheetBloc() : super(BottomSheetInitial(item: "Select role")){
    on<BottomSheetItemTap>(_bottomSheetItemTap);
  }

  void _bottomSheetItemTap(BottomSheetItemTap event, Emitter<BottomSheetState> emit) {
    print("event.item");
    print(event.item);
    emit(BottomSheetUpdated(item: event.item));
  }
}