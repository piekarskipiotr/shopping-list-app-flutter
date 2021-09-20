import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/network_bloc.dart';
import 'network_connectivity.dart';

class NetworkListener {
  NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  BuildContext context;
  NetworkListener(this.context) : super() {
    _networkConnectivity
      ..initialise()
      ..myStream.listen((source) {
        BlocProvider.of<NetworkBloc>(context).stateChanged(source);
      });
  }
}