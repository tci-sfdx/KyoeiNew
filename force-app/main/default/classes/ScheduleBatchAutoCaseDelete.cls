global class ScheduleBatchAutoCaseDelete implements Schedulable {
global void execute(SchedulableContext sc) {
            CaseDeleteBatch b = new CaseDeleteBatch();
            database.executebatch(b,200);
      }
}