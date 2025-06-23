import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecommendedGameCardWidget extends StatelessWidget {
  final Map<String, dynamic> game;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const RecommendedGameCardWidget({
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
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.cardColor,
          borderRadius: BorderRadius.circular(2.w),
          border: Border.all(
            color: AppTheme.lightTheme.colorScheme.secondary
                .withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.shadowColor,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Row(
            children: [
              // Game image
              ClipRRect(
                borderRadius: BorderRadius.circular(2.w),
                child: CustomImageWidget(
                  imageUrl: game["imageUrl"] as String,
                  width: 20.w,
                  height: 12.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 3.w),

              // Game info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and FREE badge
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            game["title"] as String,
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: AppTheme.getSuccessColor(true),
                            borderRadius: BorderRadius.circular(1.w),
                          ),
                          child: Text(
                            'FREE',
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 8.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),

                    // Recommendation reason
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.secondary
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(1.w),
                      ),
                      child: Text(
                        game["reason"] as String,
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 9.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),

                    // Genre and rating
                    Row(
                      children: [
                        Text(
                          game["genre"] as String,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        CustomIconWidget(
                          iconName: 'star',
                          color: AppTheme.getWarningColor(true),
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          game["rating"].toString(),
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action button with recommendation icon
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      // Add to watchlist
                    },
                    icon: CustomIconWidget(
                      iconName: 'bookmark_border',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  CustomIconWidget(
                    iconName: 'recommend',
                    color: AppTheme.lightTheme.colorScheme.secondary,
                    size: 16,
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
