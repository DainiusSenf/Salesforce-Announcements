/**
 * Created by daini on 19/02/01.
 */
({
    initData : function(component, event, helper) {
        component.set("v.startDate", helper.getTodayFormattedDay());

        var action = component.get("c.getAllProfilesNames");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var profiles = response.getReturnValue();
                component.set("v.profiles", profiles);
                component.set("v.loaded", true);
            } else {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                        helper.errorToast(errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
                component.set("v.loaded", true);
            }
        });
        $A.enqueueAction(action);
    },

    handleSubmit : function(component, event, helper) {
        event.preventDefault();       // stop the form from submitting
        var fields = event.getParam('fields');
        fields.Profile_Group__c = component.get("v.selectedProfiles").join(", ");
        component.find('announcementForm').submit(fields);
    },

    handleSuccess : function(component, event, helper) {
        var payload = event.getParams().response;
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId":  payload.id
        });
        navEvt.fire();
    },

    handleChange : function (component, event, helper) {
        component.set("v.selectedProfiles", event.getParam("value"));
    },

   cancelDialog : function(component, helper) {
       var homeEvt = $A.get("e.force:navigateToObjectHome");
       homeEvt.setParams({
           "scope": "Announcement__c"
       });
       homeEvt.fire();
   }
})