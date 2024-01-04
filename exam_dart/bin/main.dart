import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class Customer {
  int? id;
  String? fullName;
  DateTime? birthDay;
  String? address;
  int? phoneNumber;

  Customer({this.id,this.fullName, this.birthDay, this.address, this.phoneNumber});

  Map<String, dynamic> toJson() => {
    'id':id,
    'fullName': fullName,
    'birthDay': birthDay,
    'address': address,
    'phoneNumber': phoneNumber
  };
}
final baseUrl = 'http://localhost:8888/api/customer';
Future<void> main() async {
  while (true) {
    print('\nChoose operation:');
    print('1. Create Customer');
    print('2. Get All Customers');
    print('0. Exit');

    var choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        await createCustomer();
        break;
      case 2:
        await readAllCustomers();
        break;
      case 0:
        exit(0);
        break;
      default:
        print('Invalid choice. Please try again.');
    }
  }
}
Future<void> createCustomer() async {
  print('Enter customer details:');

  print('fullName:');
  var fullName = stdin.readLineSync()!;
  print('BirthDay:');
  var birthDay = int.parse(stdin.readLineSync()!);
  print('Address:');
  var address = stdin.readLineSync()!;
  print("phone Number:");
  var phoneNumber= int.parse(stdin.readLineSync()!);

  var customer = Customer(fullName, birthDay, address,phoneNumber);

  var response = await http.post(Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(customer.toJson()));

  if (response.statusCode == 200) {
    print('Customer created successfully.');
  } else {
    print('Error creating customer. Status code: ${response.statusCode}');
  }
}
Future<void> readAllCustomers() async {
  var response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    var customers = jsonDecode(response.body);
    print('All Customers:');
    customers.forEach((customer) {
      print('ID: ${customer['id']}, Name: ${customer['name']}, Age: ${customer['age']}, Address: ${customer['address']}');
    });
  } else {
    print('Error reading customers. Status code: ${response.statusCode}');
  }
}