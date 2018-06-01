const chai = require('chai');
const should = chai.should();

describe('/form/request-appointment', function() {

  let app;

  before(function() {

  });

  after(function() {
  });

  context('GET', function() {
    it('should return the appointment form', function(done) {
        .get('/form/request-appointment')
        .end(function(err, res) {
          res.should.have.status(200);
          res.text.should.contain('To make reservations please fill out the following form');
          done(err);
        });
    });
  });

  context('POST', function() {
    it('should accept a valid appointment request', function(done) {
        .post('/form/request-appointment')
        .set('content-type', 'application/x-www-form-urlencoded')
        .send({
          first_name: 'Test',
          last_name: 'Test',
          email: 'testemail@gmail.com',
          phone: '9192761234'
        })
        .end(function(err, res) {
          res.text.should.contain('Thanks, your booking request #1349');
          res.should.have.status(200);
          done(err);
        });
    });

    it('should reject an invalid appointment request', function(done) {
      chai.request(app)
        .post('/reservations')
        .set('content-type', 'application/x-www-form-urlencoded')
        .send({
          first_name: 'Test',
          last_name: 'Test',
          email: 'testemail@gmail.com',
          phone: ''
        })
        .end(function(err, res) {
          res.text.should.contain('Sorry, there was a problem with your booking request.');
          res.should.have.status(400);
          done();
        });
    });
  });
});
