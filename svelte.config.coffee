import adapter from '@sveltejs/adapter-static'
import {mdsvex} from 'mdsvex'
import {coffeePreProcessor} from '@jdeighan/svelte-utils/preprocessors'

export default {
	kit: {
		adapter: adapter()
		}
	extensions: ['.svelte', '.md'],
	preprocess: [
		mdsvex({extensions: ['.md']})
		{
			script: coffeePreProcessor
			}
		]
	}
