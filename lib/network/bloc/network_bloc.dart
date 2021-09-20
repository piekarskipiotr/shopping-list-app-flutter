import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'network_state.dart';

class NetworkBloc extends Cubit<NetworkState> {
  NetworkBloc() : super(InitState());
  Map _source = {ConnectivityResult.none: false};
  Future<void> stateChanged(Map source) async {
    _source = source;
    emit(StateChanged(_source));
  }
}