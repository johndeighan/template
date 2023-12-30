Playwright
==========

page = new Page()
await page.goto('https://wikipedia.org/')
await page.locator('id=username').fill('john.deighan')
await page.locator('id=password').fill('letmein')
await page.locator('id=log-in').click()
await expect(page.locator('.element-header').first())
	.toHaveText('Financial Overview')

iframes
-------

await page.goto('https://kitchen.applitools.com')
iframe = page.frameLocator('id=table')
table = iframe.locator('id=fruits')
await expect(table).tobeVisible()

waiting for search
------------------

await page.goto('https://bookstore.dev/')
await page.locator('id=searchBar').fill('testing')
await expect(page.locator('li:visible')).toHaveCount(1)

Accept an alert
---------------

page.on('dialog', dialog =>
	expect(dialog.message()).tobe('Airfryers are great')
	dialog.accept()
	)
await page.goto('https://kitchen.com/alert')
await page.locator('id=alert-button').click()
	
Dismiss an alert
---------------

page.on('dialog', dialog => dialog.dismiss()
await page.goto('https://kitchen.com/alert')
await page.locator('id=alert-button').click()
	
Answer Prompt
---------------

page.on('dialog', dialog => dialog.accept('nachos')
await page.goto('https://kitchen.com/alert')
await page.locator('id=alert-button').click()
	
Navigate to new window
======================

await page.goto(url)
[newPage] = await Promise.all([
	context.waitForEvent('page'),
	page.locator('id=button-table'.click()
	])
await newPage.waitForLoadState()
expect(newPage.url()).toContain('ingredients/table')
await expect(newPage.locator('id=fruits'))
	.toBeVisible()
	
	
API requests
============

requestContext = await request.newContext(
	{baseURL: 'https://kitchen.com'}
	)
response = await requestContext.get('api/recipes')
await expect(response).toBeOK()

body = await response.json()
expect(body.time).toBeGreaterThan(0)
expect(body.data.length).toBeGreaterThan(0)

Page Objects
============

class LoginPage
	
	constructor: (page) ->
		@page = page
		@usernameInput = page.locator('id=username')
		@passwordInput = page.locator('id=password')
		@loginButton = page.locator('id=log_in')
		
	load: (page) ->
	
		await @page.goto(url)
		
	login: (username, password) ->
	
		await @usernameInput.fill(username)
		await @passwordInput.fill(password)
		await @loginButton.click()
		
page = new Page()
loginPage = new LoginPage(page)
await loginPage.load()
await loginPage.login('john.deighan','letmein')

Language Support
----------------

