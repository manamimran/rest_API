import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'model_class.dart';


class ApiProvider with ChangeNotifier {
  List<ModelClass> dataList = [];

  Future<void> getApi() async {
    final response =
    await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    final data = jsonDecode(response.body.toString());
    //print(data);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> user in data['data']) {
        dataList.add(ModelClass(
          id: user["id"],
          email: user['email'],
          firstName: user['first_name'],
          lastName: user['last_name'],
          avatar: user['avatar'],
        ));
      }
    } else {
      print('Error: $e');
      throw Exception('Failed to fetch data');
    }
    notifyListeners();
  }

  Future<void> postApi(int id, String name, String job) async {
    final response = await http.post(
      Uri.parse("https://reqres.in/api/users"),
      body: {
        'id': 1.toString(),
        'name': 'Manam',
        'job': 'Intern',
      },
    );

    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 201) {
      // If the POST request is successful, you can handle the response data here
      print(data);
      // print('Created At: ${data['createdAt']}');
    } else {
      // If the POST request fails, throw an exception
      print('Error: $e');
      throw Exception('Failed to create user');
    }

    notifyListeners();
  }
}





// try {
// var request = http.MultipartRequest(
// 'POST',
// Uri.parse(
// "https://example.com/api/users") // Replace with your API endpoint
// );
//
// // Add text fields
// request.fields['id'] ='id';
// request.fields['name'] = 'name';
// request.fields['job'] = 'job';
//
// // File imageFile = File('assets/images/imageFile.jpg');
// // Use the imageFile parameter directly
// var image = await http.MultipartFile.fromPath('avatar',imageFile.path);
// request.files.add(image);
//
// // Send the request
// var response = await request.send();
//
// // Read the response
// var responseData = await response.stream.bytesToString();
//
// if (response.statusCode == 201) {
// // If the POST request is successful, handle the response data here
// print('User created successfully:');
// print('Response Data: $responseData');
// } else {
// // If the POST request fails, throw an exception
// print('Error: ${response.statusCode}');
// print('Message: $responseData');
// throw Exception('Failed to create user');
// }
// } catch (e) {
// // Catch any exceptions that might occur during the process
// print('Error: $e');
// throw Exception('Failed to create user');
// }