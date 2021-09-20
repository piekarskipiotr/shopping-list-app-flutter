import 'package:equatable/equatable.dart';

abstract class NetworkState extends Equatable{
  @override
  List<Object?> get props => [];
}

class InitState extends NetworkState {}
class StateChanged extends NetworkState {
  final Map source;
  StateChanged(this.source);

  @override
  List<Object?> get props => [source];
}