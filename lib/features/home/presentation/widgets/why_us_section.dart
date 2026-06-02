import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';

class FeatureData {
  final IconData icon;
  final String title;
  final String description;

  FeatureData({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class WhyUsSection extends StatelessWidget {
  const WhyUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final paddingHorizontal = ResponsiveLayout.valueFor(
      context: context,
      mobile: 24.0,
      tablet: 48.0,
      desktop: 72.0,
    );

    final List<FeatureData> features = [
      FeatureData(
        icon: Icons.restaurant_menu,
        title: 'Authentic South Indian Taste',
        description: 'Enjoy crispy dosas, stone-ground fluffy idlis, and slow-roasted masala spices toasted to ancestral specifications. No generic curries here.',
      ),
      FeatureData(
        icon: Icons.history_edu,
        title: 'Traditional Recipes',
        description: 'Our culinary roots are deep. We honor generational recipes directly from Tamil Nadu and Kerala to ensure rich, authentic culinary integrity.',
      ),
      FeatureData(
        icon: Icons.grass,
        title: 'Fresh Native Ingredients',
        description: 'Fresh curry leaves, pure hand-scraped coconut milk, high-grade organic grains, and spices imported directly from selected fields in India.',
      ),
      FeatureData(
        icon: Icons.family_restroom,
        title: 'Comfortable Family Atmosphere',
        description: 'Warm, cozy seating arrangements and traditional hospitality designed to accommodate families, tourists, and student groups alike.',
      ),
      FeatureData(
        icon: Icons.eco,
        title: 'Vegetarian-Friendly Menu',
        description: 'A massive spectrum of fully plant-based, gluten-free, and vegan-friendly culinary masterpieces cooked in separated, dedicated utensils.',
      ),
      FeatureData(
        icon: Icons.location_on,
        title: 'Convenient Nagoya Location',
        description: 'Located in central Nagoya, Aichi, making us highly accessible for local expats, Japanese gourmands, working professionals, and tourists.',
      ),
    ];

    final columns = ResponsiveLayout.valueFor(
      context: context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );

    return Container(
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 96),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section Header
              Text(
                'WHY CHOOSE US',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  letterSpacing: 4.0,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Why Guests Love MARUDHU',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: ResponsiveLayout.isMobile(context) ? 32 : 46,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: 60,
                height: 3,
                color: AppColors.secondary,
              ),
              const SizedBox(height: 64),

              // Grid of Features
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: features.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 32,
                  mainAxisSpacing: 32,
                  childAspectRatio: ResponsiveLayout.valueFor(
                    context: context,
                    mobile: 1.8,
                    tablet: 1.6,
                    desktop: 1.45,
                  ),
                ),
                itemBuilder: (context, index) {
                  return _FeatureCard(feature: features[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final FeatureData feature;

  const _FeatureCard({required this.feature});

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -6, 0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? AppColors.secondary : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppColors.black.withOpacity(0.08)
                  : AppColors.black.withOpacity(0.02),
              blurRadius: _isHovered ? 20 : 10,
              offset: _isHovered ? const Offset(0, 8) : const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Badge
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isHovered
                    ? AppColors.primary
                    : AppColors.lightBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                widget.feature.icon,
                color: _isHovered ? AppColors.secondary : AppColors.accent,
                size: 24,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              widget.feature.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),

            // Description
            Expanded(
              child: Text(
                widget.feature.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.55,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
