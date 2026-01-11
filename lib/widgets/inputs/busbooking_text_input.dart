import 'package:flutter/material.dart';

/// Bus Booking text input field widget.
class BusbookingTextInput extends StatefulWidget {
  /// The label displayed above the input field.
  final String label;

  /// The placeholder text displayed when the field is empty.
  final String placeholder;

  /// The controller for managing the text input.
  final TextEditingController? controller;

  /// Whether the input field is for password entry.
  final bool isPassword;

  /// The callback function when the text changes.
  final ValueChanged<String>? onChanged;

  /// Constructor for BusbookingTextInput.
  const BusbookingTextInput({
    required this.label,
    required this.placeholder,
    this.controller,
    this.isPassword = false,
    this.onChanged,
    super.key,
  });

  @override
  State<BusbookingTextInput> createState() => _BusbookingTextInputState();
}

class _BusbookingTextInputState extends State<BusbookingTextInput> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            widget.label,
            style: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF757575),
              height: 1.0,
              letterSpacing: 0,
            ),
          ),
        ),
        // Input Field
        Container(
          height: 54,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD1D1D1)),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  obscureText: _obscureText,
                  onChanged: widget.onChanged,
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                    hintStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF242E49).withOpacity(0.5),
                      height: 1.3125,
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF242E49),
                    height: 1.3125,
                  ),
                ),
              ),
              // Show/Hide Password Icon (only for password fields)
              if (widget.isPassword) ...[
                Container(
                  width: 1,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  color: const Color(0xFFD9D9D9),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF575757),
                      size: 24,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
