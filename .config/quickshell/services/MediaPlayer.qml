pragma Singleton 

import Quickshell
import Quickshell.Services.Mpris 
import QtQuick

Singleton {
    id: root
    property var players: Mpris.players.values
    property int playerIndex: 0
    property var player: root.players[root.playerIndex]
    property bool hasPlayer: player !== null 

    property var playbackState: root.player.playbackState
    property var shuffleSupported: root.player.shuffleSupported
    property var shuffle: player.shuffle
    property var trackArtUrl: root.player.trackArtUrl
    property var trackArtist: root.player.trackArtist
    property var trackAlbum: root.player.trackAlbum
    property var length: root.player.length 
    property bool canSeek: player.canSeek
    property real position: player.position

    function next() {
        if (root.hasPlayer) 
            root.player.next()
    }
    function previous() {
        if (root.hasPlayer) 
            player.previous()
    }
    function togglePlaying() {
        if (root.hasPlayer) 
            player.togglePlaying()
    }
    function nextPlayer() {
        let idx = playerIndex + 1
        if (idx === players.length)
            idx = 0
        playerIndex = idx 
    }
    function previousPlayer() {
        let idx = root.playerIndex - 1
        if (idx < 0)
            idx = root.players.length - 1
        root.playerIndex = idx
    }
    FrameAnimation {
        running: playbackState === MprisPlaybackState.Playing
        onTriggered: player.positionChanged()
    }
}
