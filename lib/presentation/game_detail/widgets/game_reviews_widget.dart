import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GameReviewsWidget extends StatefulWidget {
  final double rating;
  final int totalReviews;
  final int positiveReviews;
  final List<Map<String, dynamic>> recentReviews;

  const GameReviewsWidget({
    super.key,
    required this.rating,
    required this.totalReviews,
    required this.positiveReviews,
    required this.recentReviews,
  });

  @override
  State<GameReviewsWidget> createState() => _GameReviewsWidgetState();
}

class _GameReviewsWidgetState extends State<GameReviewsWidget> {
  bool _showAllReviews = false;

  Widget _buildStarRating(double rating, {double size = 16}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        return CustomIconWidget(
          iconName: starValue <= rating
              ? 'star'
              : starValue - 0.5 <= rating
                  ? 'star_half'
                  : 'star_border',
          color: Colors.amber,
          size: size,
        );
      }),
    );
  }

  Widget _buildRatingDistribution() {
    return Column(
      children: [
        // Overall Rating
        Row(
          children: [
            Text(
              widget.rating.toStringAsFixed(1),
              style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.lightTheme.colorScheme.secondary,
              ),
            ),
            SizedBox(width: 2.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStarRating(widget.rating, size: 18),
                SizedBox(height: 0.5.h),
                Text(
                  '${widget.totalReviews.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} reviews',
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 2.h),

        // Rating Bars
        ...List.generate(5, (index) {
          final starCount = 5 - index;
          final percentage = starCount == 5
              ? 65
              : starCount == 4
                  ? 20
                  : starCount == 3
                      ? 10
                      : starCount == 2
                          ? 3
                          : 2;

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 0.3.h),
            child: Row(
              children: [
                Text(
                  '$starCount',
                  style: AppTheme.lightTheme.textTheme.labelSmall,
                ),
                SizedBox(width: 1.w),
                CustomIconWidget(
                  iconName: 'star',
                  color: Colors.amber,
                  size: 12,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: AppTheme.lightTheme.dividerColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.lightTheme.colorScheme.secondary,
                    ),
                    minHeight: 0.8.h,
                  ),
                ),
                SizedBox(width: 2.w),
                Text(
                  '$percentage%',
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    final username = review['username'] as String;
    final rating = review['rating'] as int;
    final reviewText = review['review'] as String;
    final date = review['date'] as String;
    final helpful = review['helpful'] as int;

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.lightTheme.dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info and Rating
          Row(
            children: [
              CircleAvatar(
                radius: 2.h,
                backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
                child: Text(
                  username[0].toUpperCase(),
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 0.3.h),
                    Row(
                      children: [
                        _buildStarRating(rating.toDouble()),
                        SizedBox(width: 2.w),
                        Text(
                          _formatDate(date),
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 1.5.h),

          // Review Text
          Text(
            reviewText,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              height: 1.4,
            ),
          ),

          SizedBox(height: 1.h),

          // Helpful Counter
          Row(
            children: [
              CustomIconWidget(
                iconName: 'thumb_up',
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.6),
                size: 16,
              ),
              SizedBox(width: 1.w),
              Text(
                '$helpful people found this helpful',
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 30) {
        return '${date.day}/${date.month}/${date.year}';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} days ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hours ago';
      } else {
        return 'Recently';
      }
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final reviewsToShow = _showAllReviews
        ? widget.recentReviews
        : widget.recentReviews.take(2).toList();

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
                iconName: 'rate_review',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'User Reviews',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Rating Distribution
          _buildRatingDistribution(),

          SizedBox(height: 3.h),

          // Recent Reviews Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Reviews',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.tertiary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${widget.positiveReviews}% Positive',
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.tertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Review Cards
          ...reviewsToShow.map((review) => _buildReviewCard(review)),

          // Show More/Less Button
          if (widget.recentReviews.length > 2)
            Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _showAllReviews = !_showAllReviews;
                  });
                },
                child: Text(
                  _showAllReviews ? 'Show Less Reviews' : 'Show All Reviews',
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
