import 'package:go_router/go_router.dart';
import 'package:zaplab_design/zaplab_design.dart';
import '../modals/start_add_existing_key_modal.dart';
import '../modals/start_paste_key_modal.dart';
import '../modals/start_your_key_modal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<GoRoute> get startRoutes => [
      GoRoute(
        path: '/start',
        pageBuilder: (context, state) {
          return AppSlideInModal(
            child: AppStartModal(
              logoImageUrl: 'assets/images/Zapstore-Blurple-Transparent.png',
              title: 'Zapstore',
              description: "Apps. Released.",
              onStart: (profileName) {
                context.replace('/start/spin-up-key', extra: profileName);
              },
              onAlreadyHaveKey: () {
                context.replace('/start/existing-profile');
              },
            ),
          );
        },
      ),
      GoRoute(
        path: '/start/spin-up-key',
        pageBuilder: (context, state) {
          final profileName = state.extra as String;
          return AppSlideInModal(
            child: AppSpinUpKeyModal(
              profileName: profileName,
              onSpinComplete: (secretKey, profileName) {
                context.push('/start/your-key', extra: {
                  'secretKey': secretKey,
                  'profileName': profileName,
                });
              },
            ),
          );
        },
      ),
      GoRoute(
        path: '/start/your-key',
        pageBuilder: (context, state) {
          return AppSlideInModal(
            child: Consumer(
              builder: (context, ref, child) {
                final extra = state.extra as Map<String, dynamic>;
                return StartYourKeyModal(
                  secretKey: extra['secretKey'] as String,
                  profileName: extra['profileName'] as String,
                );
              },
            ),
          );
        },
      ),
      GoRoute(
        path: '/start/existing-profile',
        pageBuilder: (context, state) {
          return AppSlideInModal(
            child: StartAddExistingKeyModal(),
          );
        },
      ),
      GoRoute(
        path: '/start/paste-key',
        pageBuilder: (context, state) {
          return AppSlideInModal(
            child: StartPasteKeyModal(
              onUseThisKey: () {
                context
                    .pop(); // TODO: Add logic to use the key and add a signedInProfile + Signer
              },
            ),
          );
        },
      ),
    ];
