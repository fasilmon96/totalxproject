import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totalxproject/features/auth/controller/auth_controller.dart';
import 'package:totalxproject/features/auth/screen/login_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Text("HomeScreen"),
    );
  }
}
