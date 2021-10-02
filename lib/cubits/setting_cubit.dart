import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubits/setting_states.dart';
import 'package:news_application/shared/components/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingCubit extends Cubit<SettingStates> {
  SettingCubit() : super(SettingInitialState());

  static SettingCubit get(context) => BlocProvider.of(context);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int themeModeValue=0;
  int languageValue=0;
  bool autoDownloadMedia=false;



  Future<void> initial(BuildContext context) async {
    getThemeMode();
    getLanguage(context);
    getDownloadMedia();
  }

  Future<void> setThemeMode(themeModeValue) async {
    setPreference('theme-mode', themeModeValue);
     getThemeMode();
  }
  Future<void> getThemeMode() async {
    themeModeValue = await getPreference('theme-mode')??0;
    emit(SettingThemeState());
  }
  ThemeMode? themeMode() {
    ThemeMode themeMode=ThemeMode.system;
    if (themeModeValue==1) {
      themeMode=ThemeMode.light;
    }else if (themeModeValue==2) {
      themeMode=ThemeMode.dark;
    } else {
      themeMode=ThemeMode.system;
    }
    return themeMode;
  }
  String themeModeName(){
    if(themeModeValue==0)return themeItems()[0];
    else if(themeModeValue==1)return themeItems()[1];
    else return themeItems()[2];
  }
  List<String> themeItems(){ return[
    "auto".tr().toString(),
    "light".tr().toString(),
    "dark".tr().toString()
  ];}

  Future<void> setLanguage(int languageValue,BuildContext context) async {
    setPreference("language-value", languageValue);
    getLanguage(context);
  }
  Future<void> getLanguage(BuildContext context) async {
    languageValue =await getPreference('language-value') ?? 0;
    if (languageValue == 0) {
      await EasyLocalization.of(context)?.setLocale(Locale('en','US'));
    } else if(languageValue==1){
      await EasyLocalization.of(context)?.setLocale(Locale('ar','YE'));
    }
    emit(SettingLanguageState());
  }
  String languageName(){
    return languages()[languageValue];
  }
  List<String> languages() {return[
    "english".tr().toString(),
    "arabic".tr().toString(),
  ];}



  Future<void> setAutoDownloadMedia(bool autoDownloadMediaValue) async {
    setPreference("autoDownloadMediaValue", autoDownloadMediaValue);
    getDownloadMedia();
  }
  Future<void> getDownloadMedia() async {
    autoDownloadMedia = await getPreference('autoDownloadMediaValue') ?? false;
    emit(SettingDownloadMediaState());
  }





  Future<dynamic> getPreference(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.get(key);
  }

  Future<dynamic> setPreference(key, value) async {
    final SharedPreferences prefs = await _prefs;
    if (value is String) return prefs.setString(key, value);
    if (value is int) return prefs.setInt(key, value);
    if (value is bool) return prefs.setBool(key, value);
    if (value is double) return prefs.setDouble(key, value);
    if(value == null) prefs.remove(key);
  }
}
