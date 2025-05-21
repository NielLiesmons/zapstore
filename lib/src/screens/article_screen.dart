import 'package:zaplab_design/zaplab_design.dart';
import 'package:models/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/resolvers.dart';
import '../providers/history.dart';
import '../tabs/details/details.dart';
import 'package:go_router/go_router.dart';
import 'package:zaplab_design/src/notifications/scroll_progress_notification.dart';

class ArticleScreen extends ConsumerStatefulWidget {
  final Article article;

  const ArticleScreen({
    super.key,
    required this.article,
  });

  @override
  ConsumerState<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends ConsumerState<ArticleScreen>
    with SingleTickerProviderStateMixin {
  late AppTabController _tabController;
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = AppTabController(length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    // History
    ref.read(historyProvider.notifier).addEntry(widget.article);
    final recentHistory = ref.watch(recentHistoryItemsProvider(
        context, widget.article.id)); // Get latest 3 history entries

    // Get Data
    final resolvers = ref.read(resolversProvider);
    final state = ref.watch(query<Community>());
    final communities = state.models.cast<Community>().toList();

    return ScrollProgressListener(
      onNotification: (notification) {
        setState(() => _scrollProgress = notification.progress);
        return true;
      },
      child: AppScreen(
        onHomeTap: () => context.push('/'),
        alwaysShowTopBar: false,
        history: recentHistory,
        topBarContent: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppProfilePic.s40(widget.article.author.value),
            const AppGap.s12(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppGap.s8(),
                  Row(
                    children: [
                      AppEmojiContentType(
                        contentType: getModelContentType(widget.article),
                        size: 16,
                      ),
                      const AppGap.s10(),
                      Expanded(
                        child: AppCompactTextRenderer(
                          isMedium: true,
                          isWhite: true,
                          content: getModelDisplayText(widget.article),
                          onResolveEvent: resolvers.eventResolver,
                          onResolveProfile: resolvers.profileResolver,
                          onResolveEmoji: resolvers.emojiResolver,
                        ),
                      ),
                    ],
                  ),
                  const AppGap.s2(),
                  AppContainer(
                    padding: const AppEdgeInsets.symmetric(
                      vertical: AppGapSize.s4,
                    ),
                    child: AppProgressBar(
                      progress: _scrollProgress,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomBarContent: AppBottomBarLongText(
          model: widget.article,
          onZapTap: (model) {},
          onPlayTap: (model) {},
          onReplyTap: (model) {},
          onVoiceTap: (model) {},
          onActions: (model) {},
        ),
        child: Column(
          children: [
            AppArticleHeader(
              article: widget.article,
              communities: communities,
            ),
            AppContainer(
              child: AppTabView(
                controller: _tabController,
                tabs: [
                  TabData(
                    label: 'Article',
                    icon: AppEmojiContentType(
                      contentType: getModelContentType(widget.article),
                      size: 24,
                    ),
                    content: AppLongTextRenderer(
                      language: "ndown",
                      content: widget.article.content,
                      onResolveEvent: resolvers.eventResolver,
                      onResolveProfile: resolvers.profileResolver,
                      onResolveEmoji: resolvers.emojiResolver,
                      onResolveHashtag: resolvers.hashtagResolver,
                      onLinkTap: (url) {},
                    ),
                  ),
                  TabData(
                    label: 'Replies',
                    icon: AppIcon.s24(
                      theme.icons.characters.reply,
                      outlineColor: theme.colors.white66,
                      outlineThickness: AppLineThicknessData.normal().medium,
                    ),
                    content: const AppLoadingFeed(
                      type: LoadingFeedType.thread,
                    ),
                  ),
                  TabData(
                    label: 'Shares',
                    icon: AppIcon.s24(
                      theme.icons.characters.share,
                      outlineColor: theme.colors.white66,
                      outlineThickness: AppLineThicknessData.normal().medium,
                    ),
                    content: const AppText.reg14('Shares content'),
                  ),
                  TabData(
                    label: 'Labels',
                    icon: AppIcon.s24(
                      theme.icons.characters.label,
                      outlineColor: theme.colors.white66,
                      outlineThickness: AppLineThicknessData.normal().medium,
                    ),
                    content: const AppText.reg14('Labels content'),
                  ),
                  TabData(
                    label: 'Details',
                    icon: AppIcon.s24(
                      theme.icons.characters.details,
                      outlineColor: theme.colors.white66,
                      outlineThickness: AppLineThicknessData.normal().medium,
                    ),
                    content: DetailsTab(model: widget.article),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
