import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalxproject/core/common/error_text.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text,)));
}


Future<File?>pickImageGallery() async{

  File?image;

  try {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50
    );
    if(pickedImage != null){
        image = File(pickedImage.path);
    }

  } catch(e){
     ErrorText(error: e.toString());
  }
   return image;
}