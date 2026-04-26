import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totalxproject/core/constants/firebase_constants.dart';
import 'package:totalxproject/core/providers/providers.dart';

import '../../../model/user_model.dart';

final homeRepositoryProvider = Provider((ref) => HomeRepository(
    firestore: ref.watch(fireStoreProvider)
),);

class HomeRepository{
  final FirebaseFirestore _firestore;
  HomeRepository({required FirebaseFirestore firestore}) : _firestore = firestore;

  CollectionReference get _user => _firestore.collection(FirebaseConstants.userCollection);

  Stream<List<UserModel>> fetchUsers (){
     return _user.snapshots().map((event) {
       return event.docs.map((e) => UserModel.fromJson(e.data() as Map<String , dynamic>),).toList();
     },);
  }

}