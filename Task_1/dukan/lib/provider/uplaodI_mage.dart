import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage with ChangeNotifier {
  File? _image;
  get IImage => _image;

  final imagepick = ImagePicker();

  Future GetImageGallery() async {
    final pickedfile = await imagepick.pickImage(source: ImageSource.gallery);

    if (pickedfile != null) {
      _image = File(pickedfile.path);
    } else {
      print('No image picked');
    }
    notifyListeners();
  }

  void clearImage() {
    _image = null;
    notifyListeners();
  }
}
