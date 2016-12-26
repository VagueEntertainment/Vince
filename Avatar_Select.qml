import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "openseed.js" as OpenSeed
import "main.js" as Scripts

import QtQuick.LocalStorage 2.0 as Sql

Item {

    id:window_container

    width:parent.width * 0.40
    height:parent.height

    states: [

       State {
            name:"Show"

            PropertyChanges {
                target:window_container

                x:parent.width - window_container.width

            }
        },

        State {
             name:"Hide"

             PropertyChanges {
                 target:window_container
                 x:parent.width
             }
         }

    ]



    transitions: [

        Transition {
            from: "Hide"
            to: "Show"

            NumberAnimation {
                target: window_container
                property: "x"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        },


        Transition {
            from: "Show"
            to: "Hide"

            NumberAnimation {
                target: window_container
                property: "x"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }


    ]



    Rectangle {
        anchors.fill:parent
        color:"gray"
        border.color:Qt.rgba(0.5,0.5,0.5,0.6)
        border.width:5




        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            x:parent.x - width
            width:parent.width * 0.08
            height:parent.height * 0.20

            border.color:Qt.rgba(0.5,0.5,0.5,0.6)
            border.width:5
            radius:8
            color:"gray"

            Text {
                anchors.centerIn: parent
                text:if(window_container.state == "Hide") {"<<"} else {">>"}
                color:"white"
            }

            Image {
                anchors.top:parent.top
                anchors.topMargin:parent.height * 0.01
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width * 0.70
                height:parent.width * 0.70
                source:"graphics/avatar.png"
            }

            MouseArea {
                anchors.fill:parent
                onClicked:if(window_container.state =="Show") {window_container.state = "Hide"} else {window_container.state = "Show"}
            }

        }


        Row{
            id:opts
            anchors.horizontalCenter: parent.horizontalCenter

            width:parent.width * 0.98
            height:parent.height * 0.05

            Rectangle {
                id:avaopt
                width:parent.width * 0.335
                height:parent.height

                color:"lightgray"
                radius:8

                Text {
                    anchors.centerIn: parent
                    text:"Avatars"
                    font.pixelSize: (parent.height - text.length) * 0.50
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:avatars.visible = true,backgrounds.visible = false, shop.visible = false
                }


            }

            Rectangle {
                id:bgopt
                width:parent.width * 0.33
                height:parent.height

                color:"gray"
                radius:8

                Text {
                    anchors.centerIn: parent
                    text:"Backgrounds"
                    font.pixelSize: (parent.height - text.length) * 0.50
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:avatars.visible = false, backgrounds.visible = true, shop.visible = false
                }
            }

            Rectangle {
                id:shopopt
                width:parent.width * 0.335
                height:parent.height

                color:"gray"
                radius:8

                Text {
                    anchors.centerIn: parent
                    text:"Shop"
                    font.pixelSize: (parent.height - text.length) * 0.50
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:avatars.visible = false,backgrounds.visible = false, shop.visible = true
                }
            }

        }


        Rectangle {
            anchors.top:opts.bottom
            anchors.topMargin:-10
            width:opts.width
            height:parent.height
            anchors.horizontalCenter: opts.horizontalCenter
            color:"lightgray"
            //border.color:"darkgray"
            //visible:false

            Image {
                anchors.bottom:parent.bottom
                anchors.right:parent.right
                width:parent.width
                height:parent.height
                source: {if(shop.visible == true ){"graphics/bag.png"}else{"graphics/gears.png"}
                }
                fillMode:Image.PreserveAspectFit
                opacity:0.4
            }


        }

        GridView {
            id:avatars
            anchors.top:opts.bottom
            anchors.topMargin:parent.height * 0.01
            anchors.horizontalCenter: opts.horizontalCenter

            clip:true
            width:parent.width * 0.95
            height:parent.height * 0.90
            cellHeight: parent.width * 0.20
            cellWidth: parent.width * 0.20

            onVisibleChanged:if(avatars.visible == true) {avaopt.color = "lightGray"} else {avaopt.color = "gray"}

            model: ["default", "venessa"]

            delegate: Rectangle {
                        width:avatars.cellWidth * 0.9
                        height:avatars.cellHeight * 0.9
                        border.color:Qt.rgba(0.1,0.1,0.1,0.5)
                        color:"darkgray"

                        Image {
                            //anchors.fill:parent
                            width:parent.width * 0.98
                            height:parent.height * 0.98
                            anchors.centerIn: parent
                            fillMode:Image.PreserveAspectFit
                            source:"file:./themes/avatars/"+modelData+"/chatbox.png"
                        }

                        MouseArea {
                            anchors.fill:parent
                            hoverEnabled: true
                            onEntered: avatar_preview.avatheme = modelData, avatar_preview.state = "Show"
                            onExited: avatar_preview.avatheme = modelData, avatar_preview.state = "Hide"
                            onClicked: avatar1 = modelData,avatar_preview.state = "Hide"
                        }
            }

        }

        GridView {
            id:backgrounds
            anchors.top:opts.bottom
            anchors.topMargin:parent.height * 0.01
            anchors.horizontalCenter: opts.horizontalCenter

            clip:true
            width:parent.width * 0.98
            height:parent.height * 0.90
            cellHeight: parent.width * 0.40
            cellWidth: parent.width
            visible:false

            onVisibleChanged:if(backgrounds.visible == true) {bgopt.color = "lightGray"} else {bgopt.color = "gray"}

            model: ["default,forest.jpg","default,smalllake.jpg","default,muddywater.jpg","default,ruins.jpg"]

            delegate: Rectangle {
                        width:backgrounds.cellWidth * 0.95
                        height:backgrounds.cellHeight * 0.9
                        border.color:Qt.rgba(0.1,0.1,0.1,0.5)
                        color:"darkgray"

                        Image {
                            //anchors.fill:parent
                            width:parent.width * 0.98
                            height:parent.height * 0.98
                            anchors.centerIn: parent
                            fillMode:Image.PreserveAspectCrop
                            source:"file:./themes/backgrounds/"+modelData.split(",")[0]+"/"+modelData.split(",")[1]
                        }

                        MouseArea {
                            anchors.fill:parent

                            onClicked: {themename = modelData.split(",")[0],background = modelData.split(",")[1],Scripts.background_control(),
                                       OpenSeed.send_chat(roomid,"<background;;"+themename+";;"+background+">")
                                        }
                        }
            }

        }

        GridView {
            id:shop
            anchors.top:opts.bottom
            anchors.topMargin:parent.height * 0.01
            anchors.horizontalCenter: opts.horizontalCenter

            clip:true
            width:parent.width * 0.95
            height:parent.height * 0.90
            cellHeight: parent.width * 0.20
            cellWidth: parent.width * 0.20
            visible:false

            onVisibleChanged:if(shop.visible == true) {shopopt.color = "lightGray"} else {shopopt.color = "gray"}

            model: ["default", "venessa"]

            delegate: Rectangle {
                        width:avatars.cellWidth * 0.9
                        height:avatars.cellHeight * 0.9
                        border.color:Qt.rgba(0.1,0.1,0.1,0.5)
                        color:"darkgray"

                        Image {
                            //anchors.fill:parent
                            width:parent.width * 0.98
                            height:parent.height * 0.98
                            anchors.centerIn: parent
                            fillMode:Image.PreserveAspectFit
                            source:"file:./themes/avatars/"+modelData+"/chatbox.png"
                        }

                        MouseArea {
                            anchors.fill:parent
                            hoverEnabled: true
                            onEntered: avatar_preview.avatheme = modelData, avatar_preview.state = "Show"
                            onExited: avatar_preview.avatheme = modelData, avatar_preview.state = "Hide"
                        }
            }

        }



        Text {
            text:"Search:"
            anchors.left:parent.left
            anchors.bottom:parent.bottom
            anchors.margins: parent.width * 0.02
            font.pixelSize: parent.width * 0.04
            color:"white"

            TextField {
                width:(window_container.width - parent.width) * 0.90
                height:parent.height
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:parent.right
                placeholderText: "Search for Artist or theme"

            }
        }

    }



}
