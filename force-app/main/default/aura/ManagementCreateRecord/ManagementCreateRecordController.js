({
    doInit: function(component, event, helper) {
        var recTypeId = component.get("v.pageReference").state.recordTypeId;
        var action = component.get("c.managementCase");
        var sPageURL = decodeURIComponent(window.location.search.substring(1));
        var idFrom = sPageURL.search('id=');
        var recId = sPageURL.substr(idFrom + 3, 15);
        
        action.setParams({ managementRecordTypeId : recTypeId,
                           accidentRecordId : recId});	
        
        action.setCallback(this,function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                window.location.href='/'+response.getReturnValue();
            }else{
                alert("Error");
            }
        })	
        $A.enqueueAction(action);
    }
})