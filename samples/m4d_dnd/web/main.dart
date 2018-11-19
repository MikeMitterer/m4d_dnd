import 'dart:html' as dom;
import 'package:intl/intl.dart';

import 'package:console_log_handler/console_log_handler.dart';

import 'package:m4d_core/m4d_ioc.dart' as ioc;
import 'package:m4d_core/services.dart' as coreService;

import 'package:m4d_dnd/m4d_dnd.dart';
import 'package:m4d_dnd/services.dart' as dndService;

import "package:m4d_components/m4d_components.dart";

import 'package:md4d_dnd_sample/components/interfaces/stores.dart';
import 'package:md4d_dnd_sample/components.dart';
import 'package:md4d_dnd_sample/m4d_dnd_sample.dart';

class Application extends MaterialApplication {
    // final _logger = new Logger('dnd.Application');

//    final languages = new ObservableList<Language>();
//    final natural = new ObservableList<Language>();
//    final programming = new ObservableList<Language>();

//    Application() {
//        languages.add(new Natural("English"));
//        languages.add(new Natural("German"));
//        languages.add(new Natural("Italian"));
//        languages.add(new Natural("French"));
//        languages.add(new Natural("Spanish"));
//
//        languages.add(new Programming("CPP"));
//        languages.add(new Programming("Dart"));
//        languages.add(new Programming("Java"));
//    }

    @override
    void run() {
        new Future(() {
            ioc.IOCContainer().bind(dndService.DNDEvents).toEvents(() {
                return <String,Function>{
                    "addToProgrammingLanguages" : (data) => _addToProgrammingLanguages(data as Language),
                    "addToNaturalLanguages" : (data) => _addToNaturalLanguages(data as Language),
                    "moveToTrash" : (data) => _moveToTrash(data as Language),
                };
            });
        });
    }

    void _addToProgrammingLanguages(final Language language) {
        if(language.type == "programming") {
//            if(!programming.contains(language)) {
//                programming.add(language);
//            }
        }
    }

    void _addToNaturalLanguages(final Language language) {
        if(language.type == "natural") {
//            if(!natural.contains(language)) {
//                natural.add(language);
//            }
        }
    }

    void _moveToTrash(final Language language) {
//        if(language.type == "programming" && programming.contains(language)) {
//            programming.remove(language);
//
//        } else if(language.type == "natural" && natural.contains(language)) {
//            natural.remove(language);
//        }
    }
}

main() async {
    configLogging(show: Level.FINER);

    // Initialize M4D
    ioc.IOCContainer.bindModules([
        DNDModule(), DNDSampleModule(), CoreComponentsModule()
    ]).bind(coreService.Application).to(Application());

    final Application app = await componentHandler().upgrade();
    app.run();
}

