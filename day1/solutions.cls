public class AdventOfCode {
    
    public static List<String> getInput() {
        StaticResource input = [Select Id, body from StaticResource where name='imputDay1'];
        String inputContent = input.body.toString();
        List<String> finalInput = inputContent.split('\\n');
        return finalInput;
    }
    
    public static Integer sum2records() {
        List<String> records = getInput();
        for(String number1 : records) {
            Integer numberToFind = 2020 - Integer.valueOf(number1);
            if(records.contains(String.valueOf(numberToFind))) {
                return (Integer) Integer.valueOf(number1) * numberTofind;
            }
        }
        return null;
    }
    

}
