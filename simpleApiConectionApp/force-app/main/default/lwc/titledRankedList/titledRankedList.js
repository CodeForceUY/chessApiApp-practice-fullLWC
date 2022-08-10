import { LightningElement , api} from 'lwc';
import { setChessName } from 'c/simpleApiComponent';

export default class TitledRankedList extends LightningElement {

    value = 'inProgress';
    arrayRanked = [];

    get options() {
        return [
            { label: 'Grand Master', value: 'GM' },
            { label: 'International Master', value: 'IM' },
            { label: 'FIDE Master', value: 'FM' },
            { label: 'Candidate Master', value: 'CM' },
            { label: 'Woman Grandmaster', value: 'WGM' },
            { label: 'Woman International Master', value: 'WIM' },
            { label: 'Woman FIDE Master', value: 'WFM' },
            { label: 'Woman Candidate Master', value: 'WCM' },
        ];
    }

    handlePicklst(event) {
        this.value = event.detail.value;
    }


    handleClickRankedLst(){
        const calloutURL = "https://api.chess.com/pub/titled/" + this.value;
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
            this.arrayRanked = responseJSON.players;
        });
    }

    get arrayPlayers(){
        return this.arrayRanked;
    }

}