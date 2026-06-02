import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final paddingHorizontal = ResponsiveLayout.valueFor(
      context: context,
      mobile: 24.0,
      tablet: 48.0,
      desktop: 72.0,
    );

    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 96),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: ResponsiveLayout(
            mobile: _buildVerticalLayout(context),
            desktop: _buildHorizontalLayout(context),
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Column: Story narrative
        Expanded(
          flex: 12,
          child: _buildTextContent(context),
        ),
        const Spacer(flex: 2),
        // Right Column: Gold-accented overlapping image montage
        Expanded(
          flex: 10,
          child: _buildImageMontage(context),
        ),
      ],
    );
  }

  Widget _buildVerticalLayout(BuildContext context) {
    return Column(
      children: [
        _buildTextContent(context),
        const SizedBox(height: 64),
        _buildImageMontage(context),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Luxury Accent Badge
        Text(
          'OUR STORY',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 13,
            letterSpacing: 4.0,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 12),
        
        // Beautiful Luxury Heading
        Text(
          'Heritage, Spice & Heart',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontSize: isMobile ? 32 : 46,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 24),
        
        // Custom divider line
        Container(
          width: 60,
          height: 3,
          color: AppColors.secondary,
        ),
        const SizedBox(height: 32),
        
        // Content Paragraph 1
        Text(
          'MARUDHU is Nagoya’s premier destination for genuine, uncompromising South Indian cuisine. Our journey is rooted in the rich culinary history of Tamil Nadu, Karnataka, Kerala, and Andhra Pradesh. We bring Nagoya the precise aroma of stone-ground batters, clay-pot curries, and spices toasted by hand in our kitchen.',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            height: 1.7,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 20),
        
        // Content Paragraph 2
        Text(
          'Beyond standard curry houses, we position MARUDHU as an authentic cultural dining experience. Our signature tent-like exterior gives way to a vibrant wooden interior beautifully decorated with colorful garlands. Whether you are an expat looking for the taste of home, or a guest seeking authentic ethnic dining, we welcome you to our family table.',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 15,
            height: 1.7,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 32),

        // Features checklist grid
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            _FeatureRow(icon: Icons.kitchen, title: 'Traditional Methods'),
            const SizedBox(width: 24),
            _FeatureRow(icon: Icons.grain, title: 'Genuine Spices'),
          ],
        ),
      ],
    );
  }

  Widget _buildImageMontage(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = ResponsiveLayout.valueFor(
      context: context,
      mobile: screenWidth * 0.85,
      tablet: 400.0,
      desktop: 380.0,
    );

    return Center(
      child: Container(
        width: imageWidth + 40,
        height: imageWidth * 1.25,
        child: Stack(
          children: [
            // Gold Accent Background Frame
            Positioned(
              right: 32,
              bottom: 24,
              left: 8,
              top: 48,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.secondary.withOpacity(0.5),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            // Saffron Solid Corner block
            Positioned(
              left: 0,
              top: 24,
              width: 60,
              height: 60,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
              ),
            ),

            // Foreground Main Image
            Positioned(
              left: 24,
              top: 48,
              right: 12,
              bottom: 32,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.12),
                      blurRadius: 20,
                      offset: const Offset(8, 12),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/parota.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Saffron/Gold overlay badge
            Positioned(
              right: 0,
              bottom: 12,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.secondary, size: 20),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '100% AUTHENTIC',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            letterSpacing: 1.5,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Nagoya\'s Best',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FeatureRow({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.lightBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.accent, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
