import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ia_project/common/utils/image_picker_helper.dart';
import 'package:ia_project/common/utils/snackbar.dart';

class UserInformstionScreen extends ConsumerStatefulWidget {
  const UserInformstionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserInformstionScreenState();
}

class _UserInformstionScreenState extends ConsumerState<UserInformstionScreen> {
  File? _image;
  void pickImage(BuildContext context) async {
    final result = await ImagePickerHelper.pickImageBottomSheet(context);

    if (result == null) return; // user dismissed bottom sheet

    if (result.isSuccess) {
      setState(() => _image = result.file);
    } else {
      snackbar(context, result.error!);
    }
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
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null ? Icon(Icons.person, size: 70) : null,
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
                      decoration: InputDecoration(
                        hint: Text('Enter your name'),
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.done)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
