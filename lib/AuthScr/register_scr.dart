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
  bool emailError = false;
  bool passwordError = false;
  bool confirmPasswordError = false;
  String? emailErrorText;
  String? passwordErrorText;
  String? confirmPasswordErrorText;

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      if (emailError) {
        setState(() {
          emailError = false;
          emailErrorText = null;
        });
      }
    });

    passwordController.addListener(() {
      if (passwordError) {
        setState(() {
          passwordError = false;
          passwordErrorText = null;
        });
      }
    });

    confirmPasswordController.addListener(() {
      if (confirmPasswordError) {
        setState(() {
          confirmPasswordError = false;
          confirmPasswordErrorText = null;
        });
      }
    });
  }
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

        decoration:  BoxDecoration(
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
              padding: EdgeInsets.symmetric(horizontal: 28),

              child: SingleChildScrollView(
                child: Column(
                  children: [

                    // SizedBox(height: 10),

                    // Logo
                    const CustomLogo(
                      size: 250,
                    ),

                    // SizedBox(height: 40),

                    // Title
                    Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),

                    SizedBox(height: 40),

                    // Name
                    CustomTextField(
                      controller: nameController,
                      hintText: "Full Name",
                      prefixIcon: Icon(Icons.person_outline),
                    ),

                    SizedBox(height: 18),

                    // Email
                    CustomTextField(
                      controller: emailController,
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                      hasError: emailError,
                      errorText: emailErrorText,
                    ),

                    SizedBox(height: 18),

                    // Password
                    CustomTextField(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true,
                      prefixIcon: Icon(Icons.lock_outline),
                      hasError: passwordError,
                      errorText: passwordErrorText,
                    ),

                    SizedBox(height: 18),

                    // Confirm Password
                    CustomTextField(
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      obscureText: true,
                      prefixIcon: Icon(Icons.lock_outline),
                      hasError: confirmPasswordError,
                      errorText: confirmPasswordErrorText,
                    ),

                    SizedBox(height: 30),

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
                              SnackBar(
                                content: Text(
                                  "Please fill all fields",
                                ),
                              ),
                            );

                            return;
                          }

                          if (passwordController.text != confirmPasswordController.text) {
                            setState(() {
                              passwordError = true;
                              confirmPasswordError = true;
                              passwordErrorText = "Passwords do not match";
                              confirmPasswordErrorText = "Passwords do not match";
                            });
                            return;
                          }

                          try {

                            final credential =
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );

                            await credential.user!.updateDisplayName(
                              nameController.text.trim(),
                            );

                            try {
                              await credential.user!.sendEmailVerification();
                              debugPrint("Verification email sent");
                            } catch (e) {
                              debugPrint("Verification error: $e");
                            }

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "A verification email has been sent. Please verify your email before logging in.",
                                ),
                                duration: Duration(seconds: 4),
                              ),
                            );

                            // تسجيل الخروج عشان المستخدم ميتحسبش مسجل دخول قبل كدا
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScr(),
                              ),
                            );

                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              emailError = false;
                              passwordError = false;
                              emailErrorText = null;
                              passwordErrorText = null;
                              switch (e.code) {
                                case "email-already-in-use":
                                  emailError = true;
                                  emailErrorText = "Email already exists";
                                  break;
                                case "weak-password":
                                  passwordError = true;
                                  passwordErrorText = "Password is too weak";
                                  break;
                                case "invalid-email":
                                  emailError = true;
                                  emailErrorText = "Invalid email";
                                  break;
                                default:
                                  emailError = true;
                                  emailErrorText = "Registration failed";
                              }
                            });
                          }on FirebaseAuthException catch (e) {

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

                        child: Text(
                          "Create Account",

                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 28),

                    // Divider
                    const CustomDivider(),

                    SizedBox(height: 25),

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

                        // SizedBox(width: 30),

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

                    SizedBox(height: 25),

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

                          child: Text(
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

                    SizedBox(height: 30),
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