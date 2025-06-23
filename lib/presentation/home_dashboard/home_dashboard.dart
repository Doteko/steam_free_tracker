import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Steam Free Tracker',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        foregroundColor: AppTheme.lightTheme.appBarTheme.foregroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/user-profile-settings'),
            icon: CustomIconWidget(
              iconName: 'person',
              color: AppTheme.lightTheme.appBarTheme.foregroundColor!,
              size: 24,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeTab(),
          _buildWatchlistTab(),
          _buildDiscoverTab(),
          _buildProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.backgroundColor,
        selectedItemColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.unselectedItemColor,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'home',
              color: _currentIndex == 0
                  ? AppTheme
                      .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                  : AppTheme
                      .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'favorite',
              color: _currentIndex == 1
                  ? AppTheme
                      .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                  : AppTheme
                      .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
              size: 24,
            ),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'explore',
              color: _currentIndex == 2
                  ? AppTheme
                      .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                  : AppTheme
                      .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
              size: 24,
            ),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'person',
              color: _currentIndex == 3
                  ? AppTheme
                      .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                  : AppTheme
                      .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
              size: 24,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'videogame_asset',
            color: AppTheme.lightTheme.colorScheme.secondary,
            size: 64,
          ),
          SizedBox(height: 2.h),
          Text(
            'Welcome to Steam Free Tracker',
            style: AppTheme.lightTheme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          Text(
            'Track free games and price drops',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWatchlistTab() {
    return Center(
      child: Text(
        'Watchlist Tab',
        style: AppTheme.lightTheme.textTheme.headlineSmall,
      ),
    );
  }

  Widget _buildDiscoverTab() {
    return Center(
      child: Text(
        'Discover Tab',
        style: AppTheme.lightTheme.textTheme.headlineSmall,
      ),
    );
  }

  Widget _buildProfileTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/user-profile-settings'),
            child: Text('Go to Settings'),
          ),
        ],
      ),
    );
  }
}
