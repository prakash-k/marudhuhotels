import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateProvider representing selected food category filter
final selectedMenuCategoryProvider = StateProvider<String>((ref) {
  return 'All';
});
