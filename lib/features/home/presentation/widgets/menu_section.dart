import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_layout.dart';
import '../providers/menu_provider.dart';

class DishItem {
  final String id;
  final String name;
  final String description;
  final String price;
  final String category;
  final String imageUrl;
  final bool isLocalAsset;
  final bool isVeg;
  final String spiceLevel; // 'Mild', 'Medium', 'Hot'

  DishItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    this.isLocalAsset = false,
    required this.isVeg,
    required this.spiceLevel,
  });
}

class MenuSection extends ConsumerWidget {
  const MenuSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(selectedMenuCategoryProvider);
    final paddingHorizontal = ResponsiveLayout.valueFor(
      context: context,
      mobile: 24.0,
      tablet: 48.0,
      desktop: 72.0,
    );

    // List of Premium Signature Dishes
    final List<DishItem> signatureDishes = [
      DishItem(
        id: '1',
        name: 'Crispy Masala Dosa',
        description: 'Golden paper-thin rice crepe roasted to perfection, filled with a spiced savory potato mash. Served with sambar and traditional chutneys.',
        price: '¥1,250',
        category: 'Dosa',
        imageUrl: 'assets/images/media__1780406392045.jpg',
        isLocalAsset: true,
        isVeg: true,
        spiceLevel: 'Mild',
      ),
      DishItem(
        id: '2',
        name: 'Royal South Indian Thali / Meals',
        description: 'An ultimate traditional banquet on a silver platter featuring specialty rices, sambar, rasam, two seasonal curries, appalam, yogurt, and sweet payasam.',
        price: '¥1,980',
        category: 'Meals',
        imageUrl: 'https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?w=800&auto=format&fit=crop&q=80',
        isVeg: true,
        spiceLevel: 'Medium',
      ),
      DishItem(
        id: '3',
        name: 'Fluffy Idli & Medu Vada',
        description: 'Steam-cooked, cloud-like fermented rice cakes paired with a crispy, savory black lentil doughnut. Accompanied by sambar and fresh coconut chutney.',
        price: '¥950',
        category: 'Dosa', // Snacks/Dosa
        imageUrl: 'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=800&auto=format&fit=crop&q=80',
        isVeg: true,
        spiceLevel: 'Mild',
      ),
      DishItem(
        id: '4',
        name: 'Marudhu Biryani Special',
        description: 'Fragrant Seeraga Samba rice slow-cooked under steam (Dum style) with house-roasted spices, fresh herbs, and juicy tender meat. Rich in heritage.',
        price: '¥1,650',
        category: 'Meals',
        imageUrl: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800&auto=format&fit=crop&q=80',
        isVeg: false,
        spiceLevel: 'Hot',
      ),
      DishItem(
        id: '5',
        name: 'Heritage Chettinad Curry',
        description: 'A fiery, deeply roasted spice curry cooked in classical Chettinad stone grinders, flavored with star anise, fennel seeds, and fresh curry leaves.',
        price: '¥1,480',
        category: 'Curries',
        imageUrl: 'assets/images/poori.jpg',
        isVeg: false,
        spiceLevel: 'Hot',
      ),
      DishItem(
        id: '6',
        name: 'Traditional Filter Coffee & Lassi',
        description: 'Authentic chicory-blended milk coffee frothed at height in brass tumblers, or refreshing yogurt Lassi flavored with fresh Alphonso mango pulp.',
        price: '¥550',
        category: 'Drinks',
        imageUrl: 'assets/images/filter_coffee.png',
        isLocalAsset: true,
        isVeg: true,
        spiceLevel: 'Mild',
      ),
      DishItem(
        id: '7',
        name: 'Alcoholic Kingfisher Beer',
        description: 'A crisp and refreshing lager with a mild hop bitterness, perfect for pairing  with our spicy South Indian dishes. Brewed with quality ingredients for a smooth finish.',
        price: '¥550',
        category: 'Drinks',
        imageUrl: 'assets/images/alcohol.jpg',
        isLocalAsset: true,
        isVeg: true,
        spiceLevel: 'Mild',
      ),
    ];

    // Filtering logic
    final filteredDishes = activeFilter == 'All'
        ? signatureDishes
        : signatureDishes.where((dish) => dish.category == activeFilter).toList();

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
                'SIGNATURE DISHES',
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
                'Our Masterpieces',
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
              const SizedBox(height: 24),
              // Dietary Badges
              Wrap(
                spacing: 16,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  _buildDietaryBadge('Vegetarian', Colors.green),
                  _buildDietaryBadge('Halal', Colors.teal),
                  _buildDietaryBadge('Hindu Options', AppColors.secondary),
                ],
              ),
              const SizedBox(height: 48),

              // Filter Tabs
              _buildFilterTabs(ref, activeFilter),
              const SizedBox(height: 56),

              // Menu Grid
              _buildMenuGrid(context, filteredDishes),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTabs(WidgetRef ref, String activeFilter) {
    final categories = ['All', 'Dosa', 'Meals', 'Curries', 'Drinks'];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: categories.map((category) {
        final isActive = category == activeFilter;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              ref.read(selectedMenuCategoryProvider.notifier).state = category;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isActive ? AppColors.primary : AppColors.border,
                  width: 1,
                ),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: isActive ? AppColors.white : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDietaryBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: color, size: 14),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context, List<DishItem> dishes) {
    final columns = ResponsiveLayout.valueFor(
      context: context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );

    if (dishes.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 64),
        child: Text(
          'No dishes found in this category. Stay tuned!',
          style: TextStyle(fontFamily: 'Inter', fontSize: 16),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dishes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 32,
        mainAxisSpacing: 32,
        childAspectRatio: 0.76, // Elegant vertical card proportion
      ),
      itemBuilder: (context, index) {
        return _MenuCard(dish: dishes[index]);
      },
    );
  }
}

class _MenuCard extends StatefulWidget {
  final DishItem dish;

  const _MenuCard({required this.dish});

  @override
  State<_MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<_MenuCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -12, 0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppColors.black.withOpacity(0.1)
                  : AppColors.black.withOpacity(0.03),
              blurRadius: _isHovered ? 25 : 12,
              offset: _isHovered ? const Offset(0, 16) : const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image container with hover zoom
              Expanded(
                flex: 12,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 400),
                        scale: _isHovered ? 1.08 : 1.0,
                        curve: Curves.easeOut,
                        child: widget.dish.isLocalAsset
                            ? Image.asset(
                                widget.dish.imageUrl,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: widget.dish.imageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: AppColors.lightBackground,
                                  child: const Center(
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
                                      ),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: AppColors.lightBackground,
                                  child: const Icon(Icons.error_outline, color: AppColors.textLight),
                                ),
                              ),
                      ),
                    ),

                    // Food Badges (Veg, Hot etc)
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            // Veg symbol
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: widget.dish.isVeg ? Colors.green : Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.dish.category.toUpperCase(),
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 9,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Price Tag
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.secondary.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          widget.dish.price,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Description Details
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.dish.name,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.dish.description,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 13,
                              height: 1.5,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      
                      // Spice Indicators
                      Row(
                        children: [
                          const Icon(Icons.bolt, color: AppColors.accent, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            'Spice: ${widget.dish.spiceLevel}',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: widget.dish.spiceLevel == 'Hot'
                                  ? AppColors.success
                                  : AppColors.textSecondary,
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
      ),
    );
  }
}
