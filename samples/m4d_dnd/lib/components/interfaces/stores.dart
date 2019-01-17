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

library m4d_dnd_sample.components.interfaces;


import 'package:m4d_flux/m4d_flux.dart';

/// TransferObject (TO) for this little app.
class Language {
    final String name;
    final String type;

    Language(this.name, this.type);
}

class Programming extends Language {
    Programming(final String name) : super(name,"programming");
}

class Natural extends Language {
    Natural(final String name) : super(name,"natural");
}

// - DataStores for our components -------------------------------------------------------------------------------------

abstract class LanguageStore extends DataStore {
    Set<Language> get languages;
}

abstract class ProgrammingLanguageStore extends DataStore {
    Set<Language> get programmingLanguages;
}

abstract class NaturalLanguageStore extends DataStore {
    Set<Language> get naturalLanguages;
}


// - Actions sent by our app -------------------------------------------------------------------------------------------

