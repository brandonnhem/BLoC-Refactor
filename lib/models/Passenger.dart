import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';

class Passenger extends Equatable {
  final Contact passenger;
  final bool selected;
  final bool driving;

  Passenger(this.passenger, {this.selected = false, this.driving = false});

  Passenger copyWith({Contact passenger, bool driving, bool selected}) {
    return Passenger(
      passenger ?? this.passenger,
      selected: selected ?? this.selected,
      driving: driving ?? this.driving
    );
  }

  @override
  List<Object> get props => [passenger, selected, driving];

  @override
  String toString() {
    return 'Passenger { passenger: ${this.passenger.displayName}, selected: $selected, driving: $driving }'; 
  }
}