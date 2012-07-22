package net.avh4.rpg.generators.heroextant;

import net.avh4.rpg.maptoolkit.MapGenerationPhase;
import net.avh4.rpg.maptoolkit.data.ConstMapData;
import net.avh4.rpg.maptoolkit.data.MapData;

public class TerrainGenerationPhase implements MapGenerationPhase {
    private final int w;
    private final int h;
    private final ConstMapData<Double> temperature;
    private final ConstMapData<Double> elevation;
    private final ConstMapData<Double> rainfall;
    private final ConstMapData<Integer> waterSaturation;
    private final MapData<TileType> tiles;

    public TerrainGenerationPhase(ConstMapData<Double> elevation, ConstMapData<Double> temperature,
                                  ConstMapData<Double> rainfall, ConstMapData<Integer> waterSaturation,
                                  MapData<TileType> tiles) {
        this.elevation = elevation;
        this.temperature = temperature;
        this.rainfall = rainfall;
        this.waterSaturation = waterSaturation;
        this.tiles = tiles;
        w = elevation.getWidth();
        h = elevation.getHeight();
    }

    /**
     * Attempt to classify each temperature/rain/waterSaturation combo as a terrain type
     */
    @Override
    public void execute() {
        for (int y = 0; y < h; y++) {
            for (int x = 0; x < w; x++) {
                determineTile(x, y);
            }
        }
    }

    private void determineTile(int x, int y) {
        if (getElevation(x, y) <= WorldGenerator.SEA_LEVEL) {
            setTileType(x, y, TileType.Sea);
        } else if (getTemperature(x, y) < 0.15) {
            setTileType(x, y, TileType.Frozen);
        } else if (getWaterSaturation(x, y) > 0) {
            setTileType(x, y, TileType.River);
        } else if (getElevation(x, y) > 0.666) {
            if (getTemperature(x, y) <= 0.15) {
                setTileType(x, y, TileType.Frozen);
            } else if (getRainfall(x, y) < 0.4) {
                setTileType(x, y, TileType.BarrenMountain);
            } else {
                setTileType(x, y, TileType.GreenMountain);
            }
        } else if (getRainfall(x, y) < 0.150) {
            setTileType(x, y, TileType.Desert);
        } else if (getRainfall(x, y) < 0.250) {
            setTileType(x, y, TileType.Grassland);
        } else if (getRainfall(x, y) < 0.325) {
            setTileType(x, y, TileType.Forest);
        } else if (getRainfall(x, y) <= 1.0) {
            if (getTemperature(x, y) > 0.3) {
                setTileType(x, y, TileType.Jungle);
            } else {
                setTileType(x, y, TileType.Forest);
            }
        }
    }

    private double getTemperature(int x, int y) {
        return temperature.getData(x, y, 0.0);
    }

    private double getElevation(int x, int y) {
        return elevation.getData(x, y, 0.0);
    }

    private double getRainfall(int x, int y) {
        return rainfall.getData(x, y);
    }

    private int getWaterSaturation(int x, int y) {
        return waterSaturation.getData(x, y, 0);
    }

    private void setTileType(int x, int y, TileType value) {
        tiles.setData(x, y, value);
    }
}
