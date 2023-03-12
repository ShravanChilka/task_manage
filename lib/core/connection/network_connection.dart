// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkConnectionInterface {
  Future<bool> isConnected();
}

class NetworkConnection implements NetworkConnectionInterface {
  final Connectivity connectivity;
  NetworkConnection({
    required this.connectivity,
  });

  @override
  Future<bool> isConnected() async {
    final result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
