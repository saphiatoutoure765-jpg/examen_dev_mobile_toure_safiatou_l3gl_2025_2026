import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/loading_indicator.dart';
import '../home/home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final success = await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (success) {

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
            (route) => false,
      );

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.error ?? "Erreur de connexion"),
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Connexion"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(

            children: [

              const SizedBox(height: 30),

              CustomTextField(
                controller: _emailController,
                label: "Email",
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,

                validator: (value) {

                  if (value == null || value.isEmpty) {
                    return "Email obligatoire";
                  }

                  if (!value.contains("@") || !value.contains(".")) {
                    return "Email invalide";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              CustomTextField(
                controller: _passwordController,
                label: "Mot de passe",
                prefixIcon: Icons.lock,
                obscureText: true,

                validator: (value) {

                  if (value == null || value.isEmpty) {
                    return "Mot de passe obligatoire";
                  }

                  if (value.length < 6) {
                    return "Minimum 6 caractères";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              CustomButton(
                text: "Se connecter",
                onPressed: _login,
              ),

              const SizedBox(height: 20),

              Visibility(
                visible: authProvider.isLoading,
                child: const LoadingIndicator(),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );

                },
                child: const Text("Pas de compte ? S'inscrire"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}