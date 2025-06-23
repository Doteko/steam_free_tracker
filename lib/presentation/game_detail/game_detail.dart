import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/game_description_widget.dart';
import './widgets/game_header_widget.dart';
import './widgets/game_reviews_widget.dart';
import './widgets/game_screenshots_widget.dart';
import './widgets/price_history_chart_widget.dart';
import './widgets/system_requirements_widget.dart';

class GameDetail extends StatefulWidget {
  const GameDetail({super.key});

  @override
  State<GameDetail> createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _fabAnimationController;
  bool _isWatchlisted = false;
  bool _isLoading = false;

  // Mock game data
  final Map<String, dynamic> gameData = {
    "id": 1,
    "title": "Cyberpunk 2077",
    "developer": "CD Projekt RED",
    "heroImage":
        "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800&h=400&fit=crop",
    "currentPrice": "\$0.00",
    "originalPrice": "\$59.99",
    "discountPercentage": 100,
    "isCurrentlyFree": true,
    "offerEndsAt": "2024-12-31T23:59:59Z",
    "steamUrl": "https://store.steampowered.com/app/1091500/Cyberpunk_2077/",
    "description":
        "Cyberpunk 2077 is an open-world, action-adventure story set in Night City, a megalopolis obsessed with power, glamour and body modification. You play as V, a mercenary outlaw going after a one-of-a-kind implant that is the key to immortality.",
    "fullDescription":
        "Cyberpunk 2077 is an open-world, action-adventure story set in Night City, a megalopolis obsessed with power, glamour and body modification. You play as V, a mercenary outlaw going after a one-of-a-kind implant that is the key to immortality. You can customize your character's cyberware, skillset and playstyle, and explore a vast city where the choices you make shape the story and the world around you. Become a cyberpunk, an urban mercenary equipped with cybernetic enhancements and build your legend on the streets of Night City.",
    "rating": 4.2,
    "totalReviews": 125000,
    "positiveReviews": 85,
    "screenshots": [
      "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=400&h=225&fit=crop",
      "https://images.unsplash.com/photo-1511512578047-dfb367046420?w=400&h=225&fit=crop",
      "https://images.unsplash.com/photo-1493711662062-fa541adb3fc8?w=400&h=225&fit=crop",
      "https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=400&h=225&fit=crop"
    ],
    "systemRequirements": {
      "minimum": {
        "os": "Windows 10 64-bit",
        "processor": "Intel Core i5-3570K or AMD FX-8310",
        "memory": "8 GB RAM",
        "graphics": "NVIDIA GeForce GTX 780 or AMD Radeon RX 470",
        "storage": "70 GB available space"
      },
      "recommended": {
        "os": "Windows 10 64-bit",
        "processor": "Intel Core i7-4790 or AMD Ryzen 3 3200G",
        "memory": "12 GB RAM",
        "graphics": "NVIDIA GeForce GTX 1060 or AMD Radeon R9 Fury",
        "storage": "70 GB available space"
      }
    },
    "priceHistory": [
      {"date": "2024-01-01", "price": 59.99},
      {"date": "2024-02-01", "price": 49.99},
      {"date": "2024-03-01", "price": 39.99},
      {"date": "2024-04-01", "price": 29.99},
      {"date": "2024-05-01", "price": 19.99},
      {"date": "2024-06-01", "price": 0.00}
    ],
    "recentReviews": [
      {
        "username": "GamerPro2024",
        "rating": 5,
        "review":
            "Amazing game! The graphics are stunning and the story is captivating.",
        "date": "2024-06-15",
        "helpful": 45
      },
      {
        "username": "CyberFan",
        "rating": 4,
        "review":
            "Great gameplay but had some bugs initially. Much better now after updates.",
        "date": "2024-06-10",
        "helpful": 32
      },
      {
        "username": "NightCityExplorer",
        "rating": 5,
        "review":
            "Best RPG I've played in years. The world building is incredible.",
        "date": "2024-06-08",
        "helpful": 28
      }
    ]
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _toggleWatchlist() {
    setState(() {
      _isWatchlisted = !_isWatchlisted;
    });
  }

  void _shareGame() {
    // Mock share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${gameData["title"]}...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openSteamPage() {
    // Mock opening Steam page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening Steam page...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handlePrimaryAction() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      if (gameData["isCurrentlyFree"] == true) {
        _openSteamPage();
      } else {
        _toggleWatchlist();
      }
    });
  }

  String _getPrimaryActionText() {
    if (gameData["isCurrentlyFree"] == true) {
      return 'Get Free Game';
    } else if (_isWatchlisted) {
      return 'Remove from Watchlist';
    } else {
      return 'Add to Watchlist';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 30.h,
            pinned: true,
            backgroundColor: AppTheme.lightTheme.primaryColor,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: CustomIconWidget(
                iconName: 'arrow_back',
                color: AppTheme.lightTheme.colorScheme.onPrimary,
                size: 24,
              ),
            ),
            actions: [
              IconButton(
                onPressed: _toggleWatchlist,
                icon: CustomIconWidget(
                  iconName: _isWatchlisted ? 'favorite' : 'favorite_border',
                  color: _isWatchlisted
                      ? AppTheme.lightTheme.colorScheme.error
                      : AppTheme.lightTheme.colorScheme.onPrimary,
                  size: 24,
                ),
              ),
              IconButton(
                onPressed: _shareGame,
                icon: CustomIconWidget(
                  iconName: 'share',
                  color: AppTheme.lightTheme.colorScheme.onPrimary,
                  size: 24,
                ),
              ),
              SizedBox(width: 2.w),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: GameHeaderWidget(
                gameData: gameData,
                onSteamPressed: _openSteamPage,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                GameScreenshotsWidget(
                  screenshots: (gameData["screenshots"] as List).cast<String>(),
                ),
                SizedBox(height: 3.h),
                GameDescriptionWidget(
                  description: gameData["description"] as String,
                  fullDescription: gameData["fullDescription"] as String,
                ),
                SizedBox(height: 3.h),
                SystemRequirementsWidget(
                  requirements:
                      gameData["systemRequirements"] as Map<String, dynamic>,
                ),
                SizedBox(height: 3.h),
                PriceHistoryChartWidget(
                  priceHistory: (gameData["priceHistory"] as List)
                      .cast<Map<String, dynamic>>(),
                ),
                SizedBox(height: 3.h),
                GameReviewsWidget(
                  rating: gameData["rating"] as double,
                  totalReviews: gameData["totalReviews"] as int,
                  positiveReviews: gameData["positiveReviews"] as int,
                  recentReviews: (gameData["recentReviews"] as List)
                      .cast<Map<String, dynamic>>(),
                ),
                SizedBox(height: 10.h), // Space for FAB
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabAnimationController,
        child: Container(
          width: 85.w,
          height: 6.h,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handlePrimaryAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: gameData["isCurrentlyFree"] == true
                  ? AppTheme.lightTheme.colorScheme.tertiary
                  : AppTheme.lightTheme.colorScheme.secondary,
              foregroundColor: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? SizedBox(
                    height: 2.h,
                    width: 2.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.lightTheme.colorScheme.onSecondary,
                      ),
                    ),
                  )
                : Text(
                    _getPrimaryActionText(),
                    style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
