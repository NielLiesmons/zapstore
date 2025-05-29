import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:zaplab_design/zaplab_design.dart';

class LibraryTab extends StatelessWidget {
  const LibraryTab({super.key});

  TabData tabData(BuildContext context) {
    return TabData(
      label: 'Library',
      icon: const AppEmojiContentType(contentType: 'library'),
      content: HookConsumer(
        builder: (context, ref, _) {
          final jobs = ref.watch(query<Job>()).models.cast<Job>();

          return AppContainer(
            padding: const AppEdgeInsets.all(AppGapSize.s12),
            child: Column(
              children: [
                for (final job in jobs)
                  Column(
                    children: [
                      AppJobCard(
                        job: job,
                        onTap: (model) => context.push('/job/${model.id}'),
                        isUnread: true,
                      ),
                      const AppGap.s12(),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) => tabData(context).content;
}
