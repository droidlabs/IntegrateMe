window.app.controller('EditCompetitionController', ($scope, $http) ->

  # Fetch mailchimp lists from backend if we have datacenter and api_key
  fetchMailchimpLists = ->
    api_key = $scope.competition.mailchimp_api_key
    datacenter = $scope.competition.mailchimp_datacenter
    if api_key && datacenter
      $http.get("/mailchimp_lists.json?api_key=#{api_key}&datacenter=#{datacenter}").
        success((data, status, headers, config) ->
          $scope.lists = data.data
        )

  $scope.init = (data) ->
    $scope.competition = data
    fetchMailchimpLists()

  # Save mailchimp api details in competition
  $scope.submit = ->
    $http.patch("/competitions/#{$scope.competition.id}.json", $scope.competition).
      success((data, status, headers, config) ->
        alert("SAVED!")
      )

  $scope.$watch "competition.mailchimp_api_key", (value)->
    if value
      fetchMailchimpLists()

  $scope.$watch "competition.mailchimp_datacenter", (value)->
    if value
      fetchMailchimpLists()
)