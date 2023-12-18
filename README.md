Create a template folder
========================

- A Skeleton SvelteKit app
- Git source code management
- CoffeeScript enabled
- vite and svelte config files converted to CoffeeScript

- A layout with a simple menu
- Markdown enabled
- Easy deployment as a static app
- GitHub integration
- access to @jdeighan/base-utils


Instructions:

```bash
$ npm create svelte@latest template
	Skeleton project, no TypeScript, etc.
$ cd template
$ npm install
$ npm install -D coffeescript npm-run-all @sveltejs/adapter-static
$ npm install -D mdsvex
$ npm install -D @jdeighan/base-utils @jdeighan/svelte-utils
$ git init
$ git add -A
$ git commit -m "initial commit"
$ npm run dev -- --open
```

Change `package.json` to:

```json
{
	"name": "@jdeighan/template",
	"version": "1.0.0",
	"type": "module",
	"scripts": {
		"coffee:watch": "npx coffee -c -w .",
		"vite:dev": "vite dev",
		"dev": "npx coffee -c . && run-p coffee:watch vite:dev",
		"build": "npx coffee -c . && vite build",
		"preview": "vite preview"
	},
	"devDependencies": {
		"@sveltejs/adapter-auto": "^3.0.0",
		"@sveltejs/kit": "^2.0.0",
		"@sveltejs/vite-plugin-svelte": "^3.0.0",
		"coffeescript": "^2.7.0",
		"npm-run-all": "^4.1.5",
		"svelte": "^4.2.7",
		"vite": "^5.0.3"
	}
}
```

Change `src/routes/+page.svelte` to:

```svelte
<h1>This is a SvelteKit template with:</h1>
<ul>
	<li>Git source code management</li>
	<li>A layout with a simple menu</li>
	<li>Markdown enabled</li>
	<li>A deploy script deploying as a static app on ???</li>
	<li>GitHub integration</li>
	<li>CoffeeScript enabled</li>
</ul>
```

Add file `svelte.config.coffee`:

```coffee
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
```

Add file `vite.config.coffee`:

```coffee
import {sveltekit} from '@sveltejs/kit/vite'
import {defineConfig} from 'vite'

export default {
	plugins: [sveltekit()]
	}
```

Test use of CoffeeScript by:

Add this `<script>` block to `src/routes/+page.svelte`:

```html
<script lang="coffee">
	name = 'John'
	console.log "my name is #{name}"
</script>
```

Also use `{name}` somewhere on the page. Check your
console logs for the logged string.

Test markdown by creating the file `src/routes/test/+page.md`:

```md
Markdown test page
==================

This is a **markdown page**

Here is some stuff I use:

- CoffeeScript
- MarkDown
```

Then browse to `localhost:5173/test`.
