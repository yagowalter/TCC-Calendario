import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String title;
  final String initialValue;
  final void Function(String) onSaved;
  final bool isNumeric;
  final bool isPhoneNumber;

  const Details(
      {super.key,
      required this.title,
      required this.initialValue,
      required this.onSaved,
      required this.isNumeric,
      required this.isPhoneNumber});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.only(left: 15, bottom: 15),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            widget.title,
            style: TextStyle(color: Color(0xffa6a6a6)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_isEditing)
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    controller: _controller,
                    keyboardType: widget.isNumeric
                        ? TextInputType.number
                        : (widget.isPhoneNumber
                            ? TextInputType.phone
                            : TextInputType.text),
                  ),
                )
              else
                Text(widget.initialValue),
              IconButton(
                icon: Icon(
                  _isEditing ? Icons.check : Icons.edit,
                  color: Colors.grey[600],
                ),
                onPressed: () {
                  if (_isEditing) {
                    widget.onSaved(_controller.text);
                  }
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
