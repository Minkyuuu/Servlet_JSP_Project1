public class Board {
    int size;
    String[][] map;
    Board(int size) {
        this.size = size;
        map = new String[size][size];
        for (int row = 0; row < size; row++) {
            for (int col = 0; col < size; col++) {
                map[row][col] = ".";
            }
        }
    }
    // 인덱스 붙인 보드판 출력 메서드
    public void print() {
        int num = 0;
        char chr = 'A';
        for (int row = 0; row < size; row++) {
            System.out.printf("%2d",num);
            for (int col = 0; col < size; col++) {
                System.out.print(" " + map[row][col]);
            }
            System.out.println();
            num++;
        }
        System.out.print("  ");
        for (int i=0; i<size; i++) {
            System.out.print(" "+chr);
            chr++;
        }
    }
}