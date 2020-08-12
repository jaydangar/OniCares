/*
*	Creating TreeNode class which will contain int data as well as left and right node to save
*	a reference to Child Nodes.
*/

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.StringTokenizer;

class TreeNode {
	int data;
	private TreeNode leftNode, rightNode;

	TreeNode(int data) {
		this.data = data;
	}

	void setLeftChild(TreeNode leftNode) {
		this.leftNode = leftNode;
	}

	void setRightChild(TreeNode rightNode) {
		this.rightNode = rightNode;
	}

	TreeNode getRightChild() {
		return this.rightNode;
	}

	TreeNode getLeftChild() {
		return this.leftNode;
	}
}

/*
 * BST class for common BST operations, such as Insert, update, Delete,
 * Traverse,etc.
 */
class BST {

	// using recursive approach for
	static TreeNode insert(TreeNode rootNode, TreeNode newNode) {
		if (rootNode == null) {
			rootNode = newNode;
		} else {
			if (newNode.data > rootNode.data) {
				rootNode.setRightChild(insert(rootNode.getRightChild(), newNode));
			} else {
				rootNode.setLeftChild(insert(rootNode.getLeftChild(), newNode));
			}
		}
		return rootNode;
	}

	//	inorder traversal recursive, which prints sorted array for random inputs...
	// * Time Complexity = O(N) where N is number of Nodes which we needs to Traverse..
	static void inorderTraversal(TreeNode rootNode) {
		if (rootNode == null) {
			return;
		}
		inorderTraversal(rootNode.getLeftChild());
		System.out.print(rootNode.data + " ");
		inorderTraversal(rootNode.getRightChild());
	}
}

public class Problem1 {
	public static void main(String[] args) {
		try {
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(new FileInputStream(args[0])));
			while (bufferedReader.read() > 0) {
				StringTokenizer stringTokenizer = new StringTokenizer(bufferedReader.readLine(), ",");

				// rootNode for better access
				TreeNode rootNode = null;

				while (stringTokenizer.hasMoreTokens()) {
					int data = Integer.parseInt(stringTokenizer.nextToken());
					rootNode = BST.insert(rootNode, new TreeNode(data));
				}

				BST.inorderTraversal(rootNode);
				System.out.println("");
			}
			bufferedReader.close();
		} catch (Exception e) {
			System.out.println("Exception thrown "+ e.getMessage());
		}
	}
}