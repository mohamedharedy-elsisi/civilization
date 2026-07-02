import 'package:flutter/material.dart';
import '../core/theme/AppColors.dart';
import '../core/static/customLogo.dart';
import '../core/static/customTextFeild.dart';

class ForgottenPasswordScr extends StatelessWidget {
  const ForgottenPasswordScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 70),

                // Logo
                const CustomLogo(
                  size: 120,
                ),

                const SizedBox(height: 60),

                // Title
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkGold,
                  ),
                ),

                const SizedBox(height: 18),

                // Description
                const Text(
                  "Enter your email address and we will send you a password reset link.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 45),

                // Email Field
                const CustomTextField(
                  hintText: "Email",
                ),

                const SizedBox(height: 30),

                // Send Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkGold,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Send Reset Link",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Back To Login
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Back To Login",
                    style: TextStyle(
                      color: AppColors.lightGold,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}