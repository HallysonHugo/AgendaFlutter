import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomTypeAhead<T> extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final Widget? label;
  final Widget? prefix;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Widget Function(BuildContext, T) itemBuilder;
  final Future<List<T>> Function(String) suggestionsCallback;
  final void Function(T) onSuggestionSelected;
  const CustomTypeAhead({super.key, this.margin, this.label, this.prefix, this.suffixIcon, 
    this.controller, required this.itemBuilder, required this.suggestionsCallback, required this.onSuggestionSelected});

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      suggestionsCallback: suggestionsCallback, 
      itemBuilder: itemBuilder, 
      onSuggestionSelected: onSuggestionSelected,
      hideOnEmpty: true,
      hideOnError: false,
      getImmediateSuggestions: false,
      hideSuggestionsOnKeyboardHide: false,
      autoFlipDirection: true,
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefix,
          label: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}