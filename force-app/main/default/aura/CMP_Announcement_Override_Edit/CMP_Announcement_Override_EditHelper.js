/**
 * Created by daini on 19/02/01.
 */
({
    errorToast : function(errorMsg) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Failure!",
            "message": errorMsg,
            "type": "error"
        });
        toastEvent.fire();
    },
    redirectToAnnouncement : function(recordId) {
        var homeEvt = $A.get("e.force:navigateToSObject");
        homeEvt.setParams({
            "recordId": recordId
        });
        homeEvt.fire();
    }
})