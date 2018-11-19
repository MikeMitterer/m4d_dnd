library m4d_dnd_sample.datastore;

import 'package:m4d_flux/m4d_flux.dart';

import 'components/interfaces/stores.dart';

class DNDDataStore extends Dispatcher
    implements LanguageStore, NaturalLanguageStore, ProgrammingLanguageStore {

    final _languages = Set<Language>();

    final _naturalLanguages  = Set<Language>();

    final _programmingLanguages  = Set<Language>();

    DNDDataStore() : super(ActionBus()) {
        _languages.add(new Natural("English"));
        _languages.add(new Natural("German"));
        _languages.add(new Natural("Italian"));
        _languages.add(new Natural("French"));
        _languages.add(new Natural("Spanish"));

        _languages.add(new Programming("CPP"));
        _languages.add(new Programming("Dart"));
        _languages.add(new Programming("Java"));
    }

  @override
  Set<Language> get languages => _languages;

  @override
  Set<Language> get naturalLanguages => _naturalLanguages;

  @override
  Set<Language> get programmingLanguages => _programmingLanguages;
}
