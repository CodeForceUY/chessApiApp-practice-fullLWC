public class chessController {
    
    @AuraEnabled
    public static string savePlayerApex(String payload) {
        PlayerObject payloadObject = (PlayerObject) JSON.deserialize(payload, PlayerObject.class);
  
        // La siguiente linea es generica no hardcoded accepta cualquier SObject y lo trae por nombre no optima si se sabe objetivo o(n)?.
        SObject playObj = (SObject) Type.forName('chessSaver__c').newInstance();
        playObj.put('chessUrl__c', payloadObject.urlObj);
        playObj.put('foto__c', payloadObject.avatarObj);
        playObj.put('nombre__c', payloadObject.nameObj);
        playObj.put('nombreUsuario__c', payloadObject.usernameObj);
        playObj.put('seguidores__c', payloadObject.followersObj);
        playObj.put('titulo__c', payloadObject.titleObj);
        playObj.put('twiUrl__c', payloadObject.turlObj);
        playObj.put('ubicacion__c', payloadObject.locationObj);
  
        insert playObj;
  
        return String.valueOf(playObj.Id);
    }

    public static void sendEmailBackend(string payload, string email){
        PlayerObject payloadObject = (PlayerObject) JSON.deserialize(payload, PlayerObject.class);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddress = new String[]{email};
        string subject = 'Informacion de ' + payloadObject.nameObj;
        string cuerpo = 'Name: ' + payloadObject.nameObj + 'Nombre de Usuario: ' + payloadObject.usernameObj + 'Titulo Maestria: ' + payloadObject.titleObj + 'Twitch Url: ' + payloadObject.turlObj + 'Chess.com Url: ' + payloadObject.urlObj;
        mail.setToAddresses(toAddress);
        mail.setSubject(subject);
        mail.setHtmlBody('<h1>'+ cuerpo + '</h1>');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

    public class PlayerObject {
        @AuraEnabled
        public string avatarObj;
        @AuraEnabled
        public string urlObj; 
        @AuraEnabled
        public string nameObj; 
        @AuraEnabled
        public string usernameObj; 
        @AuraEnabled
        public string titleObj; 
        @AuraEnabled
        public string followersObj; 
        @AuraEnabled
        public string locationObj;
        @AuraEnabled
        public string turlObj;
    }
}
