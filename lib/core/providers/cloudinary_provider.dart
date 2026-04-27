import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:totalxproject/core/common/error_text.dart';

class CloudinaryProvider{
   static const cloudName = "xxxxxx";
   static const uploadPreset = "xxxxxxx";

   final CloudinaryPublic cloudinary = CloudinaryPublic(cloudName, uploadPreset);

   Future<String?> uploadImage(File imageFile) async{
      try{
        CloudinaryResponse response =  await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            imageFile.path,
            folder: "user_profiles"
          )
        );
        return response.secureUrl;
      } catch(e){
        ErrorText(error: e.toString());
        return null;
      }
   }

}
