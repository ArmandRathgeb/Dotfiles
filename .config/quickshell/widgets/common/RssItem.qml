import QtQuick
import QtQml.XmlListModel 

QtObject {
    id: root
    property string feedUrl 
    signal ready() 

    property XmlListModel child: XmlListModel {
        id: model 
        source: root.feedUrl
        query: "/rss/channel/item"

        XmlListModelRole { 
            name: "title"
            elementName: "title"
        }
        XmlListModelRole {
            name: "link"
            elementName: "link"
        }
        XmlListModelRole {
            name: "pubDate"
            elementName: "pubDate"
        }
        XmlListModelRole {
            name: "description"
            elementName: "description"
        }

        onStatusChanged: {
            if (status === XmlListModel.Ready)
                ready()
        }
    }
}