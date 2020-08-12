import java.util.ArrayList;
import java.util.Scanner;

public class Problem2 {

    public static void main(String[] args) throws Exception {

        Scanner scanner = new Scanner(System.in);

        ArrayList<Integer> list1 = new ArrayList<>();
        ArrayList<Integer> list2 = new ArrayList<>();

        System.out.println("Enter list1 length : ");
        int list1Size = scanner.nextInt();

        System.out.println("Enter list1 items : ");
        for (int i = 0; i < list1Size; i++) {
            list1.add(scanner.nextInt());
        }

        System.out.println("Enter list2 length : ");
        int list2Size = scanner.nextInt();

        System.out.println("Enter list2 items : ");
        for (int i = 0; i < list2Size; i++) {
            list2.add(scanner.nextInt());
        }

        list1 = mergeList(list1, list2, list1Size, list2Size);

        for (int i = 0; i < list1.size(); i++) {
            System.out.print(list1.get(i) + " ");
        }

        scanner.close();
    }

    // * I am using 2 pointer technique here, in which we will iterate over both
    // lists and compare
    // * as we go through the list and swap elements if value of list2 is less than
    // value of list1

    // ? Time Complexity is O(M+N) where M is size of list1, N is size of list2
    private static ArrayList<Integer> mergeList(ArrayList<Integer> list1, ArrayList<Integer> list2, int size1,
            int size2) {

        // list 1 index
        int list1CurrentIndex = 0;

        if (list1.size() == 0) {
            list1.addAll(0, list2);
            return list1;
        }

        while (!list2.isEmpty() && list1CurrentIndex < list1.size()) {
            int val1 = list1.get(list1CurrentIndex);
            int val2 = list2.get(0);
            if (val1 >= val2) {
                list1.add(list1CurrentIndex, val2);
                list2.remove(0);
            }
            list1CurrentIndex++;
        }

        if (!list2.isEmpty()) {
            list1.addAll(list1.size() - 1, list2);
        }

        return list1;
    }
}