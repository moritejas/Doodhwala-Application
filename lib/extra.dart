import 'package:get/get.dart';
import 'package:flutter/material.dart';



class DialogController extends GetxController {
  var selectedOption = (-1).obs; // Default option (-1 means no selection)
  var customOption = "".obs; // For custom option

  void setSelectedOption(int option) {
    selectedOption.value = option;
  }

  void setCustomOption(String value) {
    customOption.value = value;
  }

  bool validateSelection() {
    return selectedOption.value != -1 || customOption.value.isNotEmpty;
  }
}


void showOptionDialog() {
  final DialogController controller = Get.put(DialogController());

  Get.dialog(
    AlertDialog(
      title: const Text('Select Quantity'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => Column(
            children: [
              RadioListTile<int>(
                title: const Text('1'),
                value: 1,
                groupValue: controller.selectedOption.value,
                onChanged: (value) {
                  controller.setSelectedOption(value!);
                },
              ),
              RadioListTile<int>(
                title: const Text('2'),
                value: 2,
                groupValue: controller.selectedOption.value,
                onChanged: (value) {
                  controller.setSelectedOption(value!);
                },
              ),
              RadioListTile<int>(
                title: const Text('3'),
                value: 3,
                groupValue: controller.selectedOption.value,
                onChanged: (value) {
                  controller.setSelectedOption(value!);
                },
              ),
              RadioListTile<int>(
                title: const Text('4'),
                value: 4,
                groupValue: controller.selectedOption.value,
                onChanged: (value) {
                  controller.setSelectedOption(value!);
                },
              ),
              RadioListTile<int>(
                title: TextField(
                  decoration: const InputDecoration(hintText: 'Custom'),
                  onChanged: (value) {
                    controller.setCustomOption(value);
                    controller.setSelectedOption(0); // Custom option
                  },
                ),
                value: 0,
                groupValue: controller.selectedOption.value,
                onChanged: (value) {
                  controller.setSelectedOption(value!);
                },
              ),
            ],
          )),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (controller.validateSelection()) {
              Get.back();
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


// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GetX Dialog Example'),
        ),
        body: Center(
          child: ElevatedButton.icon(
            onPressed: () {
              showOptionDialog();
            },
            icon: const Icon(Icons.add),
            label: const Text('Select Quantity'),
          ),
        ),
      ),
    );
  }
}

// void _selectQuantity() {
//   final DialogController controller = Get.put(DialogController());
//   Get.dialog(
//     AlertDialog(
//       title: const Text('Select Quantity (Liter)'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Obx(() => Column(
//             children: [
//               RadioListTile<String>(
//                 title: const Text('0.25'),
//                 value: '0.25',
//                 groupValue: controller.selectedQuantity.value,
//                 onChanged: (value) {
//                   controller.selectedQuantity.value = value!;
//                   controller.customQuantityController.clear(); // Clear custom input
//                 },
//               ),
//               RadioListTile<String>(
//                 title: const Text('0.50'),
//                 value: '0.50',
//                 groupValue: controller.selectedQuantity.value,
//                 onChanged: (value) {
//                   controller.selectedQuantity.value = value!;
//                   controller.customQuantityController.clear(); // Clear custom input
//                 },
//               ),
//               RadioListTile<String>(
//                 title: const Text('0.75'),
//                 value: '0.75',
//                 groupValue: controller.selectedQuantity.value,
//                 onChanged: (value) {
//                   controller.selectedQuantity.value = value!;
//                   controller.customQuantityController.clear(); // Clear custom input
//                 },
//               ),
//               RadioListTile<String>(
//                 title: const Text('1'),
//                 value: '1',
//                 groupValue: controller.selectedQuantity.value,
//                 onChanged: (value) {
//                   controller.selectedQuantity.value = value!;
//                   controller.customQuantityController.clear(); // Clear custom input
//                 },
//               ),
//               RadioListTile<String>(
//                 title: const Text('2'),
//                 value: '2',
//                 groupValue: controller.selectedQuantity.value,
//                 onChanged: (value) {
//                   controller.selectedQuantity.value = value!;
//                   controller.customQuantityController.clear(); // Clear custom input
//                 },
//               ),
//               RadioListTile<String>(
//                 title: const Text('Custom'),
//                 value: 'custom',
//                 groupValue: controller.selectedQuantity.value,
//                 onChanged: (value) {
//                   controller.selectedQuantity.value = value!;
//                 },
//               ),
//               if (controller.selectedQuantity.value == 'custom')
//                 TextField(
//                   controller: controller.customQuantityController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     hintText: 'Enter custom quantity',
//                   ),
//                 ),
//             ],
//           )),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Get.back(); // Close the dialog
//           },
//           child: const Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () {
//             if (controller.validateSelection()) {
//               String quantitySelectedValue = controller.getSelectedQuantity();
//               print("Final Selected Value: $quantitySelectedValue");
//               Get.back(); // Close the dialog
//             } else {
//               Get.snackbar(
//                 'Error',
//                 'Please select a Quantity or enter a custom Quantity',
//                 snackPosition: SnackPosition.BOTTOM,
//               );
//             }
//           },
//           child: const Text('OK'),
//         ),
//       ],
//     ),
//   );
// }