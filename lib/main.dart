import 'dart:convert';
import 'dart:io';

void main (){
  print ("_________________________________________________________________________");
  print ("Welcome to contact manager created by ian using dart programming language");
  print ("_________________________________________________________________________");
  print ("_________________________________________________________________________");

  List<Map<String, String>> contacts = [];
  loadContacts(contacts);

  while (true) {
    print ("");
    print ("Choose an option:");
    print ("1. Add contacts");
    print ("2. View contacts");
    print ("3. Update contact");
    print ("4. Delete contact");
    print ("5. Search contact");
    print ("6. Save contacts");
    print ("7. Sort contacts alphabetically");
    print ("8. Exit");
    print ("_________________________________________________________________________");
    print ("Choose an option:");

    String? choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        addContact(contacts);
        break;
      case "2":
        viewContact(contacts);
        break;
      case "3":
        updateContact(contacts);
        break;
      case "4":
        deleteContact(contacts);
        break;
      case "5":
        searchContact(contacts);
        break;
      case "6":
        saveContact(contacts);
        break;
      case "7":
        sortContact(contacts);
        break;
      case "8":
        print ("Exiting the program.");
        exit(0);
      case null:
      default:
        print ("Invalid option. Please try again.");
    }
  }
}

void addContact(List<Map<String, String>> contacts) {
  print ("_________________________________________________________________________");
  print ("Adding a new contact:");
  print ("_________________________________________________________________________");

  print ("Enter first name:");
  String? firstName = stdin.readLineSync();

  print ("Enter last name:");
  String? lastName = stdin.readLineSync();

  print ("Enter email address:");
  String? email = stdin.readLineSync();

  print ("Enter phone number:");
  String? phoneNumber = stdin.readLineSync();

  if (firstName != null && lastName != null && email != null && phoneNumber != null) {
    Map<String, String> contact = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber
    };
    contacts.add(contact);
    print ("Contact added successfully.");
  }
  print ("Contact added successfully.");
}

void viewContact(List<Map<String, String>> contacts) {
  print("_________________________________________________________________________");
  print("Viewing all contacts:");
  print("_________________________________________________________________________");

  if (contacts.isEmpty) {
    print("No contacts found.");
    return;
  }

  for (int i = 0; i < contacts.length; i++) {
    print("Contact ${i + 1}:");
    print("First Name: ${contacts[i]['firstName']}");
    print("Last Name: ${contacts[i]['lastName']}");
    print("Email: ${contacts[i]['email']}");
    print("Phone Number: ${contacts[i]['phoneNumber']}");
    print("_________________________________________________________________________");
  }
}

void updateContact(List<Map<String, String>> contacts) {
  print(
      "_________________________________________________________________________");
  print("Updating a contact:");
  print(
      "_________________________________________________________________________");

  if (contacts.isEmpty) {
    print("No contacts found.");
    return;
  }

  print("Enter the first name of the contact you want to update:");
  String? firstName = stdin.readLineSync();
  // int index = int.parse(stdin.readLineSync()!);

  // if (index < 0 || index >= contacts.length) {
  //   print("Invalid index. Contact not found.");
  //   return;
  // }

  if (firstName == null) {
    print("Invalid first name. Contact not found.");
    return;
  }

  for (var contact in contacts) {
    if (contact['firstName'] == firstName) {
      // print("Enter new first name (Leave blank to keep current):");
      // String? newFirstName = stdin.readLineSync();

      print("Enter new last name (Leave blank to keep current):");
      String? newLastName = stdin.readLineSync();

      print("Enter new email address (Leave blank to keep current):");
      String? newEmail = stdin.readLineSync();

      print("Enter new phone number (Leave blank to keep current):");
      String? newPhoneNumber = stdin.readLineSync();

      if (newLastName != null && newLastName.isNotEmpty){
        contact['lastName'] = newLastName;
      }

      if (newEmail != null && newEmail.isNotEmpty){
        contact['email'] = newEmail;
      }

      if (newPhoneNumber != null && newPhoneNumber.isNotEmpty){
        contact['phoneNumber'] = newPhoneNumber;
      }
      print("Contact updated successfully.");

      // if ((newLastName != null && newLastName.isNotEmpty) && (newEmail != null && newEmail.isNotEmpty) &&
      //     (newPhoneNumber != null && newPhoneNumber.isNotEmpty)) {
      //   contact['lastName'] = newLastName;
      //   contact['email'] = newEmail;
      //   contact['phoneNumber'] = newPhoneNumber;
      //
      //   print("Contact updated successfully.");
      // }
    }
    else {
      print("Contact not found.");
    }
  }
}

void deleteContact(List<Map<String, String>> contacts) {
  print(
      "_________________________________________________________________________");
  print("Deleting a contact:");
  print(
      "_________________________________________________________________________");

  if (contacts.isEmpty) {
    print("No contacts found.");
    return;
  }

  print("Enter the first name of the contact you want to delete:");
  String? firstName = stdin.readLineSync();

  if (firstName == null) {
    print("Invalid first name. Contact not found.");
    return;
  }

  for (var i = 0; i < contacts.length; i++) {
    if (contacts[i]['firstName'] == firstName) {
      contacts.removeAt(i);
      print("Contact deleted successfully.");
      return;
    }
  }

  print("Contact not found.");
}

void searchContact(List<Map<String, String>> contacts) {
  print(
      "_________________________________________________________________________");
  print("Searching for a contact:");
  print(
      "_________________________________________________________________________");

  if (contacts.isEmpty) {
    print("No contacts found.");
    return;
  }

  print("Enter the first name of the contact you want to search for:");
  String? firstName = stdin.readLineSync();

  if (firstName == null) {
    print("Invalid first name. Contact not found.");
    return;
  }

  for (var contact in contacts) {
    if (contact['firstName'] == firstName) {
      print("Contact found:");
      print("First Name: ${contact['firstName']}");
      print("Last Name: ${contact['lastName']}");
      print("Email: ${contact['email']}");
      print("Phone Number: ${contact['phoneNumber']}");
      print("_________________________________________________________________________");
      return;
    }
  }

  print("Contact not found.");
}

void saveContact(List<Map<String, String>> contacts) {
  print(
      "_________________________________________________________________________");
  print("Saving contacts to file:");
  print(
      "_________________________________________________________________________");

  String jsonString = jsonEncode(contacts);

  try {
    File('saves/contacts.json').writeAsStringSync(jsonString);
    print("Contacts saved successfully.");
  } catch (e) {
    print("Error saving contacts to file: $e");
  }
}

void loadContacts(List<Map<String, String>> contacts) {
  print('--- Load Contacts ---');
  File file = File('contacts.json');

  if (file.existsSync()) {
    String jsonString = file.readAsStringSync();
    List<dynamic> jsonList = jsonDecode(jsonString);

    // Convert each map to a Map<String, String> and cast the final list
    List<Map<String, String>> parsedContacts = jsonList.map((contact) {
      return (contact as Map<String, dynamic>).map((key, value) => MapEntry(key, value.toString()));
    }).toList().cast<Map<String, String>>();

    contacts.addAll(parsedContacts);
    print('Contacts loaded from contacts.json.');
  } else {
    print('No saved contacts found.');
  }
}

void sortContact(List<Map<String, String>> contacts) {
  print(
      "_________________________________________________________________________");
  print("Sorting contacts alphabetically:");
  print(
      "_________________________________________________________________________");

  contacts.sort((a, b) => a['firstName']!.compareTo(b['firstName']!));

  print("Contacts sorted successfully.");
}