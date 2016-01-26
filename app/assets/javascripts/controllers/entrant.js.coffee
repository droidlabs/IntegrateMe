window.app.controller('EntrantController', ($scope, $http) ->
  $scope.init = (data) ->
    $scope.competition = data.competition
    $scope.entry = {competition_id: data.competition.id}
    $scope.errors = null

  $scope.submit = ->
    $http.post("/entries", $scope.entry).
      success((data, status, headers, config) ->
        if data.success
          $scope.entry.completed = true
        else
          $scope.errors = data.errors
      ).
      error((data, status, headers, config) ->
        alert("ERROR!")
      )
)
