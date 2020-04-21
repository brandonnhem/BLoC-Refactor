import 'package:equatable/equatable.dart';

import 'models.dart';

class Trip extends Equatable {
  final DateTime date;
  final double miles;
  final List<Passenger> passengers;
  final Map<Passenger, bool> passengersPaid;
  final double price;
  final double pricePerPassenger;
  final List<double> latLong;

  Trip(this.date, this.miles, this.passengers, this.passengersPaid, this.price, this.pricePerPassenger, this.latLong);

  Trip copyWith({DateTime date, double miles, List<Passenger> passengers, Map<Passenger, bool> passengersPaid, double price, double pricePerPassenger, List<double> latLong}) {
    return Trip(
      date ?? this.date,
      miles ?? this.miles,
      passengers ?? this.passengers,
      passengersPaid ?? this.passengersPaid,
      price ?? this.price,
      pricePerPassenger ?? this.pricePerPassenger,
      latLong ?? this.latLong
    );
  }

  @override
  List<Object> get props => [date, miles, passengers, passengersPaid, price, pricePerPassenger, latLong];

  @override
  String toString() => 
  'Trip { date: $date, miles: $miles, passengers: $passengers, passengersPaid: $passengersPaid, price: $price, pricePerPassenger: $pricePerPassenger, latLong: $latLong }';
}