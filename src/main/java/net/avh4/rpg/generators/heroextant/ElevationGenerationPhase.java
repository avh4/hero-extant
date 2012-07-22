package net.avh4.rpg.generators.heroextant;

import net.avh4.rpg.maptoolkit.MapGenerationPhase;
import net.avh4.rpg.maptoolkit.data.MapData;

import java.util.Random;

public class ElevationGenerationPhase implements MapGenerationPhase {
    private final Random r;
    private final int w;
    private final int h;
    private final MapData<Double> elevation;

    public ElevationGenerationPhase(Random r, MapData<Double> elevation) {
        this.r = r;
        this.elevation = elevation;
        w = elevation.getWidth();
        h = elevation.getHeight();
    }

    @Override
    public void execute() {
        final double roughness = 100.0 / 20;
        final double elevation = 100.0 / 200;

        // Recursively divide for Random fractal landscape
        divideWorld(0, 0, w - 1, h - 1, roughness, elevation);

        // Clamp
        for (int x = 0; x < w; x++) {
            for (int y = 0; y < h; y++) {
                if (x == 0) {
                    setElevation(x, y, 0);
                }
                if (y == 0) {
                    setElevation(x, y, 0);
                }
                if (x == w - 1) {
                    setElevation(x, y, 0);
                }
                if (y == h - 1) {
                    setElevation(x, y, 0);
                }
                if (getElevation(x, y) > 1) {
                    setElevation(x, y, 1);
                }
                if (getElevation(x, y) < 0) {
                    setElevation(x, y, 0);
                }
            }
        }
    }

    private void divideWorld(final int x1, final int y1, final int x2,
                             final int y2, final double roughness, final double midinit) {
        final int w = x2 - x1;
        final int h = y2 - y1;
        final int midx = (x1 + x2) / 2;
        final int midy = (y1 + y2) / 2;

        double d = (((double) (w + h) / 2) / (this.w + this.h));
        d = d * (r.nextDouble() * 2 - 1) * roughness;

        if (w > 1 || h > 1) {

            setElevation(midx, y1, (getElevation(x1, y1) + getElevation(x2, y1)) / 2);
            setElevation(midx, y2, (getElevation(x1, y2) + getElevation(x2, y2)) / 2);
            setElevation(x1, midy, (getElevation(x1, y1) + getElevation(x1, y2)) / 2);
            setElevation(x2, midy, (getElevation(x2, y1) + getElevation(x2, y2)) / 2);
            setElevation(midx, midy, d
                    + ((getElevation(x1, y1)
                    + getElevation(x1, y2)
                    + getElevation(x2, y1) + getElevation(x2, y2)) / 4));

            if (midinit > -1) {
                setElevation(midx, midy, midinit);
            }

            divideWorld(x1, y1, midx, midy, roughness, -1);
            divideWorld(midx, y1, x2, midy, roughness, -1);
            divideWorld(x1, midy, midx, y2, roughness, -1);
            divideWorld(midx, midy, x2, y2, roughness, -1);
        }
    }

    private void setElevation(int x, int y, double v) {
        elevation.setData(x, y, v);
    }

    private double getElevation(int x, int y) {
        return elevation.getData(x, y, 0.0);
    }
}
