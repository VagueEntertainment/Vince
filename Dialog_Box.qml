import QtQuick 2.3
import QtQuick.Window 2.2
import "openseed.js" as OpenSeed
import "main.js" as Scripts

import QtQuick.LocalStorage 2.0 as Sql

 Item {

    // property string speaker:"speaker 1"



     Timer {
         id:fadeout
         interval:if(currentmessage.length * 400 > 1500) {400*currentmessage.length} else {(400*currentmessage.length) + 1000}
         running:false
         repeat:false
         onTriggered: logbackground.state = "Hide"
     }

   /*  Timer {
         id:checkchat
         interval: 5000
         running:if(roomid != " " && heart == "Online") {true} else {false}
         repeat: true
         onTriggered: OpenSeed.retrieve_chat(roomid,currentid)
     } */


     Rectangle {
         anchors.horizontalCenter: parent.horizontalCenter
         id:logbackground
         width:parent.width
         height:parent.height
         radius:8
         color:Qt.rgba(0.1,0.1,0.1,0.8)
         clip:true

         states: [

            State {
                 name:"Hide"
                 PropertyChanges {
                     target:logbackground
                     opacity:0.0
                 }
             },
             State {
                 name:"Show"
                 PropertyChanges {
                     target:logbackground
                     opacity:1.0
                 }
             }

         ]
         state:"Hide"

         transitions: [
             Transition {
                 from: "Hide"
                 to: "Show"

                 NumberAnimation {
                     target: logbackground
                     property: "opacity"
                     duration: 200
                     easing.type: Easing.InOutQuad
                 }
             },

             Transition {
                 from: "Show"
                 to: "Hide"

                 NumberAnimation {
                     target: logbackground
                     property: "opacity"
                     duration: 200
                     easing.type: Easing.InOutQuad
                 }
             }

         ]

         onStateChanged: if(logbackground.state == "Hide") {} else {}

         Text {
             anchors.top:parent.top
             anchors.left:parent.left
             anchors.margins: parent.height * 0.01
             width:logbackground.width * 0.98
             height:logbackground.height * 0.98
             wrapMode: Text.WordWrap
             font.pixelSize: parent.height * 0.2
             text:if(currentmessage.length > 1){speaker+": "+currentmessage.replace(/&#x27;/g,"'")} else {""}
             color:"white"
             onTextChanged: {

                 logbackground.state = "Show"
                 fadeout.running =true

             }
         }
     }

 }
