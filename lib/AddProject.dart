import 'dart:convert';
import 'dart:io';
import 'package:date_field/date_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lumineux_rewards_app/ActionSuccess.dart';
import 'package:lumineux_rewards_app/You.dart';
import 'package:lumineux_rewards_app/common/AppBarAction.dart';
import 'package:lumineux_rewards_app/showCustomDialogPopup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BaseConstants.dart';
import 'package:http/http.dart' as http;

import 'CustomSnackBar.dart';
import 'FilePickerOrCamera.dart';
import 'common/CommonAppBar.dart';

class AddProject extends StatefulWidget {
  static String tag = "add-project";
  const AddProject({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddProjectForm();
  }
}

class AddProjectForm extends State<AddProject> {
  int apiCall = 0;
  var uuid = "";
  String? _field_1;
  DateTime? _field_2;
  String? _description;

  List files = [];
  late final List _platformFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Project name*",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffd8d8d8)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.green),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            onSaved: (String? value) {
              _field_1 = value;
            },
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Project name is required";
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Project date*",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          DateTimeFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffd8d8d8)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.green),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            mode: DateTimeFieldPickerMode.date,
            // validator: (e) =>
            // (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
            onDateSelected: (DateTime value) {
              _field_2 = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Description*",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          TextFormField(
            minLines: 5,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffd8d8d8)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.green),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            onSaved: (String? value) {
              _description = value;
            },
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Description is required";
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _platformFile = [];
    getUuid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        parentTag: AddProject.tag,
      ),
      body: apiCall == 1
          ? const SpinKitRing(
              color: Colors.green,
            )
          : Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            BaseConstants.addProjectPageLabel,
                            style: TextStyle(
                              fontSize: 28.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 5.0),
                            child: Text(
                              BaseConstants.addProjectDescription,
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GridView.count(
                            primary: false,
                            padding:
                                const EdgeInsets.fromLTRB(20, 0.0, 20.0, 0.0),
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 12,
                            crossAxisCount: 4,
                            children: [
                              ...files.map(
                                (file) => Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xffE5E5E5),
                                    ),
                                    color: const Color(0xffE5E5E5),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            10), // Image border
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(
                                              10), // Image radius
                                          child: file == "notAnImage"
                                              ? Image.asset(
                                                  "images/pdf-icon.jpg",
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.file(
                                                  File(file),
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 30,
                                        left: 30,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.cancel,
                                            size: 25.0,
                                            color: Colors.green,
                                          ),
                                          onPressed: () {
                                            var fileIndex = files.indexOf(file);
                                            setState(() {
                                              files.removeAt(fileIndex);
                                              _platformFile.removeAt(fileIndex);
                                            });
                                            print(files);
                                            print(_platformFile);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xffE5E5E5),
                                  ),
                                  color: const Color(0xffE5E5E5),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  iconSize: 50.0,
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    var allowedExtensions = [
                                      'jpg',
                                      'pdf',
                                      'jpeg',
                                      'png'
                                    ];
                                    var imageExtensions = [
                                      'jpg',
                                      'png',
                                      'jpeg'
                                    ];

                                    final filesList =
                                        await showCustomDialogPopup<String?>(
                                            context,
                                            const FilePickerOrCamera());
                                    //print(filesList);
                                    if (filesList[0]['name'] == "file") {
                                      FilePickerResult filesPicked =
                                          filesList[0]['data'];

                                      filesPicked.files.forEach((element) {
                                        setState(() {
                                          print(files.length);
                                          if (files.length == 7) {
                                            const CustomSnackBar(
                                                    data:
                                                        "Maximum 7 files can be added")
                                                .showSnackBar(context);
                                          } else {
                                            if (allowedExtensions
                                                .contains(element.extension)) {
                                              if (!imageExtensions.contains(
                                                  element.extension)) {
                                                files.add("notAnImage");
                                              } else {
                                                files.add(
                                                    element.path.toString());
                                              }
                                              _platformFile.add(element);
                                            } else {
                                              const CustomSnackBar(
                                                      data:
                                                          "Only .jpg, .jpeg, .png and .pdf are allowed")
                                                  .showSnackBar(context);
                                            }
                                          }
                                        });
                                      });
                                    }

                                    if (filesList[0]['name'] == "camera") {
                                      final file = filesList[0]["data"];
                                      setState(() {
                                        if (files.length == 7) {
                                          const CustomSnackBar(
                                                  data:
                                                      "Maximum 7 files can be added")
                                              .showSnackBar(context);
                                        } else {
                                          files.add(file.path.toString());
                                          _platformFile.add(file);
                                        }
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildNameField(),
                                _buildDateField(),
                                _buildDescriptionField(),
                              ],
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              backgroundColor: const Color(0xffabcc59),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              minimumSize:
                                  const Size(150, 50), // Background color
                            ),
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.0),
                            ),
                            onPressed: () async {
                              final isValid = _formKey.currentState!.validate();

                              if (isValid) {
                                setState(() {
                                  apiCall = 1;
                                });
                                _formKey.currentState!.save();
                                if (uuid.isNotEmpty) {
                                  var uri = Uri.parse(
                                      "${BaseConstants.baseUrl}api/put/points-request/$uuid/");
                                  var request =
                                      http.MultipartRequest("POST", uri);
                                  request.fields['type'] = "2";
                                  request.fields['field_1'] = _field_1!;
                                  request.fields['field_2'] =
                                      DateFormat.yMMMEd().format(_field_2!);
                                  print(request.fields['field_1']);
                                  print(request.fields['field_2']);
                                  print(request.fields['type']);
                                  request.fields['description'] = _description!;
                                  if (_platformFile.isNotEmpty) {
                                    _platformFile
                                        .asMap()
                                        .forEach((index, value) async {
                                      var name = "files_$index";
                                      request.files.add(
                                          await http.MultipartFile.fromPath(
                                              name, value.path.toString()));
                                    });
                                  }
                                  request.send().then((response) async {
                                    final responseJson =
                                        await response.stream.bytesToString();
                                    final responseArr =
                                        json.decode(responseJson);
                                    if (response.statusCode == 200) {
                                      if (!mounted) return;
                                      CustomSnackBar(
                                              data: responseArr["status_msg"])
                                          .showSnackBar(context);

                                      setState(() {
                                        apiCall = 0;
                                      });
                                      if (responseArr["status"] == "success") {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ActionSuccess(
                                                description: BaseConstants
                                                    .projectSubmitSuccess),
                                          ),
                                        );
                                      }
                                    }
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void getUuid() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      uuid = prefs.getString("uuid")!;
    });
  }
}
