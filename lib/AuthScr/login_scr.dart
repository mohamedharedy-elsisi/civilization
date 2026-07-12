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
  bool emailError = false;
  bool passwordError = false;
  String? emailErrorText;
  String? passwordErrorText;
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
  }
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
              padding: EdgeInsets.symmetric(horizontal: 28),

              child: SingleChildScrollView(
                child: Column(
                  children: [

                    // SizedBox(height: 55),

                    // Logo
                    const CustomLogo(
                      size: 250,
                    ),

                    // SizedBox(height: 55),

                    // Title
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),

                    SizedBox(height: 45),

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

                    SizedBox(height: 20),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,

                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgottenPasswordScr(),
                            ),
                          );
                        },

                        child: Text(
                          "Forgotten Password?",

                          style: TextStyle(
                            color: AppColors.lightGold,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Login Button
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
                          try {
                            final credential =
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );

                            await credential.user!.reload();

                            final user = FirebaseAuth.instance.currentUser!;

                            if (!user.emailVerified) {
                              await FirebaseAuth.instance.signOut();

                              if (!mounted) return;

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Email Not Verified"),
                                  content: Text(
                                    "Please verify your email before logging in.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        await user.sendEmailVerification();

                                        if (context.mounted) {
                                          Navigator.pop(context);

                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Verification email sent again.",
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Text("Resend"),
                                    ),

                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                ),
                              );

                              return;
                            }

                            if (!mounted) return;

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>  MainLayout(),
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              emailError = false;
                              passwordError = false;
                              emailErrorText = null;
                              passwordErrorText = null;

                              switch (e.code) {
                                case "user-not-found":
                                  emailError = true;
                                  emailErrorText = "Email not found";
                                  break;

                                case "wrong-password":
                                  passwordError = true;
                                  passwordErrorText = "Incorrect password";
                                  break;

                                case "invalid-email":
                                  emailError = true;
                                  emailErrorText = "Invalid email";
                                  break;

                                case "invalid-credential":
                                  emailError = true;
                                  passwordError = true;
                                  emailErrorText = "Incorrect email";
                                  passwordErrorText = "Incorrect password";
                                  break;

                                default:
                                  emailError = true;
                                  passwordError = true;
                                  emailErrorText = "Login failed";
                                  passwordErrorText = "Login failed";
                              }
                            });
                          }
                        },

                        child: Text(
                          "Login",

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
                      crossAxisAlignment: CrossAxisAlignment.center,
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

                        // SizedBox(width: 30),

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

                    SizedBox(height: 25),

                    // Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Text(
                          "I Don’t Have Account? ",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
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

                          child: Text(
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