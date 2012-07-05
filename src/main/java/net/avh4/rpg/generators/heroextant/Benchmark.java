package net.avh4.rpg.generators.heroextant;

import java.io.IOException;
import java.util.Date;

public class Benchmark {

    private static final int TEST_REPS = 10;
    private static final int WARM_UP_REPS = 2;

    public static void main(String[] args) {
        Runnable test = new Runnable() {
            @Override
            public void run() {
                try {
                    WorldGenerator.main(null);
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        };

        for (int i = 0; i < WARM_UP_REPS; i++) {
            test.run();
            System.out.print("*");
        }

        long start = new Date().getTime();
        for (int i = 0; i < TEST_REPS; i++) {
            test.run();
            System.out.print(".");
        }
        long end = new Date().getTime();

        System.out.println("");
        System.out.println("Benchmark: " + (end - start));
    }
}
