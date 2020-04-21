import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String address;
  final double latitude;
  final double longitude;
  final String state;
  final String city;

  Place(this.address, this.latitude, this.longitude, this.state, this.city);

  Place copyWith({String address, double latitude, double longitude, String state, String city}) {
    return Place(
      address ?? this.address,
      latitude ?? this.latitude,
      longitude ?? this.longitude,
      state ?? this.state,
      city ?? this.city
    );
  }

  @override
  List<Object> get props => [address, latitude, longitude, state, city];

  @override
  String toString() => 'Place { address: $address, latitude: $latitude, longitude: $longitude, state: $state, city: $city }';
}