import { LightningElement , track } from 'lwc';

export default class SimpleApiComponent extends LightningElement {

    @track chessName;
    @track avatar;
    @track url;
    @track namee;
    @track username;
    @track title;
    @track followers;
    @track location;
    @track twitch_url;

    getChessPlayer(event){
        this.chessName = event.target.value;
    }
    
    handleClick(){
        this.avatar = "";
        this.url = "";
        this.namee = "";
        this.username = "";
        this.title = "";
        this.followers = "";
        this.location = "";
        this.twitch_url = "";
        const calloutURL = "https://api.chess.com/pub/player/" + this.chessName;
        fetch(calloutURL, { 
            method : "GET",
            headers:{
                Accept : "application/json"
            }
        }).then((response) =>{
            if(response.ok){
                return response.json();
            }
        }).then((responseJSON) =>{
            this.avatar = String(responseJSON.avatar);
            this.url = String(responseJSON.url);
            this.namee = responseJSON.name;
            this.username = responseJSON.username;
            this.title = responseJSON.title;
            this.followers = responseJSON.followers;
            this.location = responseJSON.location;
            this.twitch_url = String(responseJSON.twitch_url);
        });
        this.chessName = "";
    }

    get getAvatar(){
        return this.avatar;
    }
    get getUrl(){
        return this.url;
    }
    get getName(){
        return this.namee;
    }
    get getUsername(){
        return this.username;
    }
    get getTitle(){
        return this.title;
    }
    get getFollowers(){
        return this.followers;
    }
    get getLocation(){
        return this.location;
    }
    get getTwitchUrl(){
        return this.twitch_url;
    }
}