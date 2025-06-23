import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/profile_header_widget.dart';
import './widgets/settings_section_widget.dart';
import './widgets/steam_connection_widget.dart';

class UserProfileSettings extends StatefulWidget {
  const UserProfileSettings({super.key});

  @override
  State<UserProfileSettings> createState() => _UserProfileSettingsState();
}

class _UserProfileSettingsState extends State<UserProfileSettings> {
  // Mock user data
  final Map<String, dynamic> userData = {
    "username": "GamerPro2024",
    "email": "gamer@steamtracker.com",
    "avatar":
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "steamConnected": true,
    "steamProfile": {
      "username": "SteamGamer123",
      "profileUrl": "https://steamcommunity.com/id/steamgamer123",
      "avatar":
          "https://images.pexels.com/photos/3165335/pexels-photo-3165335.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    }
  };

  // Settings state
  bool pushNotifications = true;
  bool emailUpdates = false;
  bool priceDropAlerts = true;
  bool freeGameAlerts = true;
  bool wishlistAlerts = true;
  bool quietHours = false;
  bool biometricAuth = false;
  String selectedCurrency = "USD (\$)";
  String selectedLanguage = "English";
  String selectedTheme = "System";

  final List<String> currencies = [
    "USD (\$)",
    "EUR (€)",
    "GBP (£)",
    "CAD (C\$)",
    "AUD (A\$)",
    "JPY (¥)"
  ];

  final List<String> languages = [
    "English",
    "Spanish",
    "French",
    "German",
    "Russian",
    "Chinese"
  ];

  final List<String> themes = ["System", "Light", "Dark"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Profile & Settings',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        foregroundColor: AppTheme.lightTheme.appBarTheme.foregroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.appBarTheme.foregroundColor!,
            size: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            ProfileHeaderWidget(
              userData: userData,
              onEditProfile: () => _showEditProfileDialog(),
            ),

            SizedBox(height: 2.h),

            // Account Section
            SettingsSectionWidget(
              title: 'Account',
              children: [
                SteamConnectionWidget(
                  isConnected: userData["steamConnected"] as bool,
                  steamProfile:
                      userData["steamProfile"] as Map<String, dynamic>?,
                  onConnect: () => _handleSteamConnection(),
                  onDisconnect: () => _handleSteamDisconnection(),
                ),
                _buildSettingsTile(
                  icon: 'sync',
                  title: 'Sync Settings',
                  subtitle: 'Manage data synchronization',
                  onTap: () => _showSyncSettings(),
                ),
              ],
            ),

            SizedBox(height: 1.h),

            // Notifications Section
            SettingsSectionWidget(
              title: 'Notifications',
              children: [
                _buildSwitchTile(
                  icon: 'notifications',
                  title: 'Push Notifications',
                  subtitle: 'Receive app notifications',
                  value: pushNotifications,
                  onChanged: (value) =>
                      setState(() => pushNotifications = value),
                ),
                _buildSwitchTile(
                  icon: 'email',
                  title: 'Email Updates',
                  subtitle: 'Receive email notifications',
                  value: emailUpdates,
                  onChanged: (value) => setState(() => emailUpdates = value),
                ),
                _buildSwitchTile(
                  icon: 'trending_down',
                  title: 'Price Drop Alerts',
                  subtitle: 'Notify when prices decrease',
                  value: priceDropAlerts,
                  onChanged: (value) => setState(() => priceDropAlerts = value),
                ),
                _buildSwitchTile(
                  icon: 'card_giftcard',
                  title: 'Free Game Alerts',
                  subtitle: 'Notify about free games',
                  value: freeGameAlerts,
                  onChanged: (value) => setState(() => freeGameAlerts = value),
                ),
                _buildSwitchTile(
                  icon: 'favorite',
                  title: 'Wishlist Alerts',
                  subtitle: 'Notify about wishlist changes',
                  value: wishlistAlerts,
                  onChanged: (value) => setState(() => wishlistAlerts = value),
                ),
                _buildSwitchTile(
                  icon: 'bedtime',
                  title: 'Quiet Hours',
                  subtitle: '10 PM - 8 AM',
                  value: quietHours,
                  onChanged: (value) => setState(() => quietHours = value),
                ),
              ],
            ),

            SizedBox(height: 1.h),

            // Preferences Section
            SettingsSectionWidget(
              title: 'Preferences',
              children: [
                _buildSelectionTile(
                  icon: 'attach_money',
                  title: 'Currency',
                  subtitle: selectedCurrency,
                  onTap: () => _showCurrencySelector(),
                ),
                _buildSelectionTile(
                  icon: 'language',
                  title: 'Language',
                  subtitle: selectedLanguage,
                  onTap: () => _showLanguageSelector(),
                ),
                _buildSelectionTile(
                  icon: 'palette',
                  title: 'Theme',
                  subtitle: selectedTheme,
                  onTap: () => _showThemeSelector(),
                ),
                _buildSwitchTile(
                  icon: 'fingerprint',
                  title: 'Biometric Authentication',
                  subtitle: 'Use fingerprint/face unlock',
                  value: biometricAuth,
                  onChanged: (value) => setState(() => biometricAuth = value),
                ),
              ],
            ),

            SizedBox(height: 1.h),

            // Support Section
            SettingsSectionWidget(
              title: 'Support',
              children: [
                _buildSettingsTile(
                  icon: 'help',
                  title: 'Help & FAQ',
                  subtitle: 'Get help and support',
                  onTap: () => _showHelp(),
                ),
                _buildSettingsTile(
                  icon: 'feedback',
                  title: 'Send Feedback',
                  subtitle: 'Share your thoughts',
                  onTap: () => _showFeedback(),
                ),
                _buildSettingsTile(
                  icon: 'file_download',
                  title: 'Export Data',
                  subtitle: 'Download your watchlist',
                  onTap: () => _exportData(),
                ),
                _buildSettingsTile(
                  icon: 'info',
                  title: 'About',
                  subtitle: 'App version 1.0.0',
                  onTap: () => _showAbout(),
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // Footer Links
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () => _showPrivacyPolicy(),
                    child: Text(
                      'Privacy Policy',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.secondary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _showTermsOfService(),
                    child: Text(
                      'Terms of Service',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      child: ListTile(
        leading: Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.secondary
                .withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: icon,
              color: AppTheme.lightTheme.colorScheme.secondary,
              size: 20,
            ),
          ),
        ),
        title: Text(
          title,
          style: AppTheme.lightTheme.textTheme.titleMedium,
        ),
        subtitle: Text(
          subtitle,
          style: AppTheme.lightTheme.textTheme.bodySmall,
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppTheme.lightTheme.colorScheme.secondary,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      ),
    );
  }

  Widget _buildSelectionTile({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      child: ListTile(
        leading: Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.secondary
                .withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: icon,
              color: AppTheme.lightTheme.colorScheme.secondary,
              size: 20,
            ),
          ),
        ),
        title: Text(
          title,
          style: AppTheme.lightTheme.textTheme.titleMedium,
        ),
        subtitle: Text(
          subtitle,
          style: AppTheme.lightTheme.textTheme.bodySmall,
        ),
        trailing: CustomIconWidget(
          iconName: 'chevron_right',
          color:
              AppTheme.lightTheme.colorScheme.onSurface.withValues(alpha: 0.6),
          size: 20,
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      ),
    );
  }

  Widget _buildSettingsTile({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      child: ListTile(
        leading: Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.secondary
                .withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: icon,
              color: AppTheme.lightTheme.colorScheme.secondary,
              size: 20,
            ),
          ),
        ),
        title: Text(
          title,
          style: AppTheme.lightTheme.textTheme.titleMedium,
        ),
        subtitle: Text(
          subtitle,
          style: AppTheme.lightTheme.textTheme.bodySmall,
        ),
        trailing: CustomIconWidget(
          iconName: 'chevron_right',
          color:
              AppTheme.lightTheme.colorScheme.onSurface.withValues(alpha: 0.6),
          size: 20,
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Profile'),
        content: Text('Profile editing functionality coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleSteamConnection() {
    // Mock Steam OAuth flow
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Connect Steam Account'),
        content: Text('Redirecting to Steam OAuth...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _handleSteamDisconnection() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Disconnect Steam Account'),
        content:
            Text('Are you sure you want to disconnect your Steam account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                userData["steamConnected"] = false;
              });
              Navigator.pop(context);
            },
            child: Text('Disconnect'),
          ),
        ],
      ),
    );
  }

  void _showSyncSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sync Settings'),
        content: Text('Configure data synchronization preferences.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCurrencySelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Currency'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: currencies.length,
            itemBuilder: (context, index) {
              final currency = currencies[index];
              return ListTile(
                title: Text(currency),
                trailing: selectedCurrency == currency
                    ? CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.lightTheme.colorScheme.secondary,
                        size: 20,
                      )
                    : null,
                onTap: () {
                  setState(() => selectedCurrency = currency);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showLanguageSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Language'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: languages.length,
            itemBuilder: (context, index) {
              final language = languages[index];
              return ListTile(
                title: Text(language),
                trailing: selectedLanguage == language
                    ? CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.lightTheme.colorScheme.secondary,
                        size: 20,
                      )
                    : null,
                onTap: () {
                  setState(() => selectedLanguage = language);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showThemeSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Theme'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: themes.length,
            itemBuilder: (context, index) {
              final theme = themes[index];
              return ListTile(
                title: Text(theme),
                trailing: selectedTheme == theme
                    ? CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.lightTheme.colorScheme.secondary,
                        size: 20,
                      )
                    : null,
                onTap: () {
                  setState(() => selectedTheme = theme);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Help & FAQ'),
        content: Text('Help documentation and FAQ will be available here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showFeedback() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Send Feedback'),
        content: Text('Feedback form will be available here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _exportData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Export Data'),
        content: Text('Your watchlist data has been prepared for export.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Share'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAbout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('About Steam Free Tracker'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version: 1.0.0'),
            SizedBox(height: 1.h),
            Text('Track Steam game pricing and free promotions.'),
            SizedBox(height: 1.h),
            Text('© 2024 Steam Free Tracker'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Privacy Policy'),
        content: Text('Privacy policy content will be displayed here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showTermsOfService() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Terms of Service'),
        content: Text('Terms of service content will be displayed here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
