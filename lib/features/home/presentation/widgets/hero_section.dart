import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';

class HeroSection extends StatelessWidget {
  final double scrollOffset;
  final VoidCallback onReserveTap;
  final VoidCallback onExploreTap;

  const HeroSection({
    super.key,
    required this.scrollOffset,
    required this.onReserveTap,
    required this.onExploreTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    
    // Parallax scrolling calculation for the background image
    final parallaxOffset = scrollOffset * 0.45;

    return Container(
      height: height,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: AppColors.primary,
      ),
      child: Stack(
        children: [
          // Background Image with Parallax
          Positioned(
            top: -parallaxOffset,
            left: 0,
            right: 0,
            height: height * 1.3, // Make image taller to support scrolling down
            child: Image.asset(
              'assets/images/dosa_banana_leaf.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

          // Deep Dark Charcoal Gradient Overlays (luxury branding and readability)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.primary, // Dark at bottom to merge with next section
                    AppColors.primary.withOpacity(0.85),
                    AppColors.primary.withOpacity(0.4),
                    AppColors.primary.withOpacity(0.6), // Darker at top for navigation bar legibility
                  ],
                  stops: const [0.0, 0.25, 0.6, 1.0],
                ),
              ),
            ),
          ),

          // Core Text Content & Actions
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveLayout.valueFor(
                    context: context,
                    mobile: 24.0,
                    tablet: 48.0,
                    desktop: 72.0,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subtitle badge
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'TRADITIONAL SOUTH INDIAN CUISINE',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveLayout.valueFor(
                              context: context,
                              mobile: 10.0,
                              tablet: 12.0,
                              desktop: 14.0,
                            ),
                            letterSpacing: 3.0,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideX(begin: -0.2, end: 0.0, curve: Curves.easeOutBack),

                    const SizedBox(height: 24),

                    // Main Headline
                    Text(
                      'Authentic South Indian\nFlavors in Nagoya',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: AppColors.white,
                        fontSize: ResponsiveLayout.valueFor(
                          context: context,
                          mobile: 36.0,
                          tablet: 52.0,
                          desktop: 68.0,
                        ),
                        height: 1.15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 800.ms)
                    .slideY(begin: 0.1, end: 0.0),

                    const SizedBox(height: 24),

                    // Description Subheadline
                    SizedBox(
                      width: 600,
                      child: Text(
                        'Experience traditional South Indian cuisine crafted with passion, heritage, and authentic recipes directly in the heart of Aichi.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.white.withOpacity(0.85),
                          fontSize: ResponsiveLayout.valueFor(
                            context: context,
                            mobile: 15.0,
                            tablet: 17.0,
                            desktop: 19.0,
                          ),
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 800.ms)
                    .slideY(begin: 0.1, end: 0.0),

                    const SizedBox(height: 40),

                    // CTA Buttons Row
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: onReserveTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            foregroundColor: AppColors.primary,
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveLayout.valueFor(
                                context: context,
                                mobile: 24.0,
                                tablet: 28.0,
                                desktop: 32.0,
                              ),
                              vertical: 18.0,
                            ),
                          ),
                          child: const Text('Reserve a Table'),
                        )
                        .animate(onPlay: (controller) => controller.repeat(reverse: true))
                        .scale(
                          delay: 1.seconds,
                          duration: 2.seconds,
                          begin: const Offset(1.0, 1.0),
                          end: const Offset(1.03, 1.03),
                          curve: Curves.easeInOut,
                        ),
                        const SizedBox(width: 20),
                        OutlinedButton(
                          onPressed: onExploreTap,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.white,
                            side: const BorderSide(color: AppColors.white, width: 1.5),
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveLayout.valueFor(
                                context: context,
                                mobile: 24.0,
                                tablet: 28.0,
                                desktop: 32.0,
                              ),
                              vertical: 18.0,
                            ),
                          ),
                          child: const Text('Explore Menu'),
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 800.ms)
                    .slideY(begin: 0.2, end: 0.0),

                    const SizedBox(height: 56),

                    // Features checklist row
                    ResponsiveLayout(
                      mobile: _MobileFeatures(),
                      desktop: _DesktopFeatures(),
                    )
                    .animate()
                    .fadeIn(delay: 800.ms, duration: 1000.ms),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileFeatures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _FeatureBadge(text: 'Authentic Recipes'),
            const SizedBox(width: 20),
            _FeatureBadge(text: 'Family Friendly'),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _FeatureBadge(text: 'Vegetarian Options'),
            const SizedBox(width: 20),
            _FeatureBadge(text: 'Fresh Ingredients'),
          ],
        ),
      ],
    );
  }
}

class _DesktopFeatures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FeatureBadge(text: 'Authentic Recipes'),
        const SizedBox(width: 32),
        _FeatureBadge(text: 'Family Friendly'),
        const SizedBox(width: 32),
        _FeatureBadge(text: 'Vegetarian Options'),
        const SizedBox(width: 32),
        _FeatureBadge(text: 'Fresh Ingredients'),
      ],
    );
  }
}

class _FeatureBadge extends StatelessWidget {
  final String text;

  const _FeatureBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.check_circle_outline,
          color: AppColors.secondary,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Inter',
            color: AppColors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
