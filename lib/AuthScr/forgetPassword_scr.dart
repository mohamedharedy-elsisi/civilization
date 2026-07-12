import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/static/customLogo.dart';
import '../core/static/customTextFeild.dart';
import '../core/theme/AppColors.dart';

class ForgottenPasswordScr extends StatefulWidget {
  const ForgottenPasswordScr({super.key});

  @override
  State<ForgottenPasswordScr> createState() => _ForgottenPasswordScrState();
}

class _ForgottenPasswordScrState extends State<ForgottenPasswordScr> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    if (emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your email."),
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Password Reset"),
          content: Text(
            "We've sent a password reset link to your email.\n\nPlease check your Inbox or Spam folder.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Something went wrong.";

      switch (e.code) {
        case "user-not-found":
          message = "No account found with this email.";
          break;

        case "invalid-email":
          message = "Invalid email address.";
          break;

        case "too-many-requests":
          message =
          "Too many requests. Please try again later.";
          break;

        default:
          message = e.message ?? "Something went wrong.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 28),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 70),

                const CustomLogo(
                  size: 120,
                ),

                SizedBox(height: 60),

                Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w400,
                    color:
                    Theme.of(context).iconTheme.color,
                  ),
                ),

                SizedBox(height: 18),

                Text(
                  "Enter your email address and we'll send you a password reset link.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withOpacity(.7),
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 45),

                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                ),

                SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: resetPassword,
                    child: Text(
                      "Send Reset Link",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 25),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
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