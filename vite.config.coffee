import {sveltekit} from '@sveltejs/kit/vite'
import {defineConfig} from 'vite'

export default {
	plugins: [sveltekit()]
	optimizeDeps: { exclude: ["fsevents"] }  # supposed to fix a vite error, but didn't work
	}
