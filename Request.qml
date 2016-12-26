import QtQuick 2.0
import "main.js" as Scripts
import "openseed.js" as OpenSeed

import QtQuick.LocalStorage 2.0 as Sql

Item {


    id:window_container


    property int type: 0
    property string inviteid: " "
    property string invitename: " "
    property string theroom: " "

    width:parent.width * 0.60
    height:parent.height * 0.40


    states: [

       State {
            name:"Show"

            PropertyChanges {
                target:window_container

                y:(parent.height - window_container.height) * 0.5

            }
        },

        State {
             name:"Hide"

             PropertyChanges {
                 target:window_container
                 y:parent.height
             }
         }

    ]



    transitions: [

        Transition {
            from: "Hide"
            to: "Show"

            NumberAnimation {
                target: window_container
                property: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        },


        Transition {
            from: "Show"
            to: "Hide"

            NumberAnimation {
                target: window_container
                property: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }


    ]

state:"Hide"

    Rectangle {
        anchors.fill:parent
        color:"darkgray"
        border.color:Qt.rgba(0.5,0.5,0.5,0.6)
        border.width:4

    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:parent.top
        anchors.topMargin:parent.height * 0.01
        font.pixelSize: parent.width * 0.05
        color:"white"
        text:if(roomid == " ") {"Create new room with\n"+invitename} else {"Asking "+invitename+"\n To Join current room"}
        width:parent.width
        wrapMode:Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }

    Row {
        anchors.bottom:parent.bottom
        anchors.bottomMargin:parent.height * 0.01
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.98
        height:parent.height * 0.2
        spacing:parent.width * 0.09

        Rectangle {
            width:parent.width * 0.45
            height:parent.height * 0.98
            color:"lightgray"
            radius:8
            Text {
                anchors.centerIn: parent
                font.pixelSize: parent.height * 0.5
                text:"Cancel"
                color:"white"
            }
            MouseArea {
                anchors.fill:parent
                onClicked:{window_container.state = "Hide"
                    if(type != 0) {

                        OpenSeed.decline_request(theroom);


                    }
                }
            }
        }
        Rectangle {
            width:parent.width * 0.45
            height:parent.height * 0.98
            color:"lightgray"
            radius:8
            Text {
                anchors.centerIn: parent
                font.pixelSize: parent.height * 0.5
                text:if(type == 0) {"Request"} else {"Join"}
                color:"white"
            }
            MouseArea {
                anchors.fill:parent
                onClicked:if(type == 0) {
                                if(roomid == " ") {
                                        Scripts.create_area();
                                        OpenSeed.send_request(roomid,inviteid);
                                } else {
                                     OpenSeed.send_request(roomid,inviteid);
                                }
                          } else {
                                Scripts.create_area(theroom);
                                OpenSeed.accept_request(theroom);


                          }
            }
        }
    }


}

