import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
 
 final Function(File) onImageSelected;
 
 ImageSourceSheet({this.onImageSelected});
 
  void imageSelected(File image) async {
    if (image != null) {
     File croppedImage = await ImageCropper.cropImage(
       sourcePath: image.path,
       aspectRatioPresets: [CropAspectRatioPreset.square]
     );
     
     onImageSelected(croppedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Row(
       mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FlatButton(
            child: Icon(Icons.camera_enhance, color: Colors.purple, size: 45,),
            onPressed: () async {
              File image = await ImagePicker.pickImage(source: ImageSource.camera);
              imageSelected(image);
            },
          ),
          FlatButton(
            child: Icon(Icons.photo, color: Colors.purple, size: 45,),
            onPressed: () async {
              File image = await ImagePicker.pickImage(source: ImageSource.gallery);
              imageSelected(image);
            },
          ),
        ],
      ),
    );
  }
}
