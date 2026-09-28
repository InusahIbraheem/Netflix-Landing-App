import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_landing_ui/core/constants/route_constants.dart';
import 'package:netflix_landing_ui/core/theme/app_colors.dart';
import 'package:netflix_landing_ui/core/utils/responsive_utils.dart';
import 'package:netflix_landing_ui/widgets/glass_container.dart';

class NetflixAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NetflixAppBar({
    super.key,
    this.showBack = false,
    this.title,
    this.actions,
  });

  final bool showBack;
  final String? title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);

    return AppBar(
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            )
          : null,
      title: title != null
          ? Text(title!)
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'N',
                  style: TextStyle(
                    color: AppColors.netflixRed,
                    fontWeight: FontWeight.w900,
                    fontSize: isDesktop ? 32 : 28,
                  ),
                ),
                Text(
                  'ETFLIX',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: isDesktop ? 28 : 24,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () => context.push(RouteConstants.search),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          tooltip: 'Notifications',
          onPressed: () {},
        ),
        if (isDesktop) ...[
          TextButton(
            onPressed: () => context.go(RouteConstants.home),
            child: const Text('Home'),
          ),
          TextButton(
            onPressed: () => context.go(RouteConstants.trending),
            child: const Text('Trending'),
          ),
          TextButton(
            onPressed: () => context.go(RouteConstants.categories),
            child: const Text('Categories'),
          ),
          TextButton(
            onPressed: () => context.go(RouteConstants.myList),
            child: const Text('My List'),
          ),
        ],
        IconButton(
          icon: const CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.netflixRed,
            child: Icon(Icons.person, size: 16, color: Colors.white),
          ),
          onPressed: () => context.push(RouteConstants.profile),
        ),
        ...?actions,
        const SizedBox(width: 8),
      ],
      flexibleSpace: ClipRect(
        child: GlassContainer(
          borderRadius: 0,
          blur: 8,
          opacity: 0.08,
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
