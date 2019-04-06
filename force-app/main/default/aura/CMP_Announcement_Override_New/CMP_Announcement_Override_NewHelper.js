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
    getTodayFormattedDay: function() {
        var today = new Date();
        var dateString = '';
        dateString += today.getFullYear() + '-';
        dateString += this.formatDateValue(today.getUTCMonth() + 1) + '-';
        dateString += this.formatDateValue(today.getUTCDate()) + 'T';
        dateString += this.formatDateValue(today.getUTCHours()) + ':';
        dateString += this.formatDateValue(today.getUTCMinutes()) + ':';
        dateString += this.formatDateValue(today.getUTCSeconds()) + '.000Z';
        return dateString;
    },
    formatDateValue : function(value) {
        return (value < 10 ? '0' + value : value)
    }
})