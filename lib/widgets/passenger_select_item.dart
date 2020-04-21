import 'package:addpassengers/models/Passenger.dart';
import 'package:flutter/material.dart';

class PassengerSelectItem extends StatelessWidget {
  final Passenger passenger;
  final ValueChanged<bool> onCheckboxChanged;

  PassengerSelectItem({
    Key key,
    @required this.passenger,
    @required this.onCheckboxChanged
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (passenger.passenger.avatar != null && passenger.passenger.avatar.length > 0)
        ? CircleAvatar(backgroundImage: MemoryImage(passenger.passenger.avatar))
        : CircleAvatar(
          backgroundColor: Colors.purple,
          child: Text(
            passenger.passenger.initials(),
            style: TextStyle(
              color: Colors.white
            ),
          )
        ),
      title: Text(passenger.passenger.displayName ?? ""),
      subtitle: passenger.passenger.phones.isNotEmpty
        ? Text(passenger.passenger.phones.first.value.toString())
        : Text(''),
      trailing: Checkbox(
        value: passenger.selected,
        onChanged: onCheckboxChanged,
      ),
    );
  }
}