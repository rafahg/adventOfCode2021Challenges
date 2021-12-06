/**
 * Created by rafaelhernandez on 06/12/2021.
 */

public with sharing class AdventOfCode2021Day6 {



    // Naive solution which it will work for not a huge community of fishes but which will fail horribly
    // with a proper amount of them.
    public static Long firstApproach(List<String> inputs, Integer numDays) {
        List<Integer> fishes = listToIntegers(inputs);
        Map<Integer, List<Integer>> days = new Map<Integer, List<Integer>>();
        Integer i = 0;
        days.put(i,fishes);
        for(Integer j=0; j<100; j++) {
            List<Integer> dailyChange = new List<Integer>();
            for (Integer fish : days.get(j)) {
                if (fish > 0 || fish == 0) {
                    if(fish == 0) {
                        dailyChange.add(6);
                        dailyChange.add(8);
                    } else {
                        dailyChange.add(fish -1);
                    }
                }
                days.put(j+1, dailyChange);
            }
        }
        return days.get(numDays).size();
    }


    // Final Solution A/B , after give it a lot of thought. And trial error.
   public static Long secondApproach(List<String> inputs, Integer numDays) {
       List<Integer> fishes = listToIntegers(inputs);

       // List to track the lifeCycle of the fishes. Readable style. :)
       List<Long> lifeCycle = new List<Long>{0,0,0,0,0,0,0,0,0,0};
       // Loop to populate the lifeCycle with the data at the beginning.
       for(Integer i = 0; i<fishes.size(); i++) {
           lifeCycle[fishes[i]]++;
       }
       System.debug(lifeCycle);

       // Adding numbers to the tracking array to follow the lifeCycle, over a given number of days.
       for(Integer i=0; i< numDays; i++) {

           //adding the new born fishes the tracking of 8 values.
           lifeCycle[7] += lifeCycle[0];

           // Using last element of the list as a pivot to add the addition in the loop.
           lifeCycle[9] = lifeCycle[0];
           // In an extremely counter intuitive way, the loop will move values along the array to perform
           // the daily subtraction and adding the respective values to each columns and the new daily additions.
           for(Integer j=0; j<9; j++) {
               lifeCycle[j] = lifeCycle[j+1];
           }
           lifeCycle[9] = 0;
       }
       return sumListElements(lifeCycle);
   }

    //Helpers

    //It will return a list of Strings.
    public static List<String> getInput(String day) {
        StaticResource  input = [Select Id, body from StaticResource where Name=:day];
        String inputContent = input.body.toString();
        List<String> finalInput = inputContent.split(',');
        return finalInput;
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

    // Simple method to sum the elements within a list
    public static Long sumListElements(List<Long> nums) {
        Long result=0;
        for(Long num : nums) {
            if(num !=null)
            result +=num;
        }
        return result;
    }

}
