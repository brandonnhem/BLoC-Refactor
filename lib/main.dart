import 'package:addpassengers/blocs/blocs.dart';
import 'package:addpassengers/passenger_repo.dart';
import 'package:addpassengers/screens/passenger_ui.dart';
import 'package:addpassengers/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
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