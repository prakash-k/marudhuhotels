import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/drawer.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/menu_section.dart';
import '../widgets/why_us_section.dart';
import '../widgets/reviews_section.dart';
import '../widgets/gallery_section.dart';
import '../widgets/location_section.dart';
import '../widgets/reservation_section.dart';
import '../widgets/reservation_modal.dart';
import '../widgets/footer_section.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  // Global Keys representing scroll anchor coordinates
  final List<GlobalKey> _sectionKeys = List.generate(7, (index) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    // Dismiss mobile drawer if open
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    final key = _sectionKeys[index];
    final targetContext = key.currentContext;

    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _showBookingModal() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return const ReservationModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: isDesktop
          ? null
          : CustomDrawer(
              onNavItemTap: _scrollToSection,
              onReserveTap: _showBookingModal,
            ),
      body: Stack(
        children: [
          // Single Scrollable Sheet compiling all restaurant section blocks
          SelectionArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Index 0: Hero banner
                  HeroSection(
                    key: _sectionKeys[0],
                    scrollOffset: _scrollOffset,
                    onReserveTap: _showBookingModal,
                    onExploreTap: () => _scrollToSection(2),
                  ),

                  // Index 1: About story
                  AboutSection(key: _sectionKeys[1]),

                  // Index 2: Signature menu
                  MenuSection(key: _sectionKeys[2]),

                  // Index 3: Why choose us features
                  WhyUsSection(key: _sectionKeys[3]),

                  // Index 4: Testimonials list
                  ReviewsSection(key: _sectionKeys[4]),

                  // Index 5: Culinary gallery grid
                  GallerySection(key: _sectionKeys[5]),

                  // Index 6: Visit location maps details
                  LocationSection(key: _sectionKeys[6]),

                  // Booking CTA Banner
                  ReservationSection(onReserveTap: _showBookingModal),

                  // Footer links
                  FooterSection(onNavItemTap: _scrollToSection),
                ],
              ),
            ),
          ),

          // Sticky Top Desktop Navigation Bar or Mobile Hamburger Trigger
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: isDesktop
                ? CustomNavigationBar(
                    scrollOffset: _scrollOffset,
                    onNavItemTap: _scrollToSection,
                    onReserveTap: _showBookingModal,
                  )
                : _buildMobileHeader(),
          ),
        ],
      ),
      
      // Floating reservation activator FAB (sticky booking prompt)
      floatingActionButton: FloatingActionButton(
        onPressed: _showBookingModal,
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.primary,
        tooltip: 'Reserve a Table',
        elevation: 6,
        child: const Icon(Icons.calendar_month, size: 24),
      ),
    );
  }

  Widget _buildMobileHeader() {
    final isScrolled = _scrollOffset > 50;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isScrolled ? AppColors.primary : Colors.transparent,
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                )
              ]
            : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Hamburger menu button
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: AppColors.white, size: 28),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),

          // Center branding text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'MARUDHU',
                style: TextStyle(
                  fontFamily: 'Playfair Display',
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              ),
              Text(
                'SOUTH INDIAN RESTAURANT',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 7,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),

          // Blank placeholder to balance layout
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
