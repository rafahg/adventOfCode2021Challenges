// Serious refactoring Incoming.....by now works which is more than I expected when I started....

public with sharing class AdventOfCode2021Day5 {

      // Solution Part 1 and Part 2. Part 1 uses the List<String> generated in 'CleaningCordinates' methods
      // Solution Part2 uses the List<String> generated in 'getInput' method.
    public static Integer matchingCoordinates(List<String> allPoints) {
        System.debug(allPoints);
        Set<String> output = new Set<String>();
        Set<String> duplicate = new Set<String>();
        for(String item : allPoints){
            if(duplicate.contains(item)) {
                output.add(item);
            }
            duplicate.add(item);
        }

        return new List<String>(output).size();
    }


    // Helpers
    public static List<List<String>> getInput(String day) {

        // it will return ordered list of coordinates : [[x1,y1 , x2,y2] , [x1,y1 , x2, y2]]
        List<List<String>> coordinates = new List<List<String>>();
        StaticResource  input = [Select Id, body from StaticResource where Name=:day];
        String inputContent = input.body.toString();
        List<String> finalInput = inputContent.split('\\n');
        for(String item : finalInput) {
            coordinates.add(item.deleteWhitespace().split('->'));
        }
        return coordinates;
    }

    public static List<List<String>> cleaningCoordinates(List<List<String>> coordinates) {

        List<List<String>> refinedCoordinates = new List<List<String>>();

        for( List<String> item : coordinates) {
            if(item[0].split(',')[0] == item[1].split(',')[0] || item[0].split(',')[1] == item[1].split(',')[1] ){
                refinedCoordinates.add(item);
            }
        }

        return refinedCoordinates;
    }



    public static List<String> generatingHorizontalAndVerticalPoints(List<List<String>> refinedCoordinates) {
        Integer num;
        List<String> allPoints = new List<String>();
        Integer x1,y1,x2,y2;
        for(List<String> item : refinedCoordinates) {
             x1 = Integer.valueOf(item[0].split(',')[0]);
             y1 = Integer.valueOf(item[0].split(',')[1]);
             x2 = Integer.valueOf(item[1].split(',')[0]);
             y2 = Integer.valueOf(item[1].split(',')[1]);
            //Getting the horizontal and vertical lines
            if(x1 != x2 && y1==y2) {
                num = x1 - x2;
                    if(num < 0) {
                        while(x1 <= x2) {
                            allPoints.add(String.valueOf(x1) + ',' + String.valueOf(y1));
                            x1 +=1;
                        }
                    } else {
                        while(x1 >= x2) {
                            allPoints.add(String.valueOf(x1) + ',' + String.valueOf(y1));
                            x1 -=1;
                        }
                    }

            } else if(y1!=y2 && x1==x2) {
                num = y1 - y2;
                if(num < 0) {
                    while(y1 <= y2) {
                        allPoints.add(String.valueOf(x1) + ',' + String.valueOf(y1));
                        y1 +=1;
                    }
                } else {
                    while(y1 >= y2) {
                        allPoints.add(String.valueOf(x1) + ',' + String.valueOf(y1));
                        y1 -=1;
                    }
                }
                // Getting the Diagonal lines
            } else {
                if(x1>=x2 && y1>=y2) {
                    while(x1 >= x2 && y1 >= y2) {

                        allPoints.add(String.valueOf(x1) + ',' + String.valueOf(y1));
                        x1 -=1;
                        y1 -=1;
                    }
                    continue;
                }
                if(x1<=x2 && y1<=y2) {
                    while(x1 <= x2 && y1 <= y2) {
                        allPoints.add(String.valueOf(x1) + ',' + String.valueOf(y1));
                        x1 +=1;
                        y1 +=1;
                    }
                    continue;
                }
                if(x1>=x2 && y1<=y2) {
                    while(x1 >= x2 && y1 <= y2) {
                        allPoints.add(String.valueOf(x1) + ',' + String.valueOf(y1));
                        x1 -=1;
                        y1 +=1;
                    }
                    continue;
                }

                if(x1<=x2 && y1>=y2) {
                    while(x1 <= x2 && y1 >= y2) {

                        allPoints.add(String.valueOf(x1) + ',' + String.valueOf(y1));
                        x1 +=1;
                        y1 -=1;
                    }
                    continue;
                }


            }


        }

        return allPoints;
    }

}
