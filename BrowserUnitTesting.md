Cypress
=======

cy.visit('https://wikipedia.org/')
cy.get('#username').type('john.deighan')
cy.get('#password').type('letmein')
cy.get('#log-in').click()
cy.contains('.element-header', 'Financial Overview')

iframes
-------

cy.visit('https://kitchen.applitools.com')
cy.iframe('#table')
	.find('#fruits')
	.should('be.visible')

waiting for search
------------------

cy.visit('https://bookstore.dev/')
cy.get('#searchBar').type('testing')
cy.get('li:visible').should('have.length', 1)

Accept an alert
---------------

cy.visit('https://kitchen.com/alert')
cy.get('#alert-button').click()
cy.on('window:alert', alert =>
	expect(alert).to.eq('Airfryers are great')

Dismiss an alert
---------------

cy.visit('https://kitchen.com/alert')
dismiss = () => return false
cy.get('#confirm-button').click()
cy.on('window:confirm', dismiss)

Answer Prompt
---------------

cy.visit('https://kitchen.com/alert', {
	onLoad(win) {
		cy.stub(win, 'prompt').returns('Hi, Mom')
		}
	})
cy.get('#prompt-button').click()


Playwright
==========

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
	
