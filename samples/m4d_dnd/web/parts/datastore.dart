library app.datastore;

import 'package:m4d_flux/m4d_flux.dart';
import 'package:m4d_core/m4d_ioc.dart' as ioc;
import 'package:m4d_dnd/services.dart' as dndService;

import 'package:md4d_dnd_sample/components/interfaces/stores.dart';
import 'package:md4d_dnd_sample/services.dart' as sampleService;

class DNDDataStore extends Dispatcher
    implements LanguageStore, NaturalLanguageStore, ProgrammingLanguageStore {

    final _languages = Set<Language>();

    final _naturalLanguages = Set<Language>();

    final _programmingLanguages = Set<Language>();

    DNDDataStore() : super(ActionBus()) {
        _languages.add(new Natural("English"));
        _languages.add(new Natural("German"));
        _languages.add(new Natural("Italian"));
        _languages.add(new Natural("French"));
        _languages.add(new Natural("Spanish"));

        _languages.add(new Programming("CPP"));
        _languages.add(new Programming("Dart"));
        _languages.add(new Programming("Java"));

        new Future(() => _bind());
    }

    @override
    Set<Language> get languages => _languages;

    @override
    Set<Language> get naturalLanguages => _naturalLanguages;

    @override
    Set<Language> get programmingLanguages => _programmingLanguages;

    // - private -------------------------------------------------------------------------------------

    void _bind() {
        ioc.IOCContainer().bind(dndService.DNDEvents).toEvents(() {
            return <String,Function>{
                "addToProgrammingLanguages" : (data) => _addToProgrammingLanguages(data as Language),
                "addToNaturalLanguages" : (data) => _addToNaturalLanguages(data as Language),
                "moveToTrash" : (data) => _moveToTrash(data as Language),
            };
        });
    }

    void _addToProgrammingLanguages(final Language language) {
        if(language.type == "programming") {
            if(!programmingLanguages.contains(language)) {
                programmingLanguages.add(language);
                emitChange();
            }
        }
    }

    void _addToNaturalLanguages(final Language language) {
        if(language.type == "natural") {
            if(!naturalLanguages.contains(language)) {
                naturalLanguages.add(language);
                emitChange();
            }
        }
    }

    void _moveToTrash(final Language language) {
        if(language.type == "programming" && programmingLanguages.contains(language)) {
            programmingLanguages.remove(language);
            emitChange();

        } else if(language.type == "natural" && naturalLanguages.contains(language)) {
            naturalLanguages.remove(language);
            emitChange();
        }
    }
}

class DNDDataStoreModule extends ioc.IOCModule {

    final _store = DNDDataStore();

    @override
    configure() {
        ioc.IOCContainer().bind(sampleService.LanguageStore).to(_store);
        ioc.IOCContainer().bind(sampleService.ProgrammingLanguageStore).to(_store);
        ioc.IOCContainer().bind(sampleService.NaturalLanguageStore).to(_store);
    }
}
