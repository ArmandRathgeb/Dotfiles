pragma Singleton 

import QtQuick 

QtObject {
    id: themeManager 
    property string currentTheme: "purple"

    property color accentBlack: "#4d4d4d"
    property color accentRed: "#ff6767"
    property color accentGreen: "#61ffca"
    property color accentYellow: "#ffca85"
    property color accentBlue: "#a277ff"
    property color accentMagenta: "#a277ff"
    property color accentCyan: "#61ffca"
    property color accentWhite: "#edecee"

    property color bgBase: "#1a1b26"
    property color bgSecondary: "#24273a"
    property color bgTernary: "#0c0d14"

    property color surface0: "#966FD6"
    property color surface1: "#4f3973"
    
    // "#414868" "#0c0d14" "#6d5670" "#0c0d14" "#a9b1d6" "#9ece6a" "#6d5670"
    // "#1a1b26" "#24273a" "#414868"

    property color fgPrimary: "#edecee"//"#FFFFFF"

    property real barOpacity: 0.85

    property string fontFamily: "JetBrainMono Nerd Font"
    property int fontSize: 14


}