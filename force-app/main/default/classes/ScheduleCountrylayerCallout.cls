public class ScheduleCountrylayerCallout implements Schedulable {
    public void execute(SchedulableContext sc){
        CountrylayerCallout.makeCallout();
    }
}
