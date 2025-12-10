import 'package:chapter_chat_ai/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final bool isLink;
  final VoidCallback? onTap;

  const CustomText({
    super.key,
    required this.text,
    this.style,
    this.isLink = false,
    this.onTap,
  });

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Center(
      child:
          (widget.isLink)
              ? GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  widget.text,
                  style:
                      widget.style ??
                      TextStyle(color: themeProvider.colors.primary),
                  textAlign: TextAlign.right,
                ),
              )
              : (Text(widget.text, style: widget.style)),
    );
  }
}
