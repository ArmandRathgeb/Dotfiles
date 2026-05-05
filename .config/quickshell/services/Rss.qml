pragma Singleton

import Quickshell
import QtQuick
import QtQuick.Controls
import qs
import qs.widgets.common

Singleton {
    id: root 

    property var feeds: Config.rssFeeds
    property list<var> feedItems: []

    signal feedsRefreshed()

    function fetchFeed(url) {
        console.log("Loading rss url", url)
        let component = Qt.createComponent("qs.widgets.common", "RssItem")
        if (component.status !== Component.Ready)  {
            console.log("Loading component error", component.errorString())
            return
        }
        let obj = component.createObject(null, { feedUrl: url })
        obj.onReady.connect(function() {
            console.log("Ready")
            for (let i = 0; i < obj.count; ++i) {
                item = obj.get(i)
                feedItems.push({
                    title       : item.title,
                    link        : item.link,
                    pubDate     : item.pubDate,
                    description : item.description,
                    source      : url
                })
            }
            sortModel()
        })
    }

    function sortModel() {
        let temp = []

        for (let i = 0; i < root.feedItems.count; i++)
            temp.push(root.feedItems[i])

        temp.sort(function(a, b) {
            return new Date(b.pubDate) - new Date(a.pubDate)
        })

        root.feedItems.clear()

        for (let i = 0; i < temp.length; i++)
            root.feedItems.push(temp[i])
    }

    function refreshAll() {
        root.feedItems = []
        for (let i = 0; i < feeds.length; i++)
            fetchFeed(feeds[i])
        feedsRefreshed()
    }

    Component.onCompleted: refreshAll()

    Timer {
        interval: 3000000
        running: true 
        repeat: true 
        onTriggered: refreshAll()
    }

    
}