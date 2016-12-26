import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "openseed.js" as OpenSeed
import "main.js" as Scripts

import QtQuick.LocalStorage 2.0 as Sql

Item {

    id:window_container

    property int wipe: 0

    Timer {
        id:wipeit
        running:true
        repeat:true
        interval:10
        onTriggered:if(wipe == 1) {chatlog.clear(),wipe =0} else {}
    }

    Timer {
        id:checkfornew
        running:true
        repeat:true
        interval:10
       /* onTriggered: {if(currentmessage != previousmessage) {
                                                                if(currentid == id) {
                                                                            chatlog.append ({
                                                                                name:username1,
                                                                                 message:currentmessage,
                                                                                 avatar:avatar1,
                                                                                 ava:avatar1,
                                                                                 LoR:0
                                                                             })
                                                                         }
                                                               if(currentid == id2) {
                                                                    chatlog.append ({
                                                                        name:username2,
                                                                         message:currentmessage,
                                                                         avatar:avatar2,
                                                                         ava:avatar2,
                                                                         LoR:1
                                                                     })
                                                                }

                                                                    if(currentid == id3) {
                                                                        chatlog.append ({
                                                                            name:username3,
                                                                             message:currentmessage,
                                                                             avatar:avatar3,
                                                                             ava:avatar3,
                                                                             LoR:0
                                                                         })
                                                                }

                                                                    if(currentid == id4) {
                                                                        chatlog.append ({
                                                                            name:username4,
                                                                             message:currentmessage,
                                                                             avatar:avatar4,
                                                                             ava:avatar4,
                                                                             LoR:1
                                                                         })
                                                                }

                previousmessage = currentmessage;
                chat.positionViewAtEnd()
            }
        } */

        onTriggered:if(currentmessage != previousmessage) {console.log(currentmessage),Scripts.last_update(roomid), previousmessage = currentmessage, chat.positionViewAtEnd() }

    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width* 0.99
        height:parent.height
        spacing:8


        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            id:logbackground
            width:parent.width * 0.96
            height:parent.height * 0.94
            radius:8
            color:Qt.rgba(0.1,0.1,0.1,0.5)
            clip:true
            opacity:0.7

            visible:if(roomid == " ") {false} else {true}

            Flickable {
                width:parent.width * 0.98
                height:parent.height * 0.98
                anchors.top:parent.top
                //contentHeight: chat.height
                contentWidth: width

                ListView {
                    id:chat
                    width:parent.width
                    height:parent.height




                    model:ListModel {
                        id:chatlog


                    }

                    delegate: Item {
                                width:parent.width
                                height:logbackground.height * 0.10



                                    Rectangle {
                                        x:if(LoR == 0) {0} else {parent.width - width}
                                        id:avatarbacking
                                        width:parent.height * 0.90
                                        height:parent.height * 0.90
                                        color:"black"
                                        border.color:"gray"

                                        Image {
                                            //avatar area, we crop it from 0,0 to what ever the height is. This will probably be replaced
                                            anchors.fill: parent
                                            fillMode:Image.PreserveAspectCrop
                                            source:"file:./themes/avatars/"+ava+"/chatbox.png"
                                           // mirror: if(LoR== 1) {true} else {false}
                                        }
                                    }
                                    Rectangle {
                                        x:if(LoR == 1) {0} else {avatarbacking.width}
                                        width:parent.width - avatarbacking.width
                                        height:parent.height * 0.90
                                        color:Qt.rgba(0.8,0.8,0.8,0.9)

                                        Text {
                                            color:"white"
                                            width:parent.width
                                            height:parent.height
                                            clip:true
                                            wrapMode:Text.WordWrap
                                            font.pixelSize: parent.height * 0.3
                                            text:name+": "+message
                                            horizontalAlignment: if(LoR==1) {Text.AlignRight} else {Text.AlignLeft}
                                        }

                                    }
                    }


                }
            }


        }


    }


Text {
    anchors.bottom:parent.bottom
    anchors.right:parent.right
    text:roomid
    onTextChanged: Scripts.load_chat(roomid);
}


}
