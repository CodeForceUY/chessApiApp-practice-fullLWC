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
        try{
            PlayerObject payloadObject = (PlayerObject) JSON.deserialize(payload, PlayerObject.class);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] destinatarios = new String[]{email};
            mail.toAddresses = destinatarios;
            string subject = 'Informacion de ' + payloadObject.nameObj;
            string cuerpo = 'Name: ' + payloadObject.nameObj + 'Nombre de Usuario: ' + payloadObject.usernameObj + 'Titulo Maestria: ' + payloadObject.titleObj + 'Twitch Url: ' + payloadObject.turlObj + 'Chess.com Url: ' + payloadObject.urlObj;
            mail.subject = subject;
            mail.plainTextBody = cuerpo;
            Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {mail};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        }catch(exception e){
            system.debug('Error '+ e.getMessage());
        }
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
