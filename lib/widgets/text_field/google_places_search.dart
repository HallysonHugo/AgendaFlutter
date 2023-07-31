// import 'package:flutter/material.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';

// class GooglePlacesTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final void Function(Prediction)? onSuggestionSelected;
//   final void Function(Prediction)? getPlaceDetailWithLatLng;
//   final Widget Function(BuildContext, int, Prediction) itemBuilder;
//   final Widget? prefix;
//   final Widget? suffixIcon;
//   final Widget? label;

//   const GooglePlacesTextField({super.key, required this.controller, this.onSuggestionSelected, 
//     this.getPlaceDetailWithLatLng, required this.itemBuilder, this.prefix, this.suffixIcon, this.label});

//   @override
//   Widget build(BuildContext context) {
//     return GooglePlaceAutoCompleteTextField(
//       textEditingController: controller, 
//       googleAPIKey: 'AIzaSyAEn5_CToVmCL6yEdr5XJNH59yq2wMUI0A',
//       countries: const ['br'],
//       debounceTime: 800,
//       isLatLngRequired: true,
//       getPlaceDetailWithLatLng: getPlaceDetailWithLatLng,
//       itemClick: onSuggestionSelected,
//       itemBuilder: itemBuilder,
//       inputDecoration: InputDecoration(
//         suffixIcon: suffixIcon,
//         prefixIcon: prefix,
//         label: label,
//         border: const OutlineInputBorder(),
//       ),
//     );
//   }
// }