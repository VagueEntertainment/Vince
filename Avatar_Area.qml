import QtQuick 2.3
import QtQuick.Window 2.2
import "openseed.js" as OpenSeed

import QtQuick.LocalStorage 2.0 as Sql


Item {

    id:window_container

    property string avatheme: "default"
    property string avatar_position: "l"
    property string emotion: "blank"
    property int locale: 0
    property string name: ""

    states: [

        State {
            name:"Hide"

            PropertyChanges {
                target:window_container
                //visible:false
                opacity:0.0


            }

        },
        State {
            name:"Show"

            PropertyChanges {
                target:window_container
                //visible:true
                opacity:1.0


            }

        }

    ]

    transitions: [
        Transition {
            from: "Hide"
            to: "Show"

            NumberAnimation {
                target: window_container
                property: "opacity"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        },

        Transition {
            from: "Show"
            to: "Hide"

            NumberAnimation {
                target: window_container
                property: "opacity"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

    ]

   // state:"Show"


    Item {
        id:ava_pos

        //this will be default for destkop mode
        anchors.bottom:parent.bottom

        x:switch(locale) {
          case 1: 0;break;
          case 2: parent.width - width;break;
          case 3: (parent.width - width) * 0.5;break;

          }
        onXChanged: switch(locale) {
                    case 1: avatar_position="l";break;
                    case 2: avatar_position="r";break;
                    case 3: avatar_position="c";break;

                    }

        width:if(locale != 3) {parent.width * 0.40} else {parent.width * 0.60}
        height:parent.height * 0.80

       Image {
            id:avatar
            source:"file:./themes/avatars/"+avatheme+"/"+avatar_position+"/"+emotion+".png"
            anchors.fill:parent
            fillMode:Image.PreserveAspectFit
        }

       Rectangle {
           anchors.horizontalCenter: parent.horizontalCenter
           anchors.horizontalCenterOffset: -10
           anchors.bottom:parent.bottom
           anchors.bottomMargin:parent.height * 0.10
           color:Qt.rgba(0.4,0.4,0.4,0.8)
           width:parent.width * 0.45
           height:parent.height * 0.08
           radius:8

           Text {
               anchors.centerIn: parent
               color:"white"
               text:name

           }
       }

    }



}
