import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:zaplab_design/zaplab_design.dart';

class CommunitiesTab extends StatelessWidget {
  const CommunitiesTab({super.key});

  TabData tabData(BuildContext context) {
    return TabData(
      label: 'Communities',
      icon: const AppEmojiContentType(contentType: 'community'),
      content: HookConsumer(
        builder: (context, ref, _) {
          final services = ref.watch(query<Service>()).models.cast<Service>();

          return AppContainer(
            child: Column(
              children: [
                for (final service in services)
                  Column(
                    children: [
                      AppFeedService(
                        service: service,
                        onTap: (event) =>
                            context.push('/service/${event.id}', extra: event),
                      ),
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
