import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String label, hint;
  final TextEditingController? controller;
  final FormFieldValidator<String?>? validator;
  final suffixIcon;


  const MyTextFormField(
      {Key? key,
      required this.label,
      required this.hint,
      this.controller,
      this.validator,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(children: [
        Container(
          height: 95,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: TextFormField(
            // cursorColor: primaryColor,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            // keyboardType: keyboard,
            validator: validator,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              // prefixIconColor: primaryColor,

              hintText: hint,
              filled: true,
              fillColor: Color(0xFF111111),
              hintStyle: TextStyle(color: Color(0xFF565656)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 21.0, vertical: 20),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide: BorderSide(color: Color(0xFF464646), width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.0),
                borderSide:
                    const BorderSide(color: Color(0xFF464646), width: 2),
              ),
              errorBorder: const OutlineInputBorder(
                  // borderSide: BorderSide(color: primaryColor),
                  ),
              focusedErrorBorder: OutlineInputBorder(
                // borderSide: const BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),

        ),
        Positioned(
          top: 2,
          left: 20,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(width: 2, color: const Color(0xFF464646)),
              color: const Color(0xFF111111),
            ),
            child: Text(
              label,
              style: TextStyle(color: Color(0xFFBABABA)),
            ),
          ),
        ),
      ]),
    );
  }
}
