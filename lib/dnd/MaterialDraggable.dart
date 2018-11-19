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

part of m4d_dnd;

/// Singleton - used by MaterialDraggable and MaterialDroppable
class DragInfo {
    static DragInfo _draginfo;

    var data;
    List<String> allowedDropZones = [];

    factory DragInfo () {
        if(_draginfo == null) {
            _draginfo = new DragInfo._internal();
        }
        return _draginfo;
    }

    DragInfo._internal();
}
 
class MaterialDraggable extends MdlComponent /* implements MdlDataConsumer */ {
    final Logger _logger = new Logger('mdldnd.MaterialDraggable');

    static const _MaterialDraggableCssClasses _cssClasses = const _MaterialDraggableCssClasses();
    static const _MaterialDraggableConstant _constants = const _MaterialDraggableConstant();

    final DragInfo _dragInfo = new DragInfo();

    Draggable _draggable;

    MaterialDraggable.fromElement(final dom.HtmlElement element,final ioc.IOCContainer iocContainer)
        : super(element,iocContainer) {
        
        _init();
    }
    
    static MaterialDraggable widget(final dom.HtmlElement element)
        => mdlComponent(element,MaterialDraggable) as MaterialDraggable;

    get _isDisabled => ElementProperties.isDisabled(element);

    //- private -----------------------------------------------------------------------------------

    void _init() {
        _logger.fine("MaterialDraggable - init");

        /// Recommended - add SELECTOR as class
        element.classes.add(_MaterialDraggableConstant.WIDGET_SELECTOR);

        element.classes.add(_cssClasses.DRAGGABLE);
        element.classes.add(_cssClasses.DND_DRAGGABLE);

        _draggable = new Draggable(element, avatarHandler: new AvatarHandler.clone());

        _draggable.onDragStart.listen(_onDragStart);
        _draggable.onDragEnd.listen(_onDragEnd);


        element.classes.add(_cssClasses.IS_UPGRADED);
    }

    /// [_consumedData] looks for the nearest M4D-Component that is a [DataProvider]
    /// and calls "provide" on it
    dynamic get _consumedData {
        final String consume = element.attributes[_constants.CONSUMES];

        /// Looks for a SCOPE-AWARE!!!-Parent
        DataProvider mdlDataProvider(final MdlComponent component) {
            final Logger _logger = new Logger('m4d_dnd.mdlDataProvider');

            if(component.parent == null) {
                _logger.fine("$component has no parent!");
                return null;
            }
            if(component.parent is DataProvider) {

                return (component.parent as DataProvider);

            } else {
                _logger.fine("${component.parent} (ID: ${component.parent.element.id}) "
                    "is a MdlComponent but no DataProvider!");
            }
            return mdlDataProvider(component.parent);
        }

        final dataProvider = mdlDataProvider(this);

        //_logger.info("DataProvider: $dataProvider");
        return dataProvider?.provide(consume);
    }

    void _onDragStart(final DraggableEvent event) {
        _logger.fine("_onDragStart ${event}");

        if (_isDisabled) {
            return;
        }

        List<String> _allowedDropZones() {
            if(element.attributes.containsKey(_constants.DROP_ZONE)) {
                return element.attributes[_constants.DROP_ZONE].split(",");
            }
            return new List<String>();
        }

        _dragInfo.allowedDropZones = _allowedDropZones();
        _dragInfo.data = _consumedData;

        _logger.fine("_onDragStart -  END");

    }

    void _onDragEnd(final DraggableEvent event) {
        _logger.fine("_onDragEnd ${event}");
        _dragInfo.data = null;
    }
}

/// registration-Helper
void registerMaterialDraggable() {
    final MdlConfig config = new MdlConfig<MaterialDraggable>(
        _MaterialDraggableConstant.WIDGET_SELECTOR,
            (final dom.HtmlElement element,final ioc.IOCContainer iocContainer)
                => new MaterialDraggable.fromElement(element,iocContainer)
    );

    config.selectorType = SelectorType.TAG;
    componentHandler().register(config);
}

/// Store strings for class names defined by this component that are used in
/// Dart. This allows us to simply change it in one place should we
/// decide to modify at a later date.
class _MaterialDraggableCssClasses {

    final String IS_UPGRADED    = 'is-upgraded';

    final String DRAGGABLE      = 'mdl-draggable';

    final String DND_DRAGGABLE  = 'dnd-draggable';

    const _MaterialDraggableCssClasses(); }

/// Store constants in one place so they can be updated easily.
class _MaterialDraggableConstant {

    static const String WIDGET_SELECTOR = "mdl-draggable";

    final String DROP_ZONE = "drop-zone";

    final String CONSUMES = "consumes";

    const _MaterialDraggableConstant();
}
