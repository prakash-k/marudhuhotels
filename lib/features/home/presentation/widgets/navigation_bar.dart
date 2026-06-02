import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CustomNavigationBar extends StatelessWidget {
  final double scrollOffset;
  final Function(int) onNavItemTap;
  final VoidCallback onReserveTap;

  const CustomNavigationBar({
    super.key,
    required this.scrollOffset,
    required this.onNavItemTap,
    required this.onReserveTap,
  });

  @override
  Widget build(BuildContext context) {
    // Dynamic styling based on scroll offset
    final isScrolled = scrollOffset > 50;
    final backgroundColor = isScrolled ? AppColors.primary : Colors.transparent;
    final shadowColor = isScrolled ? AppColors.black.withOpacity(0.15) : Colors.transparent;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 80,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Brand Logo text
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => onNavItemTap(0),
              child: Row(
                children: [
                  // Saffron accent bar
                  Container(
                    width: 4,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MARUDHU',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.white,
                          fontSize: 22,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'SOUTH INDIAN RESTAURANT',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.secondary,
                          fontSize: 9,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Menu items & CTA
          Row(
            children: [
              _NavBarLink(text: 'Home', onTap: () => onNavItemTap(0)),
              const SizedBox(width: 24),
              _NavBarLink(text: 'Our Story', onTap: () => onNavItemTap(1)),
              const SizedBox(width: 24),
              _NavBarLink(text: 'Menu', onTap: () => onNavItemTap(2)),
              const SizedBox(width: 24),
              _NavBarLink(text: 'Why Us', onTap: () => onNavItemTap(3)),
              const SizedBox(width: 24),
              _NavBarLink(text: 'Reviews', onTap: () => onNavItemTap(4)),
              const SizedBox(width: 24),
              _NavBarLink(text: 'Gallery', onTap: () => onNavItemTap(5)),
              const SizedBox(width: 24),
              _NavBarLink(text: 'Visit Us', onTap: () => onNavItemTap(6)),
              const SizedBox(width: 36),

              // Booking CTA Button
              ElevatedButton(
                onPressed: onReserveTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Reserve a Table'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavBarLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _NavBarLink({required this.text, required this.onTap});

  @override
  State<_NavBarLink> createState() => _NavBarLinkState();
}

class _NavBarLinkState extends State<_NavBarLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                color: _isHovered ? AppColors.secondary : AppColors.white.withOpacity(0.9),
                fontWeight: FontWeight.w500,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 4),
            // Custom sliding underline on hover
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: _isHovered ? 24 : 0,
              color: AppColors.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
