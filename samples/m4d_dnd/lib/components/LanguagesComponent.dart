part of m4d_dnd_sample;

class LanguagesComponent extends MdlTemplateComponent implements DataProvider {
    final Logger _logger = new Logger('todo.ToDoListComponent');

    static const _cssClasses = _LanguagesComponentCssClasses();

    /// no final because it will be initialized in [_init]
    dynamic _store;

    LanguagesComponent.fromElement(final dom.HtmlElement element,final ioc.IOCContainer iocContainer)
        : super(element,iocContainer) {

        _init();
    }

    static LanguagesComponent widget(final dom.HtmlElement element)
    => mdlComponent(element,LanguagesComponent) as LanguagesComponent;


    //- private -----------------------------------------------------------------------------------

    void _init() {
        _logger.fine("DNDLanguagesComponent - init (StoreType: ${_storeType})");

        // TODO: Change injector to something that fits the IOC-Container
        switch(_storeType) {
            case "all":
            _store = injector.resolve(sampleService.LanguageStore).as<LanguageStore>();
            break;
            case "programming":
            _store = injector.resolve(sampleService.ProgrammingLanguageStore).as<ProgrammingLanguageStore>();
            break;
            case "natural":
            _store = injector.resolve(sampleService.NaturalLanguageStore).as<NaturalLanguageStore>();
            break;
        }

        render().then((_) => _bindSignals() );

        element.classes.add(_cssClasses.IS_UPGRADED);
    }

    void _bindSignals() {
        _store.onChange.listen((final DataStoreChangedEvent event) {
            render();
        });
    }

    String get _storeType => DataAttribute.forAttribute(element, "type").asString();

    String get _dropZone => DataAttribute.forAttribute(element, "drop-zone", onError: () => "").asString();

    Set<Language> get _languages {
        // TODO: Change injector to something that fits the IOC-Container
        switch(_storeType) {
            case "all":
                return (_store as LanguageStore).languages;
            case "programming":
                return (_store as ProgrammingLanguageStore).programmingLanguages;
            case "natural":
                return (_store as NaturalLanguageStore).naturalLanguages;
        }

        throw ArgumentError("Wrong store type: ${_storeType}!");
    }

    //- Template -----------------------------------------------------------------------------------

    @override
    String get template {
        
        String _allItems() {
            final buffer = StringBuffer();
            _languages.forEach((final Language language) {
                buffer.write(_dragItem(language));
            });
            return buffer.toString();
        }

        // Template must return one single element!!!!
        return  """
            <div class="item-container ${_storeType}-languages">
                ${_allItems()}
            </div>
            """;
    }

    String _dragItem(final Language language) {
        String dropZone = _dropZone;
        if(dropZone == "") {
            dropZone = language.type;
        }

        // mdl-draggable looks in DataConsumer (in this case this instance (is DataProvider))
        // and returns data for ${language.name}
        final row = """
            <mdl-draggable class="language" consumes="${language.name}" drop-zone="${dropZone}">
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
