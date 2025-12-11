import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ShopContent extends StatelessWidget {
  final AppThemeColors colors;

  const ShopContent({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.storefront_outlined, size: 72, color: colors.primary),
            const SizedBox(height: 24),
            Text(
              'Tienda',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Próximamente podrás explorar y comprar nuevos libros',
                style: TextStyle(fontSize: 16, color: colors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
