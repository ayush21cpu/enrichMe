import 'package:ayush_enrichme_task/views/fitness_plan_list_page.dart';
import 'package:ayush_enrichme_task/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatelessWidget {

  const CheckUser({super.key});

  @override
  Widget build(BuildContext context) {
    return checkUser();
  }
  checkUser() {
    final user= FirebaseAuth.instance.currentUser;
    if(user!=null){
      return const FitnessPlanListPage();
    }else{
      return const LoginPage();
    }
  }
}
