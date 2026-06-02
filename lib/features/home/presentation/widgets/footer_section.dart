import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  final Function(int) onNavItemTap;

  const FooterSection({
    super.key,
    required this.onNavItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final paddingHorizontal = ResponsiveLayout.valueFor(
      context: context,
      mobile: 24.0,
      tablet: 48.0,
      desktop: 72.0,
    );

    return Container(
      color: AppColors.primary,
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 80),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Four-Column Desktop Footer
              ResponsiveLayout(
                mobile: _buildVerticalFooter(context),
                desktop: _buildHorizontalFooter(context),
              ),

              const SizedBox(height: 56),
              const Divider(color: Colors.white10, height: 1),
              const SizedBox(height: 32),

              // Bottom copyright row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '© ${DateTime.now().year} MARUDHU South Indian Restaurant. All Rights Reserved.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.textLight,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalFooter(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 3, child: _buildBrandCol(context)),
        const Spacer(flex: 1),
        Expanded(flex: 2, child: _buildLinksCol(context)),
        const Spacer(flex: 1),
        Expanded(flex: 3, child: _buildHoursCol(context)),
        const Spacer(flex: 1),
        Expanded(flex: 2, child: _buildSocialCol(context)),
      ],
    );
  }

  Widget _buildVerticalFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBrandCol(context),
        const SizedBox(height: 48),
        _buildLinksCol(context),
        const SizedBox(height: 48),
        _buildHoursCol(context),
        const SizedBox(height: 48),
        _buildSocialCol(context),
      ],
    );
  }

  Widget _buildBrandCol(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 4,
              height: 28,
              color: AppColors.secondary,
            ),
            const SizedBox(width: 10),
            Text(
              'MARUDHU',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Delivering traditional South Indian recipes, genuine frothed coffees, and warm hospitality to Nagoya, Japan since 2024.',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            fontFamily: 'Inter',
            color: AppColors.textLight,
            fontSize: 13,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildLinksCol(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const Text(
          'QUICK LINKS',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 11,
            letterSpacing: 1.5,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 16),
        _buildFooterLink('Home', () => onNavItemTap(0)),
        _buildFooterLink('Our Story', () => onNavItemTap(1)),
        _buildFooterLink('Menu Specials', () => onNavItemTap(2)),
        _buildFooterLink('Why Us', () => onNavItemTap(3)),
        _buildFooterLink('Testimonials', () => onNavItemTap(4)),
        _buildFooterLink('Gallery Portfolio', () => onNavItemTap(5)),
        _buildFooterLink('Visit Location', () => onNavItemTap(6)),
      ],
    );
  }

  Widget _buildFooterLink(String text, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: AppColors.textLight,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHoursCol(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const Text(
          'CONTACT & HOURS',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 11,
            letterSpacing: 1.5,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '1-Chome, Sakae, Naka Ward, Nagoya,\nAichi 460-0008, Japan',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            fontFamily: 'Inter',
            color: AppColors.textLight,
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Daily: 11:00 AM - 10:00 PM\nTel: +81 (0)52-XXX-XXXX',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            fontFamily: 'Inter',
            color: AppColors.textLight,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialCol(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const Text(
          'FOLLOW US',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 11,
            letterSpacing: 1.5,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            _buildSocialIcon(Icons.facebook, () {}),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.camera_alt, () async {
              final url = Uri.parse('https://www.instagram.com/marudhu_osaka/');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            }),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.alternate_email, () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: AppColors.secondary,
          size: 18,
        ),
      ),
    );
  }
}
