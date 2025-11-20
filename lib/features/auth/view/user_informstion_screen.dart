import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ia_project/common/utils/image_picker_helper.dart';
import 'package:ia_project/common/utils/snackbar.dart';
import 'package:ia_project/features/auth/controller/auth_controller.dart';

class UserInformstionScreen extends ConsumerStatefulWidget {
  const UserInformstionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserInformstionScreenState();
}

class _UserInformstionScreenState extends ConsumerState<UserInformstionScreen> {
  File? _image;
    final TextEditingController nameController = TextEditingController();
  void pickImage(BuildContext context) async {
    final result = await ImagePickerHelper.pickImageBottomSheet(context);

    if (result == null) return; // user dismissed bottom sheet

    if (result.isSuccess) {
      setState(() => _image = result.file);
    } else {
      snackbar(context, result.error!);
    }
  }

  void storeUserData(){
    ref.read(authControllerProvider.notifier).saveUserDataToFirebase(nameController.text.trim(), _image, context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: _image != null ? FileImage(_image!): NetworkImage('https://static.vecteezy.com/system/resources/previews/024/983/914/non_2x/simple-user-default-icon-free-png.png'),
                  ),
                  IconButton(
                    onPressed: () => pickImage(context),
                    icon: Icon(Icons.add, size: 30),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: size.width * 0.79,
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hint: Text('Enter your name'),
                      ),
                    ),
                  ),
                  IconButton(onPressed: storeUserData, icon: Icon(Icons.done)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
