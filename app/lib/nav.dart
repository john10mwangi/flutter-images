import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:app/providers/nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/gallery_view.dart' show GalleryView;
import 'screens/home_view.dart' show HomeView;
import 'screens/profile_view.dart' show ProfileView;

class NavView extends ConsumerStatefulWidget {
  const NavView({super.key});

  @override
  ConsumerState<NavView> createState() => _NavViewState();
}

class _NavViewState extends ConsumerState<NavView> {
  late NavProvider _navProvider;

  Widget page = HomeView();

  final _destinations = <AdaptiveScaffoldDestination>[
    const AdaptiveScaffoldDestination(title: "Home", icon: Icons.home_outlined),
    const AdaptiveScaffoldDestination(
      title: "Gallery",
      icon: Icons.browse_gallery_outlined,
    ),
    const AdaptiveScaffoldDestination(
      title: "Profile",
      icon: Icons.person_4_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    _navProvider = ref.watch(navProvider);
    switch (_navProvider.selectedIndex) {
      case 0:
        page = const HomeView();
        break;
      case 1:
        page = const GalleryView();
        break;
      case 2:
        page = const ProfileView();
        break;
      default:
        throw UnimplementedError("Page not yet implemented");
    }
    return AdaptiveNavigationScaffold(
      body: page,
      selectedIndex: _navProvider.selectedIndex,
      destinations: _destinations,
      onDestinationSelected: (value) => _navProvider.setSelectedIndex(value),
    );
  }
}
