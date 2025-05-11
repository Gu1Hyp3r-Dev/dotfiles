import java.io.IOException;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Arrays;


public class Main {
    public static void main(String[] args) throws IOException {
	BufferedReader input = new BufferedReader(new InputStreamReader(System.in));

	int rows = Integer.parseInt(input.readLine());
	String[] keyboard = new String[rows];

	for (int i = 0; i < rows; i++) {
	    keyboard[i] = input.readLine();

	}
	
	String word = input.readLine();
	String word_input = input.readLine();

	System.out.println("keyboard: " + Arrays.toString(keyboard));

	System.out.println(TranscriptScore(keyboard, word, word_input));

    }


    public static int TranscriptScore(String[] keyboard, String word, String word_input) {
	int key_len = keyboard.length;
	int top = DistanceChars(keyboard, keyboard[0].charAt(0), keyboard[key_len - 1].charAt(keyboard[key_len - 1].length() - 1));

	System.out.println("TOP: " + top + " | F/L Char: " + keyboard[0].charAt(0) + "/" + keyboard[key_len - 1].charAt(keyboard[key_len - 1].length() - 1));

	return 0;

    }


    public static int DistanceChars(String[] keyboard, char a, char b) {
	int[] a_pos = new int[2];
	int[] b_pos = new int[2];

	for (int i = 0; i < keyboard.length; i++) {
	    String key_row = keyboard[i];

	    if (key_row.indexOf(a) != -1) {
		a_pos[0] = key_row.indexOf(a);
		a_pos[1] = i;
		
	    }
	    
	    if (key_row.indexOf(b) != -1) {
		b_pos[0] = key_row.indexOf(b);
		b_pos[1] = i;

	    }

	}

	System.out.println("A: " + Arrays.toString(a_pos) + " | B: " + Arrays.toString(b_pos));

	return Math.max(Math.abs(a_pos[0] - b_pos[0]), Math.abs(a_pos[1] - b_pos[1]));

    }

}
