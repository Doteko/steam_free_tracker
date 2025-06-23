import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GameHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> gameData;
  final VoidCallback onSteamPressed;

  const GameHeaderWidget({
    super.key,
    required this.gameData,
    required this.onSteamPressed,
  });

  String _getTimeRemaining() {
    try {
      final endDate = DateTime.parse(gameData["offerEndsAt"] as String);
      final now = DateTime.now();
      final difference = endDate.difference(now);

      if (difference.isNegative) {
        return "Offer Expired";
      }

      final days = difference.inDays;
      final hours = difference.inHours % 24;
      final minutes = difference.inMinutes % 60;

      if (days > 0) {
        return "${days}d ${hours}h ${minutes}m";
      } else if (hours > 0) {
        return "${hours}h ${minutes}m";
      } else {
        return "${minutes}m";
      }
    } catch (e) {
      return "Limited Time";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Hero Image
        CustomImageWidget(
          imageUrl: gameData["heroImage"] as String,
          width: double.infinity,
          height: 30.h,
          fit: BoxFit.cover,
        ),

        // Gradient Overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 0.7),
              ],
            ),
          ),
        ),

        // Content Overlay
        Positioned(
          bottom: 2.h,
          left: 4.w,
          right: 4.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Game Title
              Text(
                gameData["title"] as String,
                style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 1),
                      blurRadius: 3,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 0.5.h),

              // Developer
              Text(
                gameData["developer"] as String,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 1),
                      blurRadius: 3,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 1.h),

              // Price and Discount Info
              Row(
                children: [
                  // Current Price
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: gameData["isCurrentlyFree"] == true
                          ? AppTheme.lightTheme.colorScheme.tertiary
                          : AppTheme.lightTheme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      gameData["currentPrice"] as String,
                      style: AppTheme.priceTextStyle(
                              isLight: true, fontSize: 14.sp)
                          .copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  if (gameData["discountPercentage"] != null &&
                      gameData["discountPercentage"] > 0) ...[
                    SizedBox(width: 2.w),

                    // Original Price (Strikethrough)
                    Text(
                      gameData["originalPrice"] as String,
                      style: AppTheme.priceTextStyle(
                              isLight: true, fontSize: 12.sp)
                          .copyWith(
                        color: Colors.white.withValues(alpha: 0.7),
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),

                    SizedBox(width: 2.w),

                    // Discount Percentage
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.3.h),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.error,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "-${gameData["discountPercentage"]}%",
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),

              if (gameData["isCurrentlyFree"] == true) ...[
                SizedBox(height: 1.h),

                // Countdown Timer
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.tertiary
                          .withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'access_time',
                        color: AppTheme.lightTheme.colorScheme.tertiary,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        "Ends in: ${_getTimeRemaining()}",
                        style: AppTheme.countdownTextStyle(
                                isLight: false, fontSize: 12.sp)
                            .copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              SizedBox(height: 1.h),

              // View on Steam Button
              TextButton.icon(
                onPressed: onSteamPressed,
                icon: CustomIconWidget(
                  iconName: 'open_in_new',
                  color: Colors.white,
                  size: 16,
                ),
                label: Text(
                  'View on Steam',
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black.withValues(alpha: 0.4),
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
