import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickResult {
  final File? file;
  final String? error;

  ImagePickResult({this.file, this.error});

  bool get isSuccess => file != null && error == null;
}

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  static Future<ImagePickResult> pickFromGallery() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (file == null) {
        return ImagePickResult(error: "No image selected");
      }

      return ImagePickResult(file: File(file.path));
    } catch (e) {
      return ImagePickResult(error: "Gallery error: $e");
    }
  }

  /// Pick image from camera
  static Future<ImagePickResult> pickFromCamera() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (file == null) {
        return ImagePickResult(error: "No image captured");
      }

      return ImagePickResult(file: File(file.path));
    } catch (e) {
      return ImagePickResult(error: "Camera error: $e");
    }
  }

  /// Show bottom sheet with both options
  static Future<ImagePickResult?> pickImageBottomSheet(BuildContext context) async {
    return showModalBottomSheet<ImagePickResult>(
      context: context,
      builder: (_) {
        return SizedBox(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // GALLERY
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context, await pickFromGallery());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.photo, size: 35),
                    Text("Gallery"),
                  ],
                ),
              ),

              // CAMERA
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context, await pickFromCamera());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.camera_alt, size: 35),
                    Text("Camera"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
