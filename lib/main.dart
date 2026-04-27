import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totalxproject/core/common/error_text.dart';
import 'package:totalxproject/core/common/loader.dart';
import 'package:totalxproject/features/auth/controller/auth_controller.dart';
import 'package:totalxproject/features/home/screen/home_screen.dart';


import 'features/auth/screen/login_screen.dart';
import 'firebase_options.dart';

void main()async{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
  runApp(ProviderScope(
      child: MyApp()
  ));
}


class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateChangeProvider);
    return  GestureDetector(
      onTap:() {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title:"TOTAL-X PROJECTS",
          home: authState.when(
              data: (admin) {
                if(admin != null){
                  return ref.watch(userDataProvider(admin.uid)).when(
                      data: (adminModel) {
                        if(adminModel == null) return const LoginScreen();
                       WidgetsBinding.instance.addPostFrameCallback((_) {
                         if (ref.read(adminProvider) != adminModel) {
                           ref.read(adminProvider.notifier).update((state) => adminModel);
                         }
                       },);
                       return const HomeScreen();
                      },
                      error: (error, stackTrace) => ErrorText(error: error.toString()),
                      loading: () => Loader(),
                  );
                }
                return const LoginScreen();
              },
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => Loader(),
          )
      ),
    );
  }
}
