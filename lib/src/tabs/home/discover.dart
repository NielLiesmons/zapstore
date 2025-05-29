import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import '../../feeds/jobs_feed.dart';
import 'package:zaplab_design/zaplab_design.dart';
import '../../providers/resolvers.dart';

class DummyAppCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;

  const DummyAppCard({
    super.key,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return AppContainer(
      width: 280,
      child: Row(
        children: [
          AppProfilePicSquare.fromUrl(
            imageUrl,
            size: AppProfilePicSquareSize.s48,
          ),
          const AppGap.s12(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.bold14(name),
                const AppGap.s2(),
                AppText.reg12(
                  description,
                  color: theme.colors.white66,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DiscoverTab extends ConsumerWidget {
  const DiscoverTab({super.key});

  TabData tabData(BuildContext context) {
    final theme = AppTheme.of(context);

    return TabData(
      label: 'Discover',
      icon: const AppEmojiContentType(contentType: 'discover'),
      bottomBar: const AppBottomBarSafeArea(),
      content: HookConsumer(
        builder: (context, ref, _) {
          final appsState = ref.watch(query<App>());
          final apps = appsState.models.cast<App>();
          final appPacksState = ref.watch(query<AppCurationSet>());
          final appPacks = appPacksState.models.cast<AppCurationSet>();

          return Column(
            children: [
              AppContainer(
                padding: const AppEdgeInsets.all(AppGapSize.s12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBigSectionTitle(
                      title: 'Apps',
                      filter: 'Zapstore Community',
                    ),
                    const AppGap.s8(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < 4; i++) ...[
                            AppContainer(
                              width: 280,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (i * 3 < apps.length)
                                    AppAppSmallCard(
                                      app: apps[i * 3],
                                      onTap: () {},
                                      noPadding: true,
                                    ),
                                  if (i * 3 + 1 < apps.length) ...[
                                    const AppGap.s12(),
                                    AppAppSmallCard(
                                      app: apps[i * 3 + 1],
                                      onTap: () {},
                                      noPadding: true,
                                    ),
                                  ],
                                  if (i * 3 + 2 < apps.length) ...[
                                    const AppGap.s12(),
                                    AppAppSmallCard(
                                      app: apps[i * 3 + 2],
                                      onTap: () {},
                                      noPadding: true,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            if (i < 3) const AppGap.s16(),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const AppDivider(),
              AppContainer(
                padding: const AppEdgeInsets.all(AppGapSize.s12),
                child: Column(
                  children: [
                    AppBigSectionTitle(
                      title: 'Packs',
                      filter: 'Zapstore Community',
                    ),
                    const AppGap.s8(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var pack in appPacks)
                            AppContainer(
                              width: 280,
                              child: AppAppPackCard(
                                pack: pack,
                                apps: apps,
                                onTap: () {},
                                noPadding: true,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const AppDivider(),
              AppContainer(
                padding: const AppEdgeInsets.all(AppGapSize.s12),
                child: Column(
                  children: [
                    AppBigSectionTitle(
                      title: 'Other',
                      filter: 'Placeholder',
                    ),
                    const AppGap.s8(),
                    AppPanel(
                      child: SizedBox(
                        width: double.infinity,
                        height: 320,
                      ),
                    ),
                  ],
                ),
              ),
              const AppDivider(),
              AppContainer(
                padding: const AppEdgeInsets.all(AppGapSize.s12),
                child: Column(
                  children: [
                    AppBigSectionTitle(
                      title: 'Other',
                      filter: 'Placeholder',
                    ),
                    const AppGap.s8(),
                    AppPanel(
                      child: SizedBox(
                        width: double.infinity,
                        height: 320,
                      ),
                    ),
                  ],
                ),
              ),
              const AppGap.s80()
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => tabData(context).content;
}
