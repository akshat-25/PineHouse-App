import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  File? _pickedImage;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _itemController = SingleValueDropDownController();
  List<String> _items = [
    'Select Your Department',
    'HR',
    'Finance',
    'HouseKeeping',
    'Marketing',
  ];
  String _selectedItems = 'Select Your Department';

  final _formKey = GlobalKey<FormState>();
  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.getImage(source: ImageSource.camera, imageQuality: 10);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    // Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    // Navigator.pop(context);
  }

  void _remove() {
    setState(() {
      _pickedImage != null;
    });
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        elevation: 0,
        title: Text(
          'Welcome',
          style: GoogleFonts.raleway(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                        child: CircleAvatar(
                          radius: 71,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.blue.shade100,
                            backgroundImage: _pickedImage == null
                                ? null
                                : FileImage(_pickedImage!),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 120,
                          left: 110,
                          child: RawMaterialButton(
                            elevation: 10,
                            fillColor: Colors.blue.shade300,
                            child: Icon(Icons.add_a_photo),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Choose option',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            InkWell(
                                              onTap: _pickImageCamera,
                                              splashColor: Colors.purpleAccent,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.camera,
                                                      color:
                                                          Colors.purpleAccent,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Camera',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Colors.blueAccent),
                                                  )
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: _pickImageGallery,
                                              splashColor: Colors.purpleAccent,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.image,
                                                      color:
                                                          Colors.purpleAccent,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Gallery',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Colors.lightGreen),
                                                  )
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: _remove,
                                              splashColor: Colors.purpleAccent,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.remove_circle,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Remove',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.red),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ))
                    ],
                  ),
                  // SizedBox(height: h * 0.01),
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: "Name",
                      hintText: "Enter Your Name",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.length != 10) {
                        return "Please enter valid phone number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: "Phone",
                      hintText: "Enter Phone Number",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (int.tryParse(value!)! < 18) {
                        return 'Age should be more than 18 ';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: "Age",
                      hintText: "Enter Your Age",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropDownTextField(
                      textFieldDecoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      controller: _itemController,
                      clearOption: true,
                      searchDecoration: const InputDecoration(
                        hintText: "Select Your Department",
                      ),
                      validator: (value) {
                        if (value == null) {
                          return "please select an option";
                        } else {
                          return null;
                        }
                      },
                      dropDownItemCount: 4,
                      dropDownList: [
                        DropDownValueModel(name: 'HR', value: "value1"),
                        DropDownValueModel(name: 'Finance', value: "value2"),
                        DropDownValueModel(
                            name: 'Housekeeping', value: "value3"),
                        DropDownValueModel(name: 'Marketing', value: "value4"),
                      ]),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  SizedBox(
                    height: h * 0.06,
                    width: w * 0.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        primary: Colors.blue.shade300,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')));
                        final ref = FirebaseStorage.instance
                            .ref()
                            .child('usersImages')
                            .child(_nameController.toString() + '.jpg');
                        await ref.putFile(_pickedImage!);
                        String imageUrl = await ref.getDownloadURL();
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }

                        final name = _nameController.text;
                        final phone = _phoneController.text;
                        final age = _ageController.text;
                        final dept = _itemController.toString();
                        final url1 = imageUrl;
                        createUser(
                          name: name,
                          phone: phone,
                          age: age,
                          dept: dept.toString(),
                          imageUrl: url1,
                        );
                      },
                      child: Text(
                        'SAVE',
                        style: GoogleFonts.raleway(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
  Future createUser({
    required String name,
    required String phone,
    required String age,
    required String dept,
    required String imageUrl,
  }) async {
    //Refrence to document
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final user = User(
      name: name,
      phone: phone,
      imageUrl: imageUrl,
      age: age,
      id: docUser.id,
      dept: dept,
    );
    final json = user.toJson();

    // Create document and write data to Firebase
    await docUser.set(json);
  }
}

class User {
  String id;
  final String name;
  final String imageUrl;
  final String phone;
  final String age;
  final String dept;

  User({
    this.id = '',
    required this.imageUrl,
    required this.name,
    required this.phone,
    required this.age,
    required this.dept,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'age': age,
        'department': dept,
        'imageUrl': imageUrl,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        age: json['age'],
        imageUrl: json['imageUrl'],
        dept: json['department'],
      );
}
