package net.avh4.rpg.generators.heroextant;

import net.avh4.rpg.maptoolkit.MapGenerationPhase;
import net.avh4.rpg.maptoolkit.data.ConstMapData;
import net.avh4.rpg.maptoolkit.data.MapData;
import net.avh4.util.Random;

public class WindRainfallGenerationPhase implements MapGenerationPhase {

    private static final double WIND_GRAVITY = 0.975;
    private static final int WIND_RESOLUTION = 4; // 1 is perfect, higher = rougher
    private static final double WIND_OFFSET = 180;
    private static final int WIND_PARITY = -1; // -1 or 1
    private static final double RAIN_FALLOFF = 0.2; // Default 0.2 - less for less rain, more for more rain

    // MAX_WIND_X = MAX_WORLD_X
    // MAX_WIND_Y = MAX_WIND_X

    private final int w;
    private final int h;
    private final double windAngle;
    private final MapData<Double> rainfall;
    private final MapData<Double> windz;
    private final ConstMapData<Double> temperature;
    private final ConstMapData<Double> elevation;

    public WindRainfallGenerationPhase(Random r, ConstMapData<Double> elevation, ConstMapData<Double> temperature,
                                       MapData<Double> rainfall, MapData<Double> windz) {
        this(r.nextDouble() * 360, elevation, temperature, rainfall, windz);
    }

    public WindRainfallGenerationPhase(double windAngleInDegrees, ConstMapData<Double> elevation,
                                       ConstMapData<Double> temperature, MapData<Double> rainfall,
                                       MapData<Double> windz) {
        windAngle = windAngleInDegrees;
        w = rainfall.getWidth();
        h = rainfall.getHeight();
        this.rainfall = rainfall;
        this.windz = windz;
        this.temperature = temperature;
        this.elevation = elevation;
    }

    /**
     * Orographic effect:
     * <p/>
     * # Warm, moist air carried in by wind<br/>
     * # Mountains forces air upwards, where it cools and condenses (rains)<br/>
     * # The leeward side of the mountain is drier and casts a "rain shadow".
     * <p/>
     * Wind is modeled here as a square of particles of area<br/>
     * worldW * worldH<br/>
     * and<br/>
     * Sqrt(worldW^2+worldH^2) away<br/>
     * The wind travels in direction of worldWinDir
     */
    @Override
    public void execute() {
        // Init wind x,y,w,h
        final double r = Math.sqrt((double) (w * w) + (double) (h * h));
        final double theta1 = windAngle * WIND_PARITY + WIND_OFFSET;
        final double theta2 = 180 - 90 - (windAngle * WIND_PARITY + WIND_OFFSET);
        final double sinT1 = Math.sin(theta1);
        final double sinT2 = Math.sin(theta2);
        final double mapsqrt = Math.sqrt((w * w) + (h * h));

        // Init wind
        final double[][] wind = new double[w][h];
        final double rainfall = 1.0;
        final double[][] windr = new double[w][h];
        for (int x = 0; x < w; x++) {
            for (int y = 0; y < h; y++) {
                wind[x][y] = 0;
                windr[x][y] = ((rainfall * mapsqrt) / WIND_RESOLUTION) * RAIN_FALLOFF;
            }
        }

        // Cast wind
        for (double d = r; d >= 0; d -= WIND_RESOLUTION) {

            final double windx = d * sinT1;
            final double windy = d * sinT2;

            for (int x = 0; x < w; x++) {
                for (int y = 0; y < h; y++) {

                    if (windx + x > -1 && windy + y > -1) {
                        if (windx + x < w && windy + y < h) {

                            final double windz = getElevation((int) (windx + x), (int) (windy + y));
                            wind[x][y] = Math.max(wind[x][y] * WIND_GRAVITY, windz);

                            final double rainRemaining = windr[x][y]
                                    / (((rainfall * mapsqrt) / WIND_RESOLUTION) * RAIN_FALLOFF)
                                    * (1.0 - (getTemperature(x, y) / 2.0));
                            double rlost = (wind[x][y]) * rainRemaining;
                            if (rlost < 0) {
                                rlost = 0;
                            }
                            windr[x][y] = windr[x][y] - rlost;
                            if (windr[x][y] < 0) {
                                windr[x][y] = 0;
                            }

                            setWindz((int) (windx + x), (int) (windy + y), wind[x][y]);
                            setRainfall((int) (windx + x), (int) (windy + y), rlost);
                        }
                    }
                }
            }
        }
    }

    private void setRainfall(int x, int y, double value) {
        rainfall.setData(x, y, value);
    }

    private void setWindz(int x, int y, double value) {
        windz.setData(x, y, value);
    }

    private double getTemperature(int x, int y) {
        return temperature.getData(x, y, 0.0);
    }

    private double getElevation(int x, int y) {
        return elevation.getData(x, y, 0.0);
    }
}
