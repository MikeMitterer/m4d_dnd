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
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

library m4d_dnd_sample.components;

import 'dart:html' as dom;

import 'package:logging/logging.dart';
import 'package:m4d_dnd/m4d_dnd.dart';
import 'package:validate/validate.dart';

import "package:m4d_core/m4d_core.dart";
export "package:m4d_core/m4d_core.dart";
import "package:m4d_core/m4d_ioc.dart" as ioc;

import "package:m4d_flux/m4d_flux.dart";
import 'package:m4d_template/m4d_template.dart';

import 'services.dart' as sampleService;

import 'components/interfaces/stores.dart';

class LanguagesComponent extends MdlTemplateComponent implements DataProvider {
    final Logger _logger = new Logger('todo.ToDoListComponent');

    static const _cssClasses = _LanguagesComponentCssClasses();

    final LanguageStore _store;

    LanguagesComponent.fromElement(final dom.HtmlElement element,final ioc.IOCContainer iocContainer)
        : _store = iocContainer.resolve(sampleService.LanguageStore).as<LanguageStore>(),
            super(element,iocContainer) {

        _init();
    }

    static LanguagesComponent widget(final dom.HtmlElement element)
        => mdlComponent(element,LanguagesComponent) as LanguagesComponent;


    //- private -----------------------------------------------------------------------------------

    void _init() {
        _logger.fine("DNDLanguagesComponent - init");

        render().then((_) => _bindSignals() );

        element.classes.add(_cssClasses.IS_UPGRADED);
    }

    void _bindSignals() {
        _store.onChange.listen((final DataStoreChangedEvent event) {
            render();
        });
    }

    //- Template -----------------------------------------------------------------------------------

    @override
    String get template {
        String _allRows() {
            final buffer = StringBuffer();
            _store.languages.forEach((final Language language) {
                buffer.write(_row(language));
            });
            return buffer.toString();
        }
        return  """
            <div class="source langbox mdl-dnd__drag-container" >
                ${_allRows()}
            </div>
            """;
    }

    String _row(final Language language) {

        // mdl-draggable looks in DataConsumer (in this case this instance (is DataProvider))
        // and returns data for ${language.name}
        final row = """
            <mdl-draggable class="language" consumes="${language.name}" drop-zone="${language.type}">
                ${language.name}
            </mdl-draggable>
        """;

        return row;
    }

    /// Called by mdl-draggable
    @override
    dynamic provide(final String languageName) {
      _logger.info("Provide: '$languageName'");

    return _store.languages.firstWhere((final Language language) => language.name == languageName);
    }

}

/// registration-Helper
void registerDNDLanguagesComponent() {
    final MdlConfig config = new MdlWidgetConfig<LanguagesComponent>(
        _LanguagesComponentCssClasses.MAIN_CLASS,
            (final dom.HtmlElement element, final ioc.IOCContainer iocContainer)
                => new LanguagesComponent.fromElement(element, iocContainer));

    config.selectorType = SelectorType.TAG;
    componentHandler().register(config);
}

/// Store strings for class names defined by this component that are used in
/// Dart. This allows us to simply change it in one place should we
/// decide to modify at a later date.
class _LanguagesComponentCssClasses {
    static const String MAIN_CLASS  = "languages";

    final String IS_UPGRADED = 'is-upgraded';

    const _LanguagesComponentCssClasses();
}
