import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totalxproject/features/home/screen/home_screen.dart';
import 'package:totalxproject/features/user_management/screen/add_user_screen.dart';

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


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap:() {
         FocusManager.instance.primaryFocus?.unfocus();
         },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title:"TOTAL-X PROJECTS",
        home:HomeScreen()
      ),
    );
}}
