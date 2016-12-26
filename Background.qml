import QtQuick 2.3
import QtQuick.Window 2.2
import "openseed.js" as OpenSeed

import QtQuick.LocalStorage 2.0 as Sql




    Rectangle {
        anchors.fill: parent
        color:"darkgray"

    Image {
        anchors.fill:parent
        source:if(themename == "none") {"graphics/"+background} else {"file:./themes/backgrounds/"+themename+"/"+background}
        fillMode:Image.PreserveAspectCrop


    }

}
