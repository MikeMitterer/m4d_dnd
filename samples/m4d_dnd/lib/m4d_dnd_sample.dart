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

import 'dart:html' as dom;

import 'package:logging/logging.dart';
import 'package:m4d_dnd/m4d_dnd.dart';

import "package:m4d_core/m4d_core.dart";
export "package:m4d_core/m4d_core.dart";
import "package:m4d_core/m4d_ioc.dart" as ioc;

import "package:m4d_flux/m4d_flux.dart";
import 'package:m4d_template/m4d_template.dart';

import 'services.dart' as sampleService;

import 'components/interfaces/stores.dart';

part 'components/LanguagesComponent.dart';

class DNDSampleModule extends ioc.Module {

    @override
    configure() {
        registerDNDLanguagesComponent();
    }

    @override
    List<ioc.Module> get dependsOn =>
        [
            DNDModule(),
        ];
}
