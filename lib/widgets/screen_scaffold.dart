import 'package:flutter/material.dart';
import 'package:netflix_landing_ui/core/constants/app_constants.dart';
import 'package:netflix_landing_ui/core/theme/app_colors.dart';
import 'package:netflix_landing_ui/core/utils/responsive_utils.dart';
import 'package:netflix_landing_ui/widgets/developer_footer.dart';

class ScreenScaffold extends StatelessWidget {
  const ScreenScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.showFooter = true,
    this.extendBodyBehindAppBar = false,
    this.bottomNavigationBar,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final bool showFooter;
  final bool extendBodyBehindAppBar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtils.horizontalPadding(context);

    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        top: !extendBodyBehindAppBar,
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: AppConstants.maxContentWidth,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: body,
                  ),
                ),
              ),
            ),
            if (showFooter)
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.divider)),
                ),
                child: const DeveloperFooter(),
              ),
          ],
        ),
      ),
    );
  }
}
