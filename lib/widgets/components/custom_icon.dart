import 'package:flutter/widgets.dart';

class CustomIcon extends StatefulWidget {
  final IconData icon;
  final double? size;
  final Color? color;

  const CustomIcon({super.key, required this.icon, this.size, this.color});

  @override
  State<CustomIcon> createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> {
  @override
  Widget build(BuildContext context) {
    return Icon(widget.icon, size: widget.size, color: widget.color);
  }
}
