import 'package:flutter/material.dart';
import '../presentation/home_dashboard/home_dashboard.dart';
import '../presentation/game_detail/game_detail.dart';
import '../presentation/user_profile_settings/user_profile_settings.dart';

class AppRoutes {
  static const String initial = '/';
  static const String homeDashboard = '/home-dashboard';
  static const String gameDetail = '/game-detail';
  static const String userProfileSettings = '/user-profile-settings';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const HomeDashboard(),
    homeDashboard: (context) => const HomeDashboard(),
    gameDetail: (context) => const GameDetail(),
    userProfileSettings: (context) => const UserProfileSettings(),
  };
}
