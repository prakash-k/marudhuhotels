import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onNavItemTap;
  final VoidCallback onReserveTap;

  const CustomDrawer({
    super.key,
    required this.onNavItemTap,
    required this.onReserveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header with Brand Logo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 40,
                    color: AppColors.secondary,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MARUDHU',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        'SOUTH INDIAN RESTAURANT',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.secondary,
                          fontSize: 8,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white10),

            // Navigation Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _DrawerItem(icon: Icons.home_outlined, text: 'Home', onTap: () => onNavItemTap(0)),
                  _DrawerItem(icon: Icons.history_edu, text: 'Our Story', onTap: () => onNavItemTap(1)),
                  _DrawerItem(icon: Icons.restaurant_menu, text: 'Menu', onTap: () => onNavItemTap(2)),
                  _DrawerItem(icon: Icons.thumb_up_alt_outlined, text: 'Why Us', onTap: () => onNavItemTap(3)),
                  _DrawerItem(icon: Icons.reviews_outlined, text: 'Reviews', onTap: () => onNavItemTap(4)),
                  _DrawerItem(icon: Icons.photo_library_outlined, text: 'Gallery', onTap: () => onNavItemTap(5)),
                  _DrawerItem(icon: Icons.place_outlined, text: 'Visit Us', onTap: () => onNavItemTap(6)),
                ],
              ),
            ),

            // Booking CTA
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onReserveTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: const Text('Reserve a Table'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.secondary.withOpacity(0.8), size: 20),
      title: Text(
        text,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      hoverColor: Colors.white.withOpacity(0.05),
    );
  }
}
