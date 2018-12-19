import 'package:console_log_handler/console_log_handler.dart';

import 'package:m4d_core/m4d_ioc.dart' as ioc;
import 'package:m4d_core/services.dart' as coreService;

import "package:m4d_components/m4d_components.dart";

import 'package:m4d_dnd/m4d_dnd.dart';

import 'package:m4d_dnd_sample/m4d_dnd_sample.dart';

import 'parts/datastore.dart';

// Application is here for demonstration purpose
class Application extends MaterialApplication {
    @override
    void run() { }
}

main() async {
    configLogging(show: Level.INFO);

    ioc.IOCContainer.bindModules([
        DNDSampleModule(), DNDDataStoreModule(), CoreComponentsModule()
    ]).bind(coreService.Application).to(Application());

    final Application app = await componentHandler().upgrade();
    app.run();
}

