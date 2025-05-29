import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:models/models.dart';
import 'package:zaplab_design/zaplab_design.dart';
import 'dart:convert';

final zapstoreInitializationProvider = FutureProvider<bool>((ref) async {
  try {
    await ref.read(initializationProvider(
      StorageConfiguration(
        databasePath: '',
        relayGroups: {},
        defaultRelayGroup: '',
      ),
    ).future);

    Model.register(kind: 145, constructor: Mail.fromMap);
    Model.register(kind: 35000, constructor: Task.fromMap);
    Model.register(kind: 30617, constructor: Repository.fromMap);
    Model.register(kind: 32767, constructor: Job.fromMap);
    Model.register(kind: 9321, constructor: CashuZap.fromMap);
    Model.register(
        kind: 33333,
        constructor: Service.fromMap); // TODO: Change to right kind
    Model.register(kind: 11, constructor: ForumPost.fromMap);

    final dummyProfiles = <Profile>[];
    final dummyCommunities = <Community>[];
    final dummyMails = <Mail>[];
    final dummyTasks = <Task>[];
    final dummyJobs = <Job>[];
    final dummyCashuZaps = <CashuZap>[];
    final dummyServices = <Service>[];
    final dummyForumPosts = <ForumPost>[];
    final dummyApps = <App>[];
    final dummyAppPacks = <AppCurationSet>[];

    final jane = PartialProfile(
      name: 'Jane C.',
      pictureUrl:
          'https://cdn.satellite.earth/4b544d33c594e132b8ee1d278665632a4a3abfc30d249afb733b19fe1806522a.png',
      banner:
          'https://cdn.satellite.earth/4b544d33c594e132b8ee1d278665632a4a3abfc30d249afb733b19fe1806522a.png',
    ).dummySign(
        'e9434ae165ed91b286becfc2721ef1705d3537d051b387288898cc00d5c885be');

    final niel = PartialProfile(
      name: 'Niel Liesmons',
      pictureUrl:
          'https://cdn.satellite.earth/946822b1ea72fd3710806c07420d6f7e7d4a7646b2002e6cc969bcf1feaa1009.png',
      banner:
          'https://cdn.satellite.earth/848413776358f99a9a90ebc2bac711262a76243795c95615d805dba0fd23c571.png',
    ).dummySign(
        'a9434ee165ed01b286becfc2771ef1705d3537d051b387288898cc00d5c885be');

    final zapchat = PartialProfile(
      name: 'Zapchat',
      pictureUrl:
          'https://cdn.satellite.earth/307b087499ae5444de1033e62ac98db7261482c1531e741afad44a0f8f9871ee.png',
      banner:
          'https://cdn.satellite.earth/848413776358f99a9a90ebc2bac711262a76243795c95615d805dba0fd23c571.png',
    ).dummySign(
        '4239B36789abcdef0123456789abcdef0123456789abcdef0123456789abcdef');

    final proof = PartialProfile(
      name: 'Proof Of Reign',
      pictureUrl:
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fmedia.architecturaldigest.in%2Fwp-content%2Fuploads%2F2019%2F04%2FNorth-Rose-window-notre-dame-paris.jpg&f=1&nofb=1&ipt=b915d5a064b905567aa5fe9fbc8c38da207c4ba007316f5055e3e8cb1a009aa8&ipo=images',
    ).dummySign(
        'F954B79600b16b24a1bfb0519cfe4a5d1ad84959e3cce5d6d7a99d48660a1f78');

    final cypherchads = PartialProfile(
      name: 'Cypher Chads',
      pictureUrl:
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.imgflip.com%2F52wp8m.png',
    ).dummySign(
        'f683e87035f7ad4f44e0b98cfbd9537e16455a92cd38cefc4cb31db7557f5ef2');

    final franzap = PartialProfile(
      name: 'franzap',
      pictureUrl:
          'https://nostr.build/i/nostr.build_1732d9a6cd9614c6c4ac3b8f0ee4a8242e9da448e2aacb82e7681d9d0bc36568.jpg',
    ).dummySign(
        '7fa56f5d6962ab1e3cd424e758c3002b8665f7b0d8dcee9fe9e288d7751ac194');

    final verbiricha = PartialProfile(
      name: 'verbiricha',
      pictureUrl:
          'https://npub107jk7htfv243u0x5ynn43scq9wrxtaasmrwwa8lfu2ydwag6cx2quqncxg.blossom.band/3d84787d7284c879429eb0c8e6dcae0bf94cc50456d4046adf33cf040f8f5504.jpg',
    ).dummySign(
        '30B8C05d69645b1e3cd424e758c3002b8665f7b0d8dcee9fe9e288d7751ac195');

    final communikeys = PartialProfile(
      name: 'Communikeys',
      pictureUrl:
          'https://cdn.satellite.earth/7873557e975cf404d12c04cd3e4b4e0e252a34998edd04de0d24a4dc8c6bddbc.png',
    ).dummySign(
        '9fa56f5d69645b1e3cd424e758c3002b8665f7b0d8dcee9fe9e288d7751ac196');

    final nipsout = PartialProfile(
      name: 'Nips Out',
      pictureUrl:
          'https://cdn.satellite.earth/1895487e0fcd0db92babfa58501fd7cd319620c818e01d7bb941c4d465e4d685.png',
    ).dummySign(
        'afa56f5d69645b1e3cd424e758c3002b8665f7b0d8dcee9fe9e288d7751ac197');

    final metabolism = PartialProfile(
      name: 'Metabolism Go Up',
      pictureUrl:
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fsaraichinwag.com%2Fwp-content%2Fuploads%2F2023%2F12%2Fwhy-am-i-craving-oranges.jpeg',
      about:
          'We discuss and research ways to improve your metabolism. We are not doctors, but we are passionate about health and fitness.',
      banner:
          'https://cdn.satellite.earth/5b8e0002026a4bd0804d0470295dfd209ef9c461957a85f62e00e2923ff18bf1.png',
    ).dummySign(
        '1203456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef');

    final hzrd149 = PartialProfile(
      name: 'hzrd149',
      pictureUrl:
          'https://cdn.hzrd149.com/5ed3fe5df09a74e8c126831eac999364f9eb7624e2b86d521521b8021de20bdc.png',
    ).dummySign(
        '266815e0c9210dfa324c6cba3573b14bee49da4209a9456f9484e5106cd408a5');

    final thegang = PartialProfile(
      name: 'The Gang',
      pictureUrl:
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimg.fixthephoto.com%2Fblog%2Fimages%2Fgallery%2Fnews_preview_mob_image__preview_404.jpg',
    ).dummySign(
        '266813e0c9210dfa324c6cba3573b14bee49da4209a9456f9484e5106cd408a5');

    final zapcloud = PartialProfile(
      name: 'Zapcloud',
      pictureUrl:
          'https://cdn.satellite.earth/8225a8244d1d65157adb58b1f7d16424cde1ea3f1b018a933d777ecec0959899.png',
    ).dummySign(
        '266813e0cff10dfa324c6cba3573b14bee49da4209a9456f9484e5106cd408a5');

    dummyProfiles.addAll({
      jane,
      niel,
      zapchat,
      proof,
      cypherchads,
      franzap,
      verbiricha,
      communikeys,
      nipsout,
      metabolism,
      hzrd149,
      thegang,
      zapcloud,
    });

    // SignedInProfile for testing, to avoid signing in all the time

    // Add profiles to storage
    await ref
        .read(storageNotifierProvider.notifier)
        .save(dummyProfiles.toSet());

    // Set current profile and add to signed in profiles
    if (dummyProfiles.isNotEmpty) {
      final signer = DummySigner(ref, pubkey: dummyProfiles.first.pubkey);
      // TODO: Modify the active flag here to show Jane logged in, or no-one
      await signer.initialize(active: false);
    }

    // Create community after profiles are saved and indexed
    final zapchatCommunity = PartialCommunity(
      name: 'Zapchat',
      relayUrls: {'wss://relay.damus.io'},
      description:
          'Where Zapchat builders and users meet. A place to discuss, collaborate and  publish relevant content, including the app itself.',
      contentSections: {
        CommunityContentSection(
          content: 'Chat',
          kinds: {9},
          feeInSats: 100,
        ),
        CommunityContentSection(
          content: 'Threads',
          kinds: {1},
        ),
        CommunityContentSection(
          content: 'Articles',
          kinds: {30023},
        ),
        CommunityContentSection(
          content: 'Jobs',
          kinds: {32767},
        ),
        CommunityContentSection(
          content: 'Services',
          kinds: {33333},
        ),
        CommunityContentSection(
          content: 'Apps',
          kinds: {32267},
        ),
        CommunityContentSection(
          content: 'Books',
          kinds: {30040},
        ),
        CommunityContentSection(
          content: 'Docs',
          kinds: {30040},
        ),
        CommunityContentSection(
          content: 'Albums',
          kinds: {20},
        ),
        CommunityContentSection(
          content: 'Tasks',
          kinds: {30123},
        ),
      },
    ).dummySign(zapchat.pubkey);
    final cypherchadsCommunity = PartialCommunity(
      name: 'Cypher Chads',
      relayUrls: {'wss://relay.damus.io'},
      description: 'A community for Cypher Chads',
      contentSections: {
        CommunityContentSection(
          content: 'Chat',
          kinds: {9},
          feeInSats: 100,
        ),
        CommunityContentSection(
          content: 'Threads',
          kinds: {1},
        ),
        CommunityContentSection(
          content: 'Articles',
          kinds: {30023},
        ),
        CommunityContentSection(
          content: 'Jobs',
          kinds: {32767},
        ),
        CommunityContentSection(
          content: 'Services',
          kinds: {33333},
        ),
        CommunityContentSection(
          content: 'Apps',
          kinds: {32267},
        ),
        CommunityContentSection(
          content: 'Books',
          kinds: {30040},
        ),
        CommunityContentSection(
          content: 'Docs',
          kinds: {30040},
        ),
        CommunityContentSection(
          content: 'Albums',
          kinds: {20},
        ),
        CommunityContentSection(
          content: 'Tasks',
          kinds: {30123},
        ),
      },
    ).dummySign(cypherchads.pubkey);
    final communikeysCommunity = PartialCommunity(
      name: 'Communikeys',
      relayUrls: {'wss://relay.damus.io'},
      description: 'A community for Communikeys',
      contentSections: {
        CommunityContentSection(
          content: 'Chat',
          kinds: {9},
          feeInSats: 100,
        ),
        CommunityContentSection(
          content: 'Threads',
          kinds: {1},
        ),
      },
    ).dummySign(communikeys.pubkey);
    final nipsoutCommunity = PartialCommunity(
      name: 'Nips Out',
      relayUrls: {'wss://relay.damus.io'},
      description: 'A community for Nips Out',
      contentSections: {
        CommunityContentSection(
          content: 'Chat',
          kinds: {9},
          feeInSats: 100,
        ),
        CommunityContentSection(
          content: 'Wikis',
          kinds: {30818},
        ),
      },
    ).dummySign(nipsout.pubkey);
    final metabolismCommunity = PartialCommunity(
      name: 'Metabolism Go Up',
      relayUrls: {'wss://relay.damus.io'},
      description:
          'We discuss research and fund lab work around optimizing our human metabolism. We are not doctors or staet funded, on purpose. We are just a group of people who want to improve our health and fitness.',
      contentSections: {
        CommunityContentSection(
          content: 'Chat',
          kinds: {9},
          feeInSats: 100,
        ),
        CommunityContentSection(
          content: 'Threads',
          kinds: {1},
        ),
        CommunityContentSection(
          content: 'Wikis',
          kinds: {30818},
        ),
      },
    ).dummySign(metabolism.pubkey);
    dummyCommunities.addAll([
      zapchatCommunity,
      cypherchadsCommunity,
      communikeysCommunity,
      nipsoutCommunity,
      metabolismCommunity,
    ]);

    dummyMails.addAll([
      PartialMail(
        'Marriage Invitation',
        'Chicos & Chicas, \nMe and nostr:npub1blablabla are getting married and would love for you to be there. \nPlease let me know if you can make it. \n\nBest regards, \n\n**Fran**',
        recipientPubkeys: {
          'e9434ae165ed91b286becfc2721ef1705d3537d051b387288898cc00d5c885be', // jane
          '4239B36789abcdef0123456789abcdef0123456789abcdef0123456789abcdef', // zapchat
          '266813e0cff10dfa324c6cba3573b14bee49da4209a9456f9484e5106cd408a5', // zapcloud
          'f683e87035f7ad4f44e0b98cfbd9537e16455a92cd38cefc4cb31db7557f5ef2', // cypherchads
          '7fa56f5d6962ab1e3cd424e758c3002b8665f7b0d8dcee9fe9e288d7751ac194', // franzap
          '30B8C05d69645b1e3cd424e758c3002b8665f7b0d8dcee9fe9e288d7751ac195', // verbiricha
          '9fa56f5d69645b1e3cd424e758c3002b8665f7b0d8dcee9fe9e288d7751ac196', // communikeys
          'afa56f5d69645b1e3cd424e758c3002b8665f7b0d8dcee9fe9e288d7751ac197', // nipsout
          '1203456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef', // metabolism
          '266815e0c9210dfa324c6cba3573b14bee49da4209a9456f9484e5106cd408a5', // hzrd149
          '266813e0c9210dfa324c6cba3573b14bee49da4209a9456f9484e5106cd408a5', // thegang
          '266813e0cff10dfa324c6cba357b14bee49da4209a9456f9484e5106cd408a5', // zapcloud
        },
      ).dummySign(franzap.pubkey),
      (PartialMail(
        'Re: Job Listing - Branding & Corprate Identity for Zapcloud',
        'Hey Zapcloud Team, \n\nI think I might be a good fit for this job. \n\nI have a lot of experience in branding and corporate identity, in the Nostr space specifically. \n\nHere\'s my [Portfolio](https://zapchat.com/portfolio) \n\nBest regards, \n\n**Niel**',
        recipientPubkeys: {
          'e9434ae165ed91b286becfc2721ef1705d3537d051b387288898cc00d5c885be', // jane
          '266813e0cff10dfa324c6cba3573b14bee49da4209a9456f9484e5106cd408a5', // zapcloud
        },
      )).dummySign(niel.pubkey),
      (PartialMail(
        'Top-Up Time!',
        'Hey Jane! \n\n## Reminder \nYour Zapcloud budget is running low. \n\n[Top Up Here](https://zapchat.com/top-up) to avoid service disruption. \n\nList test: \n- Item 1 \n- Item 2 \n- Item 3 \n\nBest regards, \n\n**Zapcloud**',
        recipientPubkeys: {
          'e9434ae165ed91b286becfc2721ef1705d3537d051b387288898cc00d5c885be'
        },
      )).dummySign(zapcloud.pubkey),
    ]);

    dummyTasks.addAll([
      (PartialTask(
        'Task Title',
        'Task Content',
        status: 'open',
        slug: Utils.generateRandomHex64(),
        publishedAt: DateTime.now().subtract(const Duration(minutes: 10)),
      )).dummySign(franzap.pubkey),
      (PartialTask(
        'Task Title',
        'Task Content',
        status: 'inProgress',
        slug: Utils.generateRandomHex64(),
        publishedAt: DateTime.now().subtract(const Duration(minutes: 10)),
      )).dummySign(zapcloud.pubkey),
      (PartialTask(
        'Task Title',
        'Task Content',
        status: 'inReview',
        slug: Utils.generateRandomHex64(),
        publishedAt: DateTime.now().subtract(const Duration(minutes: 10)),
      )).dummySign(niel.pubkey),
      (PartialTask(
        'Task Title',
        'Task Content',
        status: 'closed',
        slug: Utils.generateRandomHex64(),
        publishedAt: DateTime.now().subtract(const Duration(minutes: 10)),
      )).dummySign(zapchat.pubkey),
    ]);

    dummyJobs.addAll([
      (PartialJob(
        'Logo & Branding Design',
        '''Zapcloud Brand Design \n## Project Overview\nZapcloud is an **all-in-one** hosting solution for Nostr and we need branding and bla bla bla.''',
        labels: {
          'Branding',
          'Design',
          'Logo',
          'Marketing',
        },
        location: 'Remote',
        employment: 'Task Based',
      )).dummySign(zapcloud.pubkey),
      (PartialJob(
        'Community Manager',
        '''Zapchat Community Manager \n## Project Overview\nZapchat is a Nostr community for the Zapchat project and we need a community manager to help us grow the community.''',
        labels: {
          'Community',
          'Moderation',
          'Content',
        },
        location: 'Remote',
        employment: 'Full-Time',
      )).dummySign(metabolism.pubkey),
      (PartialJob(
        'Food Forest Design',
        '''Food Forest Design \n## Project Overview\nFood Forest is a permaculture project in Winsconsin, USA and we need a design to help us grow plants and trees.''',
        labels: {
          'Permaculture',
          'Gardening',
          'Design',
        },
        location: 'Winsconsin, USA',
        employment: 'Task Based',
      )).dummySign(jane.pubkey),
    ]);

    // Add dummy zap requests
    dummyCashuZaps.addAll([
      (PartialCashuZap(
        'Thanks for the great content!',
        proof: jsonEncode({'amount': 1000}),
        url: 'https://cashu.mint.example.com',
        zappedEventId: '1234567890abcdef',
        recipientPubkey: niel.pubkey,
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      )).dummySign(niel.pubkey),
      (PartialCashuZap(
        "nostr:nevent1234567890abcdef No, but here's a zap",
        proof: jsonEncode({'amount': 123}),
        url: 'https://cashu.mint.example.com',
        zappedEventId: '1234567890abcdef',
        recipientPubkey: franzap.pubkey,
        createdAt: DateTime.now().subtract(const Duration(minutes: 3)),
      )).dummySign(verbiricha.pubkey),
    ]);

    dummyServices.addAll([
      (PartialService(
        'Nostr App Design',
        'Pixel-perfect designs and front end builds for your Nostr app.',
        imageUrl:
            'https://cdn.satellite.earth/848413776358f99a9a90ebc2bac711262a76243795c95615d805dba0fd23c571.png',
      )).dummySign(niel.pubkey),
      (PartialService(
        'Flutter App Development',
        'Custom Flutter app development for your business.',
        imageUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.AbkkytIRIUhSlg1oLslz8QHaDt%26cb%3Diwp2%26pid%3DApi&f=1&ipt=8e7f7dd1d5712c198aae5004d828703e59d9c85654caf0c7f4eaac548ad55c3a&ipo=images',
      )).dummySign(franzap.pubkey),
    ]);

    dummyForumPosts.addAll([
      (PartialForumPost(
        'Forum Post Title',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      )).dummySign(niel.pubkey),
      (PartialForumPost(
        'Forum Post Title',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      )).dummySign(franzap.pubkey),
      (PartialForumPost(
        'Forum Post Title',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      )).dummySign(zapchat.pubkey),
    ]);

    dummyApps.addAll([
      (PartialApp()
            ..event.content = 'All-in-one hosting solution for Nostr.'
            ..event.addTagValue('name', 'Zapcloud')
            ..event.addTagValue('url', 'https://zapcloud.com')
            ..event.addTagValue(
                'repository', 'https://github.com/zapcloud/zapcloud')
            ..event.addTagValue('license', 'MIT')
            ..event.addTagValue('f', 'web')
            ..event.addTagValue('f', 'mobile')
            ..event.addTagValue('icon',
                'https://cdn.satellite.earth/413ea918cfc60bdab6a205fd7cf65bc67067a63de3c4407eb23b18ae3479f0c5.png')
            ..event.addTagValue('image', 'https://zapchat.com/image.png')
            ..event.addTagValue('d', Utils.generateRandomHex64()))
          .dummySign(niel.pubkey),
      (PartialApp()
            ..event.content = 'Chat & Other Stuff'
            ..event.addTagValue('name', 'Zapchat')
            ..event.addTagValue('url', 'https://zapchat.com')
            ..event
                .addTagValue('repository', 'https://github.com/zapchat/zapchat')
            ..event.addTagValue('license', 'MIT')
            ..event.addTagValue('f', 'web')
            ..event.addTagValue('f', 'mobile')
            ..event.addTagValue('icon',
                'https://cdn.satellite.earth/307b087499ae5444de1033e62ac98db7261482c1531e741afad44a0f8f9871ee.png')
            ..event.addTagValue('image', 'https://zapcloud.com/image.png')
            ..event.addTagValue('d', Utils.generateRandomHex64()))
          .dummySign(niel.pubkey),
      (PartialApp()
            ..event.content = 'Vibe with your tribe'
            ..event.addTagValue('name', 'Chachi')
            ..event.addTagValue('url', 'https://chachi.chat')
            ..event.addTagValue(
                'repository', 'https://github.com/chachi-chat/chachi')
            ..event.addTagValue('license', 'MIT')
            ..event.addTagValue('f', 'web')
            ..event.addTagValue('f', 'mobile')
            ..event.addTagValue('icon', 'https://chachi.chat/favicon.png')
            ..event.addTagValue('image', 'https://zapstore.com/image.png')
            ..event.addTagValue('d', Utils.generateRandomHex64()))
          .dummySign(niel.pubkey),
      (PartialApp()
            ..event.content = 'Live stream, live the dream'
            ..event.addTagValue('name', 'Zapstream')
            ..event.addTagValue('url', 'https://zapchat.com/pro')
            ..event.addTagValue(
                'repository', 'https://github.com/zapchat/zapchat-pro')
            ..event.addTagValue('license', 'MIT')
            ..event.addTagValue('f', 'web')
            ..event.addTagValue('f', 'mobile')
            ..event.addTagValue('icon',
                'https://primaldata.s3.us-east-005.backblazeb2.com/cache/9/ad/76/9ad767a6999897596982375ca18e4e82d13cc0d2949acb8c39a16584f2ccb11e.png')
            ..event.addTagValue('image', 'https://zapchat.com/pro-image.png')
            ..event.addTagValue('d', Utils.generateRandomHex64()))
          .dummySign(niel.pubkey),
      (PartialApp()
            ..event.content = 'Apps. Released.'
            ..event.addTagValue('name', 'Zapstore')
            ..event.addTagValue('url', 'https://zapstore.com')
            ..event
                .addTagValue('repository', 'https://github.com/zapmail/zapmail')
            ..event.addTagValue('license', 'MIT')
            ..event.addTagValue('f', 'web')
            ..event.addTagValue('f', 'mobile')
            ..event.addTagValue('icon',
                'https://primaldata.s3.us-east-005.backblazeb2.com/cache/8/a9/20/8a920dc90674b6a1cb333a95b70bf0b5a204b3b98a8a41af5adb455d777074f3.jpg')
            ..event.addTagValue('image', 'https://zapmail.com/image.png')
            ..event.addTagValue('d', Utils.generateRandomHex64()))
          .dummySign(niel.pubkey),
      (PartialApp()
            ..event.content = 'Secure Chat built on Nostr.'
            ..event.addTagValue('name', '0xchat')
            ..event.addTagValue('url', 'https://zapcloud.com/pro')
            ..event.addTagValue(
                'repository', 'https://github.com/zapcloud/zapcloud-pro')
            ..event.addTagValue('license', 'MIT')
            ..event.addTagValue('f', 'web')
            ..event.addTagValue('f', 'mobile')
            ..event.addTagValue('icon',
                'https://primaldata.s3.us-east-005.backblazeb2.com/cache/e/75/8f/e758f6eb698b314e4ffcb2cec79b17c4152bb93fcc205b2dd0a7ef1ac170a9e7.jpg')
            ..event.addTagValue('image', 'https://zapcloud.com/pro-image.png')
            ..event.addTagValue('d', Utils.generateRandomHex64()))
          .dummySign(niel.pubkey),
    ]);

    dummyAppPacks.addAll([
      (PartialAppCurationSet()
            ..event.content = 'Essential apps for getting started with Nostr'
            ..event.addTagValue('name', 'Nostr Essentials')
            ..event.addTagValue('url', 'https://zapstore.com/packs/essentials')
            ..event.addTagValue('icon',
                'https://cdn.satellite.earth/307b087499ae5444de1033e62ac98db7261482c1531e741afad44a0f8f9871ee.png')
            ..event.addTagValue(
                'a', '32267:${niel.pubkey}:${dummyApps[0].event.id}')
            ..event.addTagValue(
                'a', '32267:${niel.pubkey}:${dummyApps[1].event.id}')
            ..event.addTagValue(
                'a', '32267:${niel.pubkey}:${dummyApps[2].event.id}')
            ..event.addTagValue('d', Utils.generateRandomHex64()))
          .dummySign(niel.pubkey),
      (PartialAppCurationSet()
            ..event.content = 'Best apps for content creators on Nostr'
            ..event.addTagValue('name', 'Creator Tools')
            ..event.addTagValue('url', 'https://zapstore.com/packs/creators')
            ..event.addTagValue('icon',
                'https://cdn.satellite.earth/413ea918cfc60bdab6a205fd7cf65bc67067a63de3c4407eb23b18ae3479f0c5.png')
            ..event.addTagValue(
                'a', '32267:${niel.pubkey}:${dummyApps[3].event.id}')
            ..event.addTagValue(
                'a', '32267:${niel.pubkey}:${dummyApps[4].event.id}')
            ..event.addTagValue(
                'a', '32267:${niel.pubkey}:${dummyApps[5].event.id}')
            ..event.addTagValue('d', Utils.generateRandomHex64()))
          .dummySign(niel.pubkey),
      (PartialAppCurationSet()
            ..event.content = 'Privacy-focused apps for secure communication'
            ..event.addTagValue('name', 'Privacy Pack')
            ..event.addTagValue('url', 'https://zapstore.com/packs/privacy')
            ..event.addTagValue('icon',
                'https://primaldata.s3.us-east-005.backblazeb2.com/cache/e/75/8f/e758f6eb698b314e4ffcb2cec79b17c4152bb93fcc205b2dd0a7ef1ac170a9e7.jpg')
            ..event.addTagValue(
                'a', '32267:${niel.pubkey}:${dummyApps[0].event.id}')
            ..event.addTagValue(
                'a', '32267:${niel.pubkey}:${dummyApps[3].event.id}')
            ..event.addTagValue(
                'a', '32267:${niel.pubkey}:${dummyApps[5].event.id}')
            ..event.addTagValue('d', Utils.generateRandomHex64()))
          .dummySign(niel.pubkey),
      (PartialAppCurationSet()
            ..event.content = 'Tools for developers building on Nostr'
            ..event.addTagValue('name', 'Developer Kit')
            ..event.addTagValue('url', 'https://zapstore.com/packs/dev')
            ..event.addTagValue('icon',
                'https://primaldata.s3.us-east-005.backblazeb2.com/cache/9/ad/76/9ad767a6999897596982375ca18e4e82d13cc0d2949acb8c39a16584f2ccb11e.png')
            ..event.addTagValue(
                'a', '32267:${niel.pubkey}:${dummyApps[1].event.id}')
            ..event.addTagValue(
                'a', '32267:${niel.pubkey}:${dummyApps[2].event.id}')
            ..event.addTagValue(
                'a', '32267:${niel.pubkey}:${dummyApps[4].event.id}')
            ..event.addTagValue('d', Utils.generateRandomHex64()))
          .dummySign(niel.pubkey),
    ]);

    // Save all data
    await ref.read(storageNotifierProvider.notifier).save(Set.from([
          ...dummyProfiles,
          ...dummyCommunities,
          ...dummyMails,
          ...dummyTasks,
          ...dummyJobs,
          ...dummyCashuZaps,
          ...dummyServices,
          ...dummyForumPosts,
          ...dummyApps,
          ...dummyAppPacks,
        ]));

    return true;
  } catch (e, stackTrace) {
    print('Error during initialization: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
});
