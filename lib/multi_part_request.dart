import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class MultiPartTask extends StatefulWidget{

  @override
  State<MultiPartTask> createState() => _MultiPartTaskState();
}
                                                           // is a class provided by the Dart I/O library for working with files. In this context, it represents the selected image file.
class _MultiPartTaskState extends State<MultiPartTask> {   // State<MultiPartTask> The state class contains the logic for image picking and uploading.
  File? _selectedImage;                        //A variable that holds the selected image file. Initially, it's null as no image is selected.
  bool isUploading = false;                    // A boolean flag to track whether an image is currently being uploaded.

  //function for pickimage
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      // No image selected.
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);         //The picked image is then stored in the _selectedImage variable
    });
  }

  //function for uploadImage
  Future<void> _uploadImage() async {
    if (_selectedImage == null) {
      // No image to upload.
      return;
    }
    setState(() {
      isUploading = true;
    });
    try {
      final url = Uri.parse('https://httpbin.org/post');
      final request = http.MultipartRequest('POST', url);
      // final mimeType = lookupMimeType(_selectedImage!.path) ?? 'application/octet-stream';
      final file = await http.MultipartFile.fromPath('image', _selectedImage!.path);
         // , contentType: MediaType.parse(mimeType));
      request.files.add(file);
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        // Image uploaded successfully
        print('Image uploaded successfully.');
      } else {
        // Handle the error
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error uploading image: $e');
    }
    // finally {
    //   setState(() {
    //     isUploading = false;
    //   });
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage == null
                ? Text('No image selected.')
                : SizedBox(
                height: 100,
                width: 100,
                child: Image.file(_selectedImage!)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isUploading ? null : _pickImage,
              child: Text('Pick Image from Gallery'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isUploading ? null : _uploadImage,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}