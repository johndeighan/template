Ideas
=====

Allow async code within sync code, e.g.

```coffee
w = getWindow('https://test.org/')
	then
	await hJson = w.content()
```

More compact synonym for 'await', e.g.

```coffee
w = ? getWindow 'https://test.org/'
```

Automatic await ???

