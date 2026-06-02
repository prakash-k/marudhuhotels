import 'package:flutter/material.dart';
import 'dart:async';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewData {
  final String name;
  final String role;
  final String content;
  final double rating;
  final String avatarText;

  ReviewData({
    required this.name,
    required this.role,
    required this.content,
    required this.rating,
    required this.avatarText,
  });
}

class ReviewsSection extends StatefulWidget {
  const ReviewsSection({super.key});

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<ReviewData> _reviews = [
    ReviewData(
      name: 'Priya Sharma',
      role: 'Indian Expat, Nagoya City',
      content: 'As a South Indian living in Japan, I have been searching for authentic food for years. MARUDHU’s Masala Dosa tasted exactly like home! The sambar is rich, rasam is fiery, and the coconut chutney is freshly made daily. Pure bliss!',
      rating: 5.0,
      avatarText: 'PS',
    ),
    ReviewData(
      name: 'Kenji Sato',
      role: 'Nagoya Food Enthusiast',
      content: 'I was curious about Dosa since I only knew standard naan and curry restaurants in Japan. MARUDHU completely blew me away! The crispy paper-thin crepe combined with spiced savory potato and fresh chutneys was sensational.',
      rating: 5.0,
      avatarText: 'KS',
    ),
    ReviewData(
      name: 'Aarav Patel',
      role: 'Software Architect, Toyota City',
      content: 'We drove from Toyota City specifically for the weekend South Indian Thali, and it was worth every kilometer. The authentic recipes, clay-pot curries, and warm hospitality represent true Indian family dining.',
      rating: 5.0,
      avatarText: 'AP',
    ),
    ReviewData(
      name: 'Sarah Jenkins',
      role: 'Culinary Blogger & Tourist',
      content: 'An absolute gem in Aichi! Exceptional vegetarian and vegan options. Super fresh, healthy ingredients cooked with extreme care. The frothy South Indian filter coffee poured at height is a mandatory table showpiece!',
      rating: 5.0,
      avatarText: 'SJ',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Setup auto-cycling carousel
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < _reviews.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paddingHorizontal = ResponsiveLayout.valueFor(
      context: context,
      mobile: 24.0,
      tablet: 48.0,
      desktop: 72.0,
    );

    return Container(
      color: AppColors.lightBackground,
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 96),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section Header
              Text(
                'WHAT OUR GUESTS SAY',
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
                'Reviews & Testimonials',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: ResponsiveLayout.isMobile(context) ? 32 : 46,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final url = Uri.parse('https://tabelog.com/en/aichi/A2301/A230105/23092438/');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '3.44',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < 3 ? Icons.star : (index == 3 ? Icons.star_half : Icons.star_border),
                          color: AppColors.secondary,
                          size: 20,
                        );
                      }),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '(100 Tabelog Reviews)',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: 60,
                height: 3,
                color: AppColors.secondary,
              ),
              const SizedBox(height: 64),

              // PageView Carousel with controls
              Stack(
                alignment: Alignment.center,
                children: [
                  // Sizable PageView Container
                  Container(
                    height: ResponsiveLayout.valueFor(
                      context: context,
                      mobile: 360.0,
                      tablet: 280.0,
                      desktop: 260.0,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _reviews.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return _buildReviewCard(_reviews[index]);
                      },
                    ),
                  ),

                  // Carousel Left Arrow (Desktop Only)
                  if (!ResponsiveLayout.isMobile(context))
                    Positioned(
                      left: 0,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: AppColors.accent, size: 22),
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),

                  // Carousel Right Arrow (Desktop Only)
                  if (!ResponsiveLayout.isMobile(context))
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: AppColors.accent, size: 22),
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 32),

              // Custom Indicator Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_reviews.length, (index) {
                  final isActive = index == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: isActive ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.secondary : AppColors.textLight.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard(ReviewData review) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Quoting symbol & star rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.format_quote,
                color: AppColors.secondary,
                size: 36,
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < review.rating ? Icons.star : Icons.star_border,
                    color: AppColors.secondary,
                    size: 16,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Review Body Text
          Expanded(
            child: Text(
              '"${review.content}"',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontStyle: FontStyle.italic,
                fontSize: 14,
                color: AppColors.textPrimary,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Reviewer Info Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // User Avatar circle
              CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 18,
                child: Text(
                  review.avatarText,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.name,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    review.role,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
