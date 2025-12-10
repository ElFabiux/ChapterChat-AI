import 'package:flutter/material.dart';
import 'package:chapter_chat_ai/core/theme/theme_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDatepicker extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  const CustomDatepicker({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
  });

  @override
  State<CustomDatepicker> createState() => _CustomDatepickerState();
}

class _CustomDatepickerState extends State<CustomDatepicker> {
  Future<void> _selectDate() async {
    final now = DateTime.now();
    final theme = context.read<ThemeProvider>();

    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 5),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: theme.colors.primary,

              surface: theme.colors.surface,
              onSurface: theme.colors.textPrimary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: theme.colors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      widget.controller.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colors.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: theme.colors.shadow.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: _selectDate,
          child: AbsorbPointer(
            child: TextFormField(
              controller: widget.controller,
              style: TextStyle(color: theme.colors.textPrimary),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  widget.icon,
                  color: theme.colors.textSecondary,
                ),
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: theme.colors.textPrimary.withOpacity(0.4),
                ),
                filled: true,
                fillColor: theme.colors.background,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: theme.colors.surface,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: theme.colors.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
