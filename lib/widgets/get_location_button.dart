import 'package:addpassengers/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetLocationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PassengerBloc, PassengerState>(
      builder: (context, state) { 
        return Container(
          decoration: BoxDecoration(
            // color: _theme == 'Dark' ? Colors.amber : Colors.purple, TODO: add dark mode feature
            color: Colors.purple,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {}, // TODO: add onPressed
            tooltip: "Get Your Current Location",
            iconSize: 36,
            color: Colors.white,
          ),
        );
      }
    );
  }
}