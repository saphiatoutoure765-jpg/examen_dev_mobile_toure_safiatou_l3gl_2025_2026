import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/loading_indicator.dart';
import '../home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _register() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final success = await authProvider.register(
      _nameController.text.trim(),
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
          content: Text(authProvider.error ?? "Erreur lors de l'inscription"),
        ),
      );

    }

  }

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text("Inscription"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: SingleChildScrollView(
            child: Column(

              children: [

                const SizedBox(height: 20),

                CustomTextField(
                  controller: _nameController,
                  label: "Nom",
                  prefixIcon: Icons.person,

                  validator: (value) {

                    if (value == null || value.isEmpty) {
                      return "Nom obligatoire";
                    }

                    if (value.length < 2) {
                      return "Minimum 2 caractères";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

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

                const SizedBox(height: 16),

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

                const SizedBox(height: 16),

                CustomTextField(
                  controller: _confirmPasswordController,
                  label: "Confirmer mot de passe",
                  prefixIcon: Icons.lock,
                  obscureText: true,

                  validator: (value) {

                    if (value == null || value.isEmpty) {
                      return "Confirmation obligatoire";
                    }

                    if (value != _passwordController.text) {
                      return "Les mots de passe ne correspondent pas";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 30),

                CustomButton(
                  text: "S'inscrire",
                  onPressed: _register,
                ),

                const SizedBox(height: 20),

                Visibility(
                  visible: authProvider.isLoading,
                  child: const LoadingIndicator(),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {

                    Navigator.pop(context);

                  },
                  child: const Text("Déjà un compte ? Se connecter"),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}