'use strict'

# Controllers 
GameCtrl = ($scope) ->
  $scope.userPoints = 0

MainCtrl = ($scope, $window) ->

StartCtrl = ($scope) ->

DocCtrl = ($scope, $location, $window) ->
  $scope.documentUploaded = false
  $scope.upload = () ->
    $scope.$apply ->
      $scope.documentUploaded = true
  $scope.submit = ->
    getGoals = ->
      $.post 'api/getGoals',
        'sessionID': $window.sessionID,
        (data) ->
          $window.documentGame = {} 
          $window.documentGame.start = data.start 
          $window.documentGame.end = data.end
          $location.path('/documents/' + data.nextDocument)
        'json'

    poll = ->
      $.post 'api/getStatus',
        'sessionID': $window.sessionID,
        (data) ->
          if data.status != 'Ready'
            setTimeout( ->
                poll()
              2000)
          else
            getGoals()
    poll()

DocsCtrl = ($scope, $routeParams, $window) ->
  processDocument = (data) ->
    console.log data.locations
    doc = $window.linkForPositions(data.text, data.locations)
    # doc = data.text.linkForPositions ['location': 5, 'length': 10]
    converter = new Markdown.Converter()
    $($('.document-view')[0]).html(converter.makeHtml(doc))
    $($('.document-view a')).each (i, e) ->
      $(e).text e.text.replace(/[^a-zA-Z 0-9]+/g,'')
    $ ->
      $('div.document-view a').each (i, e)->
        $(e).attr href: 'javascript:void(0)'

  $scope.documentID = $routeParams.documentID
  $window.documentGame = {}
  # $scope.start = $window.documentGame.start
  # $scope.end = $window.documentGame.end
  # $.get 'api/getDocument',
  #   'documentID': $scope.documentID
  #   processDocument(data)
  $.post 'api/getDocument',
    'keyword': 'single-payer health care',
    (data)->
      processDocument(data)
<<<<<<< HEAD
    
  $(document).on 'click', 'div.document-view > a', (event)->
    console.log event
=======
  $('div.document-view a').on 'click', (event)->
    alert('asdf')
    false
>>>>>>> asdf


# MainCtrl.$inject = []
# MyCtrl2.$inject = []