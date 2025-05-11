import java.io.IOException;
import java.util.Arrays;
import java.io.BufferedReader;
import java.io.InputStreamReader;


public class Main {
    public static final long NULL_ROAD_VALUE = 0L;

    public static void main(String[] args) throws IOException{
	BufferedReader input = new BufferedReader(new InputStreamReader(System.in));

	int n_tests = Integer.parseInt(input.readLine());

	long[] answers = new long[n_tests];

	for (int test_index = 0; test_index < n_tests; test_index++){
	    int n_roads = Integer.parseInt(input.readLine());

	    String[] start_coords_str = input.readLine().split(" ");
	    int[] start_coords = new int[2];
	    start_coords[0] = Integer.parseInt(start_coords_str[0]) - 1;
	    start_coords[1] = Integer.parseInt(start_coords_str[1]) - 1;

	    String[] end_coords_str = input.readLine().split(" ");
	    int[] end_coords = new int[2];
	    end_coords[0] = Integer.parseInt(end_coords_str[0]) - 1;
	    end_coords[1] = Integer.parseInt(end_coords_str[1]) - 1;
	    
	    // System.out.println("Start Coords: " + Arrays.toString(start_coords) + " | End Coords: " + Arrays.toString(end_coords) + "\nBlockages:");

	    int n_blockages = Integer.parseInt(input.readLine());
	    String[][] blockages = new String[n_blockages][3];
 
	    for (int blockages_index = 0; blockages_index < n_blockages; blockages_index++){
		String[] blockage_str = input.readLine().split(" ");

		System.arraycopy(blockage_str, 0, blockages[blockages_index], 0, 3);

		if (blockages[blockages_index][2].equals("W")){
		    blockages[blockages_index][0] = Integer.toString(Integer.parseInt(blockages[blockages_index][0]) - 1);
		    blockages[blockages_index][2] = "E";

		}
		else if (blockages[blockages_index][2].equals("S")){
		    blockages[blockages_index][1] = Integer.toString(Integer.parseInt(blockages[blockages_index][1]) - 1);
		    blockages[blockages_index][2] = "N";

		}

		blockages[blockages_index][0] = Integer.toString(Integer.parseInt(blockages[blockages_index][0]) - 1);
		blockages[blockages_index][1] = Integer.toString(Integer.parseInt(blockages[blockages_index][1]) - 1);

		// System.out.println("Blockage n: " + blockages_index + " | Blockages Coords / Dir: " + Arrays.toString(blockages[blockages_index]));

	    }
	    
	    answers[test_index] = GetAllWays(n_roads, start_coords, end_coords, n_blockages, blockages);

	}

	for (long answer : answers){
	    System.out.println(answer);

	}

    }

    
    public static long GetAllWays(int n_roads, int[] start_coords, int[] end_coords, int n_blockages, String[][] blockages){
	long[][] ways_matrix = new long[n_roads][n_roads];

	for (int row = end_coords[0]; row >= start_coords[0]; row--){
	    for (int column = end_coords[1]; column >= start_coords[1]; column--){
		int[] current_road_coords = new int[2];
		current_road_coords[0] = row;
		current_road_coords[1] = column;

		// System.out.println("Current Road: " + Arrays.toString(current_road_coords));

		long current_road_value = NULL_ROAD_VALUE;

		// Current road is the end road
		if (Arrays.equals(current_road_coords, end_coords)){
		    current_road_value = 1L;

		    // System.out.println("On end road");

		}
		else{
		    long top_road_value = NULL_ROAD_VALUE;
		    long right_road_value = NULL_ROAD_VALUE;

		    // Current road has the same x as the end road
		    if (row == end_coords[0] && column < end_coords[1]){
			top_road_value = ways_matrix[row][column + 1];

			// System.out.println("Same x as end road");

		    }
		    // Current road has the same y as the end road
		    else if (row < end_coords[0] && column == end_coords[1]){
			right_road_value = ways_matrix[row + 1][column];

			// System.out.println("Same y as end road");

		    }
		    // Current road doesn't have any coordinates of the end road
		    else{
			top_road_value = ways_matrix[row][column + 1];
			right_road_value = ways_matrix[row + 1][column];

			// System.out.println("None axis as end road");

		    }
		    
		    current_road_value = GetCurrentRoadValue(current_road_coords, top_road_value, right_road_value, n_blockages, blockages);

		    // System.out.println("Current Road Value: " + current_road_value);

		}

		ways_matrix[row][column] = current_road_value;

	    }

	}

	long answer = ways_matrix[start_coords[0]][start_coords[1]];

	return answer;

    }


    public static long GetCurrentRoadValue(int[] current_road_coords, long top_road_value, long right_road_value, int n_blockages, String[][] blockages){
	int found_valid_north_blockage = 0;
	int found_valid_east_blockage = 0;

	for (int blockage_index = 0; blockage_index < n_blockages; blockage_index++){
	    int[] blockage_coords = new int[2];
	    blockage_coords[0] = Integer.parseInt(blockages[blockage_index][0]);
	    blockage_coords[1] = Integer.parseInt(blockages[blockage_index][1]);

	    String blockage_dir = blockages[blockage_index][2];

	    // Has a blockage
	    if (Arrays.equals(current_road_coords, blockage_coords)){
		// The Blockage is on north
		if (blockage_dir.equals("N")){
		    // Handles if there is a blockage in north and east
		    if (found_valid_east_blockage == 1){
			return NULL_ROAD_VALUE;

		    }

		    found_valid_north_blockage = 1;

		}
		// The blockage is on east
		else if (blockage_dir.equals("E")){
		    // Handles if there is a blockage in east and north
		    if (found_valid_north_blockage == 1){
			return NULL_ROAD_VALUE;

		    }
		    
		    found_valid_east_blockage = 1;

		}

	    }
	    
	}

	if (found_valid_north_blockage == 1){
	    return right_road_value;

	}
	else if (found_valid_east_blockage == 1){
	    return top_road_value;

	}
	
	// There is no blockage on the current road
	return top_road_value + right_road_value;

    }

}
