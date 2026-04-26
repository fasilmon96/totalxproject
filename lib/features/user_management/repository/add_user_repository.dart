import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totalxproject/core/common/error_text.dart';
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
        String? imageUrl =  await _cloudinaryProvider.uploadImage(imageFile!);
        if(imageUrl != null){
          final updatedUser = userModel.copyWith(image: imageUrl);
          await _user.doc(updatedUser.uid).set(updatedUser.toJson());
          if (context.mounted) {
            showSnackBar(context, "User Added Successfully...");
          }
        }
     } catch(e){
       ErrorText(error: e.toString());
     }
  }

}