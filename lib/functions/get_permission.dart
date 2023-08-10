 
 import '../constants/const.dart';

bool hasPermission = false;
 
 Future<void> checkAndRequestPermissions({bool retry = false}) async {
  
  hasPermission = await audioQuery.checkAndRequest(retryRequest: retry);
 
}