import 'package:addpassengers/blocs/blocs.dart';
import 'package:addpassengers/models/Passenger.dart';
import 'package:addpassengers/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddPassenger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Passenger')
      ),
      body: Container(
        alignment: Alignment.center,
        child: BlocBuilder<PassengerBloc, PassengerState>(
          builder: (context, state) {
            if(state is PassengersUninitialized) {
              return buildPanel(context);
            } else if(state is PassengersLoaded) {
              return buildLoaded(context, state.passengers);
            } else if(state is PassengersFiltered) {
              return buildLoaded(context, state.passengers);
            } else if(state is LoadedPanel) {
              return buildPanel(context);
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

  Widget buildPanel(BuildContext context) {
    PanelController _pc = new PanelController();

    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    
    return SlidingUpPanel(
      controller: _pc,
      borderRadius: radius,
      minHeight: 70.0,
      backdropTapClosesPanel: true,
      backdropEnabled: true,
      backdropOpacity: 0.3,
      parallaxEnabled: true,
      panel: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Add Passengers',
                              style: TextStyle(fontSize: 23.0),
                            ),
                            Spacer(),
                            GetLocationButton(),
                            SizedBox(
                              width: 10.0,
                            ),
                            AddPassengerButton()
                          ],
                        ),
                      ),
                      PassengerList(),
                    ],
                  ),
                ),
              ),
            ),
          ]
        )
      ),
    );
  }

  Widget buildLoaded(BuildContext context, List<Passenger> passengers) {
    return Center(
      child: ListView.builder(
        itemCount: passengers.length,
        itemBuilder: (context, index) {
          final passenger = passengers[index];
          return PassengerSelectItem(
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