import 'dart:async';

import 'package:addpassengers/passenger_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:addpassengers/models/models.dart';
import 'package:addpassengers/blocs/passenger/passenger.dart';

class PassengerBloc extends Bloc<PassengerEvent, PassengerState> {
  final PassengerRepository repository;

  PassengerBloc({@required this.repository});

  @override
  PassengerState get initialState => PassengersUninitialized();

  @override
  Stream<PassengerState> mapEventToState(
    PassengerEvent event
  ) async* {
    if(event is GetPassengers) {
      yield PassengersLoading();
      try {
        await repository.getContacts();
        final passengers = repository.getPassengers();
        yield PassengersLoaded(passengers: passengers);
      } catch (_) {
        final String error = 'Cannot retrieve contact list';
        yield PassengersError(error);
      }
    } else if(event is UpdatePassengers) {
      final passengerState = state;
      if(passengerState is PassengersLoaded) {
        final List<Passenger> passengers = 
          List<Passenger>.from(passengerState.passengers).map((Passenger passenger){
            return passenger == event.passenger ? passenger.copyWith(selected: !passenger.selected) : passenger;
          }).toList();
        yield PassengersLoaded(passengers: passengers);
      } else if(passengerState is PassengersSelected) { // TODO: fix this, logic is not right
        final List<Passenger> passengers = 
          List<Passenger>.from(passengerState.passengers).map((Passenger passenger){
            return passenger == event.passenger ? passenger.copyWith(driving: true) : passenger;
          }).toList();
        yield PassengersSelected(passengers: passengers);
      }
    } else if(event is FilterPassengers) {
      final passengerState = state;
      if(passengerState is PassengersLoaded) {
        final List<Passenger> passengers =
          List<Passenger>.from(passengerState.passengers).where((Passenger passenger) => passenger.selected == true).toList();
        yield PassengersFiltered(passengers: passengers);
      }
    } else if(event is ConfirmPassengers) {
      final passengerState = state;
      if(passengerState is PassengersFiltered) {
        yield LoadedPanel(passengers: passengerState.passengers); // TODO: change to PassengersInitialized/Finalized?
      }
    } else if(event is RemovePanelPassenger) {
      final panelState = state;
      if(panelState is LoadedPanel) {
        final List<Passenger> passengers =
          List<Passenger>.from(panelState.passengers)
            .where((passenger) => passenger != event.passenger).toList();
        if(passengers.where((Passenger passenger) => passenger.selected == true).length >= 1) {
          yield LoadedPanel(passengers: passengers);
        } else {
          yield PassengersUninitialized();
        }
      }
    } else if(event is UpdatePanelPassengers) {
      final panelState = state;
      if(panelState is LoadedPanel) {
        for(int i = 0; i < panelState.passengers.length; i++) {
          if(panelState.passengers[i].driving == true) {
            panelState.passengers[i].copyWith(driving: false);
          }
        }
        final List<Passenger> tempPassengers =
          List<Passenger>.from(panelState.passengers).map((Passenger passenger){
            return passenger.copyWith(driving: false); // make sure all selected drivings are no longer driving 
          }).toList();
        final List<Passenger> passengers =
          List<Passenger>.from(tempPassengers).map((Passenger passenger){
            return passenger == event.passenger ? passenger.copyWith(driving: true) : passenger;
          }).toList();
        yield LoadedPanel(passengers: passengers);
      }
    }
  }
}
