import 'package:addpassengers/bloc/passenger_bloc.dart';
import 'package:addpassengers/models/Passenger.dart';
import 'package:addpassengers/widgets/loading_indicator.dart';
import 'package:addpassengers/widgets/passenger_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class AddPassenger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Passenger')
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: BlocBuilder<PassengerBloc, PassengerState>(
          builder: (context, state) {
            if(state is PassengersUninitialized) {
              return buildInitial(context);
            } else if(state is PassengersLoaded) {
              return buildLoaded(context, state.passengers);
            } else if(state is PassengersFiltered) {
              return buildLoaded(context, state.passengers);
            } else if(state is PassengersLoading) {
              return LoadingIndicator();
            } else {
              return buildError();
            }
          },
        ),
      ),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildInitial(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('Add Passengers'),
        onPressed: () async {
          final status = await Permission.contacts.request();
          if(status == PermissionStatus.granted) {
            BlocProvider.of<PassengerBloc>(context)
              .add(GetPassengers());
          }
        }
      ) 
    );
  }

  Widget buildLoaded(BuildContext context, List<Passenger> passengers) {
    return Center(
      child: ListView.builder(
        itemCount: passengers.length,
        itemBuilder: (context, index) {
          final passenger = passengers[index];
          return PassengerItem(
            passenger: passenger,
            onCheckboxChanged: (_) {
              BlocProvider.of<PassengerBloc>(context).add(
                UpdatePassengers(passenger)
              );
            });
        },
      )
    );
  }

  Widget floatingActionButton() {
    return BlocBuilder<PassengerBloc, PassengerState>(
      builder: (context, state) {
        if(state is PassengersLoaded) {
          return FloatingActionButton.extended(
            label: Text('Add Passengers'),
            backgroundColor: Colors.amber,
            icon: Icon(Icons.add),
            onPressed: () {
              BlocProvider.of<PassengerBloc>(context).add(
                FilterPassengers(state.passengers)
              );
            },
          );
        } else if(state is PassengersFiltered) {
          return FloatingActionButton.extended(
            label: Text('Confirm Passengers'),
            backgroundColor: Colors.green,
            icon: Icon(Icons.send),
            onPressed: () {
              BlocProvider.of<PassengerBloc>(context).add(
                ConfirmPassengers(state.passengers)
              );
            },
          );
        } else {
          return SizedBox(width: double.infinity);
        }
      },
    );
  }

  Widget buildError() {
    return Center(child: Text('OOPS, something went wrong!'));
  }
}