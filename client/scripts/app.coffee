'use strict'

angular.module('app', [
    # Angular modules
    'ngRoute'

    # Custom modules
    'app.chatroom'
])

.config([
    '$routeProvider'
    ($routeProvider) ->
        $routeProvider
            .when(
                '/'
                templateUrl: 'views/main.html'
                controller: 'chatroom'
            )

            .otherwise(
                redirectTo: '/'
            )
])