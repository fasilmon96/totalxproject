import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totalxproject/features/home/repository/home_repository.dart';
import 'package:totalxproject/model/user_model.dart';

final homeControllerProvider = Provider((ref) => HomeController(
    homeRepository: ref.watch(homeRepositoryProvider)
),);

final streamUserProvider =StreamProvider((ref) {
   return ref.watch(homeControllerProvider).fetchUser();
},);

class HomeController{
  final HomeRepository _homeRepository;
  HomeController({required HomeRepository homeRepository}) : _homeRepository = homeRepository;


  Stream<List<UserModel>> fetchUser() {
    return _homeRepository.fetchUsers();
}
}