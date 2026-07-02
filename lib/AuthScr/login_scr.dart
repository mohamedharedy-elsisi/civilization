import 'package:civilization/core/theme/AppColors.dart';
import 'package:civilization/AuthScr/forgetPassword_scr.dart';
import 'package:civilization/AuthScr/register_scr.dart';
import 'package:flutter/material.dart';
import '../core/static/OrDivider.dart';
import '../core/constant/constant.dart';
import '../core/services/GoogleAuthService.dart';
import '../core/static/customLogo.dart';
import '../core/static/customTextFeild.dart';
import '../widgets/mainLayout.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScr extends StatefulWidget {
  const LoginScr({super.key});

  @override
  State<LoginScr> createState() => _LoginScrState();

}
class _LoginScrState extends State<LoginScr> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppConstant.background),
            fit: BoxFit.cover,
          ),
        ),

        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.55),
          ),

          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),

              child: SingleChildScrollView(
                child: Column(
                  children: [

                    // const SizedBox(height: 55),

                    // Logo
                    const CustomLogo(
                      size: 250,
                    ),

                    // const SizedBox(height: 55),

                    // Title
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkGold,
                      ),
                    ),

                    const SizedBox(height: 45),

                    // Email
                    CustomTextField(
                      controller: emailController,
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),

                    const SizedBox(height: 18),

                    // Password
                    CustomTextField(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),

                    const SizedBox(height: 20),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,

                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const ForgottenPasswordScr(),
                            ),
                          );
                        },

                        child: const Text(
                          "Forgotten Password?",

                          style: TextStyle(
                            color: AppColors.lightGold,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 58,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkGold,
                          shadowColor: Colors.black26,
                          elevation: 4,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),

                        onPressed: () async {

                          try {

                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(

                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );

                            if (!mounted) return;

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MainLayout(),
                              ),
                            );

                          } on FirebaseAuthException catch (e) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.message ?? "Login Failed",
                                ),
                              ),
                            );
                          }
                        },

                        child: const Text(
                          "Login",

                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Divider
                    const CustomDivider(),

                    const SizedBox(height: 25),

                    // Social Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        // Google
                        GestureDetector(
                          onTap: () async {
                            final user =
                            await GoogleAuthService.signInWithGoogle();

                            if (user != null && context.mounted) {

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MainLayout(),
                                ),
                              );
                            }
                          },

                          child: Image.asset(
                            AppConstant.googleIcon,
                            width: 50,
                            height: 50,
                          ),
                        ),

                        const SizedBox(width: 30),

                        // Facebook
                        // GestureDetector(
                        //   onTap: () async {
                        //     await FacebookAuthService.signInWithFacebook();
                        //   },
                        //
                        //   child: Image.asset(
                        //     AppConstant.facebookIcon,
                        //     width: 50,
                        //     height: 50,
                        //   ),
                        // ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Text(
                          "I Don’t Have Account? ",

                          style: TextStyle(
                            color: AppColors.darkGold,
                            fontSize: 15,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const RegisterScr(),
                              ),
                            );
                          },

                          child: const Text(
                            "Register",

                            style: TextStyle(
                              color: AppColors.lightGold,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}