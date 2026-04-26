import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalxproject/core/common/error_text.dart';
import 'package:totalxproject/core/constants/text_constants.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(
      text,style: AppTextStyles.title.copyWith(
      color: Colors.white,
      fontSize: 20
    )
    )));
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