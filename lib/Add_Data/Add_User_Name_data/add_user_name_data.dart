// ignore_for_file: use_super_parameters, prefer_final_fields, avoid_print, unused_import, unused_local_variable, library_private_types_in_public_api, use_build_context_synchronously

// import 'package:etf_tradings/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import '../../HomePage/home_page.dart';
import '../../model/User_name_model_class/model.dart';

class AddDataForm extends StatefulWidget {
  const AddDataForm({Key? key}) : super(key: key);

  @override
  _AddDataFormState createState() => _AddDataFormState();
}

class _AddDataFormState extends State<AddDataForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// Controllers for form fields
  late TextEditingController _usernameController = TextEditingController();
  final TextEditingController _idnoController = TextEditingController();
  final TextEditingController _phonenoController = TextEditingController();
  // final TextEditingController _phoneNoController = TextEditingController();

  Future<String> addData({
    required String username,
    required String idno,
    required String phoneno,
  }) async {
    const String scriptUrl =
        'https://script.google.com/macros/s/AKfycbwIYwpGhRzOBE8204JqDjK4fWwnp-2MBIGIPGB0yHVWT2Q7dVgE1i2Tpyj9am9AlPrJ/exec';
    try {
      final Uri uri = Uri.parse('$scriptUrl?action=addData&'
          'username=$username&'
          'idno=$idno&'
          'phoneno=$phoneno&');

      final response = await http.get(uri, headers: {});

      return response.body;
    } catch (error) {
// Handle errors appropriately
      print('Error calling Google Apps Script function: $error');
      return "error";
    }
  }

  @override
  Widget build(BuildContext context) {
//Scaffold
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
//AppBar
      appBar: AppBar(
          title: const Text(
            'Add Customer',
            style: TextStyle(
                // color:Colors.white,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_rounded))),
// Body
      body: Center(
        // body: DecoratedBox(
        // decoration: const BoxDecoration(
        // image: DecorationImage(
        // image: AssetImage("images/image6.jpg"),fit:BoxFit.cover),
        // ),
        // child: Center(),
// Use Material ShadowColor
        child: Material(
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          elevation: 20.0,
          child: Container(
            // color: Colors.white,
            height: 400,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),

            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "AddData",
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: "Enter Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the Customer name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: _idnoController,
                            decoration: InputDecoration(
                                labelText: 'id no.',
                                hintText: "Enter id no.",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                prefixIcon: const Icon(Icons.account_circle,
                                    color: Colors.deepPurpleAccent)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the id no.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: _phonenoController,
                            decoration: InputDecoration(
                                labelText: 'Contact Number',
                                hintText: "Enter Contact Number",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                prefixIcon: const Icon(Icons.call_rounded,
                                    color: Colors.deepPurpleAccent)),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the Contact Number';
                              } else if (value.length != 10) {
                                return 'Contact Number must be 10 digits';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 8,
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.deepPurpleAccent),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, call the function to add data
                              final result = await addData(
                                username: _usernameController.text,
                                idno: _idnoController.text,
                                phoneno: _phonenoController.text,
                              ); // Handle the result from the addData function
                              if (kDebugMode) {
                                print("successful");
                                // Get.to(const MyHomePage());
                                Get.to(() => const MyHomePage());
                                Get.snackbar(
                                  'Successfull',
                                  'Customer Add Successfully',

                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.black45, // Background color
                                  colorText: Colors.white,
                                  // backgroundColor: Colors.white,
                                  borderRadius: 7,
                                  animationDuration: const Duration(milliseconds: 1300),
                                );
                              } else {
                                (kDebugMode) {
                                  print("UnSuccessfull");
                                  Get.snackbar(
                                    "UnSuccessfull",
                                    'Please try again',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.black45, // Background color
                                    colorText: Colors.white,
                                    // backgroundColor: Colors.white,
                                    borderRadius: 7,
                                    animationDuration: const Duration(milliseconds: 1300),
                                  );
                                  // Get.snackbar(
                                  //   'UnSuccessfull',
                                  //   'Please try again',
                                  //   titleText: const Text(
                                  //     'UnSuccessfull',
                                  //     style: TextStyle(color: Colors.white),
                                  //   ),
                                  //   messageText: const Text(
                                  //     'Please try again',
                                  //     style: TextStyle(color: Colors.white),
                                  //   ),
                                  //   backgroundColor: const Color(0xFF9066ee),
                                  //   borderRadius: 30,
                                  //   animationDuration:
                                  //       const Duration(seconds: 2),
                                  //   snackPosition: SnackPosition.BOTTOM,
                                  // );
                                };
                              }
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
