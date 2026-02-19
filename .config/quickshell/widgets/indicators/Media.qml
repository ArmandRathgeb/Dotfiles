import Quickshell
import Quickshell.Services.Mpris 
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs
import qs.services
import qs.widgets.common

Rectangle {
    id: root
    property int playerIndex: 0
    implicitHeight: column.implicitHeight + 6
    implicitWidth: column.implicitWidth + 12

    //color: "transparent"
    color: Config.theme.bgTernary
    border.color: Config.theme.accentMagenta
    border.width: 1
    anchors.margins: 2

    radius: 14
    clip: true

    RowLayout {
        id: column
        spacing: 2
        anchors.fill: parent
        anchors.margins: parent.border.width + 1

        IconButton {
            icon: "image://icon/handle-left"
            implicitHeight: 100
            implicitWidth: 20
            onClicked: MediaPlayer.previousPlayer()
        }
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            implicitWidth: 100
            implicitHeight: 100
            clip: true
            color: "transparent"
            Image {
                source: MediaPlayer.trackArtUrl
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                cache: true
            }
        }

        ColumnLayout {
            Text {
                Layout.fillWidth: true
                text: MediaPlayer.trackArtist || "Unknown artist"
                color: Config.theme.fgPrimary
                font.family: Config.theme.fontFamily
                font.pixelSize: Config.theme.fontSize
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                elide: Text.ElideRight
                maximumLineCount: 1
            }
            Text {
                Layout.fillWidth: true
                text: MediaPlayer.trackAlbum || "Unknown album"
                color: Config.theme.fgPrimary
                font.family: Config.theme.fontFamily
                font.pixelSize: Config.theme.fontSize
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                elide: Text.ElideRight
                maximumLineCount: 1
            }
            Slider {
                id: playerSlider
                Layout.fillWidth: true
                Connections {
                    target: MediaPlayer.player 
                    function onPositionChanged() {
                        playerSlider.value = MediaPlayer.position 
                    }
                }

                from: 0
                to: MediaPlayer.length
                implicitWidth: controlRow.implicitWidth
                handle: Item {} // Invisible handle
            }
            RowLayout {
                id: controlRow
                Layout.alignment: Qt.AlignHCenter
                spacing: 1
                IconButton {
                    id: previous
                    icon: "image://icon/media-skip-backward"
                    onClicked: {
                        MediaPlayer.previous()
                        playerSlider.value = 0
                    }
                    implicitHeight: 30
                    implicitWidth: 30
                }
                IconButton {
                    id: pausePlay
                    onClicked: MediaPlayer.togglePlaying()
                    icon: {
                        switch(MediaPlayer.playbackState) {
                        case MprisPlaybackState.Playing:
                            return "image://icon/media-playback-pause"
                        case MprisPlaybackState.Paused:
                            return "image://icon/media-playback-playing"
                        case MprisPlaybackState.Stopped:
                            return "image://icon/media-playback-stopped"
                        }
                    }
                    implicitHeight: 30
                    implicitWidth: 30
                }
                IconButton {
                    id: shuffle 
                    visible: MediaPlayer.shuffleSupported
                    icon: MediaPlayer.shuffle ? "image://icon/media-playlist-shuffle" : "image://icon/media-playlist-no-shuffle"
                    onClicked: MediaPlayer.shuffle = !MediaPlayer.shuffle
                    implicitHeight: 30
                    implicitWidth: 30
                }
                IconButton {
                    id: next 
                    icon: "image://icon/media-skip-forward"
                    onClicked: {
                        MediaPlayer.next()
                        playerSlider.value = 0
                    }
                    implicitHeight: 30
                    implicitWidth: 30
                }
            }
        }
        IconButton{
            icon: "image://icon/handle-right" 
            implicitHeight: 100
            implicitWidth: 20
            onClicked: MediaPlayer.nextPlayer()
        }
    }
}