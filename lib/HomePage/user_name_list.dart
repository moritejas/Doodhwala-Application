// ignore_for_file: avoid_print, library_private_types_in_public_api, dead_code, use_build_context_synchronously, unused_local_variable, unused_element, deprecated_member_use, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../Add_Data/Add_User_Detail_Data/view.dart';
import '../Add_Data/Add_User_Name_data/add_user_name_data.dart';
import '../model/User_name_model_class/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../themes/Light_Dark_theme/themes_controller.dart';
import 'home_page.dart';
import 'quantity_add_edit_controller.dart';

//---Class
class Dudhwale extends StatefulWidget {
  final ThemeController themeController = Get.put(ThemeController());

  Dudhwale({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Dudhwale> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ThemeController themeController = Get.find<ThemeController>();
  // final QuantityController controller = Get.put(QuantityController());
  List<DudhWala> items = [];
  bool isSorted = false;
  // Select time
  // String formattedTimeOnly = DateFormat('h:mm a').format(DateTime.now()) ;

  // Select Date
  // DateTime? selectedDates;
  // DateTime selectedDates = DateTime.now();
  // String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  // String selectedDates = DateFormat('dd/MM/yyyy').format(DateTime.now());
  // DateTime selectedDates = DateFormat('dd-MM-yyyy').format(DateTime.now()) as DateTime;

  // void _sortItems(String criterion) {
  //   setState(() {
  //     items.sort((a, b) {
  //       switch (criterion) {
  //         case 'username':
  //           return a.username.compareTo(b.username);
  //         case 'idno':
  //           return a.idno.compareTo(b.idno);
  //         default:
  //           return 0; // In case of an unknown criterion, don't change the order
  //       }
  //     });
  //   });
  // }

  void _sortItemsCombine() {
    // _sortedItemsname();
    _sortedItemid();
  }

  void _sortItemsname() {
    setState(() {
      items.sort(
        (a, b) => a.username.compareTo(b.username),
      );
    });
  }

  void _sortedItemid() {
    setState(() {
      items.sort(
        (a, b) => a.idno.compareTo(b.idno),
      );
    });
  }

  //--- Add User Name Data
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
      // if(response.statusCode == 200){
      //   _addDataSuccessfull();
      // }
      // else{
      //   _addDataUnSuccessfull();
      // }

      return response.body;
    } catch (error) {
// Handle errors appropriately
      print('Error calling Google Apps Script function: $error');
      return "error";
    }
  }

  //---Add Username Deta (Dialog box)
  void _showAddContactDialog() {
    final idnoController = TextEditingController();
    final usernameController = TextEditingController();
    final phonenoController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Customer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const  Text(
                      //    "Add☺Data",
                      //    style: TextStyle(fontSize: 25),
                      //  ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              prefixIcon: const Icon(Icons.person)),
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
                          controller: idnoController,
                          decoration: InputDecoration(
                              labelText: 'id no.',
                              hintText: "id no.",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              prefixIcon: const Icon(Icons.account_circle)),
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
                          controller: phonenoController,
                          decoration: InputDecoration(
                              labelText: 'Contact Number',
                              hintText: "Contact Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              prefixIcon: const Icon(Icons.call_rounded)),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Ok'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, call the function to add data
                  final result = await addData(
                    username: usernameController.text,
                    idno: idnoController.text,
                    phoneno: phonenoController.text,
                    // points: _pointsController.text,
                  ); // Handle the result from the addData function
                  if (kDebugMode) {
                    print("successful");
                    // Get.to(const MyHomePage());
                    Get.to(() => const MyHomePage());
                    Get.snackbar(
                      'Successfull',
                      'Customer Add Successfully',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.black45,
                      borderRadius: 7,
                      animationDuration: const Duration(milliseconds: 1300),
                    );
                  } else {
                    (kDebugMode) {
                      print("UnSuccessfull");
                      Get.snackbar(
                        'UnSuccessfull',
                        'Please try again',
                        backgroundColor: Colors.black45,
                        borderRadius: 7,
                        animationDuration: const Duration(milliseconds: 1300),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    };
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  //---Pull to Refresh
  Future<void> _handleRefresh() async {
    return await Future.delayed(
      const Duration(seconds: 3),
    );
  }

  //---Fetching User Name Data
  Future<void> fetchDataFromApi() async {
    try {
      var baseUrl =
          'https://script.google.com/macros/s/AKfycbwIYwpGhRzOBE8204JqDjK4fWwnp-2MBIGIPGB0yHVWT2Q7dVgE1i2Tpyj9am9AlPrJ/exec?action=getUsername';
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final dudhwala = dudhWalaFromJson(response.body.toString());
        setState(() {
          items = dudhwala;
        });
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (error) {
      // Handle errors appropriately
    }
  }

  //---Add Quantity Data
  Future<String> addQuantity(
      {required String idno,
      required String qt,
      required dates,
      required times}) async {
    const String scriptUrl =
        'https://script.google.com/macros/s/AKfycbwIYwpGhRzOBE8204JqDjK4fWwnp-2MBIGIPGB0yHVWT2Q7dVgE1i2Tpyj9am9AlPrJ/exec';
    try {
      final Uri uri = Uri.parse('$scriptUrl?action=addQuantity&'
          'idno=$idno&'
          'qt=$qt&'
          'time=$times&'
          'dates=$dates&');
      print("ID NUMBER : $idno");
      print("LITER QUANTITY : $qt");
      print("SELECTED TIME $times");
      print("SELECTED DATE : $dates");
      final response = await http.get(uri, headers: {});
      if (response.statusCode == 200) {
        // Show success Snackbar
        Get.snackbar(
          'Success',
          'Data added successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        // Show unsuccessful Snackbar
        Get.snackbar(
          'Error',
          'Failed to add data. Status code: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      return response.body;
    } catch (error) {
      // Handle errors appropriately
      print('Error calling Google Apps Script function: $error');
      return "error";
    }
  }

  //---Scaffold
  @override
  Widget build(BuildContext context) {
    print('Build');
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,

      //  AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'DoodhWala',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            // color: Colors.deepPurple ,
          ),
        ),
        centerTitle: true,
        // backgroundColor: const Color(0xFF7accb8),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.sort,
              // color: Colors.deepPurple,
            ),
            onPressed: _sortItemsCombine,
          ),
        ],
      ),

      //  Drawer
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            ListTile(
              title: const Text('Home',
                  style: TextStyle(
                  fontSize: 22),
              ),
              leading: const Icon(
                size: 32,
                Icons.home,
                color: Colors.deepPurpleAccent,
              ),
              onTap: () {},
            ),
            const ListTile(
              title: Text('Account',style: TextStyle(
                  fontSize: 25),),
              leading: Icon(
                size: 32,
                Icons.account_box,
                color: Colors.deepPurpleAccent,
              ),
            ),
            const ListTile(
              title: Text('Logout',style: TextStyle(
                  fontSize: 22),),
              leading: Icon(size: 32,
                Icons.logout,
                color: Colors.deepPurpleAccent,
              ),
            ),
            ListTile(
              title: const Text('Language',style: TextStyle(
                  fontSize: 22),),
              leading: const Icon(size: 32,
                Icons.language,
                color: Colors.deepPurpleAccent,
              ),
              onTap: () {
                Get.defaultDialog(
                  title: 'Select Language',
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('Gujarati'),
                        leading: const Icon(
                          Icons.language_sharp,
                          color: Colors.deepPurpleAccent,
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('English'),
                        leading: const Icon(
                          Icons.language_sharp,
                          color: Colors.deepPurpleAccent,
                        ),
                        onTap: () {},
                      )
                    ],
                  ),
                );
              },
            ),
            ListTile(
                title: const Text('Themes',style: TextStyle(
                    fontSize: 22),),
                leading: const Icon(size: 32,
                  Icons.wb_sunny_sharp,
                  color: Colors.deepPurpleAccent,
                ),
                onTap: () {
                  Get.defaultDialog(
                    barrierDismissible: false,
                    title: 'Select Themes',
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('Dark Themes'),
                          leading: const Icon(
                            Icons.dark_mode_rounded,
                            color: Colors.deepPurpleAccent,
                          ),
                          onTap: () {
                            print('Dark Mode Selected');
                            themeController.switchToDarkTheme();
                            Get.back();
                          },
                        ),
                        ListTile(
                          title: const Text('Light Modes'),
                          leading: const Icon(
                            Icons.light_mode,
                            color: Colors.deepPurpleAccent,
                          ),
                          onTap: () {
                            print('Light Mode Selected');
                            themeController.switchToLightTheme();
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                }),
// Themes Modes using Bottom Sheet
            ListTile(
              title: const Text('Theme Modes',style: TextStyle(
                  fontSize: 22),),
              leading: const Icon(size: 32,
                Icons.sunny_snowing,
                color: Colors.deepPurpleAccent,
              ),
              onTap: () {
                Get.bottomSheet(
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.sunny),
                          title: const Text('Light Mode'),
                          onTap: () {
                            // Get.changeTheme(ThemeData.light());
                            themeController.switchToLightTheme();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.sunny),
                          title: const Text('Dark Modes'),
                          onTap: () {
                            themeController.switchToDarkTheme();
                            // Get.changeTheme(ThemeData.dark());
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('About',style: TextStyle(
                  fontSize: 22),),
              leading: SvgPicture.asset(
                'assets/icons/about_data.svg',
                height: 32,
                width: 32,
                color: Colors.deepPurpleAccent,
              ),
              onTap: (){
                Get.defaultDialog(
                  title: 'About',
                  middleText: 'Version : 3.1 (Demo)',
                );
              },
            ),
            /*
                ListTile(
                  title: const Text('Theme'),
                  leading: const Icon(Icons.wb_sunny_sharp),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select Theme'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: const Text('Dark Mode'),
                                leading: const Icon(Icons.dark_mode_rounded),
                                onTap: () => {
                                  print('Dark Mode selected'),
                                  themeController.switchToDarkTheme(),
                                  Get.back(),
                                },
                              ),
                              ListTile(
                                title: const Text('Light Mode'),
                                leading: const Icon(Icons.wb_sunny_outlined),
                                onTap: () => {
                                  print('Light Mode selected'),
                                  themeController.switchToLightTheme(),
                                  Get.back(),
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                */
          ],
        ),
      ),

      //  Body
      body: LiquidPullToRefresh(
          color: Colors.white,
          height: 300,
          backgroundColor: Colors.deepPurpleAccent,
          animSpeedFactor: 2,
          // showChildOpacityTransition: false,
          onRefresh: _handleRefresh,
          child: buildBody()),

      //Apply Background Image
      /*
          body: DecoratedBox(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:AssetImage("images/image8.jpg"),fit: BoxFit.cover),
          ),
          child: buildBody(),
          ),
    */

      //Add Data Floating Action Button
      floatingActionButton: FloatingActionButton(
        elevation: 8,
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          // Get.to(const AddDataForm());
          Get.to(() => const AddDataForm());
          // _showAddContactDialog();
        },
        tooltip: 'Add Data',
        // child: const Icon(Icons.add),
        child: SvgPicture.asset(
          'assets/icons/user-add.svg',
          height: 22,
          width: 22,
          color: Colors.deepPurpleAccent,
        ),
      ),
    );
  }

  //--- Id, Username
  //--- Widget BuildBody
  Widget buildBody() {
    if (items.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (!isSorted) {
        isSorted = true;
      }
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: Card(
              color: Colors.white,
              // elevation: 7,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    ListTile(
//  Username
                        title: Text(
                          " ${items[index].username}",
                          style: const TextStyle(
                            fontSize: 24,
                            // color:Colors.deepPurpleAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
//  Id No.
                        // Sub Title
                        subtitle: Text(
                          "ID-No: ${items[index].idno}",
                          style: const TextStyle(
                            fontSize: 18,
                            // color:Colors.deepPurpleAccent,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
// Person Icon                // Leading
                        leading: const Icon(
                          size: 30,
                          weight:40,
                          Icons.person_rounded,
                          // color: Colors.deepPurpleAccent,
                        ),
// Add Quantity Button
                        // Trailing
                        trailing: IconButton(
                          style: IconButton.styleFrom(
                            elevation: 8,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepPurpleAccent,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(7)),
                            ),
                          ),
                          onPressed: () {
                            _qtyAndDateSelected(items[index].idno);
                          },
                          // label: const Text('QTY'),
                          icon: const Icon(
                            size: 26,
                            Icons.add,
                          ),
                        ),
                        onLongPress: () {
                          // Perform delete operation
                          Get.defaultDialog(
                            backgroundColor: Colors.deepPurpleAccent,
                            title: "Conform Delete Item",
                            titleStyle: const TextStyle(color: Colors.white),
                            content: Text(
                              "Are you sure you want to Delete this Item ${items[index].idno}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            barrierDismissible: false,
                            cancel: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 12,
                                // foregroundBuilder:Colors.white ,
                                // backgroundColor: Colors.deepPurpleAccent,
                              ),
                              child: const Text("Cancel"),
                            ),
                            confirm: ElevatedButton(
                              onPressed: () {
                                _deleteItem(items[index].idno);
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 12,
                                // foregroundBuilder:Colors.white ,
                                // backgroundColor: Colors.deepPurpleAccent,
                              ),
                              child: const Text("Ok"),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 3,
                      width: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(17, 0, 8, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Phone Number
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            const   Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 8),
                                child: Icon(
                                  weight: 15,size: 28,
                                  Icons.call_rounded,
                                  // color: Colors.deepPurpleAccent,
                                ),
                              ),
                              Text(
                                '${items[index].phoneno}',
                                style: const TextStyle(
                                    // color:Colors.deepPurpleAccent,
                                    fontSize: 17),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 15, 8),
                            child: Column(
                              children: [
                                IconButton(
                                  style: IconButton.styleFrom(
                                    elevation: 8,
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.deepPurpleAccent,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(7)),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Used Getx with UserDetailPage
                                    // Get.to(UserDetailsPage(
                                      Get.to(() => UserDetailsPage(
                                      name: items[index].username,
                                      id: items[index].idno,
                                      phones: items[index].phoneno,
                                    ));
                                  },
                                  // label: const Text('View'),`
                                  icon: const Icon(
                                    size: 26,
                                      Icons.remove_red_eye),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  //---Delete item function
  void _deleteItem(String id) async {
    try {
      const String scriptUrl =
          'https://script.google.com/macros/s/AKfycbwIYwpGhRzOBE8204JqDjK4fWwnp-2MBIGIPGB0yHVWT2Q7dVgE1i2Tpyj9am9AlPrJ/exec';
      final Uri uri = Uri.parse('$scriptUrl?action=deletenameData&idno=$id');
      final response = await http.get(uri, headers: {});
      if (response.statusCode == 200) {
        setState(() {
          // Remove the item from the list
          items.removeWhere((element) => element.idno == id);
          // Get.snackbar(
          //   "Data",
          //   'Delete Successfully',
          //   snackPosition: SnackPosition.BOTTOM,
          //   backgroundColor: Colors.black45, // Background color
          //   colorText: Colors.white,
          //   // backgroundColor: Colors.white,
          //   borderRadius: 7,
          //   animationDuration: const Duration(milliseconds: 1300),
          // );
           Get.snackbar(
            'Successfull',
            '$id Customer Delete Successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black45,
            colorText: Colors.white,
            borderRadius: 7,
            animationDuration: const Duration(milliseconds: 1300),
          );
        });
      } else {
        throw Exception('Failed to delete item');
      }
      // Handle errors appropriately
    } catch (error) {
      print('Error deleting item: $error');
      Get.snackbar(
        'UnSuccessfull',
        'Failed to delete item',
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          'UnSuccessfull',
          style: TextStyle(color: Colors.white),
        ),
        messageText: const Text(
          'Failed to delete item',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black45,
        borderRadius: 7,
        animationDuration: const Duration(milliseconds: 1300),
      );
    }
  }

  /*i want to you create one "_qtyanddateselected"  function . Add this functionality in this function, create one getx dialog box
   and show two items, 1. drowp down button, 2. date picker, i have call this function to open dialog box user select dropdown
   value and user select date than below two show to text button first Cancel and second ok. user click cancel to close dialog
   box and user click ok than both value is saved. please make code for me*/

// Select Quantity and Date

  /*
  void _selectQuantitys() {
    final DialogController controller = Get.find<DialogController>();
    Get.dialog(
      AlertDialog(
        title: const Text('Select Quantity (Liter)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text('0.25'),
                      value: '0.25',
                      groupValue: controller.selectedQuantity.value,
                      onChanged: (value) {
                        controller.selectedQuantity.value = value!;
                        controller.customQuantityController
                            .clear(); // Clear custom input
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('0.50'),
                      value: '0.50',
                      groupValue: controller.selectedQuantity.value,
                      onChanged: (value) {
                        controller.selectedQuantity.value = value!;
                        controller.customQuantityController
                            .clear(); // Clear custom input
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('0.75'),
                      value: '0.75',
                      groupValue: controller.selectedQuantity.value,
                      onChanged: (value) {
                        controller.selectedQuantity.value = value!;
                        controller.customQuantityController
                            .clear(); // Clear custom input
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('1'),
                      value: '1',
                      groupValue: controller.selectedQuantity.value,
                      onChanged: (value) {
                        controller.selectedQuantity.value = value!;
                        controller.customQuantityController
                            .clear(); // Clear custom input
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('2'),
                      value: '2',
                      groupValue: controller.selectedQuantity.value,
                      onChanged: (value) {
                        controller.selectedQuantity.value = value!;
                        controller.customQuantityController
                            .clear(); // Clear custom input
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Custom'),
                      value: 'custom',
                      groupValue: controller.selectedQuantity.value,
                      onChanged: (value) {
                        controller.selectedQuantity.value = value!;
                      },
                    ),
                    if (controller.selectedQuantity.value == 'custom')
                      TextField(
                        controller: controller.customQuantityController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Enter custom quantity',
                        ),
                      ),
                  ],
                )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              String? quantitySelectedValue;
              if (controller.selectedQuantity.value == 'custom' &&
                  controller.customQuantityController.text.isNotEmpty) {
                quantitySelectedValue =
                    controller.customQuantityController.text;
                print('Custom Selected Quantitys:'
                    ' ${controller.customQuantityController.text}');
              }
              else {
                quantitySelectedValue = controller.selectedQuantity.value;
                // print('Select in Selected Quantity: ${controller.selectedQuantity.value}');
              }
              print("Final Selected Value $quantitySelectedValue ");
              Get.back(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
*/
  void _selectQuantity() {
    final DialogController controller = Get.put(DialogController());
    Get.dialog(
      AlertDialog(
        title: const Text('Select Quantity (Liter)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Column(
              children: [
                RadioListTile<String>(
                  title: const Text('0'),
                  value: '0.00',
                  groupValue: controller.selectedQuantity.value,
                  onChanged: (value) {
                    controller.selectedQuantity.value = value!;
                    controller.customQuantityController.clear(); // Clear custom input
                  },
                ),
                RadioListTile<String>(
                  title: const Text('અચ્છેર'),
                  value: '0.25',
                  groupValue: controller.selectedQuantity.value,
                  onChanged: (value) {
                    controller.selectedQuantity.value = value!;
                    controller.customQuantityController.clear(); // Clear custom input
                  },
                ),
                RadioListTile<String>(
                  title: const Text('સેર'),
                  value: '0.50',
                  groupValue: controller.selectedQuantity.value,
                  onChanged: (value) {
                    controller.selectedQuantity.value = value!;
                    controller.customQuantityController.clear(); // Clear custom input
                  },
                ),
                RadioListTile<String>(
                  title: const Text('પોણા સેર'),
                  value: '0.75',
                  groupValue: controller.selectedQuantity.value,
                  onChanged: (value) {
                    controller.selectedQuantity.value = value!;
                    controller.customQuantityController.clear(); // Clear custom input
                  },
                ),
                RadioListTile<String>(
                  title: const Text('એક લીટર'),
                  value: '1',
                  groupValue: controller.selectedQuantity.value,
                  onChanged: (value) {
                    controller.selectedQuantity.value = value!;
                    controller.customQuantityController.clear(); // Clear custom input
                  },
                ),
                RadioListTile<String>(
                  title: const Text('બે  લીટર'),
                  value: '2',
                  groupValue: controller.selectedQuantity.value,
                  onChanged: (value) {
                    controller.selectedQuantity.value = value!;
                    controller.customQuantityController.clear(); // Clear custom input
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Custom'),
                  value: 'custom',
                  groupValue: controller.selectedQuantity.value,
                  onChanged: (value) {
                    controller.selectedQuantity.value = value!;
                  },
                ),
                if (controller.selectedQuantity.value == 'custom')
                  TextField(
                    controller: controller.customQuantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter custom quantity',
                    ),
                  ),
              ],
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.validateSelection()) {
                String quantitySelectedValue = controller.getSelectedQuantity();
                controller.selectedQuantity.value = quantitySelectedValue;
                print("Final Selected Value: $quantitySelectedValue");
                Get.back(); // Close the dialog
              } else {
                Get.snackbar(
                  'Error',
                  'Please select a value or enter a custom value',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Select Date
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDates,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime.now(),
  //   );
  //
  //   if (pickedDate != null && pickedDate != selectedDates) {
  //     setState(() {
  //       selectedDates = pickedDate;
  //       formattedDate = DateFormat('dd/MM/yyyy').format(selectedDates);
  //     });
  //     print('Selected date: $formattedDate');
  //   }
  // }


  // Select Time
  void _qtyAndDateSelected(String idnos) {
    final DialogController controller = Get.put(DialogController());
    TimeOfDay formattedTime =  controller.selectedTime.value;
    Get.dialog(
      AlertDialog(
        title: const Text('Select Date and Time'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [

        //  Select Quantity
            SizedBox(
              // height: 35,
              width: 150,
              child: ElevatedButton.icon(
                onPressed: _selectQuantity,
                icon: SvgPicture.asset('assets/icons/milk_icon.svg', height: 28, width:28,
                        color: Colors.deepPurpleAccent,
                      ),
                label:
                // Obx(() => Text(
                //   controller.getSelectedQuantity().isEmpty
                //       ? 'Select Quantity'
                //       : 'Quantity: ${controller.getSelectedQuantity()}',
                //   style: TextStyle(fontSize: 18),
                // )),
                Obx(() => Text(controller.selectedQuantity.value)),
                // Obx(() => Text(
                //       controller.selectedQuantity.value == 'custom' &&
                //               controller.customQuantityController.text.isNotEmpty
                //           ? controller.customQuantityController.text
                //           : controller.selectedQuantity.value,
                //     )),
              ),
            ),
            const SizedBox(height: 10),

        //  Time
            SizedBox(
              // height: ,
              width: 150,
              child: Obx(() => ElevatedButton.icon (
                // onPressed: () async {}
                // /*
                onPressed: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: Get.context!,
                    initialTime: controller.selectedTime.value,
                  );
                  if (picked != null &&
                      picked != controller.selectedTime.value) {
                    controller.selectedTime.value = picked;
                  }
                },
                icon: const Icon(Icons.access_time_filled_outlined,
                color: Colors.deepPurpleAccent,),
                label: Text(
                    controller.selectedTime.value.format(Get.context!)
                  // "Selected Time: ${DateFormat('h:mm a').format(controller.selectedTime.value)}"
                ),
              )),
            ),
            const SizedBox(height: 10),

        //  Date
            SizedBox(
              width: 150,
              child: Obx(() =>
                  ElevatedButton.icon(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: Get.context!,
                        initialDate: controller.selectedDate.value,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null &&
                          picked != controller.selectedDate.value) {
                        controller.selectedDate.value = picked;
                      }
                      // print('Selected Datettttt: ${DateFormat('yyyy-MM-dd').format(controller.selectedDate.value)}');
                    },
                      icon: const Icon(Icons.calendar_month_sharp,
                        color: Colors.deepPurpleAccent,),
                    label: Text(
                        DateFormat('yyyy-MM-dd').
                        format(controller.selectedDate.value)
                    ),
                  ),),
            ),

            const SizedBox(height: 16),

          ],
        ),
        actions: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
//  Cancel Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 8,
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurpleAccent),
            onPressed: () {
              Get.back(); // Close the dialog
              Get.snackbar(
                'Error',
                'Failed to add Quantity.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.black45, // Background color
                colorText: Colors.white,
                borderRadius: 7,
                animationDuration: const Duration(milliseconds: 1300),
              );

            },
            child: const Text('Cancel'),
          ),
//  Ok  Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 8,
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurpleAccent),
            onPressed: () {
              // String formattedDated = DateFormat('dd/MM/yyyy').format(selectedDates);
              // Check and save the selected values here
              // String? quantitySelectedValue;
              // if (controller.selectedQuantity.value == 'custom' &&
              //     controller.customQuantityController.text.isNotEmpty) {
              //   quantitySelectedValue = controller.customQuantityController.text;
                print('Custom Selected Quantitys: ${controller.customQuantityController.text}');
              // }
              // else {
              //   quantitySelectedValue = controller.selectedQuantity.value;
              //   print('Select in Selected Quantity: ${controller.selectedQuantity.value}');
              // }
              addQuantity(
                idno: idnos,
                qt:controller.selectedQuantity.value,
                // quantitySelectedValue,
                dates:DateFormat('yyyy-MM-dd').format(controller.selectedDate.value),
                times:
                // formattedTimeOnly
                controller.selectedTime.value.format(Get.context!),
              );
              Get.back(); // Close the dialog
            },
            child: const Text('OK'),
          ),
          ],
          ),
        ],
      ),
    );
  }
//opopopopopo
/*
// Selected Value
             Column(
              children:[
                Card(
                  child: Obx(() => Text(
                             controller.selectedQuantity.value == 'custom' &&
                             controller.customQuantityController.text.isNotEmpty
                             ? controller.customQuantityController.text
                             : controller.selectedQuantity.value,
                  )),
                  // Text(""),
                ),
                Card(
                  child:  Text(
                      controller.selectedTime.value.format(Get.context!)
                      ),
                  // Text(""),
                ),
                Card(
                  child:  Text(
                      DateFormat('yyyy-MM-dd').
                      format(controller.selectedDate.value)
                  ),
                  // Text(""),
                ),
              ],
            )*/

//  Successfully
//   void _addDataSuccessfull(){
//     Get.snackbar(
//       'Success',
//       'Data added successfully!',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.green,
//       colorText: Colors.white,
//     );
//   }

// Unsuccessfully
//   void _addDataUnSuccessfull(){
//     Get.snackbar(
//       'Error',
//       'Failed to add data',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.red,
//       colorText: Colors.white,
//     );
//   }


/*
  void _selectQuantity() {
    final DialogController controller = Get.find<DialogController>();
    Get.dialog(
      AlertDialog(
        title: const Text('Select Quantity'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Column(
              children: [
                RadioListTile<String>(
                  title: const Text('1 Liter'),
                  value: '1 Liter',
                  groupValue: controller.selectedQuantity.value,
                  onChanged: (value) {
                    controller.selectedQuantity.value = value!;},
                ),
                RadioListTile<String>(
                  title: const Text('2 Liters'),
                  value: '2 Liters',
                  groupValue: controller.selectedQuantity.value,
                  onChanged: (value) {
                    controller.selectedQuantity.value = value!;
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Three Liters'),
                  value: 'three Liters',
                  groupValue: controller.selectedQuantity.value,
                  onChanged: (value) {
                    controller.selectedQuantity.value = value!;
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Four Liters'),
                  value: 'four Liters',
                  groupValue: controller.selectedQuantity.value,
                  onChanged: (value) {
                    controller.selectedQuantity.value = value!;
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Five Liters'),
                  value: 'five Liters',
                  groupValue: controller.selectedQuantity.value,
                  onChanged: (value) {
                    controller.selectedQuantity.value = value!;},
                ),
              ],
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              print('Selected Quantity: ${controller.selectedQuantity.value}');
              Get.back(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _qtyAndDateSelected() {
    final DialogController controller = Get.put(DialogController());

    Get.dialog(
      AlertDialog(
        title: const Text('Select Date and Time'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: _selectQuantity,
              child: Obx(() => Text(
                'Select Quantity: ${controller.selectedQuantity.value}',
              )),
            ),
            const SizedBox(height: 16),
            Obx(() => ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: Get.context!,
                  initialDate: controller.selectedDate.value,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != controller.selectedDate.value) {
                  controller.selectedDate.value = picked;
                }
              },
              child: Text(
                  'Selected Date: ${DateFormat('yyyy-MM-dd').format(controller.selectedDate.value)}'),
            )),
            const SizedBox(height: 16),
            Obx(() => ElevatedButton(
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: Get.context!,
                  initialTime: controller.selectedTime.value,
                );
                if (picked != null && picked != controller.selectedTime.value) {
                  controller.selectedTime.value = picked;
                }
              },
              child: Text(
                  'Selected Time: ${controller.selectedTime.value.format(Get.context!)}'),
            )),
          ],
        ),actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Save the selected values here
            print('Selected Quantity: ${controller.selectedQuantity.value}');
            print('Selected Date: ${controller.selectedDate.value}');
            print('Selected Time: ${controller.selectedTime.value.format(Get.context!)}');
            Get.back(); // Close the dialog
          },
          child: const Text('OK'),
        ),
      ],
      ),
    );
  }
  */

  //  Select Quantity------
  /*
  void _showOptionDialog(BuildContext context, String id) {
    String? selectedValue;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Quantity'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildRadioOption(context,'અચ્છેર', selectedValue, (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  }),
                  _buildRadioOption(context,'સેર', selectedValue, (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  }),
                  _buildRadioOption(context,'પોણા સેર', selectedValue,
                          (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      }),
                  _buildRadioOption(context,'એક લીટર', selectedValue, (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  }),
                  _buildRadioOption(context,'બે  લીટર', selectedValue,
                          (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      }),
                  _buildRadioOption(context,'ત્રણ  લીટર', selectedValue,
                          (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      }),
                ],
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 8,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurpleAccent),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without passing the value
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 8,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurpleAccent),
              onPressed: () {
                if (selectedValue != null) {
                  Navigator.of(context)
                      .pop(selectedValue); // Pass the selected value
                  // }
                  Get.snackbar(
                    'Success',
                    '$selectedValue added successfully',
                    snackPosition: SnackPosition.BOTTOM,
                    titleText: const Text(
                      'Success',
                      style: TextStyle(color: Colors.white),
                    ),
                    messageText: Text(
                      '$selectedValue added successfully',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: const Color(0xFF9066ee),
                    borderRadius: 30,
                    animationDuration: const Duration(milliseconds: 1500),
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    ).then((value) {
      // Handle the selected option
      if (value != null) {
        setState(() {
          print('Id No: $id');
          print('Select Quantity: $value');
          // Integrate switch-case logic here
          double quantity;
          switch (value) {
            case 'અચ્છેર':
              quantity = 0.25;
              break;
            case 'સેર':
              quantity = 0.50;
              break;
            case 'પોણા સેર':
              quantity = 0.75;
              break;
            case 'એક લીટર':
              quantity = 1;
              break;
            case 'બે  લીટર':
              quantity = 2;
              break;
            case 'ત્રણ  લીટર':
              quantity = 3;
              break;
            default:
              quantity = 0;
              break;
          }
          print('Quantity: $quantity');
          addQuantity(
            idno: id,
            qt: quantity.toString(),
          );
        });
      }
    });
  }

  Widget _buildRadioOption(BuildContext context, String option,
      String? selectedValue, Function(String) onSelect) {
    return RadioListTile<String>(
      title: Text(option,
      // style: const TextStyle(
      //     fontWeight: FontWeight.w400,
      //     fontFamily: "Noto Sans Gujarati"
      // ),
    ),
      value: option,
      groupValue: selectedValue,
      onChanged: (value) {
        onSelect(value!);
      },
    );
  }

  */
}
