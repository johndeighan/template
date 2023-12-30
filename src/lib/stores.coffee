# stores.coffee

# import {PrefsDataStore} from '$lib/browserStores.js'
import {PrefsDataStore} from '@jdeighan/svelte-utils/stores'

export lAllowedKeys = [
	'firstName'
	'lastName'
	'address'
	'phone'
	'email'
	'bgColor'
	]

export hPrefs = new PrefsDataStore({
	firstName: 'John', 
	lastName: 'Deighan'
	})
