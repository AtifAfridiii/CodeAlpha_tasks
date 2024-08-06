import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dukan/Utilis/toast_message.dart';
import 'package:dukan/components/Round_Button.dart';
import 'package:dukan/provider/theme.dart';
import 'package:dukan/provider/uplaodI_mage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UploadItem extends StatefulWidget {
  const UploadItem({super.key});

  @override
  State<UploadItem> createState() => _UploadItemState();
}

Future<Uint8List> convertImageToByteArray(File imageFile) async {
  ui.Codec codec = await ui.instantiateImageCodec(imageFile.readAsBytesSync());
  ui.FrameInfo frame = await codec.getNextFrame();
  ui.Image image = frame.image;
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  Uint8List data = byteData!.buffer.asUint8List();
  return data;
}

class _UploadItemState extends State<UploadItem> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Iconprovider = Provider.of<ThemeChanger>(context);
    bool ISDark = Iconprovider.Thememode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Item',
            style: GoogleFonts.b612(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Gap(31),
              Align(
                alignment: Alignment.center,
                child: Consumer<UploadImage>(
                  builder: (context, value, child) {
                    return InkWell(
                      onTap: () async {
                        await value.GetImageGallery();
                      },
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.3,
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ISDark ? Colors.white : Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Center(
                          child: value.IImage != null
                              ? ClipRRect(
                                  child: Image.file(
                                    value.IImage!.absolute,
                                    fit: BoxFit.fill,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.3,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                  ),
                                )
                              : const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_outlined,
                                      size: 71,
                                    ),
                                    Gap(11),
                                    Text(
                                      '(upload only 1 photo)',
                                      style: TextStyle(),
                                    )
                                  ],
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(31),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 31),
                child: TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
              ),
              const Gap(11),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 31),
                child: TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    return null;
                  },
                ),
              ),
              const Gap(31),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 31),
                child: TextFormField(
                  maxLength: 150,
                  maxLines: 5,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
              ),
              const Gap(11),
              RoundButton(
                title: 'Publish',
                color: ISDark ? Colors.deepPurple : Colors.black,
                ontap: () async {
                  if (_formKey.currentState!.validate()) {
                    final uploadImageProvider =
                        Provider.of<UploadImage>(context, listen: false);
                    final ref = FirebaseDatabase.instance.ref('Ads');
                    var datetime =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    if (uploadImageProvider.IImage != null) {
                      File imageFile = uploadImageProvider.IImage!;
                      String base64Image =
                          base64Encode(await imageFile.readAsBytes());

                      final data = {
                        'Description': descriptionController.text,
                        'Title': titleController.text,
                        'price': priceController.text,
                        'image': base64Image,
                      };

                      await ref.child(datetime).set(data).then((_) {
                        Utilis().ToastMessage('Item added');
                        titleController.clear();
                        priceController.clear();
                        descriptionController.clear();
                        uploadImageProvider.clearImage();
                      }).catchError((error) {
                        Utilis().ToastMessage(error.toString());
                      });
                    } else {
                      Utilis().ToastMessage('Please select an image');
                    }
                  } else {
                    Utilis().ToastMessage('Please fill all fields');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
