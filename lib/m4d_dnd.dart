/*
 * Copyright (c) 2015, Michael Mitterer (office@mikemitterer.at),
 * IT-Consulting and Development Limited.
 *
 * All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

library m4d_dnd;

import 'dart:html' as dom;
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:logging/logging.dart';
import 'package:validate/validate.dart';


import "package:m4d_core/m4d_core.dart";
import "package:m4d_core/m4d_utils.dart";

export "package:m4d_core/m4d_core.dart";

import "package:m4d_core/m4d_ioc.dart" as ioc;

import 'services.dart' as dndService;

import 'package:dnd/dnd.dart';

part "dnd/components/MaterialDraggable.dart";
part "dnd/components/MaterialDropZone.dart";

abstract class DataProvider {
    dynamic provide(final String data);
}

void registerMdlDND() {
    registerMaterialDraggable();
    registerMaterialDropZone();
}

class DNDModule extends ioc.IOCModule {

    @override
    configure() {
        registerMdlDND();
    }

    // @override
    // List<ioc.IOCModule> get dependsOn => [
    //     CoreComponentsModule(),
    // ];
}

