describe('Message board test', () => {
    it('Message can be posted', () => {
        cy.wait(1000)
        cy.visit('/').debug()
        cy.get('[name=message-input]').type('test message{enter}')
        cy.get('li').should('contain', 'test message')
    })
})