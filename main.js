

function load_chat(room) {

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

        var logid;
        var lr;


    var testStr = "SELECT  *  FROM CHATS WHERE roomid='"+room+"'";

        chatlog.clear();

        db.transaction(function(tx) {

            var pull =  tx.executeSql(testStr);
            var num = 1;

            while(pull.rows.length > num) {


                if(id != pull.rows.item(num).id) {
                    if(id2.length < 2) {
                    avatar2 =pull.rows.item(num).avatar;
                    username2 =pull.rows.item(num).name;
                    id2 = pull.rows.item(num).id;
                        ava2.state = "Show";
                        ava2.locale = 2;
                        logid = pull.rows.item(num).id;

                    } else if(id2 !=pull.rows.item(num).id) {
                        if(id3.length < 2) {
                            avatar3 =pull.rows.item(num).avatar;
                            username3 =pull.rows.item(num).name;
                            id3 = pull.rows.item(num).id;
                            ava3.state = "Show";
                            ava3.locale = 1;
                      logid = pull.rows.item(num).id;

                    } else if(id3 != pull.rows.item(num).id) {
                            avatar4 =pull.rows.item(num).avatar;
                            username4 =pull.rows.item(num).name;
                            id4 = pull.rows.item(num).id;
                            ava4.state = "Show";
                            ava4.locale = 2;
                          logid = pull.rows.item(num).id;
                        }
                    }

                } else {
                    avatar1 =pull.rows.item(num).avatar;
                    username1 =pull.rows.item(num).name;
                    username =pull.rows.item(num).name;
                    id = pull.rows.item(num).id;
                     ava1.locale = 1;
                     logid = pull.rows.item(num).id;
                }



                      part_id = id+";"+id2+";"+id3+";"+id4
                     part_names = username1+";"+username2+";"+username3+";"+username4
                     part_avatar = avatar1+";"+avatar2+";"+avatar3+";"+avatar4;

                    speaker = pull.rows.item(num).speaker;

                    mesgdate = pull.rows.item(num).date;
                    currentid = pull.rows.item(num).id;

                         if(currentid == id ) {lr = 0} else {lr = 1}


                if(pull.rows.item(num).message.search("<background;;") == -1){

                    previousmessage = pull.rows.item(num).message;
                    currentmessage = pull.rows.item(num).message;

                chatlog.append ({
                                name:pull.rows.item(num).speaker,
                                ava:pull.rows.item(num).avatar,
                                message:pull.rows.item(num).message.replace(/&#x27;/g,"'"),
                                LoR:lr
                                });
                } else {
                    themename = pull.rows.item(num).message.split(";;")[1];
                    background = pull.rows.item(num).message.split(";;")[2].split(">")[0];
                }


                num = num + 1
            }

        });

   // console.log(part_id,part_names);

    chat.positionViewAtEnd();

}

function save_chat() {

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

    part_id = id+";"+id2+";"+id3+";"+id4
    part_names = username1+";"+username2+";"+username3+";"+username4
    part_avatar = avatar1+";"+avatar2+";"+avatar3+";"+avatar4;

    mesgdate = Date();
    var data = [id,username,avatar1,part_id,part_names,part_avatar,roomid,mesgdate,currentmessage.replace(/\'/g,"&#x27;"),username];

    var userStr = "INSERT INTO CHATS VALUES(?,?,?,?,?,?,?,?,?,?)";


   var testStr = "SELECT  *  FROM CHATS WHERE id='"+id+"' AND date='"+mesgdate+"' AND message='"+currentmessage.replace(/\'/g,"&#x27;")+"'";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS CHATS (id TEXT, name TEXT,avatar TEXT,part_id TEXT, part_names TEXT,part_avatar TEXT,roomid TEXT,date TEXT,message TEXT,speaker TEXT)');

            var pull = tx.executeSql(testStr);

            if(pull.rows.length == 0) {


            tx.executeSql(userStr,data);

            }

        });

         db.transaction(function(tx) {

             tx.executeSql('CREATE TABLE IF NOT EXISTS AREAS (id TEXT, roomid TEXT,party INT,lastdate TEXT,lastmessage TEXT)');

            var updateArea = "UPDATE AREAS SET lastdate='"+Date()+"',party='"+part_id.split(";").length+"',lastmessage='"+currentmessage.replace(/\'/g,"&#x27;")+"' WHERE roomid='"+roomid+"'";

            tx.executeSql(updateArea);

         });

}

function firstload() {

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);



    var testStr = "SELECT  *  FROM USER WHERE 1";

        db.transaction(function(tx) {
          //tx.executeSql("DROP TABLE USER");
            tx.executeSql('CREATE TABLE IF NOT EXISTS USER (id TEXT, name TEXT, avatar_packs TEXT, theme_packs TEXT)');

             var pull =  tx.executeSql(testStr);

          //  console.log(pull.rows.length);

            if(pull.rows.length == 0) {
                os_connect.state = "Show";
            } else {
                id = pull.rows.item(0).id;
                username = pull.rows.item(0).name;
                list_areas();
                chat_controls.state = "Show";
                heart.running = true;
            }

        });

}

function list_areas(where) {
    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);


    var testStr = "SELECT  *  FROM AREAS WHERE 1";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS AREAS (id TEXT, roomid TEXT,party INT,lastdate TEXT,lastmessage TEXT)');

            var pull = tx.executeSql(testStr);

            if(pull.rows.length == 0) {
                console.log("No Areas found. Creating new");
                create_area("local");

            } else {
                   // roomid = pull.rows.item(0).roomid;

            if(where == "roomlist") {
                roomlist.clear();
                var num = 0;
                while ( num < pull.rows.length) {

                    var pull2 = tx.executeSql("SELECT * FROM CHATS WHERE roomid='"+pull.rows.item(num).roomid+"'");



                roomlist.append ({
                                partynum:pull.rows.item(num).party,
                                lastmessage:pull.rows.item(num).lastmessage.replace(/&#x27;/g,"'"),
                                lastdate:pull.rows.item(num).lastdate,
                                room:pull.rows.item(num).roomid,
                                party_names:pull2.rows.item(pull2.rows.length - 1).part_names
                                 });

                        num = num + 1;
                        }

                  }

            }

        });


}

function create_area(remote) {
    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

    var d = new Date();
    if(remote == "local") {
    roomid = id+d.getTime();
    } else {
        roomid = remote;
    }

    part_id = id+";"+id2+";"+id3+";"+id4
    part_names = username1+";"+username2+";"+username3+";"+username4
    part_avatar = avatar1+";"+avatar2+";"+avatar3+";"+avatar4;


    var data = [id,username,avatar1,part_id,part_names,part_avatar,roomid,Date(),"<start>","none"];

    var userStr = "INSERT INTO CHATS VALUES(?,?,?,?,?,?,?,?,?,?)";


    var testStr = "SELECT  *  FROM CHATS WHERE 1";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS CHATS (id TEXT, name TEXT,avatar TEXT,part_id TEXT, part_names TEXT,part_avatar TEXT,roomid TEXT,date TEXT,message TEXT,speaker TEXT)');

            tx.executeSql(userStr,data);

        });

    var areaStr = "INSERT INTO AREAS VALUES(?,?,?,?,?)";
        data = [id,roomid,part_id.split(";").length,Date(),"<start>"];

     var testAreas = "SELECT  *  FROM AREAS WHERE roomid='"+roomid+"'";

    db.transaction(function(tx) {

        var pull =  tx.executeSql(testAreas);

        if(pull.rows.length == 0) {

        tx.executeSql('CREATE TABLE IF NOT EXISTS AREAS (id TEXT, roomid TEXT,party INT,lastdate TEXT,lastmessage TEXT)');
        tx.executeSql(areaStr,data);
        }

    });
}




function change_Emotion(message,theid) {
        var  avatarchoice;


   if(theid == id) {
       avatarchoice = ava1;
   } else if (theid == id2){
       avatarchoice = ava2;
   } else if (theid == id3) {
       avatarchoice = ava3;
   } else if (theid == id4) {
       avatarchoice = ava4;
   }


    if(message.split(":)").length > 1){avatarchoice.emotion="happy";}
    if(message.split(":(").length > 1){avatarchoice.emotion="frown";}
    if(message.split(":/").length > 1){avatarchoice.emotion="smirk1";}
    if(message.split(":\\").length > 1){avatarchoice.emotion="smirk2";}
    if(message.split(";)").length > 1){avatarchoice.emotion="wink";}
    if(message.split(":P").length > 1){avatarchoice.emotion="tounge";}
    if(message.split(":O").length > 1){avatarchoice.emotion="shock";}
    if(message.split(":_(").length > 1){avatarchoice.emotion="cry";}
    if(message.split("T-T").length > 1){avatarchoice.emotion="smirk2";}
    if(message.split("0-0").length > 1){avatarchoice.emotion="blank";}
    if(message.split(";\*").length > 1){avatarchoice.emotion="flirt";}
    if(message.split(":\*").length > 1){avatarchoice.emotion="kiss";}
    if(message.split(":D").length > 1){avatarchoice.emotion="largesmile";}
    if(message.split("|‑O").length > 1){avatarchoice.emotion="bored";}
    if(message.split("\\o\/").length > 1){avatarchoice.emotion="cheer";}
    if(message.split("<3").length > 1){avatarchoice.emotion="love";}
    if(message.split(":|").length > 1){avatarchoice.emotion="blank";}



}

function change_Position(message,theid) {

    var  avatarchoice;
    if(theid == id) {
        avatarchoice = ava1;
    } else if (theid == id2){
        avatarchoice = ava2;
    } else if (theid == id3) {
        avatarchoice = ava3;
    } else if (theid == id4) {
        avatarchoice = ava4;
    }

    if(message.split("!!").length > 1){avatarchoice.locale=3;}
     if(message.split("<<").length > 1){if(currentid == id) {avatarchoice.locale=1 } else {avatarchoice.locale =2;}
                                           // if (previousmessage == currentmessage) {avatarchoice.state = "Hide"}
                                        }
     if(message.split(">>").length > 1){if(currentid == id) {avatarchoice.locale=2;} else {avatarchoice.locale =1;}
                                               //  if (previousmessage == currentmessage) {avatarchoice.state = "Hide"}
                                        }


}

function play_log(room) {


    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);



    var testStr = "SELECT  *  FROM CHATS WHERE roomid='"+room+"'";




        db.transaction(function(tx) {

            var pull =  tx.executeSql(testStr);

             frames = pull.rows.length;

            if(pull.rows.item(currentframe).message.search("<background;;") == -1){

                currentmessage = pull.rows.item(currentframe).message;
                currentid = pull.rows.item(currentframe).id;

                switch(pull.rows.item(currentframe).id) {
                case id:avatar1 = pull.rows.item(currentframe).avatar;break;
                case id2:avatar2 = pull.rows.item(currentframe).avatar;break;
                case id3:avatar3 = pull.rows.item(currentframe).avatar;break;
                case id4:avatar4 = pull.rows.item(currentframe).avatar;break;
                default:break;
                }

                change_Emotion(pull.rows.item(currentframe).message,pull.rows.item(currentframe).id);
                change_Position(pull.rows.item(currentframe).message,pull.rows.item(currentframe).id);

                speaker = pull.rows.item(currentframe).speaker;

} else {
                themename = pull.rows.item(currentframe).message.split(";;")[1];
                background = pull.rows.item(currentframe).message.split(";;")[2].split(">")[0];
            }

                currentframe = currentframe +1;

            console.log("running play back for room "+room+"\n Which we are at "+currentframe+"/"+frames);
        });

}

function background_control() {

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);
    var thespeaker = " ";

    var data = [id,username,avatar1,part_id,part_names,part_avatar,roomid,Date(),"<background;;"+themename+";;"+background+">",thespeaker];

    var userStr = "INSERT INTO CHATS VALUES(?,?,?,?,?,?,?,?,?,?)";


    var testStr = "SELECT  *  FROM CHATS WHERE 1";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS CHATS (id TEXT, name TEXT,avatar TEXT,part_id TEXT, part_names TEXT,part_avatar TEXT,roomid TEXT,date TEXT,message TEXT,speaker TEXT)');

            tx.executeSql(userStr,data);

        });

         db.transaction(function(tx) {

             tx.executeSql('CREATE TABLE IF NOT EXISTS AREAS (id TEXT, roomid TEXT,party INT,lastdate TEXT,lastmessage TEXT)');

            var updateArea = "UPDATE AREAS SET lastdate='"+Date()+"',party='"+part_id.split(";").length+"',lastmessage='"+currentmessage.replace(/\'/g,"&#x27;")+"' WHERE roomid='"+roomid+"'";



            tx.executeSql(updateArea);

         });

}


function add_address_book(userid,name,avatar,lastseen) {

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);
    var thespeaker = " ";

    var data = [userid,name,avatar,lastseen];

    var userStr = "INSERT INTO ADDRESSES VALUES(?,?,?,?)";


    var testStr = "SELECT  *  FROM ADDRESSES WHERE 1";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS ADDRESSES (id TEXT, name TEXT,avatar TEXT,lastseen TEXT)');

            tx.executeSql(userStr,data);

        });

    address_book();
    find.visible = false;
    address.visible = true;


}

function remove_address_book(userid) {



    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);


    var userStr = "DELETE FROM ADDRESSES WHERE id='"+userid+"'";


    var testStr = "SELECT  *  FROM ADDRESSES WHERE 1";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS ADDRESSES (id TEXT, name TEXT,avatar TEXT,lastseen TEXT)');

            tx.executeSql(userStr);

        });



    address_book();
}

function address_book() {

    addressbook.clear();

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);



    var testStr = "SELECT  *  FROM ADDRESSES WHERE 1";

        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS ADDRESSES (id TEXT, name TEXT,avatar TEXT,lastseen TEXT)');

            var pull = tx.executeSql(testStr);
            var num = 0;
            while(num < pull.rows.length) {

            addressbook.append({
                            theid:pull.rows.item(num).id,
                                   name:pull.rows.item(num).name,
                                   avatar:pull.rows.item(num).avatar,
                                   lastseen:pull.rows.item(num).lastseen,



                               });

                num = num + 1;
            }

        });

}

function last_update(room) {

    var db = Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo", 1);

        var logid;
        var lr;


    var testStr = "SELECT  *  FROM CHATS WHERE roomid='"+room+"'";

       //chatlog.clear();

        db.transaction(function(tx) {

            var pull =  tx.executeSql(testStr);
            var num = pull.rows.length -1;




                if(id != pull.rows.item(num).id) {
                    if(id2.length < 2) {
                    avatar2 =pull.rows.item(num).avatar;
                    username2 =pull.rows.item(num).name;
                    id2 = pull.rows.item(num).id;
                        ava2.state = "Show";
                        ava2.locale = 2;
                        logid = pull.rows.item(num).id;

                    } else if(id2 !=pull.rows.item(num).id) {
                        if(id3.length < 2) {
                            avatar3 =pull.rows.item(num).avatar;
                            username3 =pull.rows.item(num).name;
                            id3 = pull.rows.item(num).id;
                            ava3.state = "Show";
                            ava3.locale = 1;
                      logid = pull.rows.item(num).id;

                    } else if(id3 != pull.rows.item(num).id) {
                            avatar4 =pull.rows.item(num).avatar;
                            username4 =pull.rows.item(num).name;
                            id4 = pull.rows.item(num).id;
                            ava4.state = "Show";
                            ava4.locale = 2;
                          logid = pull.rows.item(num).id;
                        }
                    }

                } else {
                    avatar1 =pull.rows.item(num).avatar;
                    username1 =pull.rows.item(num).name;
                    username =pull.rows.item(num).name;
                    id = pull.rows.item(num).id;
                     ava1.locale = 1;
                     logid = pull.rows.item(num).id;
                }



                      part_id = id+";"+id2+";"+id3+";"+id4
                     part_names = username1+";"+username2+";"+username3+";"+username4
                     part_avatar = avatar1+";"+avatar2+";"+avatar3+";"+avatar4;

                    speaker = pull.rows.item(num).speaker;
                   //previousmessage = pull.rows.item(num).message;



                    mesgdate = pull.rows.item(num).date;
                    currentid = pull.rows.item(num).id;

                         if(currentid == id ) {lr = 0} else {lr = 1}


                if(pull.rows.item(num).message.search("<background;;") == -1){

                    change_Emotion(pull.rows.item(num).message,pull.rows.item(num).id)
                    change_Position(pull.rows.item(num).message,pull.rows.item(num).id)

                        currentmessage = pull.rows.item(num).message;

                chatlog.append ({
                                name:pull.rows.item(num).speaker,
                                ava:pull.rows.item(num).avatar,
                                message:pull.rows.item(num).message.replace(/&#x27;/g,"'"),
                                LoR:lr
                                });
                } else {
                    themename = pull.rows.item(num).message.split(";;")[1];
                    background = pull.rows.item(num).message.split(";;")[2].split(">")[0];
                }


              //  num = num + 1
          //  }

        });

   // console.log(part_id,part_names);

    chat.positionViewAtEnd();


}
