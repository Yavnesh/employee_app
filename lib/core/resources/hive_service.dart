import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static HiveService? hive;

  static HiveService getHive() {
  hive ??= HiveService();
  return hive!;
  }

  Future<bool> isExists({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    return length != 0;
  }

  addBoxes<T>(dynamic response, String boxName) async {
    print("adding boxes "+ boxName);
    final openBox = await Hive.openBox(boxName);
    try{
      openBox.deleteAt(0);
    }catch(exception){
      print("adding boxes exception ${exception}");
    }
    finally{
      openBox.add(response);
      print("openBox");
      print(openBox);
    }
  }

  Future<dynamic> getBoxes(String boxName) async {
    print("getting boxes-> "+boxName);
    final openBox = await Hive.openBox(boxName);
    return openBox.getAt(0) ;
  }
}