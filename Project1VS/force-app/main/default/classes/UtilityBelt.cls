public class UtilityBelt {
	//code coverage 92%
    
    //public static void RecordPuller(){
    //    List<Task> taskList  = [SELECT  FROM Task LIMIT:3];
    //    for (Task T: taskList){
    //        system.debug(T);
    //    }
    //}
    
    public Task ToTaskQueue(string queueName, string subject, string priority, id taskID, id accountId){
		//creates a task and assciates it with a specific contract and puts it in a queue
		//currently does not associate with contract
        
        queueName = '{{' + queueName + '}}';
        
        Group g = [SELECT Id, Name, Type FROM Group WHERE Type = 'Queue'][0];

        system.debug(g.Name);
        
        Task newTask = new Task();
        newTask.Subject = subject;
        newTask.Priority = priority;
        //newTask.WhoId = ID;
        newTask.WhatId = taskID;
        newTask.OwnerId = g.Id; 
        return newTask;
        
    }

    public GroupMember ToContactQueue(string queueName, string subject, string priority, id contactID){
		//creates a task and assciates it with a specific contract and puts it in a queue
		//currently does not associate with contract
        
        string selectorString = 'SELECT Id, Name, Type FROM Group WHERE Name = {0} and Type = \'Queue\'';
        
        string finQuery = String.format(selectorString, new List<String>{queueName});
        
        
        Group g = database.query(finQuery);

		GroupMember member = new GroupMember();
        member.UserOrGroupId = contactID;
        member.GroupId = g.Id;

        return member;
    }
    
    public String ValidCard(String cardNum, String secCode){
        //evaluated a credit card number to ensure that it is from a valid company
        //after the first digit determines the company that is used to determine the target format
        Set<String> validNumbers = new Set<String>{'3', '4', '5', '6'};
        Map<String, List<Integer>> rules = new Map<String, List<Integer>>() ;
        Map<String, String> typeName = new Map<String, String>();

        typeName.put('3', 'AmEx');
        typeName.put('4', 'Visa');
        typeName.put('5', 'MasterCard');
        typeName.put('6', 'Discover');
        
        rules.put('3', new List<Integer>{15, 4});
        rules.put('4', new List<Integer>{16, 3});
        rules.put('5', new List<Integer>{16, 3});
        rules.put('6', new List<Integer>{16, 3});

        String firstDigit = cardNum.substring(0,1);

		if (cardNum.length() != rules.get(firstDigit)[0] || !validNumbers.contains(firstDigit) ){
            return 'Card Number Invalid';
        }else if (secCode.length() != rules.get(firstDigit)[1]){
            return 'Security Code Invalid';
        }else{
            return 'Valid ' + typeName.get(firstDigit);
        }
        
        
    }
}