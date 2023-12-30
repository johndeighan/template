Cypress
=======

url = 'https://kitchen.applitools.com'

cy.visit(url)
cy.get('#username').type('john.deighan')
cy.get('#password').type('letmein')
cy.get('#log-in').click()
cy.contains('.element-header', 'Financial Overview')

iframes
-------

cy.visit(url)
cy.iframe('#table')
	.find('#fruits')
	.should('be.visible')

waiting for search
------------------

cy.visit(url)
cy.get('#searchBar').type('testing')
cy.get('li:visible').should('have.length', 1)

Accept an alert
---------------

cy.visit(url)
cy.get('#alert-button').click()
cy.on('window:alert', alert =>
	expect(alert).to.eq('Airfryers are great')

Dismiss an alert
---------------

cy.visit(url)
dismiss = () => return false
cy.get('#confirm-button').click()
cy.on('window:confirm', dismiss)

Answer Prompt
---------------

cy.visit(url, {
	onLoad(win) {
		cy.stub(win, 'prompt').returns('Hi, Mom')
		}
	})
cy.get('#prompt-button').click()


Navigate to new window
======================

cy.visit(url)
cy.get('#new-page-button')
	.invoke('removeAttr', 'target')
	.click()
cy.location('pathname')
	.should('eq', '/ingredients/table')
cy.get('#fruits:visible')
	.should('have.length', 1)
	
API requests
============

cy.request(url).then(({status, body, duration}) =>
	expect(status).to.eq(200)
	expect(body.data).to.have.length.greaterThan(0)
	expect(duration).to.be.greaterThan(0)
	)
	
Maybe???

{status, body, duration} = await cy.request(url)
expect(status).to.eq(200)
expect(body.data).to.have.length.greaterThan(0)
expect(duration).to.be.greaterThan(0)

Page Objects
============

loginPage = {
	username: '#username'
	password: '#password'
	log_in: '#log-in'
	load: () ->
		cy.visit(url)
		return this
	login: (name, pwd) ->
		cy.get(@username).type(name)
		cy.get(@password).type(pwd)
		cy.get(@log_in).click()
		return this
	}
	
loginPage.load().login('john.deighan','letmein')


Language Support
----------------

