import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SteamConnectionWidget extends StatelessWidget {
  final bool isConnected;
  final Map<String, dynamic>? steamProfile;
  final VoidCallback onConnect;
  final VoidCallback onDisconnect;

  const SteamConnectionWidget({
    super.key,
    required this.isConnected,
    this.steamProfile,
    required this.onConnect,
    required this.onDisconnect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      child: ListTile(
        leading: Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: isConnected
                ? AppTheme.lightTheme.colorScheme.tertiary
                    .withValues(alpha: 0.1)
                : AppTheme.lightTheme.colorScheme.secondary
                    .withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: 'videogame_asset',
              color: isConnected
                  ? AppTheme.lightTheme.colorScheme.tertiary
                  : AppTheme.lightTheme.colorScheme.secondary,
              size: 20,
            ),
          ),
        ),
        title: Text(
          'Steam Connection',
          style: AppTheme.lightTheme.textTheme.titleMedium,
        ),
        subtitle: isConnected && steamProfile != null
            ? Text(
                'Connected as ${steamProfile!["username"] as String? ?? "Unknown"}',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.tertiary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : Text(
                'Connect your Steam account',
                style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
        trailing: isConnected
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Connected status indicator
                  Container(
                    width: 2.w,
                    height: 2.w,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.tertiary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  // Disconnect button
                  TextButton(
                    onPressed: onDisconnect,
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.lightTheme.colorScheme.error,
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    ),
                    child: Text(
                      'Disconnect',
                      style:
                          AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.error,
                      ),
                    ),
                  ),
                ],
              )
            : ElevatedButton(
                onPressed: onConnect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
                  foregroundColor: AppTheme.lightTheme.colorScheme.onSecondary,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
                child: Text(
                  'Connect',
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        onTap: isConnected ? null : onConnect,
      ),
    );
  }
}
