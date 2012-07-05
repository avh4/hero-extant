package net.avh4.rpg.generators.heroextant.datastore;

import net.avh4.rpg.generators.heroextant.DataStore;
import net.avh4.rpg.generators.heroextant.TileType;

public class MemoryDataStore implements DataStore {

    private Tile worldTile[][];

    @Override
    public void init(int w, int h) {
        worldTile = new Tile[w][h];
        for (int x = 0; x < w; x++) {
            for (int y = 0; y < h; y++) {
                worldTile[x][y] = new Tile();
            }
        }
    }

    @Override
    public void setRainfall(int x, int y, double value) {
        worldTile[x][y].rainfall = value;
    }

    @Override
    public void setWindz(int x, int y, double value) {
        worldTile[x][y].windz = value;
    }

    @Override
    public void setTemperature(int x, int y, double v) {
        worldTile[x][y].temperature = v;
    }

    @Override
    public double getTemperature(int x, int y) {
        return worldTile[x][y].temperature;
    }

    @Override
    public void setElevation(int x, int y, double v) {
        worldTile[x][y].elevation = v;
    }

    @Override
    public double getElevation(int x, int y) {
        return worldTile[x][y].elevation;
    }

    @Override
    public double getRainfall(int x, int y) {
        return worldTile[x][y].rainfall;
    }

    @Override
    public void setWaterSaturation(int x, int y, int value) {
        worldTile[x][y].waterSaturation = value;
    }

    @Override
    public int getWaterSaturation(int x, int y) {
        return worldTile[x][y].waterSaturation;
    }

    @Override
    public void setTileType(int x, int y, TileType tileType) {
        worldTile[x][y].tileType = tileType;
    }

    @Override
    public TileType getTileType(int x, int y) {
        return worldTile[x][y].tileType;
    }
}
