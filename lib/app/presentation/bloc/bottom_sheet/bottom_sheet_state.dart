part of 'bottom_sheet_bloc.dart';

abstract class BottomSheetState{
  final String item;
  BottomSheetState({required this.item});
}

class BottomSheetInitial extends BottomSheetState{
  BottomSheetInitial({required String item}): super(item: item);
}

class BottomSheetUpdated extends BottomSheetState{
  BottomSheetUpdated({required String item}): super(item: item);
}