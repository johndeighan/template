# browserStores.coffee

import {writable, readable} from 'svelte/store'
import {
	undef, defined, notdefined, isString, isHash, isFunction,
	} from '@jdeighan/base-utils'
import {LOGJSON} from '@jdeighan/base-utils/log'
import {assert} from '@jdeighan/base-utils/exceptions'
import {
	getLocalStore, setLocalStore,
	} from '@jdeighan/browser'

debugLocalStore = true

# ---------------------------------------------------------------------------

class WritableDataStore

	constructor: (defValue=undef) ->
		@store = writable defValue

	subscribe: (func) ->
		return @store.subscribe(func)

	set: (value) ->
		assert defined(value), "stored value must be defined"
		@store.set(value)
		return

	update: (func) ->
		assert isFunction(func), "Not a function"
		@store.update(func)
		return

# ---------------------------------------------------------------------------

export class LocalStorageDataStore extends WritableDataStore

	constructor: (@masterKey, defValue=undef) ->

		# --- CoffeeScript forces us to call super first
		#     so we can't get the localStorage value first
		super defValue
		
		# --- Check if this key exists in localStorage
		storedVal = getLocalStore @masterKey
		if debugLocalStore
			console.log "1. getLocalStore #{@masterKey} = #{storedVal}"
			LOGJSON 'storedVal', storedVal
		
		if defined(storedVal)
			@set storedVal
		else
			@set defValue

	set: (value) ->
		assert defined(value), "set(): cannot set to undef"
		super value
		if debugLocalStore
			console.log "2. setLocalStore #{@masterKey} to #{value}"
			LOGJSON 'storedVal', value
		setLocalStore @masterKey, value
		return

	update: (func) ->
		super func
		value = @store.get()
		if debugLocalStore
			console.log "3. setLocalStore #{@masterKey} to #{value}"
			LOGJSON 'storedVal', value
		setLocalStore @masterKey, value
		return

# ---------------------------------------------------------------------------

export class PropsDataStore extends LocalStorageDataStore

	constructor: (masterKey, hDefaults) ->
		assert isHash(hDefaults), "hPrefs must be a hash"
		super masterKey, hDefaults

# ---------------------------------------------------------------------------

export class PrefsDataStore extends PropsDataStore

	constructor: (hDefaults) ->
		super 'hPrefs', hDefaults
