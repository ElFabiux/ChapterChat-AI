import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_provider.dart';
import '../../widgets/common/theme_toggle_button.dart';

class ProfileContent extends StatelessWidget {
  final AppThemeColors colors;
  final ThemeProvider themeProvider;

  const ProfileContent({
    super.key,
    required this.colors,
    required this.themeProvider,
  });

  @override
  Widget build(BuildContext context) {
    // Usar SliverToBoxAdapter en lugar de SliverFillRemaining
    // para evitar overflow cuando aparece el teclado
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 32),

            // Avatar del usuario
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple,
              ),
              child: const Center(
                child: Text(
                  'F',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Mi Perfil',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),

            const SizedBox(height: 48),

            // Sección de configuración
            _buildSettingsSection(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Toggle de tema
          _buildSettingsItem(
            icon: themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            title: 'Tema de la aplicación',
            subtitle: themeProvider.isDarkMode ? 'Modo oscuro' : 'Modo claro',
            trailing: ThemeToggleButton(themeProvider: themeProvider),
          ),

          Divider(color: colors.border, height: 1),

          // Otros ajustes (placeholders)
          _buildSettingsItem(
            icon: Icons.notifications_outlined,
            title: 'Notificaciones',
            subtitle: 'Activadas',
            trailing: Icon(Icons.chevron_right, color: colors.iconDefault),
          ),

          Divider(color: colors.border, height: 1),

          _buildSettingsItem(
            icon: Icons.info_outline,
            title: 'Acerca de',
            subtitle: 'Versión 1.0.0',
            trailing: Icon(Icons.chevron_right, color: colors.iconDefault),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: colors.iconDefault, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: colors.textSecondary),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
