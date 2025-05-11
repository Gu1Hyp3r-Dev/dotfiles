import java.io.IOException;
import java.util.Arrays;
import java.io.BufferedReader;
import java.io.InputStreamReader;


public class Main {
    public static final int NULL_COIN_TYPE = -1;
    public static final int DEFAULT_COIN_VALUE = Integer.MAX_VALUE;

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

        int coin_amount = Integer.parseInt(br.readLine());
        int[] coin_types = new int[coin_amount];

        String[] coin_types_str = br.readLine().split(" ");

        for (int i = 0; i < coin_amount; i++) {
            coin_types[i] = Integer.parseInt(coin_types_str[i]);
        }

        int questions_amount = Integer.parseInt(br.readLine());
        int[] questions = new int[questions_amount];

        for (int i = 0; i < questions_amount; i++) {
            questions[i] = Integer.parseInt(br.readLine());

        }

        //System.out.println(Arrays.toString(questions));

        for (int question : questions) {
            int[] answer = GetMinCoinsWithType(question, coin_types);
            System.out.print(question + ": [" + answer[0] + "]");

            for (int i = 1; i < answer.length; i++) {
                System.out.print(" " + answer[i]);

            }

            System.out.println();

        }

    }

    public static int[] GetMinCoinsWithType(int req_amount, int[] coin_types){
	int[] used_coins_amount = new int[req_amount + 1];
        Arrays.fill(used_coins_amount, DEFAULT_COIN_VALUE);
        used_coins_amount[0] = 0;

	int[] used_coins_type = new int[req_amount];
	Arrays.fill(used_coins_type, NULL_COIN_TYPE);

        for (int i = 1; i <= req_amount; i++) {
            for (int coin : coin_types) {
                if (coin <= i) {
                    int current_amount = 1 + used_coins_amount[i - coin];

                    if (used_coins_amount[i] > current_amount) {
			used_coins_amount[i] = current_amount;
			used_coins_type[i - 1] = coin;
			


                    }
                    // used_coins[i] = Math.min(used_coins[i], 1 + used_coins[i - coin]);
                    // System.out.println("Coin Verified: " + coin + " | Required Amount: " + i + " | Amount used: " + used_coins[i]);

                }

            }

        }

	int min_coins_used = used_coins_amount[req_amount];

	int[] answer = new int[min_coins_used + 1];
	answer[0] = min_coins_used;
	
	int current_amount_verified = req_amount;
	int index = 1;

        while (current_amount_verified > 0){
	    // System.out.println("Index: " + index + " | Amount verified: " + current_amount_verified);

	    answer[index] = used_coins_type[current_amount_verified - 1];

	    // System.out.println("Index: " + index);
	    
	    current_amount_verified -= used_coins_type[current_amount_verified - 1];
	    index++;

	}     

        return answer;

    }

}
