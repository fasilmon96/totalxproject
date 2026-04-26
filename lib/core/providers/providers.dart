import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalxproject/core/providers/cloudinary_provider.dart';

final authProvider = Provider((ref) => FirebaseAuth.instance);
final fireStoreProvider = Provider((ref) => FirebaseFirestore.instance);
final storageProvider = Provider((ref) => FirebaseStorage.instance);
final googleSignInProvider = Provider((ref) => GoogleSignIn(),);
final cloudinaryProvider = Provider((ref) => CloudinaryProvider(),);
final imageProvider = StateProvider<File?>((ref) =>null,);



