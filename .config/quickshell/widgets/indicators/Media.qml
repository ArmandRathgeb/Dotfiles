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
    //border.color: Config.theme.accentMagenta
    //border.width: 1
    anchors.margins: 2

    radius: 14
    clip: true

    RowLayout {
        id: column
        spacing: 2
        anchors.fill: parent
        anchors.margins: parent.border.width + 1

        IconButton {
            icon: Quickshell.iconPath("handle-left")
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
                text: MediaPlayer.trackTitle || "Unknown track"
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
                text: MediaPlayer.trackAlbum 
                color: Config.theme.fgPrimary
                font.family: Config.theme.fontFamily
                font.pixelSize: Config.theme.fontSize
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                elide: Text.ElideRight
                maximumLineCount: 1
                visible: MediaPlayer.trackAlbum !== ""
            }
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
                    icon: Quickshell.iconPath("media-skip-backward")
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
                            return Quickshell.iconPath("media-playback-pause")
                        case MprisPlaybackState.Paused:
                            return Quickshell.iconPath("media-playback-playing")
                        case MprisPlaybackState.Stopped:
                            return Quickshell.iconPath("media-playback-stopped")
                        }
                    }
                    implicitHeight: 30
                    implicitWidth: 30
                }
                IconButton {
                    id: shuffle 
                    visible: MediaPlayer.shuffleSupported
                    icon: Quickshell.iconPath(MediaPlayer.shuffle ? "media-playlist-shuffle" : "media-playlist-no-shuffle")
                    onClicked: MediaPlayer.shuffle = !MediaPlayer.shuffle
                    implicitHeight: 30
                    implicitWidth: 30
                }
                IconButton {
                    id: next 
                    icon: Quickshell.iconPath("media-skip-forward")
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
            icon: Quickshell.iconPath("handle-right")
            implicitHeight: 100
            implicitWidth: 20
            onClicked: MediaPlayer.nextPlayer()
        }
    }
}