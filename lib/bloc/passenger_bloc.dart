import 'dart:async';

import 'package:addpassengers/passenger_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:addpassengers/models/Passenger.dart';

part 'passenger_event.dart';
part 'passenger_state.dart';

class PassengerBloc extends Bloc<PassengerEvent, PassengerState> {
  final PassengerRepository repository;

  PassengerBloc({@required this.repository});

  @override
  void onTransition(Transition<PassengerEvent, PassengerState> transition) {
    super.onTransition(transition);
    print(transition);
  }

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
        yield PassengersUninitialized();
      }
    }
  }
}
