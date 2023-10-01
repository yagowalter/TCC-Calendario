import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Widget suffixIcon;
  final Widget preffixIcon;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.suffixIcon,
      required this.preffixIcon,
      t});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        focusNode: _focusNode,
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xffa6a6a6), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xff202C39)),
          ),
        fillColor: Color(0xfffcfcfc),  
          filled: true,
          hintText: widget.hintText,
          labelStyle: TextStyle(
            color: Color(0xffa6a6a6),
          ),
          suffixIcon: IconTheme(
            data: IconThemeData(color: _isFocused ? Color(0xff202C39) : Color(0xffa6a6a6)),
            child: widget.suffixIcon,
          ),
          prefixIcon: IconTheme(
            data: IconThemeData(color: _isFocused? Color(0xff202C39) : Color(0xffa6a6a6)
            ),
            child: widget.preffixIcon,
          ),
        ),
      ),
    );
  }
}
