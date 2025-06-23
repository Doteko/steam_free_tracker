import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> userData;
  final VoidCallback onEditProfile;

  const ProfileHeaderWidget({
    super.key,
    required this.userData,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    final bool steamConnected = userData["steamConnected"] as bool? ?? false;
    final Map<String, dynamic>? steamProfile =
        userData["steamProfile"] as Map<String, dynamic>?;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar and basic info
          Row(
            children: [
              // Profile Avatar
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: steamConnected
                        ? AppTheme.lightTheme.colorScheme.secondary
                        : AppTheme.lightTheme.colorScheme.outline,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: CustomImageWidget(
                    imageUrl: steamConnected && steamProfile != null
                        ? (steamProfile["avatar"] as String? ??
                            userData["avatar"] as String)
                        : userData["avatar"] as String,
                    width: 20.w,
                    height: 20.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(width: 4.w),

              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData["username"] as String? ?? "Unknown User",
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 0.5.h),

                    Text(
                      userData["email"] as String? ?? "No email",
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 1.h),

                    // Account status
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: steamConnected
                            ? AppTheme.lightTheme.colorScheme.tertiary
                                .withValues(alpha: 0.1)
                            : AppTheme.lightTheme.colorScheme.outline
                                .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(1.w),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: steamConnected ? 'check_circle' : 'info',
                            color: steamConnected
                                ? AppTheme.lightTheme.colorScheme.tertiary
                                : AppTheme.lightTheme.colorScheme.outline,
                            size: 14,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            steamConnected
                                ? 'Steam Connected'
                                : 'Steam Not Connected',
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: steamConnected
                                  ? AppTheme.lightTheme.colorScheme.tertiary
                                  : AppTheme.lightTheme.colorScheme.outline,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Edit button
              IconButton(
                onPressed: onEditProfile,
                icon: CustomIconWidget(
                  iconName: 'edit',
                  color: AppTheme.lightTheme.colorScheme.secondary,
                  size: 20,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: AppTheme.lightTheme.colorScheme.secondary
                      .withValues(alpha: 0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
              ),
            ],
          ),

          // Steam profile info if connected
          if (steamConnected && steamProfile != null) ...[
            SizedBox(height: 2.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.secondary
                    .withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(2.w),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.secondary
                      .withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'videogame_asset',
                    color: AppTheme.lightTheme.colorScheme.secondary,
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Steam Profile',
                          style: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          steamProfile["username"] as String? ?? "Unknown",
                          style: AppTheme.lightTheme.textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  CustomIconWidget(
                    iconName: 'open_in_new',
                    color: AppTheme.lightTheme.colorScheme.secondary
                        .withValues(alpha: 0.7),
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
