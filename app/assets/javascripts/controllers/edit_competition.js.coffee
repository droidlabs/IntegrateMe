window.app.controller('EditCompetitionController', ($scope) ->
  $scope.init = (data) ->
    console.log("data")
    $scope.competition = data
    $scope.errors = null

  $scope.submit = ->
    # console.log()
)