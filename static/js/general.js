// Generated by CoffeeScript 1.3.3

window.updateFb = function(response) {
  var userID;
  userID = response.authResponse.userID;
  return $.post('/api/login', {
    'userID': userID
  });
};
