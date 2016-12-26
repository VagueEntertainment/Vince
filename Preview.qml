import QtQuick 2.0

Item {

        id:window_container
        width:parent.width * 0.58
        height:parent.height * 0.98
        anchors.verticalCenter: parent.verticalCenter
        anchors.left:parent.left
        anchors.leftMargin:parent.width * 0.01

        property string avatheme: "default"
        property string avathemeartist: "Benjamin Flanagin"
        property string avathemedate: "5-17-16"
        property string avathemeother: "www.example.com"
        property string avathemediscription: "default discription"

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

Rectangle {
    color:Qt.rgba(0.1,0.1,0.1,0.7)
    anchors.fill:parent

    Image {
        id:preimage
        source:"file:./themes/avatars/"+avatheme+"/preview.png"
        width:parent.width * 0.30
        height:parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.left:parent.left
        anchors.leftMargin:parent.width * 0.01
        fillMode:Image.PreserveAspectFit
    }
    Column {
        width:parent.width - preimage.width
        anchors.left:preimage.right
        height:parent.height
        anchors.top:parent.top
        spacing:parent.height * 0.01

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: parent.height * 0.08
            color:"White"
            width:parent.width
            wrapMode:Text.WordWrap
            text:avatheme
        }
        Text {
            width:parent.width
            wrapMode:Text.WordWrap
            text:"Artist: "+avathemeartist
            color:"White"
            font.pixelSize: parent.height * 0.03
        }
        Text {
            width:parent.width
            wrapMode:Text.WordWrap
            text:"Date: "+avathemedate
            color:"White"
            font.pixelSize: parent.height * 0.03
        }
        Text {
            width:parent.width
            wrapMode:Text.WordWrap
            text:"Other works: "+avathemeother
            color:"White"
            font.pixelSize: parent.height * 0.03
        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            color:"white"
            border.color:"black"
            width:parent.width * 0.90
            height:parent.height * 0.01
        }

        Text {
            width:parent.width
            wrapMode:Text.WordWrap
            text:"Discription:\n "+avathemediscription
            color:"White"
            font.pixelSize: parent.height * 0.03
        }
    }

}




//nothing below line
}

