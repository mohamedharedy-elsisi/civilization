import 'package:civilization/core/theme/AppColors.dart';
import 'package:civilization/AuthScr/login_scr.dart';
import 'package:flutter/material.dart';
import '../core/static/OrDivider.dart';
import '../core/constant/constant.dart';
// import '../core/services/FacebookAuthService.dart';
import '../core/services/GoogleAuthService.dart';
import '../core/static/customLogo.dart';
import '../core/static/customTextFeild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/mainLayout.dart';
class RegisterScr extends StatefulWidget {
  const RegisterScr({super.key});

  @override
  State<RegisterScr> createState() => _RegisterScrState();

}
class _RegisterScrState extends State<RegisterScr> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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

                    // const SizedBox(height: 10),

                    // Logo
                    const CustomLogo(
                      size: 250,
                    ),

                    // const SizedBox(height: 40),

                    // Title
                    Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Name
                    CustomTextField(
                      controller: nameController,
                      hintText: "Full Name",
                      prefixIcon: const Icon(Icons.person_outline),
                    ),

                    const SizedBox(height: 18),

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

                    const SizedBox(height: 18),

                    // Confirm Password
                    CustomTextField(
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),

                    const SizedBox(height: 30),

                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      height: 58,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGold,
                          shadowColor: Colors.black26,
                          elevation: 4,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),

                        onPressed: () async {

                          if (nameController.text.trim().isEmpty ||
                              emailController.text.trim().isEmpty ||
                              passwordController.text.trim().isEmpty ||
                              confirmPasswordController.text.trim().isEmpty) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please fill all fields",
                                ),
                              ),
                            );

                            return;
                          }

                          if (passwordController.text !=
                              confirmPasswordController.text) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Passwords do not match",
                                ),
                              ),
                            );

                            return;
                          }

                          try {

                            final credential =
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );

                            await credential.user?.updateDisplayName(
                              nameController.text.trim(),
                            );

                            await FirebaseAuth.instance.currentUser
                                ?.reload();

                            if (!mounted) return;

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MainLayout(),
                              ),
                            );

                          } on FirebaseAuthException catch (e) {

                            String message =
                                "Registration Failed";

                            if (e.code ==
                                "email-already-in-use") {

                              message =
                              "Email already exists";

                            } else if (e.code ==
                                "weak-password") {

                              message =
                              "Password is too weak";

                            } else if (e.code ==
                                "invalid-email") {

                              message =
                              "Invalid email";
                            }

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(message),
                              ),
                            );
                          }
                        },

                        child: const Text(
                          "Create Account",

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

                            if (user != null && mounted) {

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
                        //
                        //     await FacebookAuthService
                        //         .signInWithFacebook();
                        //
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

                    // Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Text(
                          "Already Have Account? ",

                          style: TextStyle(
                            color:Theme.of(context).iconTheme.color,
                            fontSize: 15,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const LoginScr(),
                              ),
                            );
                          },

                          child: const Text(
                            "Login",

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