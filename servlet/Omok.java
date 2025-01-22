import java.util.Scanner;

public class Omok {
	final static int BOARDSIZE = 19;
    public static void main(String[] args) {
        Player user = new Player("사용자", "O");
        Player computer = new Player("컴퓨터", "X");
        Board board = new Board(BOARDSIZE);
        play(board, user, computer);
    }

    private static void play(Board board, Player user, Player computer) {
        // 보드판 생성
        board.print();
        Scanner scan = new Scanner(System.in);
        int cnt = 1;

        while (true) {
            Player turn;
            // 입력 받기
            System.out.println();
            if (cnt % 2 == 1) System.out.print("컴퓨터> ");
            else if (cnt % 2 == 0) System.out.println("사용자> ");
            
            try {
	            String in = scan.nextLine();
	            String[] input = in.split(" ");
	            // 입력 값을 인덱스로 변환
	            int idx1 = Character.toUpperCase(input[0].charAt(0)) - 'A';
	            int idx2 = Integer.parseInt(input[1]);
	
	            // 번갈아 게임 진행
	            if (cnt % 2 == 1) {
	                turn = user;
	                // 둔 자리에 또 두면 또 입력 받기
	                if (board.map[idx2][idx1] != ".") {
	                    continue;
	                } else {
	                    board.map[idx2][idx1] = turn.stone;
	                }
	            } else {
	                turn = computer;
	                // 둔 자리에 또 두면 또 입력 받기
	                if (board.map[idx2][idx1] != ".") {
	                    continue;
	                } else {
	                    board.map[idx2][idx1] = turn.stone;
	                }
	            }
	
	            // 종료 조건
	            int[][] arr = new int[BOARDSIZE][BOARDSIZE];
	            for (int i = 0; i < BOARDSIZE; i++) {
	                for (int j = 0; j < BOARDSIZE; j++) {
	                    if (turn.stone.equals(board.map[i][j])) {
	                        arr[i][j] = 1;
	                    }
	                }
	            }
	            for (int i = 0; i < BOARDSIZE; i++) {
	                for (int j = 0; j < BOARDSIZE; j++) {
	                    int num = 0;
	                    // 세로 조건
	                    if (i + 4 < BOARDSIZE) {
	                        if (arr[i][j] + arr[i + 1][j] + arr[i + 2][j] + arr[i + 3][j] + arr[i + 4][j] >= 5) {
	                            System.out.println("게임 종료");
	                            return;
	                        }
	                    }
	
	                    // 가로 조건
	                    if (j + 4 < BOARDSIZE) {
	                        if (arr[i][j] + arr[i][j + 1] + arr[i][j + 2] + arr[i][j + 3] + arr[i][j + 4] >= 5) {
	                            System.out.println("게임 종료");
	                            return;
	                        }
	                    }
	
	                    // 우하향 대각선 조건
	                    if (i + 4 < BOARDSIZE && j + 4 < BOARDSIZE) {
	                        if (arr[i][j] + arr[i + 1][j + 1] + arr[i + 2][j + 2] + arr[i + 3][j + 3] + arr[i + 4][j + 4] >= 5) {
	                            System.out.println("게임 종료");
	                            return;
	                        }
	                    }
	                    // 우상향 대각선 조건
	                    if (i >= 4 && j + 4 < BOARDSIZE) {
	                        if (arr[i][j] + arr[i - 1][j + 1] + arr[i - 2][j + 2] + arr[i - 3][j + 3] + arr[i - 4][j + 4] >= 5) {
	                            System.out.println("게임 종료");
	                            return;
	                        }
	                    }
	                }
	            }
	            cnt++;
	            board.print();
            } catch(ArrayIndexOutOfBoundsException e) {
        	continue;
            }
        }
    }
}