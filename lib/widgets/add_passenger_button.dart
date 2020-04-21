import 'package:addpassengers/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class AddPassengerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PassengerBloc, PassengerState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            // color: _theme == 'Dark' ? Colors.amber : Colors.purple, TODO: add dark mode feature
            color: Colors.purple,
            shape: BoxShape.circle
          ),
          child: IconButton(
            icon: Icon(Icons.group_add),
            onPressed: () async {
              final status = await Permission.contacts.request();
              if(status == PermissionStatus.granted) {
                BlocProvider.of<PassengerBloc>(context)
                  .add(GetPassengers());
              }
            },
            tooltip: "Add Passengers to a Trip",
            iconSize: 36,
            color: Colors.white,
          ),
        );
      }
    );
  }
}