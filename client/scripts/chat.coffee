'use strict'

angular.module('app.chatroom', [])

.factory('socket', [
    '$rootScope'
    ($rootScope) ->
        socket = io.connect('http://localhost:3333')

        # return
        #     on: (eventName, callback) ->
])

.controller('chatroom', [
    '$scope', 'socket'
    ($scope, socket) ->
        $scope.chat =
            user: undefined
            message: ''

        $scope.messages = [
            sender: 'Admin'
            content: 'Hi~ Welcome to the chatroom :)'
        ]

        $scope.sendMessage = (chat) ->
            if chat.message is ''
                return
            else
                message =
                    sender: chat.user
                    content: chat.message
                socket.emit('messages', message)
                insertMessage(message, true)
                # reset
                chat.message = ''

        # insert message to the chat window
        insertMessage = (message, isSelf) ->
            $scope.messages.push message

            if !isSelf
                $scope.$apply()

        socket.on('messages', (data) ->
            # console.log data
            insertMessage(data)
        )

        socket.on('connect', (data) ->
            $scope.chat.user = prompt("What's your name?")

            socket.emit('join', $scope.chat.user)
        )

        # Remove the socket listeners whenever the controller is destroyed, http://stackoverflow.com/questions/14389049/how-to-use-angularjs-with-socket-io
        $scope.$on('$destroy',  (event) ->
            socket.removeAllListeners()
        )
])