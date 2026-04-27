import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totalxproject/core/constants/firebase_constants.dart';
import 'package:totalxproject/core/providers/cloudinary_provider.dart';
import 'package:totalxproject/core/providers/providers.dart';
import 'package:totalxproject/core/providers/utils..dart';
import 'package:totalxproject/model/user_model.dart';

final addUserRepositoryProvider = Provider((ref) => AddUserRepository(
    firestore: ref.watch(fireStoreProvider),
    cloudinaryProvider: ref.watch(cloudinaryProvider)),
);

class AddUserRepository{
  final FirebaseFirestore _firestore;
  final CloudinaryProvider _cloudinaryProvider;

  AddUserRepository({required FirebaseFirestore firestore, required CloudinaryProvider cloudinaryProvider})
      : _firestore = firestore,
        _cloudinaryProvider = cloudinaryProvider;

  CollectionReference get _user => _firestore.collection(FirebaseConstants.userCollection);

  Future<void>addUser({
    required UserModel userModel ,
    required File? imageFile ,
    required BuildContext context
  })async{
     try{

       String imageUrl = "";

       if(imageFile !=null){
          final uploaderUrl = await _cloudinaryProvider.uploadImage(imageFile);
        if(uploaderUrl != null){
           imageUrl = uploaderUrl;
        }else{
          if(context.mounted){
            showSnackBar(context, "Image Upload Failed! Please Try again");
          }
          return;
        }
       }

          final updatedUser = userModel.copyWith(image: imageUrl);
          await _user.doc(updatedUser.uid).set(updatedUser.toJson());
       if (context.mounted) {
         showSnackBar(context, "User Added Successfully!");
         await Future.delayed(const Duration(milliseconds: 1500));
         if (context.mounted) {
           Navigator.pop(context);
         }
       }
     } catch(e){
       if(context.mounted){
         showSnackBar(context, e.toString());
       }
     }
  }

}