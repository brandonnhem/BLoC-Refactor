import 'package:equatable/equatable.dart';

class UserLocation extends Equatable {
  final double latitude;
  final double longitude;

  UserLocation(this.latitude, this.longitude);

  UserLocation copyWith({double latitude, double longitude}) {
    return UserLocation(
      latitude ?? this.latitude,
      longitude ?? this.longitude
    );
  }

  @override
  List<Object> get props => [latitude, longitude];

  @override
  String toString() => 'UserLocation { latitude: $latitude, longitude: $longitude }';
}