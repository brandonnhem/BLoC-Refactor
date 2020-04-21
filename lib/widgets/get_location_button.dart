import 'package:flutter/material.dart';

class GetLocationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: _theme == 'Dark' ? Colors.amber : Colors.purple, TODO: add dark mode feature
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
}