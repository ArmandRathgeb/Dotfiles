pragma Singleton 

import Quickshell
import Quickshell.Io
import QtQuick
import qs

Singleton {
    id: root

    property list<Information> weatherInformation: []

    readonly property var icons: {
        "m": "weather-few-clouds",
        "?": "weather-none-available",
        "mm": "weather-clouds",
        "=": "weather-fog",
        "///": "weather-storm",
        "//": "weather-showers",
        "**": "weather-snow",
        ".": "weather-showers-scattered",

    /*
    "LightRain": "/",
    "LightSleet": "x",
    "LightSleetShowers": "x/",
    */
        "*/": "weather-snow-rain",
        "*": "weather-snow-scattered",
        "o": "weather-clear",
        "/!/": "weather-showers-scattered-storm",
        "!/": "weather-showers-scattered-storm",
        "*!*": "weather-snow-storm",
        "mmm": "weather-many-clouds",
    }

    function getUrl() {
        let urlbase = `"https://wttr.in/{%1`.arg(Config.weatherCities[0])
        for (let i = 1; i < Config.weatherCities.length; i++) {
            urlbase += ",%1".arg(Config.weatherCities[i])
        }
        urlbase += `}?u&format=%l+%x+%t\\n"`
        return urlbase
    }

    Process {
        id: checkWeather
        command: [ "sh", "-c", "curl --max-time 30 -s " +  root.getUrl() ]
        running: true
        stdout: SplitParser {
            onRead: data => {
                console.log("Got input", data)
                if (weatherInformation.length === Config.weatherCities.length) {
                    weatherInformation = []
                }
                const [city, condition, temp] = data.split(" ")
                console.log(city, condition, temp)
                weatherInformation.push(information.createObject(null, {
                    city: city,
                    icon: "image://icon/" + icons[condition],
                    temp:temp
                }))
            }
        }
        stderr: StdioCollector {
            onStreamFinished: console.log("Weather error:", this.text)
        }
    }

    Timer {
        interval: 180000
        running: true
        repeat: true 
        onTriggered: checkWeather.running = true
    }

    component Information: QtObject {
        property string city
        property string icon 
        property string temp
    }
    Component {
        id: information 
        Information {}
    }
}