import 'package:addpassengers/models/Passenger.dart';
import 'package:equatable/equatable.dart';

abstract class PassengerEvent extends Equatable {
  const PassengerEvent();

  @override
  List<Object> get props => [];
}

class GetPassengers extends PassengerEvent {}

class UpdatePassengers extends PassengerEvent {
  final Passenger passenger;

  const UpdatePassengers(this.passenger);

  @override 
  List<Object> get props => [passenger];

  @override
  String toString() => 'UpdatePassengers { passenger: $passenger}';
}

class FilterPassengers extends PassengerEvent {
  final List<Passenger> passengers;

  const FilterPassengers(this.passengers);

  @override
  List<Object> get props => [passengers];

  @override
  String toString() => 'FilterPassengers { passengers.selected.length: ${passengers.where((passenger) => passenger.selected == true).length} }';
}

class ConfirmPassengers extends PassengerEvent {
  final List<Passenger> passengers;

  const ConfirmPassengers(this.passengers);

  @override
  List<Object> get props => [passengers];

  @override
  String toString() => 'ConfirmPassengers { passengers.selected.length: ${passengers.where((passenger) => passenger.selected == true).length} }';
}

class RemovePanelPassenger extends PassengerEvent {
  final Passenger passenger;

  const RemovePanelPassenger(this.passenger);

  @override
  List<Object> get props => [passenger];

  @override
  String toString() => 'RemovePanelPassenger { passenger: ${passenger.passenger.displayName} }';
}

class UpdatePanelPassengers extends PassengerEvent {
  final List<Passenger> passengers;
  final Passenger passenger;

  const UpdatePanelPassengers(this.passengers, this.passenger);

  @override
  List<Object> get props => [passengers, passenger];

  @override
  String toString() => 'UpdatePassengersEvent { passenger: $passenger }';
}