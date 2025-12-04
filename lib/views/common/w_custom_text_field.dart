import 'package:connex_chat/app/core.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
  });

  final String label;
  final TextEditingController controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '이 칸은 비워둘 수 없습니다.';
          }
          if (widget.label == '이메일을 입력해주세요') {
            if (!value.contains('@')) {
              return '@를 포함시켜 주세요.';
            } else if (value.contains(' ')) {
              return '공백은 포함 할 수 없습니다.';
            }
          }
          if (widget.label == '비밀번호를 입력해주세요') {
            if (value.length < 4) {
              return '비밀번호는 4자리 이상이여야 합니다';
            }
          }
          return null;
        },
        // key: formKey,
        controller: widget.controller,
        keyboardType: widget.label == '이메일을 입력해주세요'
            ? TextInputType.emailAddress
            : TextInputType.text,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
