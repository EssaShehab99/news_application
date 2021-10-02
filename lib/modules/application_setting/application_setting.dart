import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubits/setting_cubit.dart';
import 'package:news_application/cubits/setting_states.dart';
import 'package:news_application/layout/main_layout/main_layout.dart';
import 'package:news_application/shared/components/components.dart';
import 'package:news_application/shared/components/constants.dart';

class ApplicationSetting extends StatelessWidget {
  const ApplicationSetting({Key? key}) : super(key: key);
  static String applicationSetting = "/applicationSetting";

  @override
  Widget build(BuildContext context) {
    SettingCubit value = SettingCubit.get(context);
    return defaultScaffold(
        title: "setting".tr().toString(),
        body: BlocConsumer<SettingCubit, SettingStates>(
          listener: (context, state) {},
          builder: (context, state) => SingleChildScrollView(
            padding: const EdgeInsets.all(padding),
            child: Padding(
              padding: const EdgeInsets.all(padding),
              child: Column(
                children: [
                  defaultGroupListTile(
                      groupTitle: "data-using".tr().toString(),
                      groupElements: [
                        Builder(
                          builder: (context) => CheckboxListTile(
                            title: Text(
                              "photos".tr().toString(),
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            subtitle: Text(
                              "load-photos-on-the-home-screen".tr().toString(),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            value: value.autoDownloadMedia,
                            onChanged: (onChangedValue) {
                              value.setAutoDownloadMedia(onChangedValue!);
                            },
                          ),
                        ),
                      ]),
                  defaultGroupListTile(
                      groupTitle: "display".tr().toString(),
                      groupElements: [
                        defaultListTile(
                            title: "theme".tr().toString(),
                            subtitle: "${value.themeModeName()}",
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => StatefulBuilder(
                                        builder: (context, setState) =>
                                            AlertDialog(
                                                backgroundColor: Theme.of(context).canvasColor,
                                                title: Center(
                                                  child: Text(
                                                    "theme".tr().toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3,
                                                  ),
                                                ),
                                                content: SizedBox(
                                                  height: 180,
                                                  child: Column(
                                                    children: value
                                                        .themeItems()
                                                        .map((themeItem) =>
                                                            RadioListTile<int>(
                                                              controlAffinity:
                                                                  ListTileControlAffinity
                                                                      .leading,
                                                              value: value
                                                                  .themeItems()
                                                                  .indexOf(
                                                                      themeItem),
                                                              groupValue: value
                                                                  .themeModeValue,
                                                              onChanged: (val) {
                                                                value
                                                                    .setThemeMode(
                                                                        val!);
                                                              },
                                                              title: Text(
                                                                themeItem,
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline2,
                                                              ),
                                                            ))
                                                        .toList(),
                                                  ),
                                                )),
                                      ));
                            })
                      ]),
                  defaultGroupListTile(
                      groupTitle: "language".tr().toString(),
                      groupElements: [
                        defaultListTile(
                          title: "language".tr().toString(),
                          subtitle: "${value.languageName()}",
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => StatefulBuilder(
                                      builder: (context, setState) =>
                                          AlertDialog(
                                              backgroundColor:
                                                  Theme.of(context).canvasColor,
                                              title: Center(
                                                child: Text(
                                                  "language".tr().toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline3,
                                                ),
                                              ),
                                              content: SizedBox(
                                                height: 120,
                                                child: Column(
                                                  children: value
                                                      .languages()
                                                      .map((language) =>
                                                          RadioListTile<int>(
                                                            controlAffinity:
                                                                ListTileControlAffinity
                                                                    .leading,
                                                            value: value
                                                                .languages()
                                                                .indexOf(
                                                                    language),
                                                            groupValue: value
                                                                .languageValue,
                                                            onChanged: (val) {
                                                              setState(() {
                                                                value.setLanguage(
                                                                    val!,
                                                                    context);
                                                              });
                                                            },
                                                            title: Text(
                                                              language,
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline2,
                                                            ),
                                                          ))
                                                      .toList(),
                                                ),
                                              )),
                                    ));
                          },
                        )
                      ]),
                ],
              ),
            ),
          ),
        ),
        context: context);
  }
}
