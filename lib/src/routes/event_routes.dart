import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:models/models.dart';
import 'package:zaplab_design/zaplab_design.dart';
import '../providers/resolvers.dart';
import '../providers/search.dart';

import '../screens/mail_screen.dart';
import '../modals/reply_modal.dart';
import '../modals/actions_modal.dart';

String getModelRoute(String modelType) {
  return switch (modelType.toLowerCase()) {
    'thread' => '/thread',
    'article' => '/article',
    'mail' => '/mail',
    'book' => '/book',
    'task' => '/task',
    'job' => '/job',
    'group' => '/group',
    'community' => '/community',
    _ => '/nostr-publication', // Default to nostr-publication if unknown
  };
}

List<GoRoute> get eventRoutes => [
      GoRoute(
        path: '/nostr-publication/:eventId',
        redirect: (context, state) {
          // If a model is provided, redirect to the appropriate route
          if (state.extra != null) {
            final model = state.extra as Model;
            final route = getModelRoute(model.runtimeType.toString());
            return '$route/${state.pathParameters['eventId']}';
          }
          // If no model is provided, return null to use the pageBuilder
          return null;
        },
        pageBuilder: (context, state) {
          // Show the default nostr publication view
          return AppSlideInScreen(
            child: Consumer(
              builder: (context, ref, _) {
                return AppText.h1(
                    'Nostr publication ${state.pathParameters['eventId']}');
              },
            ),
          );
        },
      ),
      GoRoute(
        path: '/actions/:eventId',
        pageBuilder: (context, state) {
          final model = state.extra as Model;
          return AppSlideInModal(
            child: Consumer(
              builder: (context, ref, _) {
                return ActionsModal(
                  model: model,
                );
              },
            ),
          );
        },
      ),
      GoRoute(
        path: '/zap/:eventId',
        pageBuilder: (context, state) {
          final model = state.extra as Model;
          return AppSlideInModal(
            child: Consumer(
              builder: (context, ref, _) {
                return AppZapModal(
                  model: model,
                  otherZaps: [],
                  recentAmounts: AppDefaultData.defaultAmounts,
                  onResolveEvent: ref.read(resolversProvider).eventResolver,
                  onResolveProfile: ref.read(resolversProvider).profileResolver,
                  onResolveEmoji: ref.read(resolversProvider).emojiResolver,
                  onSearchProfiles: ref.read(searchProvider).profileSearch,
                  onSearchEmojis: ref.read(searchProvider).emojiSearch,
                  onCameraTap: () {},
                  onEmojiTap: () {},
                  onGifTap: () {},
                  onAddTap: () {},
                );
              },
            ),
          );
        },
      ),
      GoRoute(
        path: '/reply-to/:eventId',
        pageBuilder: (context, state) {
          final model = state.extra as Model;
          return AppSlideInModal(
            child: Consumer(
              builder: (context, ref, _) {
                return ReplyModal(
                  model: model,
                );
              },
            ),
          );
        },
      ),
      GoRoute(
        path: '/mail/:eventId',
        pageBuilder: (context, state) {
          final model = state.extra as Model;
          return AppSlideInScreen(
            child: Consumer(
              builder: (context, ref, _) {
                return MailScreen(
                  mail: model as Mail,
                );
              },
            ),
          );
        },
      ),
    ];
