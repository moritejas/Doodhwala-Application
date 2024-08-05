// // ignore_for_file: use_super_parameters, prefer_final_fields, avoid_print, unused_import, unused_local_variable, library_private_types_in_public_api, use_build_context_synchronously
//
// // import 'package:etf_tradings/home_page.dart';
// import 'package:doodhwala/HomePage/home_page.dart';
// import 'package:doodhwala/HomePage/user_name_list.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/services.dart';
// import '../../model/User_name_model_class/model.dart';
//
// class AddDataForm extends StatefulWidget {
//   const AddDataForm({Key? key}) : super(key: key);
//
//   @override
//   _AddDataFormState createState() => _AddDataFormState();
// }
//
// class _AddDataFormState extends State<AddDataForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
// // Controllers for form fields
// //   late TextEditingController _usernameController = TextEditingController();
// //   final TextEditingController _idnoController = TextEditingController();
// //   final TextEditingController _phonenoController = TextEditingController();
//
//   Future<String> addData({
//     required String username,
//     required String idno,
//     required String phoneno,
//   }) async {
//     const String scriptUrl =
//         'https://script.google.com/macros/s/AKfycbz0jT4QlJZ-dZ_32UTiY-M1ZslqWfkcGt-i2ytiaSng5Kmjhc-Qq2IOChACRJuaLYI6/exec';
//     try {
//       final Uri uri = Uri.parse('$scriptUrl?action=addData&'
//           'username=$username&'
//           'idno=$idno&'
//           'phoneno=$phoneno&');
//
//       final response = await http.get(uri, headers: {});
//
//       return response.body;
//     } catch (error) {
// // Handle errors appropriately
//       print('Error calling Google Apps Script function: $error');
//       return "error";
//     }
//   }
//
//   void _showAddContactDialog() {
//     final idnoController = TextEditingController();
//     final usernameController = TextEditingController();
//     final phonenoController = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Add New Customer'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                      // const  Text(
//                      //    "Add☺Data",
//                      //    style: TextStyle(fontSize: 25),
//                      //  ),
//                       Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: TextFormField(
//                           controller: usernameController,
//                           decoration: InputDecoration(
//                               labelText: 'Name',
//                               hintText: "Name",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               prefixIcon: const Icon(Icons.person)),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter the Customer name';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: TextFormField(
//                           controller: idnoController,
//                           decoration: InputDecoration(
//                               labelText: 'id no.',
//                               hintText: "id no.",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               prefixIcon: const Icon(Icons.account_circle)),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter the id no.';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: TextFormField(
//                           controller: phonenoController,
//                           decoration: InputDecoration(
//                               labelText: 'Contact Number',
//                               hintText: "Contact Number",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               prefixIcon: const Icon(Icons.call_rounded)),
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             FilteringTextInputFormatter.allow(
//                                 RegExp(r'[0-9]')),
//                             LengthLimitingTextInputFormatter(10),
//                           ],
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter the Contact Number';
//                             } else if (value.length != 10) {
//                               return 'Contact Number must be 10 digits';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//               /*
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             foregroundColor: Colors.white,
//                             backgroundColor: Colors.blueAccent),
//                         onPressed: () async {
//                           if (_formKey.currentState!.validate()) {
//                             // If the form is valid, call the function to add data
//                             final result = await addData(
//                               username: _usernameController.text,
//                               idno: _idnoController.text,
//                               phoneno: _phonenoController.text,
//                               // points: _pointsController.text,
//                             ); // Handle the result from the addData function
//                             if (kDebugMode) {
//                               print("successful");
//                               Get.to(const MyHomePage());
//                               Get.snackbar(
//                                 'Successfull',
//                                 'Customer Add Successfully',
//                                 titleText: const Text(
//                                   'Successfull',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 messageText: const Text(
//                                   'Customer Add Successfully',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 snackPosition: SnackPosition.BOTTOM,
//                                 backgroundColor: const Color(0xFF9066ee),
//                                 borderRadius: 30,
//                                 animationDuration: const Duration(seconds: 2),
//                               );
//                             } else {
//                                   (kDebugMode) {
//                                 print("UnSuccessfull");
//                                 Get.snackbar(
//                                   'UnSuccessfull',
//                                   'Please try again',
//                                   titleText: const Text(
//                                     'UnSuccessfull',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   messageText: const Text(
//                                     'Please try again',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   backgroundColor: const Color(0xFF9066ee),
//                                   borderRadius: 30,
//                                   animationDuration:
//                                   const Duration(seconds: 2),
//                                   snackPosition: SnackPosition.BOTTOM,
//                                 );
//                               };
//                             }
//                           }
//                         },
//                         child: const Text('Submit'),
//                       ),
//                       */
//                     ],
//                   ),
//                 ),
//               ),
//               // TextField(
//               //   controller: _idController,
//               //   decoration: InputDecoration(hintText: "Enter ID"),
//               //   keyboardType: TextInputType.number,
//               // ),
//               // TextField(
//               //   controller: _nameController,
//               //   decoration: InputDecoration(hintText: "Enter Name"),
//               // ),
//               // TextField(
//               //   controller: _phoneController,
//               //   decoration: InputDecoration(hintText: "Enter Phone Number"),
//               //   keyboardType: TextInputType.phone,
//               // ),
//             ],
//           ),
//
//           actions: <Widget>[
//             ElevatedButton(
//               child: const Text('CANCEL'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             ElevatedButton(
//               child: const Text('ADD'),
//               // onPressed: () {
//               //   final id = int.tryParse(_idController.text) ?? 0;
//               //   final name = _nameController.text;
//               //   final phoneNumber = _phoneController.text;
//               //   if (id > 0 && name.isNotEmpty && phoneNumber.isNotEmpty) {
//               //     _addContact(
//               //         Contact(id: id, name: name, phoneNumber: phoneNumber));
//               //     Navigator.of(context).pop();
//               //   }
//               // },
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   // If the form is valid, call the function to add data
//                   final result = await addData(
//                     username: usernameController.text,
//                     idno: idnoController.text,
//                     phoneno: phonenoController.text,
//                     // points: _pointsController.text,
//                   ); // Handle the result from the addData function
//                   if (kDebugMode) {
//                     print("successful");
//                     Get.to(const MyHomePage());
//                     Get.snackbar(
//                       'Successfull',
//                       'Customer Add Successfully',
//                       titleText: const Text(
//                         'Successfull',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       messageText: const Text(
//                         'Customer Add Successfully',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       snackPosition: SnackPosition.BOTTOM,
//                       backgroundColor: const Color(0xFF9066ee),
//                       borderRadius: 30,
//                       animationDuration: const Duration(seconds: 2),
//                     );
//                   } else {
//                         (kDebugMode) {
//                       print("UnSuccessfull");
//                       Get.snackbar(
//                         'UnSuccessfull',
//                         'Please try again',
//                         titleText: const Text(
//                           'UnSuccessfull',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         messageText: const Text(
//                           'Please try again',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         backgroundColor: const Color(0xFF9066ee),
//                         borderRadius: 30,
//                         animationDuration:
//                         const Duration(seconds: 2),
//                         snackPosition: SnackPosition.BOTTOM,
//                       );
//                     };
//                   }
//                 }
//               },
//
//
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
// //Scaffold
//     return Scaffold(
// //AppBar
//       appBar: AppBar(
//           title: const Text('Add Customer Details'),
//           centerTitle: true,
//           // backgroundColor: const Color(0xFF7accb8),
//           leading: IconButton(
//               onPressed: () {
//                 Get.back();
//               },
//               icon: const Icon(Icons.arrow_back_rounded))),
// // Body
//       body:
//       Center(
//         child: ElevatedButton(onPressed: (){
//           _showAddContactDialog();
//         }, child: const Text('Add Username'))
//         /*
//         Material(
//           shadowColor: Colors.grey,
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           elevation: 20.0,
//           child: SizedBox(
//             height: 400,
//             width: 300,
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.all(5.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Add☺Data",
//                                 style: TextStyle(fontSize: 25),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: TextFormField(
//                             controller: _usernameController,
//                             decoration: InputDecoration(
//                                 labelText: 'Name',
//                                 hintText: "Name",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 prefixIcon: const Icon(Icons.person)),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter the Customer name';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: TextFormField(
//                             controller: _idnoController,
//                             decoration: InputDecoration(
//                                 labelText: 'id no.',
//                                 hintText: "id no.",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 prefixIcon: const Icon(Icons.account_circle)),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter the id no.';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: TextFormField(
//                             controller: _phonenoController,
//                             decoration: InputDecoration(
//                                 labelText: 'Contact Number',
//                                 hintText: "Contact Number",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 prefixIcon: const Icon(Icons.call_rounded)),
//                             keyboardType: TextInputType.number,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.allow(
//                                   RegExp(r'[0-9]')),
//                               LengthLimitingTextInputFormatter(10),
//                             ],
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter the Contact Number';
//                               } else if (value.length != 10) {
//                                 return 'Contact Number must be 10 digits';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               foregroundColor: Colors.white,
//                               backgroundColor: Colors.blueAccent),
//                           onPressed: () async {
//                             if (_formKey.currentState!.validate()) {
//                               // If the form is valid, call the function to add data
//                               final result = await addData(
//                                 username: _usernameController.text,
//                                 idno: _idnoController.text,
//                                 phoneno: _phonenoController.text,
//                                 // points: _pointsController.text,
//                               ); // Handle the result from the addData function
//                               if (kDebugMode) {
//                                 print("successful");
//                                 Get.to(const MyHomePage());
//                                 Get.snackbar(
//                                   'Successfull',
//                                   'Customer Add Successfully',
//                                   titleText: const Text(
//                                     'Successfull',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   messageText: const Text(
//                                     'Customer Add Successfully',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   snackPosition: SnackPosition.BOTTOM,
//                                   backgroundColor: const Color(0xFF9066ee),
//                                   borderRadius: 30,
//                                   animationDuration: const Duration(seconds: 2),
//                                 );
//                               } else {
//                                     (kDebugMode) {
//                                   print("UnSuccessfull");
//                                   Get.snackbar(
//                                     'UnSuccessfull',
//                                     'Please try again',
//                                     titleText: const Text(
//                                       'UnSuccessfull',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     messageText: const Text(
//                                       'Please try again',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     backgroundColor: const Color(0xFF9066ee),
//                                     borderRadius: 30,
//                                     animationDuration:
//                                     const Duration(seconds: 2),
//                                     snackPosition: SnackPosition.BOTTOM,
//                                   );
//                                 };
//                               }
//                             }
//                           },
//                           child: const Text('Submit'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         */
//       ),
//       // ),
//     );
//   }
// }
