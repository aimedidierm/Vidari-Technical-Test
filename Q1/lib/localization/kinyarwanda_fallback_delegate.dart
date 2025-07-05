import 'package:flutter/material.dart';

class KinyarwandaFallbackDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const KinyarwandaFallbackDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'rw';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return const DefaultMaterialLocalizations();
  }

  @override
  bool shouldReload(KinyarwandaFallbackDelegate old) => false;
}
