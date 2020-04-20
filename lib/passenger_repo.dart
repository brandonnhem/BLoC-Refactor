import 'package:addpassengers/models/Passenger.dart';
import 'package:contacts_service/contacts_service.dart';

abstract class PassengerRepository {
  Future<void> getContacts();
  void populatePassengers(Iterable<Contact> contacts);
  List<Passenger> getPassengers();
}

class PassengerRepo implements PassengerRepository {
  List<Passenger> passengers;

  @override
  Future<void> getContacts() async {
    var contacts = await ContactsService.getContacts();
    populatePassengers(contacts);    
  }

  @override
  void populatePassengers(Iterable<Contact> contacts) {
    var _contacts = contacts.where((element) => element.displayName != null).toList();
    _contacts.sort((a, b) => a.displayName.compareTo(b.displayName));
    passengers = _contacts.map((contact) => Passenger(contact)).toList();
  }

  @override
  List<Passenger> getPassengers() => passengers;
}

class PassengerError extends Error {}