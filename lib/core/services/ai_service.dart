import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../views/DetailsScreen.dart';

class AIService {
  static const String baseUrl = "https://civilization-api-production.up.railway.app";

  static final ImagePicker _picker = ImagePicker();

  static Future<void> showImageSourceDialog(
      BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Wrap(
              children: [
                Center(
                  child: Text("Select Image Source",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Take Photo"),
                  onTap: () {
                    Navigator.pop(context);
                    scanArtifact(
                      context, ImageSource.camera,
                    );
                  },
                ),

                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Choose from Gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    scanArtifact(
                      context, ImageSource.gallery,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> scanArtifact(
      BuildContext context,
      ImageSource source,
      ) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 640,
      );
      if (image == null) return;

      var request = http.MultipartRequest(
        "POST", Uri.parse("$baseUrl/api/predict"),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          "image", image.path,
        ),
      );

      final response = await request.send();

      if (response.statusCode != 200) {
        _showError(
          context, "Prediction failed.\nPlease try again.",
        );
        return;
      }

      final body = jsonDecode(await response.stream.bytesToString());

      if (body["success"] != true) {
        _showError(
          context,
          "We couldn't identify this landmark.\n\n"
              "• Make sure the landmark is clearly visible.\n"
              "• Move closer to the monument.\n"
              "• Try taking the photo in good lighting.",
        );
        return;
      }

      final artifact = body["artifact"];

      if (artifact == null) {
        _showError(
          context, "The landmark was detected, but no information was found in the database.",
        );
        return;
      }

      Navigator.push(context,
        MaterialPageRoute(
          builder: (_) => DetailsScreen(
            id: artifact["id"],
            title: artifact["name"],
            arabicName: artifact["arabic_name"],
            description: artifact["description"],
            images: [artifact["image"]],
          ),
        ),
      );
    } catch (e) {
      _showError(
        context, "Unexpected error:\n$e",
      );
    }
  }

  static void _showError(
      BuildContext context,
      String message,
      ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title:  Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text("Artifact Not Detected",),
            ),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            label: Text("Cancel"),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              showImageSourceDialog(context);
            },
            icon: Icon(Icons.camera_alt),
            label: Text("Try Again"),
          ),
        ],
      ),
    );
  }
}