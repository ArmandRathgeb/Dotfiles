pragma Singleton

import QtQuick

QtObject {
    property string currentTheme: "Catpuccin Mocha"

    function boldColor(c: color):  color {
        let nc = Qt.hsla(
            c.hslLightness * .94,
            c.hslSaturation * .8,
            c.hslHue + .2,
            1.0
        )
        console.log(nc)
        return nc
    }

    property color accentBlack: this.surface0
    property color accentRed: "#f38ba8"
    property color accentGreen: "#a6e3a1"
    property color accentYellow: "#f9e2af"
    property color accentBlue: "#89b4fa"
    property color accentMagenta: "#cba6f7" // "#f5c2e7"
    property color accentCyan: "#94e2d5"
    property color accentWhite: this.fgPrimary

    property color boldBlack: this.surface1
    property color boldRed: boldColor(this.accentRed)
    property color boldGreen: boldColor(this.accentGreen)
    property color boldYellow: boldColor(this.accentYellow)
    property color boldBlue: boldColor(this.accentBlue)
    property color boldMagenta: boldColor(this.accentMagenta)
    property color boldCyan: boldColor(this.accentCyan)
    property color boldWhite: "#bac2de"

    property color bgBase: "#1e1e2e"
    property color bgSecondary: "#181825"
    property color bgTernary: "#11111b"

    property color surface0: "#313244"
    property color surface1: "#45475a"
    property color surface2: "#585b70"

    property color fgPrimary: "#cdd6f4"

    property real barOpacity: 0.85

    property string fontFamily: "JetBrainMono Nerd Font"
    property int fontSize: 14
}