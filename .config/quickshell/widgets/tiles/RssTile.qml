import Quickshell 
import QtQuick
import QtQuick.Controls
import QtQml.Models
import qs 
import qs.services

Tile {
    id: root 
    implicitHeight: 400 
    implicitWidth: 400

    Connections {
        target: Rss 

        function onFeedsRefreshed() {
            aggregateModel.clear()
            for (var item in Rss.feedItems) {
                aggregateModel.append(item)
            }
        }
    }

    ListModel {
        id: aggregateModel
    }

    ListView {
        anchors.fill: parent
        model: aggregateModel
        spacing: 8

        delegate: Rectangle {
            width: parent.width
            height: content.height + 16
            color: "#1e1e1e"
            radius: 6
            border.color: "#333"

            Column {
                id: content
                anchors.fill: parent
                anchors.margins: 8
                spacing: 4

                Text {
                    text: title
                    color: "white"
                    font.bold: true
                    wrapMode: Text.Wrap
                }

                Text {
                    text: pubDate + "  (" + source + ")"
                    color: "#888"
                    font.pixelSize: 11
                }

                Text {
                    text: description
                    color: "#ccc"
                    wrapMode: Text.Wrap
                    maximumLineCount: 3
                    elide: Text.ElideRight
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Qt.openUrlExternally(link)
                }
            }
        }
    }
}