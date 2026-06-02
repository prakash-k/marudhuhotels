import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';

class GalleryImage {
  final String path;
  final bool isLocal;
  final String caption;
  final String category;

  GalleryImage({
    required this.path,
    required this.isLocal,
    required this.caption,
    required this.category,
  });
}

class GallerySection extends StatefulWidget {
  const GallerySection({super.key});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  final List<GalleryImage> _galleryImages = [
    GalleryImage(
      path: 'assets/images/dosa_banana_leaf.jpg',
      isLocal: true,
      caption: 'Our Signature Crispy Masala Dosa Platter',
      category: 'Signature Dishes',
    ),
    GalleryImage(
      path: 'assets/images/thali_eating.jpg',
      isLocal: true,
      caption: 'The Traditional Hand-Eating Thali Experience',
      category: 'Family Dining',
    ),
    GalleryImage(
      path: 'assets/images/media__1780406392054.jpg',
      isLocal: true,
      caption: 'Our Authentic South Indian Restaurant Interior',
      category: 'Restaurant Interior',
    ),
    GalleryImage(
      path: 'https://images.unsplash.com/photo-1541658016709-82535e94bc69?w=800&auto=format&fit=crop&q=80',
      isLocal: false,
      caption: 'Frothy Chicory-Blended Traditional Filter Coffee',
      category: 'Beverages',
    ),
    GalleryImage(
      path: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800&auto=format&fit=crop&q=80',
      isLocal: false,
      caption: 'Seeraga Samba Dum Biryani with Roasted Herbs',
      category: 'Specialties',
    ),
    GalleryImage(
      path: 'https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?w=800&auto=format&fit=crop&q=80',
      isLocal: false,
      caption: 'Unforgettable Family Moments at MARUDHU',
      category: 'Family Dining',
    ),
  ];

  void _openLightbox(int initialIndex) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.92),
      builder: (context) {
        return _LightboxDialog(
          images: _galleryImages,
          initialIndex: initialIndex,
        );
      },
    );
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
                'DINING EXPERIENCE GALLERY',
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
                'A Taste of South India',
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
              const SizedBox(height: 56),

              // Responsive Asymmetrical Layout Grid
              _buildResponsiveGalleryGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveGalleryGrid(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final columns = isMobile ? 1 : (ResponsiveLayout.isTablet(context) ? 2 : 3);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _galleryImages.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.25, // Wide photographic standard
      ),
      itemBuilder: (context, index) {
        return _GalleryTile(
          image: _galleryImages[index],
          onTap: () => _openLightbox(index),
        );
      },
    );
  }
}

class _GalleryTile extends StatefulWidget {
  final GalleryImage image;
  final VoidCallback onTap;

  const _GalleryTile({
    required this.image,
    required this.onTap,
  });

  @override
  State<_GalleryTile> createState() => _GalleryTileState();
}

class _GalleryTileState extends State<_GalleryTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Background Image with scale transition
                Positioned.fill(
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: _isHovered ? 1.06 : 1.0,
                    child: widget.image.isLocal
                        ? Image.asset(
                            widget.image.path,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: widget.image.path,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: AppColors.lightBackground,
                            ),
                          ),
                  ),
                ),

                // Black transparent shade on hover
                Positioned.fill(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    color: _isHovered
                        ? Colors.black.withOpacity(0.5)
                        : Colors.black.withOpacity(0.15),
                  ),
                ),

                // Hover Text details
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: _isHovered ? 1.0 : 0.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            widget.image.category.toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.image.caption,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LightboxDialog extends StatefulWidget {
  final List<GalleryImage> images;
  final int initialIndex;

  const _LightboxDialog({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_LightboxDialog> createState() => _LightboxDialogState();
}

class _LightboxDialogState extends State<_LightboxDialog> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // PageView display
            Container(
              constraints: const BoxConstraints(maxWidth: 900),
              child: AspectRatio(
                aspectRatio: 1.4,
                child: PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final img = widget.images[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: img.isLocal
                        ? Image.asset(img.path, fit: BoxFit.contain)
                        : CachedNetworkImage(imageUrl: img.path, fit: BoxFit.contain),
                  );
                },
              ),
              ),
            ),

            // Left Swipe navigation (Desktop only)
            if (!ResponsiveLayout.isMobile(context))
              Positioned(
                left: 24,
                child: CircleAvatar(
                  backgroundColor: AppColors.white.withOpacity(0.2),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white),
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ),

            // Right Swipe navigation (Desktop only)
            if (!ResponsiveLayout.isMobile(context))
              Positioned(
                right: 24,
                child: CircleAvatar(
                  backgroundColor: AppColors.white.withOpacity(0.2),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: AppColors.white),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ),

            // Close button (Top-Right)
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                backgroundColor: AppColors.white.withOpacity(0.2),
                child: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),

            // Caption overlay (Bottom)
            Positioned(
              bottom: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  widget.images[_currentIndex].caption,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
