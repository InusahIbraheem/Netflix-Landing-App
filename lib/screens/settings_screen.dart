import 'package:flutter/material.dart';
import 'package:netflix_landing_ui/core/theme/app_colors.dart';
import 'package:netflix_landing_ui/widgets/netflix_app_bar.dart';
import 'package:netflix_landing_ui/widgets/screen_scaffold.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _autoPlay = true;
  bool _hdStreaming = true;
  bool _notifications = false;
  double _dataUsage = 1;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      appBar: const NetflixAppBar(showBack: true, title: 'Settings'),
      body: ListView(
        children: [
          _SettingsSection(
            title: 'Playback',
            children: [
              SwitchListTile(
                title: const Text('Autoplay Next Episode'),
                subtitle: const Text('Automatically play the next title'),
                value: _autoPlay,
                activeThumbColor: AppColors.netflixRed,
                onChanged: (v) => setState(() => _autoPlay = v),
              ),
              SwitchListTile(
                title: const Text('HD Streaming'),
                subtitle: const Text('Stream in high definition when available'),
                value: _hdStreaming,
                activeThumbColor: AppColors.netflixRed,
                onChanged: (v) => setState(() => _hdStreaming = v),
              ),
            ],
          ),
          _SettingsSection(
            title: 'Notifications',
            children: [
              SwitchListTile(
                title: const Text('Push Notifications'),
                subtitle: const Text('New releases and recommendations'),
                value: _notifications,
                activeThumbColor: AppColors.netflixRed,
                onChanged: (v) => setState(() => _notifications = v),
              ),
            ],
          ),
          _SettingsSection(
            title: 'Data Usage',
            children: [
              ListTile(
                title: const Text('Download Quality'),
                subtitle: Text(
                  _dataUsage == 0
                      ? 'Standard'
                      : _dataUsage == 1
                          ? 'High'
                          : 'Ultra HD',
                ),
              ),
              Slider(
                value: _dataUsage,
                min: 0,
                max: 2,
                divisions: 2,
                activeColor: AppColors.netflixRed,
                onChanged: (v) => setState(() => _dataUsage = v),
              ),
            ],
          ),
          _SettingsSection(
            title: 'Account',
            children: [
              ListTile(
                leading: const Icon(Icons.language, color: AppColors.netflixRed),
                title: const Text('Language'),
                subtitle: const Text('English'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.subtitles, color: AppColors.netflixRed),
                title: const Text('Subtitles'),
                subtitle: const Text('English, French, Spanish'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: AppColors.netflixRed),
                title: const Text('Sign Out'),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.netflixRed,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...children,
        const Divider(color: AppColors.divider),
      ],
    );
  }
}
