import 'package:addpassengers/bloc/passenger_bloc.dart';
import 'package:addpassengers/passenger_repo.dart';
import 'package:addpassengers/screens/passenger_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Passenger',
      home: BlocProvider(
        create: (context) => PassengerBloc(repository: PassengerRepo()),
        child: AddPassenger(),
      )
    );
  }
}