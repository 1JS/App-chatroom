'use strict'

angular.module('app.chatroom', [])

.factory('socket', [
    '$rootScope'
    ($rootScope) ->
        socket = io.connect('http://localhost:3333')
])

.controller('chatroom', [
    '$scope', 'socket'
    ($scope, socket) ->
        $scope.chat =
            user: undefined
            message: ''

        $scope.sendMessage = (chat) ->
            if chat.message is ''
                return
            else
                console.log 'hi'

        # Remove the socket listeners whenever the controller is destroyed, http://stackoverflow.com/questions/14389049/how-to-use-angularjs-with-socket-io
        $scope.$on('$destroy',  (event) ->
            socket.removeAllListeners()
        )
])