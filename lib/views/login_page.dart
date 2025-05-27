import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../services/auth_service.dart';
import '../viewModel/login_viewModle.dart';
import '../viewModel/user_provider.dart';
import 'fitness_plan_list_page.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final loginProvider = Provider.of<LoginViewModel>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Login', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: loginProvider.isLoading
                      ? null
                      : () async {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    final user = await loginProvider.login(email, password);
                    if (user != null) {
                      Provider.of<UserViewModel>(context, listen: false)
                          .setUser(user);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FitnessPlanListPage()),
                      );
                    } else if (loginProvider.error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(loginProvider.error!,
                                style: const TextStyle(
                                    color: Colors.white))),
                      );
                    }
                  },
                  child: loginProvider.isLoading
                      ? LoadingAnimationWidget.inkDrop(
                      color: Colors.white, size: 40)
                      : const Text('Login',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  );
                },
                child: const Text("Don't have an account? Register here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

