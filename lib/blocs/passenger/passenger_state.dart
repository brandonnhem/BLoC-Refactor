import 'package:addpassengers/models/Passenger.dart';
import 'package:equatable/equatable.dart';

abstract class PassengerState extends Equatable {
  const PassengerState();

  @override
  List<Object> get props => [];
}

class PassengersUninitialized extends PassengerState {}

class PassengersLoading extends PassengerState {}

class PassengersError extends PassengerState {
  final String error;

  const PassengersError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PassengersError { error: $error }';
}

class PassengersLoaded extends PassengerState {
  final List<Passenger> passengers;

  const PassengersLoaded({this.passengers});

  @override
  List<Object> get props => [passengers];

  @override
  String toString() => 
  'PassengersLoaded { passengers.length: ${passengers.length}, passengers.selected.length: ${passengers.where((passenger) => passenger.selected == true).length} }';
}

class PassengersFiltered extends PassengerState {
  final List<Passenger> passengers;

  const PassengersFiltered({this.passengers});

  @override
  List<Object> get props => [passengers];

  @override
  String toString() => 
  'PassengersFiltered { passengers.selected.length: ${passengers.where((passenger) => passenger.selected == true).length} }';
}

class PassengersSelected extends PassengerState {
  final List<Passenger> passengers;

  const PassengersSelected({this.passengers});

  @override
  List<Object> get props => [passengers];

  @override
  String toString() => 
  'PassengersSelected { passengers.selected.length: ${passengers.where((passenger) => passenger.selected == true).length} }';
}

//// panel

class PanelEmpty extends PassengerState {}

class LoadingPanel extends PassengerState {}

class LoadedPanel extends PassengerState {
  final List<Passenger> passengers;

  const LoadedPanel({this.passengers});

  @override
  List<Object> get props => [passengers];

  @override
  String toString() => 
  'LoadedPanel { passengers.selected.length: ${passengers.where((passenger) => passenger.selected == true).length} }';
}

class PanelOpen extends PassengerState {}

class PanelClosed extends PassengerState {}