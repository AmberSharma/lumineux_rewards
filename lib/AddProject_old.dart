import 'dart:io';
import 'package:date_field/date_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'BaseConstants.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddProjectForm();
  }
}

class AddProjectForm extends State<AddProject> {
  var uuid = "";
  String? _field_1;
  DateTime? _field_2;
  String? _description;

  // FilePickerResult? _filePickerResult;
  List files = [];
  late final List<PlatformFile> _platformFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildDescriptionField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextFormField(
        minLines: 5,
        maxLines: 5,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: 'Tap here to enter a description',
          labelText: 'Description *',
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.amberAccent),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
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

  Widget _buildNameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextFormField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: 'Tap here to enter a name',
          labelText: 'Project name *',
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.greenAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.greenAccent),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
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
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: DateTimeFormField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: 'Tap here to enter a date',
          labelText: 'Project date *',
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: Colors.greenAccent), //<-- SEE HERE
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.amberAccent),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _platformFile = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: const [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    child: Text(
                      "Add a Project",
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
                      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 0.0, 0.0),
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
                            child: Image.file(File(file)),
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
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   flex: 2,
            //   child: Row(
            //     children: [
            //
            //     ],
            //   ),
            // ),
            // Expanded(
            //   flex: 2,
            //   child: Row(
            //     children: [
            //
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
                      backgroundColor:
                          const Color(0xffabcc59), // Background color
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
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
}
