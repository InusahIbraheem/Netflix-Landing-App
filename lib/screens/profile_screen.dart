import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_landing_ui/core/constants/route_constants.dart';
import 'package:netflix_landing_ui/core/theme/app_colors.dart';
import 'package:netflix_landing_ui/services/movie_service.dart';
import 'package:netflix_landing_ui/widgets/glass_container.dart';
import 'package:netflix_landing_ui/widgets/netflix_app_bar.dart';
import 'package:netflix_landing_ui/widgets/screen_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = MovieService.profile;

    return ScreenScaffold(
      appBar: const NetflixAppBar(title: 'Profile'),
      body: ListView(
        children: [
          GlassContainer(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Hero(
                  tag: 'profile-avatar',
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: CachedNetworkImageProvider(profile.avatarUrl),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        profile.email,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.netflixRed.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          profile.plan,
                          style: const TextStyle(
                            color: AppColors.netflixRed,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _ProfileTile(
            icon: Icons.settings_outlined,
            title: 'Settings',
            subtitle: 'App preferences and account',
            onTap: () => context.push(RouteConstants.settings),
          ),
          _ProfileTile(
            icon: Icons.download_outlined,
            title: 'Downloads',
            subtitle: 'Manage offline content',
            onTap: () {},
          ),
          _ProfileTile(
            icon: Icons.help_outline,
            title: 'Help Center',
            subtitle: 'FAQs and support',
            onTap: () {},
          ),
          _ProfileTile(
            icon: Icons.info_outline,
            title: 'About',
            subtitle: 'Member since ${profile.memberSince}',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: AppColors.surfaceLight,
      child: ListTile(
        leading: Icon(icon, color: AppColors.netflixRed),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
