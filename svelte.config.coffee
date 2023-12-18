import adapter from '@sveltejs/adapter-static'
import {coffeePreProcessor} from '@jdeighan/svelte-utils/preprocessors'

export default {
	kit: {
		adapter: adapter()
		}
	preprocess: {
		script: coffeePreProcessor
		}
	}
