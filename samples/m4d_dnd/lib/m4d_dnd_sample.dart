/*
 * Copyright (c) 2018, Michael Mitterer (office@mikemitterer.at),
 * IT-Consulting and Development Limited.
 * 
 * All Rights Reserved.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    http:// www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

library m4d_dnd_sample;

import 'dart:async';
import 'dart:collection';
import 'dart:html' as dom;
import 'dart:math' as Math;

import "package:m4d_core/m4d_core.dart";

export "package:m4d_core/m4d_core.dart";

import "package:m4d_core/m4d_ioc.dart" as ioc;

import "package:m4d_components/m4d_components.dart";
import 'package:m4d_template/m4d_template.dart';
// import "package:m4d_components/m4d_formatter.dart";

// import 'package:m4d_flux/m4d_flux.dart';
// export 'package:m4d_flux/m4d_flux.dart';

import 'package:m4d_animation/m4d_animation.dart';
import 'package:m4d_translate/m4d_translate.dart';

import 'components.dart';
import 'services.dart' as dndService;
import 'datastore.dart';

class DNDSampleModule extends ioc.IOCModule {

    final _store = DNDDataStore();
    
    @override
    configure() {
        registerDNDLanguagesComponent();

        ioc.IOCContainer().bind(dndService.LanguageStore).to(_store);
    }

    // @override
    // List<ioc.IOCModule> get dependsOn => [
    //     CoreComponentsModule(),
    //     TranslationModule(),
    //     DirectivesModule()
    // ];
}