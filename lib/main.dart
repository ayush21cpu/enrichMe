import 'package:ayush_enrichme_task/viewModel/AssignPlan_ViewModel.dart';
import 'package:ayush_enrichme_task/viewModel/AssignedPlans_viewModel.dart';
import 'package:ayush_enrichme_task/viewModel/fitness_plan_viewModel.dart';
import 'package:ayush_enrichme_task/viewModel/login_viewModle.dart';
import 'package:ayush_enrichme_task/viewModel/register_viewModel.dart';
import 'package:ayush_enrichme_task/viewModel/user_provider.dart';
import 'package:ayush_enrichme_task/views/checkUser.dart';
import 'package:ayush_enrichme_task/views/login_page.dart';
import 'package:ayush_enrichme_task/views/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyBVL4VGG8aaxJXaTNle38zqZo5y_hm21fg',
        appId: '1:239435972827:android:f697245df3a4cacd4b4cfe',
        messagingSenderId: '239435972827',
        projectId: 'flash-chat-9a',
        storageBucket: 'flash-chat-9a.firebasestorage.app',
      )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserViewModel()),
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(create: (_) => RegisterViewModel()),
          ChangeNotifierProvider(create: (_) => FitnessPlanViewModel()),
          ChangeNotifierProvider(create: (_) => AssignPlanViewModel()),
          ChangeNotifierProvider(create: (_) => AssignedPlansViewModel()),

        ],
      child:  MaterialApp(
        title: 'EnrichMe',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
      );
  }
}
