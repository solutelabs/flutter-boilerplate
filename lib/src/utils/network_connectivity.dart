import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_base_project/src/utils/custom_exceptions.dart';

abstract class NetworkConnectivityChecker {
  Future<bool> isNetworkAvailable();

  Future<void> validateNetworkConnectivity();
}

final NetworkConnectivityChecker _instance =
    NetworkConnectivity(Connectivity());

NetworkConnectivityChecker networkConnectivityChecker() {
  return _instance;
}

class NetworkConnectivity implements NetworkConnectivityChecker {
  Connectivity connectivity;

  NetworkConnectivity(this.connectivity);

  @override
  Future<bool> isNetworkAvailable() async {
    final result = await connectivity.checkConnectivity();
    return _isNetworkAvailable(result);
  }

  @override
  Future<void> validateNetworkConnectivity() async {
    final result = await connectivity.checkConnectivity();
    if (!_isNetworkAvailable(result)) {
      throw NoNetworkException();
    }
  }

  bool _isNetworkAvailable(ConnectivityResult result) {
    return [
      ConnectivityResult.mobile,
      ConnectivityResult.wifi,
    ].contains(result);
  }
}
