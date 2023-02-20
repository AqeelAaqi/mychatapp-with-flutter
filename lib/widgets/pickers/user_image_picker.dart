import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;
  UserImagePicker(this.imagePickFn, {Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  File? _pickedImageFile;
  void _pickImage() async{
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    // final pickedImageFile = await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedImageFile = pickedImageFile as File;
    });

    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImageFile != null ?FileImage(_pickedImageFile!) : null,
        ),
        TextButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.image),
            label: Text("Add Image")),
      ],
    );
  }
}
