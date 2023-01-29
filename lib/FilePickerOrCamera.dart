import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import 'BaseConstants.dart';

class FilePickerOrCamera extends StatefulWidget {
  const FilePickerOrCamera({Key? key}) : super(key: key);

  @override
  State<FilePickerOrCamera> createState() => _FilePickerOrCameraState();
}

class _FilePickerOrCameraState extends State<FilePickerOrCamera> {
  int apiCall = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff3C8A34),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: apiCall == 1
              ? const SpinKitRing(
                  color: Colors.white,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_left_sharp),
                          label: const Text(''),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add_alert),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: [
                            IconButton(
                              icon: Image.asset("images/add-file.png"),
                              iconSize: 75.0,
                              color: Colors.white,
                              onPressed: () async {
                                FilePickerResult filesPicked =
                                    (await FilePicker.platform.pickFiles(
                                  allowMultiple: true,
                                  type: FileType.custom,
                                  allowedExtensions: [
                                    'jpg',
                                    'pdf',
                                    'jpeg',
                                    'png'
                                  ],
                                ))!;

                                List filesList = [
                                  {"name": "file", "data": filesPicked}
                                ];

                                if (!mounted) return;
                                Navigator.pop(context, filesList);
                              },
                            ),
                            const Text(
                              BaseConstants.addAFileLabel,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Image.asset("images/add-camera.png"),
                              iconSize: 75.0,
                              color: Colors.white,
                              onPressed: () async {
                                final XFile? photo = await ImagePicker()
                                    .pickImage(source: ImageSource.camera);

                                if (photo != null) {
                                  List filesList = [
                                    {"name": "camera", "data": photo}
                                  ];

                                  if (!mounted) return;
                                  Navigator.pop(context, filesList);
                                }
                              },
                            ),
                            const Text(
                              BaseConstants.addFromCameraLabel,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
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
