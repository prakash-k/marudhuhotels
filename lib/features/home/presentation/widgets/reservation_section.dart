import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';

class ReservationSection extends StatelessWidget {
  final VoidCallback onReserveTap;

  const ReservationSection({
    super.key,
    required this.onReserveTap,
  });

  Future<void> _callRestaurant() async {
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

    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 80),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gold Ring decoration
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.secondary, width: 1.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.restaurant,
                  color: AppColors.secondary,
                  size: 28,
                ),
              ),
              const SizedBox(height: 32),

              // Title
              Text(
                'Reserve Your Table Today',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColors.white,
                  fontSize: isMobile ? 28 : 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Description text
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  'Join us for an authentic, memorable South Indian dining experience in Nagoya. Whether it is a business lunch, family celebration, or romantic dinner, we have a table waiting for you.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.white.withOpacity(0.8),
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Action CTAs row
              Wrap(
                spacing: 20,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: onReserveTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Book Table Online'),
                  ),
                  OutlinedButton(
                    onPressed: _callRestaurant,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.white,
                      side: const BorderSide(color: AppColors.white, width: 1.5),
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.phone, size: 16),
                        SizedBox(width: 8),
                        Text('Call Restaurant'),
                      ],
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
}
