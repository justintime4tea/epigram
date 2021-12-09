import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../generated/intl/messages_all.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static Future<AppLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return AppLocalizations(locale);
    });
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    );
  }

  String get appTitle => Intl.message(
        'Epigram',
        name: 'app-title',
        args: [],
        locale: locale.toString(),
      );

  String get Epigraph => Intl.message(
        'Epigraph',
        name: 'epigraph',
        args: [],
        locale: locale.toString(),
      );
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  Future<AppLocalizations> load(Locale locale) => Future(() => AppLocalizations(locale));

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) => locale.languageCode.toLowerCase().contains('en');
}
