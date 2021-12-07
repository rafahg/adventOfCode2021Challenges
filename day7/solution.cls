/**
 * Created by rafaelhernandez on 07/12/2021.
 */

public with sharing class AdventOfCode2021Day7 {


    // Super complex solution which needs a lot of refactoring. It reach the CPU limit 9 out of 10 times, but is working.
    public static void alignPositions(List<String> positions) {
        Map<Integer,Integer> allCrabPositions = new Map<Integer,Integer>();
        List<Integer> numPositions = listToIntegers(positions);
        //numPositions.sort();
        System.debug(numPositions);
        Integer lastPosition = numPositions[numPositions.size() -1];

        for(Integer i=0; i<lastPosition; i++) {
            allCrabPositions.put(i, 0);
        }
        Set<Integer> uniquePositions = allCrabPositions.keySet();
        List<Integer> iterablePositions = new List<Integer>(uniquePositions);

        // Determine the fuel needed by performing the operation between all the unique position
        // and all the crabs present in the data.
        for(Integer i=0; i<uniquePositions.size(); i++) {
            for(Integer position : numPositions) {
                 Integer fuel = Math.abs(iterablePositions[i] - position);
                     Integer temp = allCrabPositions.get(iterablePositions[i]) + fuel;
                     allCrabPositions.put(iterablePositions[i],temp);
            }
        }

        List<Integer> allFuelConsumption = allCrabPositions.values();
        //allFuelConsumption.sort();
        Set<Integer> test = new Set<Integer>(allFuelConsumption);

        // The solution is the first element of this set.
        system.debug(test);

    }


    // After getting crazy cause I could not adapt the first solution to the second
    // due efficiency issues, I found around (don't ask) that the average of the positions
    // is the longest position any crap should make. Having that in account for the part 2
    // I coded this solution much more simpler than the first one but less beautiful for complexity lovers
    // like me.
    public static Integer alignPositionsComplex(List<String> positions) {
       List<Integer> intPositions = listToIntegers(positions);
        Integer average = mean(intPositions);
        Integer fuel = 0;
        for( Integer position : intPositions) {
            Integer distance = Math.abs(position - average);
            fuel += complexFuelConsumption(distance);
        }
        return fuel;
    }

    //Helpers
    public static Integer complexFuelConsumption(Integer num) {
        Integer result = num * (num+1)/2;

        return result;
    }
    // Simple method to sum the elements within a list
    public static Integer sumListElements(List<Integer> nums) {
        Integer result=0;
        for(Integer num : nums) {
            if(num !=null)
                result +=num;
        }
        return result;
    }

    //It will return a list of Strings.
    public static List<String> getInput(String day) {
        StaticResource  input = [Select Id, body from StaticResource where Name=:day];
        String inputContent = input.body.toString();
        List<String> finalInput = inputContent.split(',');
        return finalInput;
    }

    // Simple method to return the inverse of a given integer.
    public static Integer inverse(Integer num) {
        return num * -1;
    }

    public static Integer mean(List<Integer> nums) {
        Integer total = 0;
        for (Integer n : nums) {
            total += n;
        }
        return total / nums.size();
    }

    // It will return a converted List of Integers from a List of strings.
    public static List<Integer> listToIntegers(List<String> strings) {
        List<Integer> result = new List<Integer>();
        for(String str : strings) {
            Integer num = Integer.valueOf(str);
            result.add(num);
        }
        return result;
    }
}
