import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  NetworkInfoImpl({
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
