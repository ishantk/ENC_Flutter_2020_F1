import 'package:connectivity/connectivity.dart';

class Utils{

  // static variables will be in the memory till time app is running
  static String UID = "";

  static Future<bool> isInternetConnected() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi;
  }

}