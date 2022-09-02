import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/views/screen/camera/camera_option.dart';
import 'package:ecome_app/views/screen/widget/snackbar_error.dart';
import 'package:ecome_app/views/screen/widget/text_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecome_app/views/screen/widget/common_buttons.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';

class CameraScreen extends StatefulWidget {
  static const String routeName = '/camera';
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final mainService = MainService();
  File? _image;
  String? photo;

  @override
  void initState() {
    super.initState();
    getImage(context);
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().getImage(source: source);

      if (image == null) return;

      File? img = File(image.path);

      img = await _cropImage(imageFile: img);
      // var images = File.fromRawPath(await image.readAsBytes());
      // print(images);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
      postImage(_image);
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );

    if (croppedImage == null) return null;
    var file = await _compressImage(croppedImage.path, 35);
    return File(file!.path);
  }

  Future<File?> _compressImage(String path, int quality) async {
    final newPath = await p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);

    return File(result!.path);
  }

  Future getImage(BuildContext context) async {
    var url = await mainService.urlApi() + '/api/v1/user/profile/picture';
    // var url = 'https://ng-api-dev.gitsolutions.id/api/user/profile/picture';

    mainService.getUrl(url, (res) {
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print(jsonDecode(res.body)['profilePicture']);
        setState(() {
          photo = data['profilePicture'];
        });
      } else {
        mainService.errorHandling(res, context);
      }
    });
  }

  postImage(formData) async {
    var url = await mainService.urlApi() + '/api/v1/user/profile/picture';
    // var url = 'https://ng-api-dev.gitsolutions.id/api/user/profile/picture';

    var fileName = formData.path.split('/').last;

    var ext = fileName.split('.').last;

    var form = {
      'profilePicture':
          await MultipartFile.fromBytes(await formData.readAsBytes(),
              filename: fileName,
              contentType: MediaType(
                'image',
                ext,
              ))
    };

    mainService.postFormDataUrlApi(url, form, (res) {
      if (res.statusCode == 200) {
        var msg = res.data['message'];
        SnackBarSuccess(context, msg);
        getImage(context);
      } else {
        mainService.errorHandlingDio(res, context);
      }
    });
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    const kHeadTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    const kHeadSubtitleTextStyle = TextStyle(
      fontSize: 18,
      color: Colors.black87,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TextAppbar(text: 'Camera'),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Set a photo of yourself',
                        style: kHeadTextStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Photos make your profile more engaging',
                        style: kHeadSubtitleTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Center(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _showSelectPhotoOptions(context);
                    },
                    child: Center(
                      child: Container(
                        height: 200.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: Center(
                          child: _image == null && photo == null
                              ? Text(
                                  'No image selected',
                                  style: TextStyle(fontSize: 20),
                                )
                              : CircleAvatar(
                                  backgroundImage: photo != null
                                      ? NetworkImage(photo!) as ImageProvider
                                      : FileImage(_image!),
                                  radius: 200.0,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Anonymous',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonButtons(
                    onTap: () => _showSelectPhotoOptions(context),
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    textLabel: 'Add a Photo',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
