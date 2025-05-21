import 'package:zaplab_design/zaplab_design.dart';
import 'package:models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/signer.dart';
import '../providers/resolvers.dart';
import '../providers/search.dart';

class ReplyModal extends ConsumerStatefulWidget {
  final Model model;

  const ReplyModal({
    super.key,
    required this.model,
  });

  @override
  ConsumerState<ReplyModal> createState() => _ReplyModalState();
}

class _ReplyModalState extends ConsumerState<ReplyModal> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late PartialChatMessage _partialMessage;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _partialMessage = PartialChatMessage('');

    // Request focus after modal is built
    Future.microtask(() => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onContentChanged(String content) {
    print('Content changed to: $content');
    setState(() {
      _partialMessage = PartialChatMessage(content);
    });
    // Update the controller's text
    if (_controller.text != content) {
      _controller.text = content;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: content.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final signedInProfile = ref.watch(Profile.signedInProfileProvider);
    final signer = signedInProfile != null
        ? ref.read(signersProvider.notifier).getSigner(signedInProfile.pubkey)
        : null;

    return AppInputModal(
      children: [
        SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              if (widget.model is! ChatMessage)
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppProfilePic.s40(widget.model.author.value),
                        const AppGap.s12(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AppEmojiImage(
                                    emojiUrl:
                                        'assets/emoji/${getModelContentType(widget.model)}.png',
                                    emojiName:
                                        getModelContentType(widget.model),
                                    size: 16,
                                  ),
                                  const AppGap.s10(),
                                  Expanded(
                                    child: AppCompactTextRenderer(
                                      content:
                                          getModelDisplayText(widget.model),
                                      onResolveEvent: ref
                                          .read(resolversProvider)
                                          .eventResolver,
                                      onResolveProfile: ref
                                          .read(resolversProvider)
                                          .profileResolver,
                                      onResolveEmoji: ref
                                          .read(resolversProvider)
                                          .emojiResolver,
                                      isWhite: true,
                                      isMedium: true,
                                    ),
                                  ),
                                ],
                              ),
                              const AppGap.s2(),
                              AppText.reg12(
                                widget.model.author.value?.name ??
                                    formatNpub(
                                        widget.model.author.value?.pubkey ??
                                            ''),
                                color: theme.colors.white66,
                              ),
                            ],
                          ),
                        ),
                        const AppGap.s8(),
                      ],
                    ),
                    Row(
                      children: [
                        AppContainer(
                          width: theme.sizes.s38,
                          child: Center(
                            child: AppContainer(
                              decoration:
                                  BoxDecoration(color: theme.colors.white33),
                              width: AppLineThicknessData.normal().medium,
                              height: theme.sizes.s16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              AppShortTextField(
                controller: _controller,
                focusNode: _focusNode,
                placeholder: [
                  AppText.reg16(
                    'Your Reply',
                    color: theme.colors.white33,
                  ),
                ],
                quotedChatMessage: widget.model is ChatMessage
                    ? (widget.model as ChatMessage)
                    : null,
                onSearchProfiles: ref.read(searchProvider).profileSearch,
                onSearchEmojis: ref.read(searchProvider).emojiSearch,
                onResolveEvent: ref.read(resolversProvider).eventResolver,
                onResolveProfile: ref.read(resolversProvider).profileResolver,
                onResolveEmoji: ref.read(resolversProvider).emojiResolver,
                onCameraTap: () {}, // TODO: Implement camera tap
                onEmojiTap: () {}, // TODO: Implement emoji tap
                onGifTap: () {}, // TODO: Implement gif tap
                onAddTap: () {}, // TODO: Implement add tap
                onSendTap: () async {
                  print('Send button tapped');
                  final text = _controller.text;
                  print('Text content: $text');
                  print('Signed in profile: $signedInProfile');
                  print('Signer: $signer');

                  if (text.isNotEmpty &&
                      signedInProfile != null &&
                      signer != null) {
                    print('Attempting to sign message');
                    final message = PartialChatMessage(text);
                    final signedMessage = await message.signWith(
                      signer,
                      withPubkey: signedInProfile.pubkey,
                    );
                    print('Message signed successfully');
                    // TODO: Actually publish the message
                    print('Would publish message: $signedMessage');
                  } else {
                    print('Conditions not met:');
                    print('- Text empty: ${text.isEmpty}');
                    print('- No profile: ${signedInProfile == null}');
                    print('- No signer: ${signer == null}');
                  }
                },
                onChevronTap: () {}, // TODO: Implement chevron tap
                onChanged: _onContentChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
