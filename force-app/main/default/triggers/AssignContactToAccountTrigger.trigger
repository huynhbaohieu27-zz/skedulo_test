trigger AssignContactToAccountTrigger on Contact (after update, after insert, after delete) {
    if (Trigger.isInsert) {
        ContactHelpers.insertContact(Trigger.new);
    } else if (Trigger.isUpdate) {
        ContactHelpers.updateContact(Trigger.new);
    } else {
        ContactHelpers.deleteContact(Trigger.old);
    }
}