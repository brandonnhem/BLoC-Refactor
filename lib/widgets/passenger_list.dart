import 'package:addpassengers/blocs/blocs.dart';
import 'package:addpassengers/models/Passenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PassengerBloc, PassengerState>(
      builder: (context, state) {
        if(state is PanelEmpty) {
          return buildEmptyList();
        } else if(state is LoadedPanel) {
          return buildList(context, state.passengers);
        } else {
          return buildEmptyList();
        }
      },
    );
  }

  Widget buildEmptyList() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[100]
          // color: _theme == 'Dark' ? Colors.grey[900] : Colors.grey[100], TODO: implement dark mode
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Try adding some contacts!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[400]
            ),
          ),
        )
      )
    );
  }

  Widget buildList(BuildContext context, List<Passenger> passengers) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[100]
          // color: _theme == 'Dark' ? Colors.grey[900] : Colors.grey[100], TODO: implement dark mode
        ),
        child: ListView.builder(
          itemCount: passengers.length,
          itemBuilder: (BuildContext context, int index) {
          return PassengerListItem(
            index: index,
            onDismissed: (_) {
              final Passenger passenger = passengers[index];
              BlocProvider.of<PassengerBloc>(context).add(
                RemovePanelPassenger(passenger)
              );
              Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('${passenger.passenger.displayName} Removed')));
            },
            onLongPress: () {
              final Passenger passenger = passengers[index];
              BlocProvider.of<PassengerBloc>(context).add(
                UpdatePanelPassengers(passengers, passenger)
              );
            },
            passenger: passengers[index],
          );
        },
        ),
      )
    );
  }
}

class PassengerListItem extends StatelessWidget {
  final Passenger passenger;
  final DismissDirectionCallback onDismissed;
  final GestureLongPressCallback onLongPress;
  final int index;

  PassengerListItem({
    Key key,
    @required this.passenger,
    @required this.onDismissed,
    @required this.onLongPress,
    @required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String noPhoneError = 'NO PHONE NUMBER PROVIDED';
    return Dismissible(
      key: UniqueKey(),
      onDismissed: onDismissed,
      child: Card(
        elevation: 4.0,
        color: passenger.driving ? Colors.amber[300] : null,
        child: ListTile(
          onLongPress: onLongPress,
          leading: (passenger.passenger.avatar != null &&
                passenger.passenger.avatar.length > 0)
            ? CircleAvatar(
                backgroundImage:
                    MemoryImage(passenger.passenger.avatar),
                maxRadius: 30,)
            : CircleAvatar(
                child: Text(passenger.passenger.initials(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  )
                ),
                backgroundColor: Colors.purple,
                maxRadius: 30,
              ),
          title: Text(
            passenger.passenger.displayName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          subtitle: Text(passenger.passenger.phones.isEmpty ? noPhoneError :
            passenger.passenger.phones.first.value.toString()
          ),
          trailing: Text((index + 1).toString()),
        )
      ),
    );
  }
}