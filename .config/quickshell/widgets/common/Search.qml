import Quickshell
import QtQuick
import QtQuick.Controls
import qs

Rectangle {
    id: root
    required property list<var> searchSpace
    required property var heuristic
    property string placeHolderText: "󰍉 "

    color: Config.theme.bgBase

    property alias resultsModel: searchHits

    ListModel {
        id: searchHits
    }

    Component.onCompleted: {
        for (let i = 0; i < root.searchSpace.length; ++i) {
            searchHits.append({'entry': searchSpace[i]})
        }
    }

    TextField {
        id: searchBox
        placeholderText: root.placeHolderText
        anchors.fill: parent 
        onTextChanged: filter()
        focus: true 
        leftPadding: 10
        rightPadding: 10

        background: Rectangle {
            radius: 20
            color: "transparent"
            border.width: 2
            border.color: {
                if (searchBox.enabled)
                    return Config.theme.accentMagenta
                return Config.theme.bgBase
            }
        }
    }

    function filter() {
        let query = searchBox.text.toLowerCase()
        searchHits.clear()

        for (let i = 0; i < root.searchSpace.length; ++i) {
            let entry = searchSpace[i]
            if (query === "" || root.heuristic(query, entry)
            )
                searchHits.append({'entry': entry})
        }
    }
}