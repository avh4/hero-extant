package net.avh4.rpg.generators.heroextant;

import net.avh4.rpg.maptoolkit.MapGenerationPhase;
import net.avh4.rpg.maptoolkit.data.ConstMapData;
import net.avh4.rpg.maptoolkit.data.MapData;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class RiverGenerationPhase implements MapGenerationPhase {
    private final Random r;
    private final int w;
    private final int h;
    private final ConstMapData<Double> elevation;
    private final ConstMapData<Double> rainfall;
    private final MapData<Integer> waterSaturation;

    public RiverGenerationPhase(Random r, ConstMapData<Double> elevation, ConstMapData<Double> rainfall,
                                MapData<Integer> waterSaturation) {
        this.r = r;
        this.elevation = elevation;
        this.rainfall = rainfall;
        this.waterSaturation = waterSaturation;
        w = elevation.getWidth();
        h = elevation.getHeight();
    }

    @Override
    public void execute() {
        int steps = 0;
        final double maxSteps = Math.sqrt((w * w) + (h * h)) / 2;
        // maxSteps = worldW / 2

        // Init rivers
        final List<River> riverList = new ArrayList<River>();
        for (int i = 0; i < maxSteps * 8; i++) {
            final int x = r.nextInt(w - 3) + 1;
            final int y = r.nextInt(h - 3) + 1;
            if (getElevation(x, y) > WorldGenerator.SEA_LEVEL
                    && getElevation(x, y) < 1.0) {
                if (r.nextDouble() * getRainfall(x, y) > 0.125) {
                    final River river = new River();
                    riverList.add(river);
                    river.x = x;
                    river.y = y;
                }
            }
        }

        // Water flow
        int countMoves = 0;
        int moves;
        do {
            moves = 0;
            steps++;

            // Water physics
            for (final River river : riverList) {

                final int x = river.x;
                final int y = river.y;

                if (getElevation(x, y) > WorldGenerator.SEA_LEVEL && (x > 0) && (y > 0)
                        && (x < w - 1) && (y < h - 1)) {
                    // Water flows based on cost, seeking the highest elevation
                    // difference
                    // biggest difference = lower (negative) cost

                    // Cost
                    // 0,0 1,0 2,0
                    // 0,1 *** 2,1
                    // 0,2 1,2 2,2
                    final double[][] cost = new double[3][3];
                    cost[0][0] = 0;
                    cost[1][0] = 0;
                    cost[2][0] = 0;
                    cost[0][1] = 0;
                    cost[2][1] = 0;
                    cost[0][2] = 0;
                    cost[1][2] = 0;
                    cost[2][2] = 0;

                    // Top
                    // cost[0][0] = ((worldTile[x - 1][y - 1].elevation) -
                    // (worldTile[x][y].elevation)); // 1.41
                    cost[1][0] = (getElevation(x, y - 1)) - (getElevation(x, y));
                    // cost[2][0] = ((worldTile[x + 1][y - 1].elevation) -
                    // (worldTile[x][y].elevation)); // 1.41

                    // Mid
                    cost[0][1] = (getElevation(x - 1, y)) - (getElevation(x, y));
                    cost[2][1] = (getElevation(x + 1, y)) - (getElevation(x, y));

                    // Bottom
                    // cost[0][2] = ((worldTile[x - 1][y + 1].elevation) -
                    // (worldTile[x][y].elevation)); // 1.41
                    cost[1][2] = (getElevation(x, y + 1)) - (getElevation(x, y));
                    // cost[2][2] = ((worldTile[x + 1][y + 1].elevation) -
                    // (worldTile[x][y].elevation)); // 1.41

                    // Randomize flow */ 2
                    // cost[0][0] = cost[0][0] * r.nextDouble() * 1.5 + 0.5;
                    cost[1][0] = cost[1][0] * r.nextDouble() * 1.5 + 0.5;
                    // cost[2][0] = cost[2][0] * r.nextDouble() * 1.5 + 0.5;
                    cost[0][1] = cost[0][1] * r.nextDouble() * 1.5 + 0.5;
                    cost[2][1] = cost[2][1] * r.nextDouble() * 1.5 + 0.5;
                    // cost[0][2] = cost[0][2] * r.nextDouble() * 1.5 + 0.5;
                    cost[1][2] = cost[1][2] * r.nextDouble() * 1.5 + 0.5;
                    // cost[2][2] = cost[2][2] * r.nextDouble() * 1.5 + 0.5;

                    // Highest Cost
                    double highestCost = cost[1][0];
                    // highestCost = Math.min(cost[0][0], cost[1][0]);
                    // highestCost = Math.min(highestCost, cost[2][0]);
                    highestCost = Math.min(highestCost, cost[0][1]);
                    highestCost = Math.min(highestCost, cost[2][1]);
                    // highestCost = Math.min(highestCost, cost[0][2]);
                    highestCost = Math.min(highestCost, cost[1][2]);
                    // highestCost = Math.min(highestCost, cost[2][2]);

                    for (int i = 0; i <= 2; i++) {
                        for (int j = 0; j <= 2; j++) {
                            if (i != 1 || j != 1) /* and (cost[i,j] < 0) */ {
                                // Divide water up...
                                if (cost[i][j] == highestCost) {
                                    river.x = x + (i - 1);
                                    river.y = y + (j - 1);
                                    setWaterSaturation(x, y, 1);
                                    moves++;
                                }
                            }
                        }
                    }
                }
            }

            countMoves = countMoves + moves;
        } while (moves != 0 && steps <= maxSteps - 1);

        // resultString = "Moves: "+ToString(countMoves)
    }

    private double getElevation(int x, int y) {
        return elevation.getData(x, y, 0.0);
    }

    private double getRainfall(int x, int y) {
        return rainfall.getData(x, y);
    }

    private void setWaterSaturation(int x, int y, int value) {
        waterSaturation.setData(x, y, value);
    }
}
