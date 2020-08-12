
/*
*   This is array based approach which combines array from right to left, given that array1 have enough length to 
*   contain all the elements of array2
*/

import java.util.Scanner;

//  sample input a1 length = 8, [1 5 6 8 0 0 0 0], a2 length = 4 [2 3 5 7]
public class Problem2_array {
    public static void main(String[] args) throws Exception {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Enter length of array 1: ");
        int m  = scanner.nextInt();

        System.out.println("Enter array 1 elements : ");
        int[] a1 = new int[m];
        for (int i = 0; i < m; i++) {
            a1[i] = scanner.nextInt();
        }
        
        System.out.println("Enter length of array 2: ");
        int n  = scanner.nextInt();

        System.out.println("Enter array 2 elements : ");
        int[] a2 = new int[n];
        for (int i = 0; i < n; i++) {
            a2[i] = scanner.nextInt();
        }
        
        int[] returnArray = merge(a1, m, a2, n);
        
        for (int i = 0; i < returnArray.length; i++) {
            System.out.print(returnArray[i] + " ");
        }
        scanner.close();
    }

    public static int[] merge(int[] nums1, int m, int[] nums2, int n) {
        int lastIndex = m - 1;
        int lastIndexNum1 = m - n - 1;
        int lastIndexNum2 = n - 1;

        while (lastIndex > -1 && lastIndexNum2 > -1) {
            if (lastIndexNum1 > -1 && nums1[lastIndexNum1] > nums2[lastIndexNum2]) {
                nums1[lastIndex] = nums1[lastIndexNum1];
                lastIndexNum1--;
            } else {
                nums1[lastIndex] = nums2[lastIndexNum2];
                lastIndexNum2--;
            }
            lastIndex--;
        }

        return nums1;
    }

}