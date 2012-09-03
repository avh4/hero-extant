package net.avh4.rpg.generators.heroextant;

import net.avh4.rpg.maptoolkit.MapGenerationPhase;
import net.avh4.rpg.maptoolkit.data.ConstMapData;
import net.avh4.rpg.maptoolkit.data.MapData;
import net.avh4.util.Random;

public class TemperatureGenerationPhase implements MapGenerationPhase {
    private static final int TEMPERATURE_BAND_RESOLUTION = 2; // 1 is perfect, higher = rougher
    // WGEN_MAX_TEMPERATURE = 40
    // WGEN_MIN_TEMPERATURE = -60

    private final Random r;
    private final int w;
    private final int h;
    private final MapData<Double> temperature;
    private final ConstMapData<Double> elevation;
    private final Hemisphere hemisphere;

    public TemperatureGenerationPhase(Random r, Hemisphere hemisphere, ConstMapData<Double> elevation, MapData<Double> temperature) {
        this.r = r;
        this.hemisphere = hemisphere;
        w = elevation.getWidth();
        h = elevation.getHeight();
        this.elevation = elevation;
        this.temperature = temperature;
    }

    @Override
    public void execute() {
        for (int bandy = 0; bandy < h; bandy += TEMPERATURE_BAND_RESOLUTION) {

            // Generate band
            final int bandrange = 7;

            double bandtemp;
            switch (this.hemisphere) {
                case North:
                    // 0, 0.5, 1
                    bandtemp = (double) bandy / h;
                    break;
                case Equator:
                    // 0, 1, 0
                    if (bandy < h / 2) {
                        bandtemp = (double) bandy / h;
                        bandtemp = bandtemp * 2.0;
                    } else {
                        bandtemp = 1.0 - (double) bandy / h;
                        bandtemp = bandtemp * 2.0;
                    }
                    break;
                case South:
                    // 1, 0.5, 0
                    bandtemp = 1.0 - (double) bandy / h;
                    break;
                default:
                    bandtemp = 0;
                    break;
            }
            bandtemp = Math.max(bandtemp, 0.075);

            final int[] band = new int[w];
            for (int x = 0; x < w; x++) {
                band[x] = bandy;
            }

            // Randomize
            double dir = 1.0;
            double diradj = 1;
            double dirsin = r.nextDouble() * 7 + 1;
            for (int x = 0; x < w; x++) {
                band[x] = (int) (band[x] + dir);
                dir = dir + r.nextDouble() * (Math.sin(dirsin * x) * diradj);
                if (dir > bandrange) {
                    diradj = -1;
                    dirsin = r.nextDouble() * 7 + 1;
                }
                if (dir < -bandrange) {
                    diradj = 1;
                    dirsin = r.nextDouble() * 7 + 1;
                }
            }

            for (int x = 0; x < w; x++) {
                for (int y = 0; y < h; y++) {

                    double elevation = getElevation(x, y);
                    if (elevation < WorldGenerator.SEA_LEVEL) {
                        // Water tiles
                        if (y > band[x]) {
                            setTemperature(x, y, bandtemp * 0.7);
                        }
                    } else {
                        // Land tiles
                        if (y > band[x]) {
                            setTemperature(x, y, bandtemp * (1.0 - (elevation - WorldGenerator.SEA_LEVEL)));
                        }
                    }
                }
            }
        }
    }

    private void setTemperature(int x, int y, double v) {
        temperature.setData(x, y, v);
    }

    private double getElevation(int x, int y) {
        return elevation.getData(x, y, 0.0);
    }
}
