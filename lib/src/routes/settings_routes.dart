import 'package:go_router/go_router.dart';
import 'package:zaplab_design/zaplab_design.dart';
import 'package:zapchat/src/screens/settings_screen.dart';
import 'package:zapchat/src/modals/preferences_modal.dart';
import 'package:zapchat/src/modals/start_add_existing_key_modal.dart';
import 'package:zapchat/src/modals/settings_history_modal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:models/models.dart';
import 'package:zapchat/src/providers/signer.dart';

List<GoRoute> get settingsRoutes => [
      GoRoute(
        path: '/settings',
        pageBuilder: (context, state) {
          return AppSlideInScreen(
            child: const SettingsScreen(),
          );
        },
      ),
      GoRoute(
        path: '/settings/add-profile',
        pageBuilder: (context, state) {
          return AppSlideInModal(
            child: AppAddProfileModal(
              onStart: (profileName) {
                context.replace('/settings/spin-up-key', extra: profileName);
              },
              onAlreadyHaveKey: () {
                context.replace('/settings/existing-profile');
              },
            ),
          );
        },
      ),
      GoRoute(
        path: '/settings/spin-up-key',
        pageBuilder: (context, state) {
          final profileName = state.extra as String;
          return AppSlideInModal(
            child: AppSpinUpKeyModal(
              profileName: profileName,
              onSpinComplete: (secretKey, profileName) {
                context.replace('/settings/your-key', extra: {
                  'secretKey': secretKey,
                  'profileName': profileName,
                });
              },
            ),
          );
        },
      ),
      GoRoute(
        path: '/settings/your-key',
        pageBuilder: (context, state) {
          return AppSlideInModal(
            child: Consumer(
              builder: (context, ref, child) {
                final extra = state.extra as Map<String, dynamic>;
                return AppYourKeyModal(
                  secretKey: extra['secretKey'] as String,
                  profileName: extra['profileName'] as String,
                  onUseThisKey: () async {
                    final secretKey = extra['secretKey'] as String;
                    final profileName = extra['profileName'] as String;

                    // Create a PartialProfile with the provided name
                    final partialProfile = PartialProfile(
                      name: profileName,
                    );

                    // Verify nsec format
                    if (!AppKeyGenerator.verifyNsecChecksum(secretKey)) {
                      throw FormatException('Invalid nsec format: $secretKey');
                    }

                    try {
                      // Convert nsec to hex
                      final hexKey = AppKeyGenerator.nsecToHex(secretKey);

                      // Get the signer from the provider
                      final signer = ref.read(bip340SignerProvider(hexKey));
                      await signer.initialize();

                      // Sign the profile with the signer
                      final profile = await partialProfile.signWith(
                        signer,
                        withPubkey: secretKey,
                      );

                      // Save the profile to storage
                      await ref
                          .read(storageNotifierProvider.notifier)
                          .save({profile});

                      // Add the signer to the signers provider
                      await ref
                          .read(signersProvider.notifier)
                          .addNsecSigner(profile.pubkey, secretKey);

                      // Set as active profile
                      profile.setAsActive();

                      context.go('/');
                    } catch (e) {
                      print('Error processing nsec: $e');
                      rethrow;
                    }
                  },
                  onUSpinAgain: () {
                    context.pop();
                  },
                );
              },
            ),
          );
        },
      ),
      GoRoute(
        path: '/settings/existing-profile',
        pageBuilder: (context, state) {
          return AppSlideInModal(
            child: StartAddExistingKeyModal(),
          );
        },
      ),
      GoRoute(
        path: '/settings/history',
        pageBuilder: (context, state) {
          return AppSlideInModal(
            child: const SettingsHistoryModal(),
          );
        },
      ),
      GoRoute(
        path: '/settings/appearance',
        pageBuilder: (context, state) {
          return AppSlideInModal(
            child: const PreferencesModal(),
          );
        },
      ),
    ];
