Create a template folder
========================

- A Skeleton SvelteKit app
- Git source code management
- access to @jdeighan/base-utils, @jdeighan/svelte-utils
- CoffeeScript enabled
- vite and svelte config files converted to CoffeeScript
- Markdown enabled
- GitHub integration
- A layout with a simple menu

- a basic store, using local storage
- Easy deployment as a static app
- an installable web app


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

Add the file `.npmrc`:

```text
engine-strict=true
loglevel=silent
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
	<li>CoffeeScript enabled</li>
	<li>Markdown enabled</li>
	<li>GitHub integration</li>
	<li>A layout with a simple menu</li>
	<li>Ability to create a simple data store in local storage</li>
	<li>Implemented as an installable web app</li>
	<li>A deploy script deploying as a static app on surge.sh</li>
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

GitHub integration
------------------

(Ensure that the GitHub CLI is installed)
(From inside the project folder)

```bash
$ gh repo create
```
Choose `Push an existing local repository to GitHub`

Add a remote named `origin`

From this point on, you can push changes (after
committing locally) via:

```bash
$ git push
```

Create a layout with menu
-------------------------

Create the file `src/routes/about/+page.md`

```markdown
About this project
==================

This will be a description of the project
```

Create the file `src/routes/contact/+page.md`

```markdown
Contact Me
==========

How to contact me
```

Test by browsing directly to these URLs:

```text
http://localhost:5173/
http://localhost:5173/about
http://localhost:5173/contact
```

Add this `<style>` block to `src/app.html` in the
`<head>` section, just before `%sveltekit.head%`

```css
<style>
	:root {
		--bkg-color: GhostWhite;
		--text-color: Black;
		--menu-bkg-color: #09CABE;
		--menu-text-color: White;
		}
	* {
		box-sizing: border-box;
		}
	html, body {
		height: 100vh;
		width: 100vw;
		margin: 0;
		padding: 0
		}
	body {
		font: 15px sans-serif;
		display: grid;
		grid-template-areas:
			"left top    right"
			"left middle right"
			"left bottom right"
			;
		grid-template-rows: auto 1fr auto;
		}

	/* NOTE: Using a CSS variable in place of '800px' doesn't work */

	@media (max-width: 800px) {
		body {
			grid-template-columns: 0 100% 0;
			}
		}

	@media (min-width: 800px) {
		body {
			grid-template-columns: 1fr 800px 1fr;
			}
		}
</style>
```

Add `id="svelte"` to the `<div>` inside the `<body>`

Create the file `src/routes/+layout.svelte`

```svelte
<nav>
	<a href="/">Home</a>
	<a href="/about">About</a>
	<a href="/contact">Contact</a>
</nav>

<main>
  <slot/>
</main>

<footer>
	Built with SvelteKit!
</footer>

<style>
	main {
		grid-area: middle;
		padding: 15px 5px;
		overflow: auto;    /* scroll bars appear with large content */
		background-color: var(--bkg-color);
		color: var(--text-color);
		}

	nav, footer {
		background-color: var(--menu-bkg-color);
		color: var(--menu-text-color);
		text-align: center;
		margin: 0;
		padding: 5px 0;
		}

	nav {
		grid-area: top;
		}
	nav a {
		color: var(--menu-text-color);
		text-decoration: none;
		padding: 0 8px;
		display: inline-block;
		}
	nav a:hover {
		color: white;
		}

	footer {
		grid-area: bottom;
		}
</style>

```

