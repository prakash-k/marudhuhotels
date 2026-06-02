import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  Future<void> _launchMaps() async {
    // Open Google Maps centered on Nagoya South Indian Cuisine
    final Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=MARUDHU+South+Indian+Restaurant+Nagoya+Aichi+Japan');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchPhone() async {
    final Uri url = Uri.parse('tel:+8152XXXXXXX');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
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
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section Header
              Text(
                'VISIT US',
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
                'Find Us in Nagoya',
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

              // Two Column Split View
              ResponsiveLayout(
                mobile: _buildVerticalLayout(context),
                desktop: _buildHorizontalLayout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Business Details & Schedule
        Expanded(
          flex: 10,
          child: _buildDetailsColumn(context),
        ),
        const Spacer(flex: 2),
        // Right Column: Elegant Interactive mock map
        Expanded(
          flex: 12,
          child: _buildInteractiveMockMap(context),
        ),
      ],
    );
  }

  Widget _buildVerticalLayout(BuildContext context) {
    return Column(
      children: [
        _buildDetailsColumn(context),
        const SizedBox(height: 64),
        _buildInteractiveMockMap(context),
      ],
    );
  }

  Widget _buildDetailsColumn(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Contact details card
        Text(
          'MARUDHU South Indian Restaurant',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 16),

        _buildContactRow(
          icon: Icons.location_on_outlined,
          title: 'Address',
          value: '1-Chome, Sakae, Naka Ward, Nagoya, Aichi 460-0008, Japan',
          onTap: _launchMaps,
        ),
        const SizedBox(height: 20),

        _buildContactRow(
          icon: Icons.phone_outlined,
          title: 'Phone Number',
          value: '052-990-4577',
          onTap: _launchPhone,
        ),
        const SizedBox(height: 20),

        _buildContactRow(
          icon: Icons.access_time,
          title: 'Opening Hours',
          value: 'Mon - Sun: 11:00 AM - 10:00 PM\n(Last Order: 9:30 PM)',
        ),
        const SizedBox(height: 32),

        // Accessible Train badge
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.directions_subway_filled, color: AppColors.secondary, size: 24),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SUBWAY ACCESS',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      letterSpacing: 1.0,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '3-minute walk from Sakae Station (Exit 5)\n5-minute walk from Fushimi Station',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.accent, size: 20),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  letterSpacing: 1.0,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: 4),
              onTap != null
                  ? MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: onTap,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accent,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    )
                  : Text(
                      value,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveMockMap(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.06),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // Custom Road grids (built using borders/containers)
            Positioned(
              left: 0, right: 0, top: 80, height: 16,
              child: Container(color: Colors.white),
            ),
            Positioned(
              left: 0, right: 0, bottom: 90, height: 24,
              child: Container(color: Colors.white),
            ),
            Positioned(
              left: 120, width: 20, top: 0, bottom: 0,
              child: Container(color: Colors.white),
            ),
            Positioned(
              right: 150, width: 24, top: 0, bottom: 0,
              child: Container(color: Colors.white),
            ),

            // Diagonal park block (representing Nagoya greenspace)
            Positioned(
              left: 170, top: 120, width: 180, height: 80,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD5E8D4),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Positioned(
              left: 200, top: 150,
              child: Row(
                children: const [
                  Icon(Icons.park, color: Colors.green, size: 14),
                  SizedBox(width: 4),
                  Text('Shirakawa Park', style: TextStyle(fontFamily: 'Inter', fontSize: 10, color: Colors.green)),
                ],
              ),
            ),

            // Pin marker pulsing ring
            Positioned(
              left: 270,
              top: 70,
              child: _MockMapPin(onTap: _launchMaps),
            ),

            // Sakae Station Label
            Positioned(
              right: 120,
              top: 30,
              child: Row(
                children: const [
                  Icon(Icons.directions_subway_filled, color: Colors.blue, size: 12),
                  SizedBox(width: 4),
                  Text('Sakae Stn', style: TextStyle(fontFamily: 'Inter', fontSize: 9, fontWeight: FontWeight.bold, color: Colors.black54)),
                ],
              ),
            ),

            // Glassmorphic navigation overlay prompt
            Positioned(
              left: 16,
              bottom: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Nagoya Central Branch',
                          style: TextStyle(fontFamily: 'Inter', color: AppColors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Sakae Naka-ku, Nagoya',
                          style: TextStyle(fontFamily: 'Inter', color: AppColors.secondary, fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    ElevatedButton(
                      onPressed: _launchMaps,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.directions, size: 14),
                          SizedBox(width: 6),
                          Text('Get Directions', style: TextStyle(fontSize: 12)),
                        ],
                      ),
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

class _MockMapPin extends StatefulWidget {
  final VoidCallback onTap;

  const _MockMapPin({required this.onTap});

  @override
  State<_MockMapPin> createState() => _MockMapPinState();
}

class _MockMapPinState extends State<_MockMapPin> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Pulse ring
            ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 2.2).animate(
                CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
              ),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.6, end: 0.0).animate(
                  CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
                ),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            // Inner solid pin
            Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
            ),
            
            // Text Label popup
            Positioned(
              bottom: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.accent, width: 1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: const Text(
                  'MARUDHU',
                  style: TextStyle(fontFamily: 'Inter', fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
