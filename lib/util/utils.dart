import 'package:connectivity/connectivity.dart';

class Utils{

  static Future<bool> isInternetConnected() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi;
  }

}