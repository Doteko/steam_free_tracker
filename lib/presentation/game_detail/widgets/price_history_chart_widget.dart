import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PriceHistoryChartWidget extends StatefulWidget {
  final List<Map<String, dynamic>> priceHistory;

  const PriceHistoryChartWidget({
    super.key,
    required this.priceHistory,
  });

  @override
  State<PriceHistoryChartWidget> createState() =>
      _PriceHistoryChartWidgetState();
}

class _PriceHistoryChartWidgetState extends State<PriceHistoryChartWidget> {
  int? _touchedIndex;

  List<FlSpot> _generateSpots() {
    return widget.priceHistory.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      final price = (data['price'] as num).toDouble();
      return FlSpot(index.toDouble(), price);
    }).toList();
  }

  double _getMaxY() {
    if (widget.priceHistory.isEmpty) return 100;
    final prices =
        widget.priceHistory.map((e) => (e['price'] as num).toDouble()).toList();
    final maxPrice = prices.reduce((a, b) => a > b ? a : b);
    return maxPrice + (maxPrice * 0.1); // Add 10% padding
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${months[date.month - 1]} ${date.day}';
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.priceHistory.isEmpty) {
      return const SizedBox.shrink();
    }

    final spots = _generateSpots();
    final maxY = _getMaxY();

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
                  offset: const Offset(0, 2)),
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CustomIconWidget(
                iconName: 'trending_down',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 20),
            SizedBox(width: 2.w),
            Text('Price History',
                style: AppTheme.lightTheme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600)),
          ]),

          SizedBox(height: 3.h),

          SizedBox(
              height: 25.h,
              child: LineChart(LineChartData(
                  gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: maxY / 4,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                            color: AppTheme.lightTheme.dividerColor,
                            strokeWidth: 1);
                      }),
                  titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              interval: 1,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                final index = value.toInt();
                                if (index >= 0 &&
                                    index < widget.priceHistory.length) {
                                  return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text(
                                          _formatDate(widget.priceHistory[index]
                                              ['date'] as String),
                                          style: AppTheme
                                              .lightTheme.textTheme.labelSmall
                                              ?.copyWith(fontSize: 10.sp)));
                                }
                                return const Text('');
                              })),
                      leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              interval: maxY / 4,
                              reservedSize: 40,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                return Text('\$${value.toStringAsFixed(0)}',
                                    style: AppTheme
                                        .lightTheme.textTheme.labelSmall
                                        ?.copyWith(fontSize: 10.sp));
                              }))),
                  borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                          color: AppTheme.lightTheme.dividerColor, width: 1)),
                  minX: 0,
                  maxX: (widget.priceHistory.length - 1).toDouble(),
                  minY: 0,
                  maxY: maxY,
                  lineBarsData: [
                    LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        gradient: LinearGradient(colors: [
                          AppTheme.lightTheme.colorScheme.secondary,
                          AppTheme.lightTheme.colorScheme.secondary
                              .withValues(alpha: 0.7),
                        ]),
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                  radius: _touchedIndex == index ? 6 : 4,
                                  color:
                                      AppTheme.lightTheme.colorScheme.secondary,
                                  strokeWidth: 2,
                                  strokeColor: AppTheme.lightTheme.cardColor);
                            }),
                        belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                                colors: [
                                  AppTheme.lightTheme.colorScheme.secondary
                                      .withValues(alpha: 0.3),
                                  AppTheme.lightTheme.colorScheme.secondary
                                      .withValues(alpha: 0.1),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter))),
                  ],
                  lineTouchData: LineTouchData(
                      enabled: true,
                      touchCallback: (FlTouchEvent event,
                          LineTouchResponse? touchResponse) {
                        setState(() {
                          if (touchResponse != null &&
                              touchResponse.lineBarSpots != null) {
                            _touchedIndex =
                                touchResponse.lineBarSpots!.first.spotIndex;
                          } else {
                            _touchedIndex = null;
                          }
                        });
                      },
                      touchTooltipData: LineTouchTooltipData(
                          tooltipRoundedRadius: 8,
                          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                            return touchedBarSpots.map((barSpot) {
                              final index = barSpot.spotIndex;
                              final price = barSpot.y;
                              final date =
                                  widget.priceHistory[index]['date'] as String;

                              return LineTooltipItem(
                                  '\$${price.toStringAsFixed(2)}\n${_formatDate(date)}',
                                  AppTheme.lightTheme.textTheme.labelSmall
                                          ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500) ??
                                      const TextStyle(color: Colors.white));
                            }).toList();
                          }))))),

          SizedBox(height: 2.h),

          // Price Summary
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _buildPriceStat(
                'Lowest',
                '\$${widget.priceHistory.map((e) => e['price'] as num).reduce((a, b) => a < b ? a : b).toStringAsFixed(2)}',
                AppTheme.lightTheme.colorScheme.tertiary),
            _buildPriceStat(
                'Highest',
                '\$${widget.priceHistory.map((e) => e['price'] as num).reduce((a, b) => a > b ? a : b).toStringAsFixed(2)}',
                AppTheme.lightTheme.colorScheme.error),
            _buildPriceStat(
                'Current',
                '\$${widget.priceHistory.last['price'].toStringAsFixed(2)}',
                AppTheme.lightTheme.colorScheme.secondary),
          ]),
        ]));
  }

  Widget _buildPriceStat(String label, String value, Color color) {
    return Column(children: [
      Text(label,
          style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.6))),
      SizedBox(height: 0.5.h),
      Text(value,
          style: AppTheme.priceTextStyle(isLight: true, fontSize: 14.sp)
              .copyWith(color: color, fontWeight: FontWeight.bold)),
    ]);
  }
}
