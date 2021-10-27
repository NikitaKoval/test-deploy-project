describe('My First Test', () => {
    it('Does not do much!', () => {
        cy.wait(1000)
        cy.visit('/').debug()
        cy.get('[name=message-input]').type('test message{enter}')
        cy.get('li').should('contain', 'test message')
    })
})