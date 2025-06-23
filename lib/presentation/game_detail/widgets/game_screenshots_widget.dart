import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GameScreenshotsWidget extends StatefulWidget {
  final List<String> screenshots;

  const GameScreenshotsWidget({
    super.key,
    required this.screenshots,
  });

  @override
  State<GameScreenshotsWidget> createState() => _GameScreenshotsWidgetState();
}

class _GameScreenshotsWidgetState extends State<GameScreenshotsWidget> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showFullScreenImage(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _FullScreenImageViewer(
          screenshots: widget.screenshots,
          initialIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.screenshots.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            'Screenshots',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        SizedBox(height: 1.5.h),

        // Screenshots Carousel
        SizedBox(
          height: 25.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.screenshots.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _showFullScreenImage(index),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CustomImageWidget(
                      imageUrl: widget.screenshots[index],
                      width: double.infinity,
                      height: 25.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 1.5.h),

        // Page Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.screenshots.length,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 0.5.w),
              width: _currentIndex == index ? 3.w : 2.w,
              height: 1.h,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? AppTheme.lightTheme.colorScheme.secondary
                    : AppTheme.lightTheme.colorScheme.secondary
                        .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FullScreenImageViewer extends StatefulWidget {
  final List<String> screenshots;
  final int initialIndex;

  const _FullScreenImageViewer({
    required this.screenshots,
    required this.initialIndex,
  });

  @override
  State<_FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<_FullScreenImageViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'close',
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          '${_currentIndex + 1} of ${widget.screenshots.length}',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Mock share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sharing screenshot...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: CustomIconWidget(
              iconName: 'share',
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: widget.screenshots.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            minScale: 0.5,
            maxScale: 3.0,
            child: Center(
              child: CustomImageWidget(
                imageUrl: widget.screenshots[index],
                width: 100.w,
                height: 100.h,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
