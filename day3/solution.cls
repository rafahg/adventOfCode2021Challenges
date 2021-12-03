public with sharing class AdventOfCode2021Day3 {

    public static List<String> inputs = getInput('inputDay3');
    
    // Solution A
    public static Integer gammaEpsilonValues(List<List<String>> inputs) {
        Integer finalNumber;
        List<String> epsilonString = new List<String>();
        List<String> gammaString = new List<String>();
        List<List<String>> allToCompare = new List<List<String>>();

        for(Integer i=0; i<inputs[0].size(); i++) {
            List<String> elToCompare = new List<String>();
            for(List<String> input : inputs) {
                elToCompare.add(input[i]);
            }
            allToCompare.add(elToCompare);
        }

        Integer zero = 0;
        Integer one = 0;
        for(List<String> item : allToCompare) {
          for(String str : item) {
              if(str=='1') {
                  one +=1;
              } else {
                  zero +=1;
              }
          }
            if(one > zero) {
                gammaString.add('1');
                epsilonString.add('0');
            } else {
                gammaString.add('0');
                epsilonString.add('1');
            }

            zero = 0;
            one = 0;
        }

        Integer finalGamma = binaryToInteger(String.join(gammaString,('')));
        Integer finalEpsilon = binaryToInteger(String.join(epsilonString,('')));
     
        return finalGamma * finalEpsilon;
    }

    
    // Solution B
    public static Integer gettingTheOxygen(List<String> inputs) {
        Integer Oxygen;
        Integer column = 0;
        while (inputs.size()>1) {
            Integer one = 0;
            Integer zero = 0;
            for(Integer row = 0; row < inputs.size(); row++) {
                // value of 1 is 48 , apparently thanks Apex!
                if( inputs[row].charAt(column) == 48) {
                    zero +=1;
                } else {
                    one +=1;
                }
            }
            Integer max = ((one >= zero) ? 49 : 48);
            for (Integer row = inputs.size()-1; row >=0; row--) {
                if( inputs.get(row).charAt(column) != max ) {
                    inputs.remove(row);
                }

            }
            column +=1;

        }

        return oxygen = binaryToInteger(inputs[0]);
    }

    public static Integer gettingTheCO2(List<String> inputs) {
        Integer cO2;
        Integer column = 0;
        while ( inputs.size()>1 ) {
            Integer one = 0;
            Integer zero = 0;
            for(Integer row = 0; row < inputs.size(); row++) {
                // Value of 1 is 48, apparently, thanks Apex!
                if( inputs[row].charAt(column) == 48) {
                    zero +=1;
                } else {
                    one +=1;
                }
            }
            Integer min = ((one >= zero) ? 48 : 49);
            for (Integer row = inputs.size()-1; row >=0; row--) {
                if( inputs.get(row).charAt(column) != min ) {
                    inputs.remove(row);
                }

            }
            column +=1;

        }

        return cO2 = binaryToInteger(inputs[0]);
    }


      // The solution, at this point I was looking for all the people in the submarine were running out of oxygen.....
    
    public static Integer lifeSupport() {
        Integer oxigen = (gettingTheOxygen(inputs));
        Integer co2 = (gettingTheCO2(inputs));
        return oxigen * co2;
    }



   



    // Helpers
    public static List<String> getInput(String day) {
        StaticResource  input = [Select Id, body from StaticResource where Name=:day];
        String inputContent = input.body.toString();
        List<String> finalInput = inputContent.split('\\n');
        return finalInput;
    }
    
     public static List<List<String>> manageData(List<String> inputs)  {
        List<List<String>> dataOrganised= new List<List<String>>();

        for(String input : inputs) {
            dataOrganised.add(input.split(''));
        }
        return dataOrganised;
    }

    public static Integer binaryToInteger(String value) {
        Integer result;
        if(value != null && value.containsOnly('01')) {
            result = 0;
            for(String s: value.split('')) {
                result = (result << 1) | (s == '1'? 1: 0);
            }
        }
        return result;
    }
}
