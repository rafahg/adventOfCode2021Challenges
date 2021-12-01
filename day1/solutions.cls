public with sharing class AdventOfCode2021Day1 {


    // Solution A
    
    public static Integer howManyIncrease(List<String> beeps) {
        List<Integer> beepsInt = stringToIntConverter(beeps);
        Integer counter = 0;
        for(Integer i=0; i<beepsInt.size()-1; i++) {
            if(beepsInt[i] < beepsInt[i+1]) {
                counter +=1;
            }
        }
        return counter;
    }
    
    // Solution B

    public static Integer howManyIncreaseIn3beepsWindow(List<String> beeps) {
        List<Integer> beepsInt = stringToIntConverter(beeps);
        Integer counter = 0;
        for(Integer i=0; i<beepsInt.size()-3; i++) {
            if((beepsInt[i] + beepsInt[i+1] + beepsInt[i+2] ) < (beepsInt[i+1] + beepsInt[i+2] + beepsInt[i+3])) {
                counter +=1;
            }
        }
        return counter;
    }


    // Helper Methods

    public static List<String> getInput(String day) {
        StaticResource  input = [Select Id, body from StaticResource where Name=:day];
        String inputContent = input.body.toString();
        List<String> finalInput = inputContent.split('\\n');
        return finalInput;
    }


    private static List<Integer> stringToIntConverter(List<String> strings) {
        List<Integer> integers = new List<Integer>();
        for(String stringItem : strings) {
            integers.add(Integer.valueOf(stringItem));
        }
        return integers;
    }

}


  
