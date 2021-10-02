import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubits/files_cubit.dart';
import 'package:news_application/cubits/post_cubit.dart';
import 'package:news_application/cubits/setting_states.dart';
import 'package:news_application/cubits/title_cubit.dart';
import 'package:news_application/shared/bloc_observer/bloc_observer.dart';
import 'package:news_application/shared/styles/theme.dart';

import 'cubits/setting_cubit.dart';
import 'modules/about_application/about_application.dart';
import 'modules/application_setting/application_setting.dart';
import 'modules/home/home.dart';
import 'modules/news_screen/news_details.dart';
import 'modules/post_editing/post_editing.dart';
import 'modules/title_editing/title_editing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  runApp(const InitialApp());
}

class InitialApp extends StatelessWidget {
  const InitialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) =>
          PostCubit()
            ..fetchPosts()),
          BlocProvider(create: (context) =>
          TitleCubit()
            ..fetch()),
          BlocProvider(create: (context) =>
          SettingCubit()
            ..initial(context)),
          BlocProvider(create: (context) =>
          FilesCubit()),
        ],
        child: const LauncherApp(),
      ),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'YE'),
      ],
      path: 'assets/translation',
      saveLocale: true,
    );
  }
}

class LauncherApp extends StatelessWidget {
  const LauncherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingCubit,SettingStates,ThemeMode?>(
      selector: (state)=>SettingCubit.get(context).themeMode(),
      builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          themeMode: SettingCubit.get(context).themeMode(),
          theme: theme,
          darkTheme: darkTheme,
          initialRoute: '/',
          routes: {
            '/': (ctx) => Home(),
            NewsDetails.newsDetailsScreen: (ctx) => const NewsDetails(),
            ApplicationSetting.applicationSetting: (ctx) =>
            const ApplicationSetting(),
            AboutApplication.aboutApplication: (ctx) => const AboutApplication(),
            PostEditing.postEditing: (ctx) => const PostEditing(),
             TitleEditing.titleEditing: (ctx) => const TitleEditing(),
          },
        ),);
  }
}
