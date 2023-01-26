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
import 'package:shared_preferences/shared_preferences.dart';
import 'BaseConstants.dart';
import 'package:http/http.dart' as http;

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
  late final List<PlatformFile> _platformFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(12.0, 12.0, 0, 0),
          hintText: 'Tap here to enter a project name',
          labelText: 'Project name *',
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(width: 1, color: Color(0xffd8d8d8)),
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
            return "Wholesaler is required";
          }
        },
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: DateTimeFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(12.0, 12.0, 0, 0),
          hintText: 'Tap here to enter a date',
          labelText: 'Project date *',
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(width: 1, color: Color(0xffd8d8d8)),
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
        autovalidateMode: AutovalidateMode.always,
        // validator: (String? value) {
        //   if (value!.isEmpty) {
        //     return "Date is required";
        //   }
        // },
        validator: (e) =>
            (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
        onDateSelected: (DateTime value) {
          _field_2 = value;
        },
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextFormField(
        minLines: 5,
        maxLines: 5,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(12.0, 12.0, 0, 0),
          hintText: 'Tap here to enter a description',
          labelText: 'Description *',
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(width: 1, color: Color(0xffd8d8d8)),
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
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[900],
        actions: [
          AppBarAction(
            parentTag: AddProject.tag,
          )
        ],
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
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.0),
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
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GridView.count(
                            primary: false,
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10), // Image border
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(
                                          10), // Image radius
                                      child: Image.file(
                                        File(file),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
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
                                    filesPicked.files.forEach((element) {
                                      setState(() {
                                        files.add(element.path.toString());
                                        _platformFile.add(element);
                                      });
                                    });
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
                    flex: 4,
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
                  // Expanded(
                  //   flex: 2,
                  //   child: Row(
                  //     children: [
                  //       _buildAreaField(),
                  //     ],
                  //   ),
                  // ),
                  // Expanded(
                  //   flex: 2,
                  //   child: Row(
                  //     children: [
                  //       _buildDescriptionField(),
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0),
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
                                  final responseArr = json.decode(responseJson);
                                  if (response.statusCode == 200) {
                                    if (!mounted) return;

                                    var snackBar = SnackBar(
                                      content: Center(
                                        child: Text(
                                          responseArr["status_msg"],
                                          style:
                                              const TextStyle(fontSize: 17.0),
                                        ),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height -
                                                100,
                                        right: 20,
                                        left: 20,
                                        bottom: 20,
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);

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
