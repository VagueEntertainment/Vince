import QtQuick 2.0
import QtQuick.Controls 1.4
import "openseed.js" as OpenSeed
import "main.js" as Scripts

import QtQuick.LocalStorage 2.0 as Sql


Item {

    property string tempmessage:""

    visible: if(roomid == " ") {false} else {true}

    Timer {
        id:playback
        running:false
        repeat:true
        interval: if(currentmessage.length * 400 > 1800) {400*currentmessage.length} else {(400*currentmessage.length) + 1300}
        onTriggered: if(currentframe < frames) {Scripts.play_log(roomid)} else {currentframe = 1; playback.running = false; playing = 0;}
    }

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        id:textboxbackground
        width:parent.width
        height:parent.height
        radius:8
        color:Qt.rgba(0.1,0.1,0.1,0.8)

        TextField {
            width:parent.width * 0.95
            height:parent.height * 0.98
            anchors.verticalCenter: parent.verticalCenter
            x:parent.width * 0.01
            placeholderText: "Enter Text here"
            text:tempmessage
            onTextChanged: tempmessage = text

            Keys.onReturnPressed:remote = 0,currentmessage = tempmessage,tempmessage = "",currentid = id,speaker = username,Scripts.save_chat(),OpenSeed.send_chat(roomid,currentmessage);
        }

        Rectangle {
            radius:width / 2
            height:parent.height * 0.7
            width:parent.height * 0.7
            anchors.verticalCenter: parent.verticalCenter
            anchors.right:parent.right
            color:"black"

            Image {
                source:"graphics/keyboard-enter.svg"
                anchors.centerIn: parent
                width:parent.width * 0.70
                height:parent.height * 0.70
                fillMode: Image.PreserveAspectFit
            }
            MouseArea {
                anchors.fill:parent
                onClicked:remote = 0,currentmessage = tempmessage, tempmessage = "",currentid = id,speaker = username,Scripts.save_chat(),OpenSeed.send_chat(roomid,currentmessage);
            }
        }

    }

    Rectangle {
        anchors.bottom:textboxbackground.top
        anchors.right:textboxbackground.right
        height:textboxbackground.height * 0.80
        width:textboxbackground.width * 0.08
        color:"lightgray"
        radius:8

        Row {
            anchors.centerIn: parent
            //width:parent.width
            height:parent.height

            Image {
                id:back
                source:"graphics/media-skip-backward.svg"
                height:parent.height * 0.80
                width:parent.height * 0.80
                fillMode:Image.PreserveAspectFit

            }
            Image {
                id:play
                source:if(playing == 0) {"graphics/media-playback-start.svg"} else {"graphics/media-playback-pause.svg"}
                height:parent.height * 0.80
                width:parent.height * 0.80
                fillMode:Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    onClicked:{ if(playing == 0) {playing =1,playback.running = true,chatbox.wipe = 1
} else {playing = 0,playback.running = false}

                    }
                }

            }
            Image {
                id:forward
                source:"graphics/media-skip-forward.svg"
                height:parent.height * 0.80
                width:parent.height * 0.80
                fillMode:Image.PreserveAspectFit

            }
        }
    }

}

