import QtQuick 2.0
import QtQuick.Controls 1.4
import "main.js" as Scripts
import "openseed.js" as OpenSeed

import QtQuick.LocalStorage 2.0 as Sql

Item {
    property string search: ""

    id:window_container

    width:parent.width * 0.40
    height:parent.height

    onStateChanged: if(window_container.state == "Show") {Scripts.list_areas("roomlist")} else {}

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


        Row{
            id:opts
            anchors.horizontalCenter: parent.horizontalCenter

            width:parent.width * 0.98
            height:parent.height * 0.05

            Rectangle {
                id:areaopt
                width:parent.width * 0.335
                height:parent.height

                color:"lightgray"
                radius:8

                Text {
                    anchors.centerIn: parent
                    text:"Areas"
                    font.pixelSize: (parent.height - text.length) * 0.50
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:rooms.visible = true,address.visible = false, find.visible = false
                }


            }

            Rectangle {
                id:addressopt
                width:parent.width * 0.33
                height:parent.height

                color:"gray"
                radius:8

                Text {
                    anchors.centerIn: parent
                    text:"Address Book"
                    font.pixelSize: (parent.height - text.length) * 0.50
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:rooms.visible = false, address.visible = true, find.visible = false
                }
            }

            Rectangle {
                id:findopt
                width:parent.width * 0.335
                height:parent.height

                color:"gray"
                radius:8

                Text {
                    anchors.centerIn: parent
                    text:"Find People"
                    font.pixelSize: (parent.height - text.length) * 0.50
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:rooms.visible = false,address.visible = false, find.visible = true
                }
            }

        }

        Rectangle {
            anchors.top:opts.bottom
            anchors.topMargin:-10
            width:rooms.width
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
                source:"graphics/gears.png"
                fillMode:Image.PreserveAspectFit
                opacity:0.4
            }

        }

        Flickable {
            id:rooms
            anchors.horizontalCenter: opts.horizontalCenter
            anchors.top:opts.bottom
            anchors.topMargin:parent.height * 0.01
            width:parent.width * 0.98
            height:parent.height * 0.98
            contentWidth: width
            visible:true
            clip:true

        ListView {

            width:parent.width * 0.98
            height:parent.height


            clip:true

            onVisibleChanged:if(rooms.visible == true) {areaopt.color = "lightGray",search = ""} else {areaopt.color = "gray"}

            model:ListModel {
                id:roomlist

            }

            delegate: Item {
                x:parent.width * 0.02
                width:parent.width * 0.98
                height:window_container.height * 0.1


                clip:true

                Rectangle {
                    color:if(index % 2 == 0) {"lightgray"} else {"darkgray"}
                    width:parent.width
                    height:parent.height * 0.98
                    id:roomborder
                    border.color:"gray"
                    opacity: 0.7
                }

                Row {
                    width:parent.width - leave.width
                    height:parent.height * 0.98
                    spacing:3

                    Text {
                        text:partynum - 1
                        width:parent.width * 0.05
                       // height:parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment: Text.AlignHCenter

                    }

                    Column {
                        width:parent.width * 0.54
                        height:parent.height
                        clip:true
                         Text {
                                text:lastmessage
                                 width:parent.width
                                 height:parent.height * 0.6
                                 wrapMode: Text.WordWrap
                                 clip:true


                             }
                          Text {
                               //anchors.top:parent.bottom
                              text:party_names
                              wrapMode: Text.WordWrap
                              width:parent.width
                              font.pixelSize: (parent.height - text.length) * 0.2
                         }
                    }
                    Text {
                        text:lastdate
                        width:parent.width * 0.40
                        //height:parent.height
                        wrapMode: Text.WordWrap
                        clip:true
                    }

                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:roomid = room
                    hoverEnabled: true
                    onEntered: roomborder.border.color = "gold"
                    onExited: roomborder.border.color = "gray"
                }

                Rectangle {
                    id:leave
                    anchors.right:parent.right
                     anchors.rightMargin: parent.width * 0.005
                    anchors.verticalCenter: parent.verticalCenter
                    width:parent.height  * 0.94
                    height:parent.height  * 0.94
                    color:"lightgray"
                    radius:5

                    Image {
                        source:'graphics/edit-delete.svg'
                        anchors.centerIn: parent
                        width:parent.width * 0.80
                        height:parent.width * 0.80
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: leave.color = "red"
                        onExited: leave.color = "darkgray"
                    }
                }



            }

        }

        }


        Flickable {
            id:address
            anchors.horizontalCenter: opts.horizontalCenter
            anchors.top:opts.bottom
            anchors.topMargin:parent.height * 0.01
            width:parent.width * 0.98
            height:parent.height * 0.98
            contentWidth: width
            visible:false
            clip:true


        ListView {

            width:parent.width
            height:parent.height


            onVisibleChanged:if(address.visible == true) {Scripts.address_book();addressopt.color = "lightGray",search = ""} else {addressopt.color = "gray"}

            model:ListModel {
                id:addressbook

            }

            delegate: Item {
                x:parent.width * 0.02
                width:parent.width * 0.98
                height:window_container.height * 0.05
                //anchors.horizontalCenter: opts.horizontalCenter

                clip:true

                Rectangle {
                    color:if(index % 2 == 0) {"lightgray"} else {"darkgray"}
                    width:parent.width
                    height:parent.height * 0.98
                    id:addressborder
                    border.color:"gray"
                    opacity: 0.7
                }

                Row {
                    width:parent.width - trash.width
                    height:parent.height
                    spacing:3

                    Image {
                        width:parent.height * 0.98
                        height:parent.height * 0.98
                        source:"file:./themes/avatars/"+avatar+"/chatbox.png"
                    }

                    Text {
                        text:name
                        width:parent.width * 0.50
                        anchors.verticalCenter: parent.verticalCenter
                        x:width / 2


                    }
                    Text {
                        text:lastseen
                        width:parent.width * 0.20
                        anchors.verticalCenter: parent.verticalCenter
                        x:width / 2


                    }

                }

                MouseArea {
                    anchors.fill:parent
                    onClicked:requests.inviteid = theid,requests.invitename = name,requests.state = "Show",chat_controls.state = "Hide"
                    hoverEnabled: true
                    onEntered: addressborder.border.color = "gold"
                    onExited: addressborder.border.color = "gray"
                    //propagateComposedEvents:true
                }

                Rectangle {
                    id:trash
                    anchors.right:parent.right
                    anchors.rightMargin: parent.width * 0.005
                     anchors.verticalCenter: parent.verticalCenter
                     width:parent.height  * 0.94
                     height:parent.height  * 0.94
                        color:"lightgray"

                    Image {
                        source:'graphics/edit-delete.svg'
                        anchors.centerIn: parent
                        width:parent.width * 0.80
                        height:parent.width * 0.80
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: Scripts.remove_address_book(theid)
                    }
                }

            }

        }

        }

        Flickable {
            id:find
            anchors.horizontalCenter: opts.horizontalCenter
            anchors.top:opts.bottom
            anchors.topMargin:parent.height * 0.01
            width:parent.width * 0.98
            height:parent.height * 0.98
            contentWidth: width
            visible:false
            clip:true


        ListView {


            width:parent.width
            height:parent.height

            //clip:true

            onVisibleChanged:if(find.visible == true) {findopt.color = "lightGray",search = ""} else {findopt.color = "gray"}

            model:ListModel {
                id:findpeeps

            }

            delegate: Item {
                x:parent.width * 0.02
                width:parent.width * 0.98
                height:window_container.height * 0.05

                Rectangle {
                    color:if(index % 2 == 0) {"lightgray"} else {"darkgray"}
                    width:parent.width
                    height:parent.height * 0.98
                    id:findborder
                    border.color:"gray"
                    opacity: 0.7
                }

                Row {
                    width:parent.width - add.width
                    height:parent.height
                    spacing:3

                    Image {
                        width:parent.height * 0.98
                        height:parent.height * 0.98
                        source:"file:./themes/avatars/"+avatar+"/chatbox.png"
                    }

                    Text {
                        text:name
                        width:parent.width * 0.50
                        anchors.verticalCenter: parent.verticalCenter
                        x:width / 2


                    }
                    Text {
                        text:lastseen
                        width:parent.width * 0.20
                        anchors.verticalCenter: parent.verticalCenter
                        x:width / 2


                    }


                }
                MouseArea {
                    anchors.fill:parent
                    propagateComposedEvents:true
                    hoverEnabled: true
                    onEntered: findborder.border.color = "gold"
                    onExited: findborder.border.color = "gray"
                }

                Rectangle {
                    id:add
                    anchors.right:parent.right
                    anchors.rightMargin: parent.width * 0.005
                   anchors.verticalCenter: parent.verticalCenter
                   width:parent.height  * 0.94
                   height:parent.height  * 0.94
                    color:"lightgray"

                    Image {
                        source:'graphics/add.svg'
                        anchors.centerIn: parent
                        width:parent.width * 0.80
                        height:parent.width * 0.80
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked:Scripts.add_address_book(theid,name,avatar,lastseen);

                    }
                }



            }

        }

        }



        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset:-(height*1.02)
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
                source:"graphics/home.png"
            }

            MouseArea {
                anchors.fill:parent
                onClicked:if(window_container.state =="Show") {window_container.state = "Hide"} else {window_container.state = "Show"}
            }

        }

    }

    Text {
        text:"Search:"
        anchors.left:parent.left
        anchors.bottom:parent.bottom
        anchors.margins: parent.width * 0.02
        font.pixelSize: parent.width * 0.04
        color:"black"

        TextField {
            id:searchfield
            width:(window_container.width - parent.width) * 0.90
            height:parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.left:parent.right
            placeholderText: { if(rooms.visible == true){ "Search for Room based on users"}
                                if(address.visible == true){ "Search addressbook for users"}
                                if(find.visible == true){ "Search for Users"}


            }
            text:search
            onTextChanged: { if(rooms.visible == true){ console.log("Searching rooms")}
                if(address.visible == true){ console.log("Searching addressbook")}
                if(find.visible == true){console.log("Searching for Users"),OpenSeed.retrieve_users()}

                    }
        }
        Rectangle {
            visible:if(rooms.visible == true) {true} else {false}
            width:parent.height * 0.98
            height:parent.height * 0.98
            color:"lightgray"
            anchors.left:searchfield.right
            anchors.verticalCenter: searchfield.verticalCenter

            Image {
                anchors.centerIn:parent
                width:parent.width  * 0.90
                height:parent.height * 0.90
                source:"graphics/add.svg"
                fillMode:Image.PreserveAspectFit

            }

            MouseArea {
                anchors.fill:parent
                onClicked:Scripts.create_area("local"),Scripts.list_areas("roomlist");
            }
        }
    }




//Nothing below this point
}

