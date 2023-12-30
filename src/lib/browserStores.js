// Generated by CoffeeScript 2.7.0
// browserStores.coffee
var WritableDataStore, debugLocalStore;

import {
  writable,
  readable
} from 'svelte/store';

import {
  undef,
  defined,
  notdefined,
  isString,
  isHash,
  isFunction
} from '@jdeighan/base-utils';

import {
  LOGJSON
} from '@jdeighan/base-utils/log';

import {
  assert
} from '@jdeighan/base-utils/exceptions';

import {
  getLocalStore,
  setLocalStore
} from '@jdeighan/coffee-utils/browser';

debugLocalStore = true;

// ---------------------------------------------------------------------------
WritableDataStore = class WritableDataStore {
  constructor(defValue = undef) {
    this.store = writable(defValue);
  }

  subscribe(func) {
    return this.store.subscribe(func);
  }

  set(value) {
    assert(defined(value), "stored value must be defined");
    this.store.set(value);
  }

  update(func) {
    assert(isFunction(func), "Not a function");
    this.store.update(func);
  }

};

// ---------------------------------------------------------------------------
export var LocalStorageDataStore = class LocalStorageDataStore extends WritableDataStore {
  constructor(masterKey1, defValue = undef) {
    var storedVal;
    super(defValue);
    this.masterKey = masterKey1;
    
    // --- Check if this key exists in localStorage
    storedVal = getLocalStore(this.masterKey);
    if (debugLocalStore) {
      console.log(`1. getLocalStore ${this.masterKey} = ${storedVal}`);
      LOGJSON('storedVal', storedVal);
    }
    if (defined(storedVal)) {
      this.set(storedVal);
    } else {
      this.set(defValue);
    }
  }

  set(value) {
    assert(defined(value), "set(): cannot set to undef");
    super.set(value);
    if (debugLocalStore) {
      console.log(`2. setLocalStore ${this.masterKey} to ${value}`);
      LOGJSON('storedVal', value);
    }
    setLocalStore(this.masterKey, value);
  }

  update(func) {
    var value;
    super.update(func);
    value = this.store.get();
    if (debugLocalStore) {
      console.log(`3. setLocalStore ${this.masterKey} to ${value}`);
      LOGJSON('storedVal', value);
    }
    setLocalStore(this.masterKey, value);
  }

};

// ---------------------------------------------------------------------------
export var PropsDataStore = class PropsDataStore extends LocalStorageDataStore {
  constructor(masterKey, hDefaults) {
    assert(isHash(hDefaults), "hPrefs must be a hash");
    super(masterKey, hDefaults);
  }

};

// ---------------------------------------------------------------------------
export var PrefsDataStore = class PrefsDataStore extends PropsDataStore {
  constructor(hDefaults) {
    super('hPrefs', hDefaults);
  }

};
