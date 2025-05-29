import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:zaplab_design/zaplab_design.dart';
import '../../providers/resolvers.dart';

class ForumTab extends StatelessWidget {
  const ForumTab({super.key});

  TabData tabData(BuildContext context) {
    return TabData(
      label: 'Forum',
      icon: const AppEmojiContentType(contentType: 'forum'),
      bottomBar: const AppBottomBarSafeArea(),
      content: HookConsumer(
        builder: (context, ref, _) {
          final forumPosts =
              ref.watch(query<ForumPost>()).models.cast<ForumPost>();

          return Column(
            children: [
              for (final forumPost in forumPosts)
                AppFeedForumPost(
                  forumPost: forumPost,
                  onTap: (model) =>
                      context.push('/forum/${model.id}', extra: model),
                  onReply: (model) =>
                      context.push('/reply-to/${model.id}', extra: model),
                  onActions: (model) =>
                      context.push('/actions/${model.id}', extra: model),
                  onReactionTap: (reaction) {},
                  onZapTap: (zap) {},
                  onResolveEvent: ref.read(resolversProvider).eventResolver,
                  onResolveProfile: ref.read(resolversProvider).profileResolver,
                  onResolveEmoji: ref.read(resolversProvider).emojiResolver,
                  onResolveHashtag: ref.read(resolversProvider).hashtagResolver,
                  onLinkTap: (url) {
                    print(url);
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) => tabData(context).content;
}
