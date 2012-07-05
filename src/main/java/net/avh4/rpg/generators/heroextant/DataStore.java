package net.avh4.rpg.generators.heroextant;

public interface DataStore {
    void init(int w, int h);

    void setRainfall(int x, int y, double rlost1);

    void setWindz(int x, int y, double windz);

    void setTemperature(int x, int y, double v);

    double getTemperature(int x, int y);

    void setElevation(int x, int y, double v);

    double getElevation(int x, int y);

    double getRainfall(int x, int y);

    void setWaterSaturation(int x, int y, int waterSaturation);

    int getWaterSaturation(int x, int y);

    void setTileType(int x, int y, TileType tileType);

    TileType getTileType(int x, int y);
}
