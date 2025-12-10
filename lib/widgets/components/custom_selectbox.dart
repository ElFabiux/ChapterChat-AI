import 'package:chapter_chat_ai/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSelectbox extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final ValueChanged<String?> onChanged;
  final String? value;
  final IconData? icon;

  const CustomSelectbox({
    super.key,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.value,
    this.icon,
  });

  @override
  State<CustomSelectbox> createState() => _CustomSelectboxState();
}

class _CustomSelectboxState extends State<CustomSelectbox> {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colors.background,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: theme.colors.shadow.withOpacity(0.15),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: DropdownButtonFormField<String>(
          value: widget.value,
          icon: const SizedBox.shrink(),
          hint: Text(
            widget.hintText,
            style: TextStyle(color: theme.colors.textPrimary.withOpacity(0.4)),
          ),
          decoration: InputDecoration(
            prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
            prefixIconColor: theme.colors.textSecondary,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: theme.colors.surface, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: theme.colors.primary, width: 1),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: theme.colors.textPrimary.withOpacity(
                0.4,
              ), // <- ajusta el número
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          items:
              widget.items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
