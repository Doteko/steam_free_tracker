import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SystemRequirementsWidget extends StatefulWidget {
  final Map<String, dynamic> requirements;

  const SystemRequirementsWidget({
    super.key,
    required this.requirements,
  });

  @override
  State<SystemRequirementsWidget> createState() =>
      _SystemRequirementsWidgetState();
}

class _SystemRequirementsWidgetState extends State<SystemRequirementsWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildRequirementItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 25.w,
            child: Text(
              label,
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.7),
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              value,
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementsTab(Map<String, dynamic> requirements) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          _buildRequirementItem(
              'OS:', requirements['os'] as String? ?? 'Not specified'),
          Divider(color: AppTheme.lightTheme.dividerColor),
          _buildRequirementItem('Processor:',
              requirements['processor'] as String? ?? 'Not specified'),
          Divider(color: AppTheme.lightTheme.dividerColor),
          _buildRequirementItem(
              'Memory:', requirements['memory'] as String? ?? 'Not specified'),
          Divider(color: AppTheme.lightTheme.dividerColor),
          _buildRequirementItem('Graphics:',
              requirements['graphics'] as String? ?? 'Not specified'),
          Divider(color: AppTheme.lightTheme.dividerColor),
          _buildRequirementItem('Storage:',
              requirements['storage'] as String? ?? 'Not specified'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final minimum =
        widget.requirements['minimum'] as Map<String, dynamic>? ?? {};
    final recommended =
        widget.requirements['recommended'] as Map<String, dynamic>? ?? {};

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
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
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'computer',
                  color: AppTheme.lightTheme.colorScheme.secondary,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Text(
                  'System Requirements',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: AppTheme.lightTheme.colorScheme.secondary,
              unselectedLabelColor: AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.6),
              indicatorColor: AppTheme.lightTheme.colorScheme.secondary,
              indicatorWeight: 3,
              labelStyle: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: AppTheme.lightTheme.textTheme.labelLarge,
              tabs: const [
                Tab(text: 'Minimum'),
                Tab(text: 'Recommended'),
              ],
            ),
          ),
          SizedBox(
            height: 35.h,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRequirementsTab(minimum),
                _buildRequirementsTab(recommended),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
