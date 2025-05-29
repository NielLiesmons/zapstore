import 'package:zaplab_design/zaplab_design.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'tabs/home/discover.dart';
import 'tabs/home/communities.dart';
import 'tabs/home/library.dart';
import 'tabs/home/forum.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final AppTabController _tabController;
  double _topContainerHeight = 1.0;

  static const double _heightWithProfile = 288.0;
  static const double _heightWithoutProfile = 288.0;

  // Tab controller to switch bottom bar based on the tab that is selected.
  @override
  void initState() {
    super.initState();
    _tabController = AppTabController(length: 5);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Home page content
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final activeProfile = ref.watch(Signer.activeProfileProvider);
    final containerHeight =
        activeProfile == null ? _heightWithoutProfile : _heightWithProfile;

    return Stack(
      children: [
        AppScaffold(
          body: AppContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const AppTopSafeArea(),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 50),
                  height: containerHeight * _topContainerHeight,
                  child: Opacity(
                    opacity: _topContainerHeight,
                    child: AppContainer(
                      height: containerHeight,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AppContainer(
                              padding: const AppEdgeInsets.all(AppGapSize.s12),
                              child: activeProfile == null
                                  ? Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/Zapstore-Blurple-Transparent.png',
                                          width: theme.sizes.s32,
                                          height: theme.sizes.s32,
                                        ),
                                        const AppGap.s8(),
                                        AppText.h1('Zapstore'),
                                        const Spacer(),
                                        AppButton(
                                          onTap: () => context.push('/start'),
                                          children: [
                                            AppIcon.s12(
                                              theme.icons.characters.play,
                                              color: theme.colors.whiteEnforced,
                                            ),
                                            const AppGap.s12(),
                                            AppText.med14('Start',
                                                color:
                                                    theme.colors.whiteEnforced),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        // if (AppPlatformUtils.isMobile)
                                        AppProfilePic.s38(
                                          activeProfile,
                                          onTap: () =>
                                              context.push('/settings'),
                                        ),
                                        const AppGap.s12(),
                                        Expanded(
                                          child: AppInputButton(
                                            children: [
                                              AppIcon.s18(
                                                  theme.icons.characters.search,
                                                  outlineThickness:
                                                      AppLineThicknessData
                                                              .normal()
                                                          .medium,
                                                  outlineColor:
                                                      theme.colors.white33),
                                              const AppGap.s8(),
                                              AppText.med14(
                                                  'Search Jobs, Services, ...',
                                                  color: theme.colors.white33),
                                            ],
                                          ),
                                        ),
                                        const AppGap.s12(),
                                        AppButton(
                                          onTap: () => context.push('/create'),
                                          square: true,
                                          inactiveColor: theme.colors.white16,
                                          children: [
                                            AppIcon.s12(
                                                theme.icons.characters.plus,
                                                outlineThickness:
                                                    AppLineThicknessData
                                                            .normal()
                                                        .thick,
                                                outlineColor:
                                                    theme.colors.white66),
                                          ],
                                        ),
                                      ],
                                    ),
                            ),
                            const AppDivider(),
                            AppContainer(
                              padding: const AppEdgeInsets.all(AppGapSize.s12),
                              child: activeProfile == null
                                  ? Stack(
                                      children: [
                                        AppContainer(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                theme.sizes.s16),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: Image.asset(
                                            'assets/images/Zapstore-Banner.png',
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.fitHeight,
                                            alignment: Alignment.topCenter,
                                          ),
                                        ),
                                        Positioned(
                                          left: theme.sizes.s16,
                                          right: theme.sizes.s16,
                                          bottom: theme.sizes.s16,
                                          child: AppInputButton(
                                            onTap: () {},
                                            backgroundColor:
                                                theme.colors.white8,
                                            children: [
                                              AppIcon.s18(
                                                theme.icons.characters.search,
                                                outlineThickness:
                                                    AppLineThicknessData
                                                            .normal()
                                                        .medium,
                                                outlineColor:
                                                    theme.colors.white33,
                                              ),
                                              const AppGap.s8(),
                                              AppText.med14('Search',
                                                  color: theme.colors.white33),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : AppPanel(
                                      child: AppText('Placeholder'),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: AppTabView(
                    tabs: [
                      const DiscoverTab().tabData(context),
                      const ForumTab().tabData(context),
                      const CommunitiesTab().tabData(context),
                      const LibraryTab().tabData(context),
                    ],
                    controller: _tabController,
                    scrollableContent: true,
                    onScroll: (position) {
                      setState(() {
                        _topContainerHeight =
                            (1.0 - ((position * 2) / containerHeight))
                                .clamp(0.0, 1.0);
                      });
                    },
                    scrollOffsetHeight: containerHeight / 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
