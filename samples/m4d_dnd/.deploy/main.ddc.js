define(['dart_sdk', 'packages/m4d_core/core/interfaces', 'packages/logging/logging', 'packages/console_log_handler/console_log_handler', 'packages/m4d_core/services', 'packages/m4d_dnd_sample/m4d_dnd_sample', 'packages/m4d_components/m4d_components', 'packages/m4d_core/m4d_ioc', 'packages/m4d_core/m4d_core', 'packages/m4d_dnd_sample/components/interfaces/stores', 'packages/m4d_flux/m4d_flux', 'packages/m4d_dnd/services', 'packages/m4d_dnd_sample/services'], function(dart_sdk, interfaces, logging, console_log_handler, services, m4d_dnd_sample, m4d_components, m4d_ioc, m4d_core, stores, m4d_flux, services$, services$0) {
  'use strict';
  const core = dart_sdk.core;
  const _interceptors = dart_sdk._interceptors;
  const async = dart_sdk.async;
  const collection = dart_sdk.collection;
  const _js_helper = dart_sdk._js_helper;
  const dart = dart_sdk.dart;
  const dartx = dart_sdk.dartx;
  const core__interfaces = interfaces.core__interfaces;
  const logging$ = logging.logging;
  const console_log_handler$ = console_log_handler.console_log_handler;
  const services$1 = services.services;
  const m4d_dnd_sample$ = m4d_dnd_sample.m4d_dnd_sample;
  const m4d_components$ = m4d_components.m4d_components;
  const m4d_ioc$ = m4d_ioc.m4d_ioc;
  const m4d_core$ = m4d_core.m4d_core;
  const components__interfaces__stores = stores.components__interfaces__stores;
  const m4d_flux$ = m4d_flux.m4d_flux;
  const services$2 = services$.services;
  const services$3 = services$0.services;
  const _root = Object.create(null);
  const main = Object.create(_root);
  const parts__datastore = Object.create(_root);
  let JSArrayOfIOCModule = () => (JSArrayOfIOCModule = dart.constFn(_interceptors.JSArray$(m4d_ioc$.IOCModule)))();
  let _HashSetOfLanguage = () => (_HashSetOfLanguage = dart.constFn(collection._HashSet$(components__interfaces__stores.Language)))();
  let VoidTovoid = () => (VoidTovoid = dart.constFn(dart.fnType(dart.void, [])))();
  let FutureOfvoid = () => (FutureOfvoid = dart.constFn(async.Future$(dart.void)))();
  let IdentityMapOfString$Function = () => (IdentityMapOfString$Function = dart.constFn(_js_helper.IdentityMap$(core.String, core.Function)))();
  let dynamicTovoid = () => (dynamicTovoid = dart.constFn(dart.fnType(dart.void, [dart.dynamic])))();
  let MapOfString$Function = () => (MapOfString$Function = dart.constFn(core.Map$(core.String, core.Function)))();
  let VoidToMapOfString$Function = () => (VoidToMapOfString$Function = dart.constFn(dart.fnType(MapOfString$Function(), [])))();
  let SetOfLanguage = () => (SetOfLanguage = dart.constFn(core.Set$(components__interfaces__stores.Language)))();
  main.Application = class Application extends core__interfaces.MaterialApplication {
    run() {}
  };
  (main.Application.new = function() {
  }).prototype = main.Application.prototype;
  dart.addTypeTests(main.Application);
  main.main = function() {
    return async.async(dart.dynamic, function* main$() {
      console_log_handler$.configLogging({show: logging$.Level.INFO});
      m4d_ioc$.IOCContainer.bindModules(JSArrayOfIOCModule().of([new m4d_dnd_sample$.DNDSampleModule.new(), new parts__datastore.DNDDataStoreModule.new(), new m4d_components$.CoreComponentsModule.new()])).bind(services$1.Application).to(new main.Application.new());
      let app = (yield m4d_core$.componentHandler().upgrade(main.Application));
      app.run();
    });
  };
  const _languages = Symbol('_languages');
  const _naturalLanguages = Symbol('_naturalLanguages');
  const _programmingLanguages = Symbol('_programmingLanguages');
  const _bind = Symbol('_bind');
  const _addToProgrammingLanguages = Symbol('_addToProgrammingLanguages');
  const _addToNaturalLanguages = Symbol('_addToNaturalLanguages');
  const _moveToTrash = Symbol('_moveToTrash');
  parts__datastore.DNDDataStore = class DNDDataStore extends m4d_flux$.Dispatcher {
    get languages() {
      return this[_languages];
    }
    get naturalLanguages() {
      return this[_naturalLanguages];
    }
    get programmingLanguages() {
      return this[_programmingLanguages];
    }
    [_bind]() {
      m4d_ioc$.IOCContainer.new().bind(services$2.DNDEvents).toEvents(dart.fn(() => new (IdentityMapOfString$Function()).from(["addToProgrammingLanguages", dart.fn(data => this[_addToProgrammingLanguages](components__interfaces__stores.Language.as(data)), dynamicTovoid()), "addToNaturalLanguages", dart.fn(data => this[_addToNaturalLanguages](components__interfaces__stores.Language.as(data)), dynamicTovoid()), "moveToTrash", dart.fn(data => this[_moveToTrash](components__interfaces__stores.Language.as(data)), dynamicTovoid())]), VoidToMapOfString$Function()));
    }
    [_addToProgrammingLanguages](language) {
      if (language.type === "programming") {
        if (!dart.test(this.programmingLanguages.contains(language))) {
          this.programmingLanguages.add(language);
          this.emitChange();
        }
      }
    }
    [_addToNaturalLanguages](language) {
      if (language.type === "natural") {
        if (!dart.test(this.naturalLanguages.contains(language))) {
          this.naturalLanguages.add(language);
          this.emitChange();
        }
      }
    }
    [_moveToTrash](language) {
      if (language.type === "programming" && dart.test(this.programmingLanguages.contains(language))) {
        this.programmingLanguages.remove(language);
        this.emitChange();
      } else if (language.type === "natural" && dart.test(this.naturalLanguages.contains(language))) {
        this.naturalLanguages.remove(language);
        this.emitChange();
      }
    }
  };
  (parts__datastore.DNDDataStore.new = function() {
    this[_languages] = new (_HashSetOfLanguage()).new();
    this[_naturalLanguages] = new (_HashSetOfLanguage()).new();
    this[_programmingLanguages] = new (_HashSetOfLanguage()).new();
    parts__datastore.DNDDataStore.__proto__.new.call(this, m4d_flux$.ActionBus.new());
    this[_languages].add(new components__interfaces__stores.Natural.new("English"));
    this[_languages].add(new components__interfaces__stores.Natural.new("German"));
    this[_languages].add(new components__interfaces__stores.Natural.new("Italian"));
    this[_languages].add(new components__interfaces__stores.Natural.new("French"));
    this[_languages].add(new components__interfaces__stores.Natural.new("Spanish"));
    this[_languages].add(new components__interfaces__stores.Programming.new("CPP"));
    this[_languages].add(new components__interfaces__stores.Programming.new("Dart"));
    this[_languages].add(new components__interfaces__stores.Programming.new("Java"));
    FutureOfvoid().new(dart.fn(() => this[_bind](), VoidTovoid()));
  }).prototype = parts__datastore.DNDDataStore.prototype;
  dart.addTypeTests(parts__datastore.DNDDataStore);
  parts__datastore.DNDDataStore[dart.implements] = () => [components__interfaces__stores.LanguageStore, components__interfaces__stores.NaturalLanguageStore, components__interfaces__stores.ProgrammingLanguageStore];
  dart.setMethodSignature(parts__datastore.DNDDataStore, () => ({
    __proto__: dart.getMethods(parts__datastore.DNDDataStore.__proto__),
    [_bind]: dart.fnType(dart.void, []),
    [_addToProgrammingLanguages]: dart.fnType(dart.void, [components__interfaces__stores.Language]),
    [_addToNaturalLanguages]: dart.fnType(dart.void, [components__interfaces__stores.Language]),
    [_moveToTrash]: dart.fnType(dart.void, [components__interfaces__stores.Language])
  }));
  dart.setGetterSignature(parts__datastore.DNDDataStore, () => ({
    __proto__: dart.getGetters(parts__datastore.DNDDataStore.__proto__),
    languages: core.Set$(components__interfaces__stores.Language),
    naturalLanguages: core.Set$(components__interfaces__stores.Language),
    programmingLanguages: core.Set$(components__interfaces__stores.Language)
  }));
  dart.setFieldSignature(parts__datastore.DNDDataStore, () => ({
    __proto__: dart.getFields(parts__datastore.DNDDataStore.__proto__),
    [_languages]: dart.finalFieldType(SetOfLanguage()),
    [_naturalLanguages]: dart.finalFieldType(SetOfLanguage()),
    [_programmingLanguages]: dart.finalFieldType(SetOfLanguage())
  }));
  const _store = Symbol('_store');
  parts__datastore.DNDDataStoreModule = class DNDDataStoreModule extends m4d_ioc$.IOCModule {
    configure() {
      m4d_ioc$.IOCContainer.new().bind(services$3.LanguageStore).to(this[_store]);
      m4d_ioc$.IOCContainer.new().bind(services$3.ProgrammingLanguageStore).to(this[_store]);
      m4d_ioc$.IOCContainer.new().bind(services$3.NaturalLanguageStore).to(this[_store]);
    }
  };
  (parts__datastore.DNDDataStoreModule.new = function() {
    this[_store] = new parts__datastore.DNDDataStore.new();
  }).prototype = parts__datastore.DNDDataStoreModule.prototype;
  dart.addTypeTests(parts__datastore.DNDDataStoreModule);
  dart.setMethodSignature(parts__datastore.DNDDataStoreModule, () => ({
    __proto__: dart.getMethods(parts__datastore.DNDDataStoreModule.__proto__),
    configure: dart.fnType(dart.dynamic, [])
  }));
  dart.setFieldSignature(parts__datastore.DNDDataStoreModule, () => ({
    __proto__: dart.getFields(parts__datastore.DNDDataStoreModule.__proto__),
    [_store]: dart.finalFieldType(parts__datastore.DNDDataStore)
  }));
  dart.trackLibraries("web/main.ddc", {
    "main.dart": main,
    "parts/datastore.dart": parts__datastore
  }, '{"version":3,"sourceRoot":"","sources":["main.dart","parts/datastore.dart"],"names":[],"mappings":";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;WAgBiB;;;EACjB;;;AAEO;AACH,wCAAa,QAAO,cAAK,KAAK;AAE9B,uCAA4B,CAAC,6BACzB,mCAAe,QAAI,uCAAkB,QAAI,wCAAoB,UAC1D,CAAa,sBAAW,IAAI,KAAC,oBAAW;AAE/C,UAAkB,OAAM,MAAM,0BAAgB,UAAU;AACxD,SAAG,IAAI;IACX;;;;;;;;;;;YCKmC,iBAAU;;;YAGH,wBAAiB;;;YAGb,4BAAqB;;;AAK3D,+BAAgB,OAAO,CAAY,oBAAS,UAAU,CAAC,cAC5C,2CACH,6BAA8B,QAAC,IAAI,IAAK,gCAA0B,4CAAC,IAAI,sBACvE,yBAA0B,QAAC,IAAI,IAAK,4BAAsB,4CAAC,IAAI,sBAC/D,eAAgB,QAAC,IAAI,IAAK,kBAAY,4CAAC,IAAI;IAGvD;iCAEgC,QAAuB;AACnD,UAAG,QAAQ,KAAK,KAAI,eAAe;AAC/B,uBAAI,yBAAoB,SAAS,CAAC,QAAQ,IAAG;AACzC,mCAAoB,IAAI,CAAC,QAAQ;AACjC,yBAAU;;;IAGtB;6BAE4B,QAAuB;AAC/C,UAAG,QAAQ,KAAK,KAAI,WAAW;AAC3B,uBAAI,qBAAgB,SAAS,CAAC,QAAQ,IAAG;AACrC,+BAAgB,IAAI,CAAC,QAAQ;AAC7B,yBAAU;;;IAGtB;mBAEkB,QAAuB;AACrC,UAAG,QAAQ,KAAK,KAAI,2BAAiB,yBAAoB,SAAS,CAAC,QAAQ,IAAG;AAC1E,iCAAoB,OAAO,CAAC,QAAQ;AACpC,uBAAU;YAEP,KAAG,QAAQ,KAAK,KAAI,uBAAa,qBAAgB,SAAS,CAAC,QAAQ,IAAG;AACzE,6BAAgB,OAAO,CAAC,QAAQ;AAChC,uBAAU;;IAElB;;;IApEM,gBAAU,GAAG;IAEb,uBAAiB,GAAG;IAEpB,2BAAqB,GAAG;AAEb,2DAAM,uBAAS;AAC5B,oBAAU,IAAI,CAAC,IAAI,0CAAO,CAAC;AAC3B,oBAAU,IAAI,CAAC,IAAI,0CAAO,CAAC;AAC3B,oBAAU,IAAI,CAAC,IAAI,0CAAO,CAAC;AAC3B,oBAAU,IAAI,CAAC,IAAI,0CAAO,CAAC;AAC3B,oBAAU,IAAI,CAAC,IAAI,0CAAO,CAAC;AAE3B,oBAAU,IAAI,CAAC,IAAI,8CAAW,CAAC;AAC/B,oBAAU,IAAI,CAAC,IAAI,8CAAW,CAAC;AAC/B,oBAAU,IAAI,CAAC,IAAI,8CAAW,CAAC;AAE/B,IAAI,kBAAM,CAAC,cAAM,WAAK;EAC1B;;;;;;;;;;;;;;;;;;;;;;;;;AA2DI,+BAAgB,OAAO,CAAe,wBAAa,IAAI,CAAC,YAAM;AAC9D,+BAAgB,OAAO,CAAe,mCAAwB,IAAI,CAAC,YAAM;AACzE,+BAAgB,OAAO,CAAe,+BAAoB,IAAI,CAAC,YAAM;IACzE;;;IAPM,YAAM,OAAG,iCAAY;EAQ/B","file":"main.ddc.js"}');
  // Exports:
  return {
    main: main,
    parts__datastore: parts__datastore
  };
});

//# sourceMappingURL=main.ddc.js.map
