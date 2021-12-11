public with sharing class AdventOfCode2021Day9 {


    public static void gettingTheRisk(List<List<Integer>> values) {
        Integer risk = 0;
        for(Integer row = 0; row < values.size(); row++ ) {
            for(Integer column = 0; column < values[0].size(); column++) {
                if(isLowPoint(row,column, values)) {
                    risk += 1 + values[row][column];
                }
            }
        }

        System.debug(risk);

    }

    public static void part2(List<List<Integer>> values) {
        List<Integer> sizes = new List<Integer>();
        for (Integer row = 0; row < values.size(); row++) {
            for (Integer column = 0; column < values[0].size(); column++) {
                if (isLowPoint(row, column,values)) {
                sizes.add(basin(row, column, values));
                }
            }
        }
    // sorting the sizes to multiply the last 3, which being sorted should be the biggest ones.
    sizes.sort();

        Integer biggest = sizes.get(sizes.size() - 1);
    Integer secondBiggest = sizes.get(sizes.size() - 2);
    Integer thirdBiggest = sizes.get(sizes.size() - 3);
    Long result = biggest * secondBiggest * thirdBiggest;
    System.debug(result);
    }



    public static Integer basin(Integer row, Integer column, List<List<Integer>> values) {
        if (row < 0 || column < 0 || row >= values.size() || column >= values[0].size() || values[row][column] == 9)
            return 0;

        values[row][column] = 9;

        return 1 + basin(row - 1, column, values) +
                   basin(row + 1, column, values) +
                   basin(row, column - 1 , values) +
                   basin(row, column + 1, values);

    }


    // This method will return the correct integer if it is within the limit of the list,
    // otherwise will return 9 which is the maximun heigth on the values.
    public static boolean isLowPoint(Integer row, Integer column, List<List<Integer>> values) {
        Integer height = values[row][column];
        Integer up = (row > 0 ? values[row -1][column] : 9);
        Integer down = (row <= values.size() -2 ? values[row + 1][column] : 9);
        Integer left = (column > 0 ? values[row][column - 1] : 9);
        Integer right = (column <= values[0].size() - 2 ? values[row][column + 1] : 9);

        return (height < up && height < down && height < left && height < right);

    }


    // Helpers

    public static Integer getValue(String s) {
        List<Integer> charAtList = s.getChars();
        System.debug(charAtList[0]);
        return charAtList[0];
    }

    public static List<Integer> listToIntegers(List<String> strings) {
        List<Integer> result = new List<Integer>();
        for(String str : strings) {
            Integer num = Integer.valueOf(str);
            result.add(num);
        }
        return result;
    }

    public static List<List<Integer>> getInput(String day) {
        List<List<Integer>> matrixPositions = new List<List<Integer>>();
        StaticResource  input = [Select Id, body from StaticResource where Name=:day];
        String inputContent = input.body.toString();
        List<String> finalInput = inputContent.split('\\n');
        for(String str : finalInput) {
            List<Integer> temp = listToIntegers(str.split(''));
            matrixPositions.add(temp);
        }
        return matrixPositions;
    }

