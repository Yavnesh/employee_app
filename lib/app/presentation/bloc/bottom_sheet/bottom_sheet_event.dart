part of 'bottom_sheet_bloc.dart';

abstract class BottomSheetEvent{
  final String item;
  BottomSheetEvent({required this.item});
}

class BottomSheetItemTap extends BottomSheetEvent{
  BottomSheetItemTap({required String item}) : super(item: item);
}