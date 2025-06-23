import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FeaturedGameCardWidget extends StatelessWidget {
  final Map<String, dynamic> game;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const FeaturedGameCardWidget({
    super.key,
    required this.game,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: 65.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.w),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3.w),
          child: Stack(
            children: [
              // Game cover image
              CustomImageWidget(
                imageUrl: game["imageUrl"] as String,
                width: 65.w,
                height: 35.h,
                fit: BoxFit.cover,
              ),

              // Gradient overlay
              Container(
                width: 65.w,
                height: 35.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),

              // FREE badge
              Positioned(
                top: 2.h,
                right: 3.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: AppTheme.getSuccessColor(true),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Text(
                    'FREE',
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),

              // Limited time badge
              if (game["isLimitedTime"] == true)
                Positioned(
                  top: 2.h,
                  left: 3.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: AppTheme.getWarningColor(true),
                      borderRadius: BorderRadius.circular(1.5.w),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: 'access_time',
                          color: Colors.white,
                          size: 12,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          'LIMITED',
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 8.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Game info at bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Game title
                      Text(
                        game["title"] as String,
                        style:
                            AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 1.h),

                      // Price info
                      Row(
                        children: [
                          Text(
                            game["originalPrice"] as String,
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: Colors.white.withValues(alpha: 0.7),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            game["currentPrice"] as String,
                            style: AppTheme.priceTextStyle(
                                    isLight: true, fontSize: 16.sp)
                                .copyWith(
                              color: AppTheme.getSuccessColor(true),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),

                      // Time left and rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (game["timeLeft"] != null)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 0.5.h),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(1.w),
                              ),
                              child: Text(
                                game["timeLeft"] as String,
                                style: AppTheme.countdownTextStyle(
                                        isLight: true, fontSize: 10.sp)
                                    .copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          Row(
                            children: [
                              CustomIconWidget(
                                iconName: 'star',
                                color: AppTheme.getWarningColor(true),
                                size: 16,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                game["rating"].toString(),
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
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
