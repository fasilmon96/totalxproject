import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totalxproject/features/user_management/repository/add_user_repository.dart';
import 'package:totalxproject/model/user_model.dart';

final addUserControllerProvider = Provider((ref) =>AddUserController(
    addUserRepository: ref.watch(addUserRepositoryProvider)));

class AddUserController{
  final AddUserRepository _addUserRepository;
  AddUserController({required AddUserRepository addUserRepository}) : _addUserRepository = addUserRepository;


  Future<void>addUser(
      UserModel userModel ,
      File? imageFile ,
      BuildContext context)async{
   await _addUserRepository.addUser(userModel: userModel, imageFile: imageFile, context: context);
  }

}