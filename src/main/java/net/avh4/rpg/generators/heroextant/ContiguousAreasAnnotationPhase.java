package net.avh4.rpg.generators.heroextant;

import net.avh4.rpg.maptoolkit.MapGenerationPhase;
import net.avh4.rpg.maptoolkit.data.ConstMapData;

public class ContiguousAreasAnnotationPhase implements MapGenerationPhase {
    private final int w;
    private final int h;
    private final ConstMapData<TileType> tiles;
    private final int[][] contiguousMap;

    public ContiguousAreasAnnotationPhase(ConstMapData<TileType> tiles) {
        this.tiles = tiles;
        w = tiles.getWidth();
        h = tiles.getHeight();
        contiguousMap = new int[w][h];
    }

    @Override
    public void execute() {
        for (int y = 0; y < h; y++) {
            for (int x = 0; x < w; x++) {
                contiguousMap[x][y] = 1;
            }
        }

        // Step 1 - identify groups
        int i = 2;
        for (int y = 1; y < h; y++) {
            for (int x = 1; x < w; x++) {
                if (!(getTileType(x, y) == getTileType(x - 1, y))
                        && !(getTileType(x, y) == getTileType(x, y - 1))) {
                    contiguousMap[x][y] = i;
                    i++;
                } else {
                    int mincg1 = 0;
                    int mincg2 = 0;

                    if (getTileType(x, y) == getTileType(x, y - 1)) {
                        contiguousMap[x][y] = contiguousMap[x][y - 1];
                        mincg1 = contiguousMap[x][y - 1];
                    }
                    if (getTileType(x, y) == getTileType(x - 1, y)) {
                        contiguousMap[x][y] = contiguousMap[x - 1][y];
                        mincg2 = contiguousMap[x - 1][y];
                    }

                    if ((mincg1 != 0) && (mincg2 != 0)) {
                        contiguousMap[x][y] = Math.min(mincg1, mincg2);
                    }
                }
            }
        }

        // Step 2a - merge rivers
        for (int x = 1; x < w - 1; x++) {
            for (int y = 1; y < h - 1; y++) {
                if (getTileType(x, y) == TileType.River) {
                    contiguousMap[x][y] = 1;
                }
            }
        }

        // Step 2b - merge groups
        for (int x = 1; x < w - 1; x++) {
            for (int y = 1; y < h - 1; y++) {

                for (int x2 = -1; x2 <= 1; x2++) {
                    for (int y2 = -1; y2 <= 1; y2++) {
                        if (x2 != 0 || y2 != 0) {
                            if (contiguousMap[x][y] != contiguousMap[x + x2][y + y2]) {
                                if (getTileType(x, y) == getTileType(x + x2, y + y2)) {
                                    final int adjust = contiguousMap[x + x2][y + y2];
                                    for (int x3 = 0; x3 < w; x3++) {
                                        for (int y3 = 0; y3 < h; y3++) {
                                            if (contiguousMap[x3][y3] == adjust) {
                                                contiguousMap[x3][y3] = contiguousMap[x][y];
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        // Stage 3 - reduce groups (This bit is very unoptimised and I don't
        // think does the job completely)
        int limit = 0;
        int lowest = w * h + 1;
        boolean done;
        do {
            done = true;

            for (int x = 0; x < w; x++) {
                for (int y = 0; y < h; y++) {
                    if (contiguousMap[x][y] < lowest && contiguousMap[x][y] > limit) {
                        lowest = contiguousMap[x][y];
                    }
                }
            }

            for (int x = 0; x < w; x++) {
                for (int y = 0; y < h; y++) {
                    if (lowest == contiguousMap[x][y]) {
                        contiguousMap[x][y] = limit + 1;
                        done = false;
                    }
                }
            }
            if (lowest == limit + 1) {
                limit++;
            }
        } while (!done);
    }

    private TileType getTileType(int x, int y) {
        return tiles.getData(x, y);
    }
}
