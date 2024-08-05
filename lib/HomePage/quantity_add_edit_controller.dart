import 'package:flutter/material.dart';
import 'package:get/get.dart';

//  class DialogControllers extends GetxController {
//   RxString selectedQuantity = '0.50'.obs;
//   TextEditingController customQuantityController = TextEditingController();
//   Rx<DateTime> selectedDate = DateTime.now().obs;
//   Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
// }

class DialogController extends GetxController {
 var selectedQuantity = '0.50'.obs;
 var customQuantityController = TextEditingController();
 Rx<DateTime> selectedDate = DateTime.now().obs;
 Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
 bool validateSelection() {
  return selectedQuantity.value.isNotEmpty &&
      (selectedQuantity.value != 'custom' ||
          (selectedQuantity.value == 'custom' &&
              customQuantityController.text.isNotEmpty));
 }

 String getSelectedQuantity() {
  if (selectedQuantity.value == 'custom' &&
      customQuantityController.text.isNotEmpty) {
   return customQuantityController.text;
  }
  return selectedQuantity.value;
 }

 @override
 void onClose() {
  customQuantityController.dispose();
  super.onClose();
 }
}



// void _selectQuantity() {
//   final DialogController controller = Get.find<DialogController>();
//   Get.dialog(
//     AlertDialog(
//       title: const Text('Select Quantity'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Obx(() => Column(
//                 children: [
//                   RadioListTile<String>(
//                     title: const Text('One Liter'),
//                     value: 'one Liter',
//                     groupValue: controller.selectedQuantity.value,
//                     onChanged: (value) {
//                       controller.selectedQuantity.value = value!;
//                       controller.customQuantityController.clear(); // Clear custom input
//                     },
//                   ),
//                   RadioListTile<String>(
//                     title: const Text('Two Liters'),
//                     value: 'two Liters',
//                     groupValue: controller.selectedQuantity.value,
//                     onChanged: (value) {
//                       controller.selectedQuantity.value = value!;
//                       controller.customQuantityController.clear(); // Clear custom input
//                     },
//                   ),
//                   RadioListTile<String>(
//                     title: const Text('Three Liters'),
//                     value: 'three Liters',
//                     groupValue: controller.selectedQuantity.value,
//                     onChanged: (value) {
//                       controller.selectedQuantity.value = value!;
//                       controller.customQuantityController.clear(); // Clear custom input
//                     },
//                   ),
//                   RadioListTile<String>(
//                     title: const Text('Four Liters'),
//                     value: 'four Liters',
//                     groupValue: controller.selectedQuantity.value,
//                     onChanged: (value) {
//                       controller.selectedQuantity.value = value!;
//                       controller.customQuantityController.clear(); // Clear custom input},
//                   ),
//                   RadioListTile<String>(
//                     title: const Text('Five Liters'),
//                     value: 'five Liters',
//                     groupValue: controller.selectedQuantity.value,
//                     onChanged: (value) {
//                       controller.selectedQuantity.value = value!;
//                       controller.customQuantityController.clear(); // Clear custom input
//                     },
//                   ),
//                   RadioListTile<String>(
//                     title: const Text('Custom'),
//                     value: 'custom',
//                     groupValue: controller.selectedQuantity.value,
//                     onChanged: (value) {
//                       controller.selectedQuantity.value = value!;
//                     },
//                   ),
//                   if (controller.selectedQuantity.value == 'custom')
//                     TextField(
//                       controller: controller.customQuantityController,
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(
//                         hintText: 'Enter custom quantity',
//                       ),
//                     ),
//                 ],
//               )),
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
//             if (controller.selectedQuantity.value == 'custom' &&
//                 controller.customQuantityController.text.isNotEmpty) {
//               print(
//                   'Selected Quantity: ${controller.customQuantityController.text}');
//             } else {
//               print('Selected Quantity: ${controller.selectedQuantity.value}');
//             }
//             Get.back(); // Close the dialog
//           },
//           child: const Text('OK'),
//         ),
//       ],
//     ),
//   );
// }
//
// void _qtyAndDateSelected() {
//   final DialogController controller = Get.put(DialogController());
//
//   Get.dialog(
//     AlertDialog(
//       title: const Text('Select Date and Time'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextButton(
//             onPressed: _selectQuantity,
//             child: Obx(() => Text(
//                   controller.selectedQuantity.value == 'custom' &&
//                           controller.customQuantityController.text.isNotEmpty
//                       ? 'Select Quantity: ${controller.customQuantityController.text}'
//                       : 'Select Quantity: ${controller.selectedQuantity.value}',)),
//           ),
//           const SizedBox(height: 16),
//           Obx(() => ElevatedButton(
//                 onPressed: () async {
//                   final DateTime? picked = await showDatePicker(
//                     context: Get.context!,
//                     initialDate: controller.selectedDate.value,
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2101),
//                   );
//                   if (picked != null && picked != controller.selectedDate.value) {
//                     controller.selectedDate.value = picked;
//                   }
//                 },
//                 child: Text(
//                     'Selected Date: ${DateFormat('yyyy-MM-dd').format(controller.selectedDate.value)}'),
//               )),
//           const SizedBox(height: 16),
//           Obx(() => ElevatedButton(
//                 onPressed: () async {
//                   final TimeOfDay? picked = await showTimePicker(
//                     context: Get.context!,
//                     initialTime: controller.selectedTime.value,
//                   );
//                   if (picked != null && picked != controller.selectedTime.value) {
//                     controller.selectedTime.value = picked;
//                   }
//                 },
//                 child: Text(
//                     'Selected Time: ${controller.selectedTime.value.format(Get.context!)}'),
//               )),
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
//             // Save the selected values here
//             if (controller.selectedQuantity.value == 'custom' &&
//                 controller.customQuantityController.text.isNotEmpty) {
//               print(
//                   'Selected Quantity: ${controller.customQuantityController.text}');
//             } else {
//               print('Selected Quantity: ${controller.selectedQuantity.value}');
//             }
//             print('Selected Date: ${controller.selectedDate.value}');
//             print('Selected Time: ${controller.selectedTime.value.format(Get.context!)}');
//             Get.back(); // Close the dialog
//           },
//           child: const Text('OK'),
//         ),
//       ],
//     ),
//   );
// }
//
//
//
//     // */