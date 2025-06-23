import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GameDescriptionWidget extends StatefulWidget {
  final String description;
  final String fullDescription;

  const GameDescriptionWidget({
    super.key,
    required this.description,
    required this.fullDescription,
  });

  @override
  State<GameDescriptionWidget> createState() => _GameDescriptionWidgetState();
}

class _GameDescriptionWidgetState extends State<GameDescriptionWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'description',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'About This Game',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.description,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 1.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = true;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Read More',
                        style:
                            AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 1.w),
                      CustomIconWidget(
                        iconName: 'expand_more',
                        color: AppTheme.lightTheme.colorScheme.secondary,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.fullDescription,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 1.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = false;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Show Less',
                        style:
                            AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 1.w),
                      CustomIconWidget(
                        iconName: 'expand_less',
                        color: AppTheme.lightTheme.colorScheme.secondary,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
