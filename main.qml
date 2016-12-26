import QtQuick 2.3
import QtQuick.Window 2.2

import "openseed.js" as OpenSeed
import "main.js" as Scripts

import QtQuick.LocalStorage 2.0 as Sql



Window {
    visible: true
    width: Screen.width * 0.80
    height: Screen.height * 0.80


    //openseed gobals
    property string id: ""
    property string username: "" //this might need to have a secondary variable for those that RP
    property string useremail:""
    property string devId: "Vag-01001011" //given by the OpenSeed server when registered
    property string appId: "VagVIN-5859" //given by the OpenSeed server when registered

    property string heart: ""

    //global variables for visual stuff

    property string background: "default_BG.png"
    property string themename: "none"

    //each possible chatter needs to have a avatar set.

    property string avatar1:"default"
    property string avatar2:" "
    property string avatar3:" "
    property string avatar4:" "


    property string id2:"2"
    property string id3:"3"
    property string id4:"4"

     property string username1: username
     property string username2: ""
     property string username3: ""
     property string username4: ""
    property string speaker: ""


    // up to four people per chat "area" //
    property int avatar1_position: 1
    property int avatar2_position: 2
    property int avatar3_position: 1
    property int avatar4_position: 2


    //chat stuff
    property string roomid:" "
    property string currentmessage: " "
    property string currentid: " "
     property string previousmessage: " "
    property string part_id: ""
    property string part_avatar: ""
    property string part_names: ""
    property string mesgdate: ""
    property int remote: 1


    property int playing: 0
    property int frames: 2
    property int currentframe: 1





    //Timers: Area for all those timed events that make things....tick

    Timer {
        id:firstrun
        interval:10
        running:true
        repeat:false
        onTriggered:Scripts.firstload()

    }

    Timer {
        id:heartbeats
        interval:1000
        running:true
        repeat:true
        onTriggered:OpenSeed.heartbeat()

    }

    Background {
        id:bg
        anchors.fill:parent
    }

    Text {

        anchors.bottom:parent.bottom
        anchors.left:parent.left
        text:heart
    }


    Item {
        id:window_container

        anchors.fill:parent

        Chat_box {
            id:chatbox
            anchors.fill:parent
        }
        Avatar_Area {
            id:ava1
            anchors.fill:parent
            state:if(avatar1 != " ") {"Show"} else {"Hide"}
            avatheme:avatar1
            locale:1
            name:username

        }
        Avatar_Area {
            id:ava2
            anchors.fill:parent
            state:if(avatar2 != " ") {"Show"} else {"Hide"}
            avatheme:avatar2
            locale:2
            name:username2

        }
        Avatar_Area {
            id:ava3
            anchors.fill:parent
            state:if(avatar3 != " ") {"Show"} else {"Hide"}
            avatheme:avatar3
            locale:1
            name:username3
        }
        Avatar_Area {
            id:ava4
            anchors.fill:parent
            state:if(avatar4 != " ") {"Show"} else {"Hide"}
            avatheme:avatar4
             locale:2
             name:username4
        }

        Dialog_Box {
            id:dialog
            anchors.bottom:chat_entry.top
            anchors.bottomMargin:4
            anchors.horizontalCenter: chat_entry.horizontalCenter
            height:parent.height * 0.2
            width:chat_entry.width
        }

        Chat_entry {
            id:chat_entry
            anchors.bottom:parent.bottom
            anchors.bottomMargin:10
            width:parent.width * 0.98
            anchors.horizontalCenter: parent.horizontalCenter
            height:parent.height * 0.05
        }

        Preview {
            id:avatar_preview
            state: "Hide"

        }


        Rooms {
            id:chat_controls
            z:1
            state: "Hide"
        }

        Avatar_Select {
            id:theme_controls
            z:if(chat_controls.state == "Show") {0} else {1}
             state:"Hide"
        }

        Request {
            id:requests
            state:"Hide"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Auth {
            id:os_connect
            anchors.centerIn: parent
            width:parent.width * 0.60
            height:parent.height * 0.70
            state:"Hide"
        }

    }

}

