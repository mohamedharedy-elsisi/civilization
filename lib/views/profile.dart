import 'package:civilization/AuthScr/login_scr.dart';
import 'package:civilization/core/theme/AppColors.dart';
import 'package:civilization/views/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constant/constant.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() =>
      _profileState();
}

class _profileState extends State<profile> {

  User? user;
  File? profileImage;

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser;

    loadProfileImage();

    user?.reload().then((_) {
      setState(() {
        user = FirebaseAuth.instance.currentUser;
      });
    });
  }
  Future<void> loadProfileImage() async {

    final prefs =
    await SharedPreferences.getInstance();

    final imagePath =
    prefs.getString("profile_image");

    if (imagePath != null) {

      setState(() {
        profileImage = File(imagePath);
      });
    }
  }
  Future<void> pickImage() async {

    final picker = ImagePicker();

    final XFile? image =
    await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setString(
      "profile_image",
      image.path,
    );

    setState(() {
      profileImage = File(image.path);
    });
  }
  // Future<void> uploadImage(File file) async {
  //
  //   try {
  //
  //     final user =
  //         FirebaseAuth.instance.currentUser;
  //
  //     if (user == null) return;
  //
  //     final storageRef =
  //     FirebaseStorage.instance
  //         .ref()
  //         .child("users")
  //         .child("${user.uid}.jpg");
  //
  //     await storageRef.putFile(file);
  //
  //     final imageUrl =
  //     await storageRef.getDownloadURL();
  //
  //     await user.updatePhotoURL(
  //       imageUrl,
  //     );
  //
  //     await user.reload();
  //
  //     setState(() {
  //       this.user =
  //           FirebaseAuth.instance.currentUser;
  //     });
  //
  //   } catch (e) {
  //
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           e.toString(),
  //         ),
  //       ),
  //     );
  //   }
  // }
  Future<void> logout() async {

    await GoogleSignIn().signOut();

    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScr(),
      ),
          (route) => false,
    );
  }

  Widget profileItem(String title) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color:Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        const SizedBox(height: 10),
        const Divider(thickness: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile",
          style: TextStyle(
            color:Theme.of(context).iconTheme.color,
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,

        automaticallyImplyLeading: false,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     IconButton(
              //       onPressed: () {
              //         Navigator.pop(context);
              //       },
              //       icon: const Icon(
              //         Icons.arrow_back,
              //       ),
              //     ),
              //     const Text(
              //       "Profile",
              //       style: TextStyle(
              //         fontSize: 22,
              //         fontWeight: FontWeight.bold,
              //         Theme.of(context).iconTheme.color,
              //       ),
              //     ),
              //   ],
              // ),
              //  const SizedBox(height: 40),
        Row(
          children: [
            GestureDetector(
              onTap: pickImage,

              child: CircleAvatar(
                radius: 40,

                backgroundImage:

                profileImage != null

                    ? FileImage(profileImage!)

                    : user?.photoURL != null

                    ? NetworkImage(
                  user!.photoURL!,
                ) as ImageProvider

                    : null,

                child:

                profileImage == null &&
                    user?.photoURL == null

                    ? Image.asset(
                  "assets/icons/user.png",
                  width: 40,
                  height: 40,
                )

                    : null,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    user?.displayName ?? "User",

                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.brown,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    user?.email ?? "",

                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {

                showDialog(
                  context: context,

                  builder: (context) {

                    return AlertDialog(
                      backgroundColor:
                      const Color(0xffF7F4EE),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(20),
                      ),

                      title: Text(
                        "Logout",
                        style: TextStyle(
                          color:Theme.of(context).iconTheme.color,
                        ),
                      ),
                      content: const Text(
                        "Are you sure you want to logout?",
                      ),

                      actions: [

                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          child: const Text(
                            "Cancel",
                          ),
                        ),

                        TextButton(
                          onPressed: () async {

                            Navigator.pop(context);

                            await logout();

                          },

                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Column(
                children: [

                  Image.asset(
                    AppConstant.logout,
                    width: 28,
                    height: 28,
                  ),

                  SizedBox(height: 4),

                  Text(
                    "Logout",
                    style: TextStyle(
                      color:Theme.of(context).iconTheme.color,
                    ),
                  ),
                ],
              ),
            )


          ],
        ),



              SizedBox(height: 50),

              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SettingsScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.settings),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Settings",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 18),
                    ],
                  ),
                ),
              ) ,

            ],
          ),
        ),
      ),
    );
  }
}