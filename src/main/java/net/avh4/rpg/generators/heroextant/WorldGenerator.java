package net.avh4.rpg.generators.heroextant;

import net.avh4.rpg.maptoolkit.MapGenerationPhase;
import net.avh4.rpg.maptoolkit.data.DenseMapData;
import net.avh4.rpg.maptoolkit.data.MapData;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Random;

public class WorldGenerator implements MapGenerationPhase {

    private static final int MAX_WORLD_X = 2048 * 2;
    private static final int MAX_WORLD_Y = MAX_WORLD_X;

    // MAX_WORLD_SUMSQR = 0 + ((MAX_WORLD_X * MAX_WORLD_X) + (MAX_WORLD_Y *
    // MAX_WORLD_Y))
    //
    // PRECOMPRESS_ABS_OFFSET = 1073741824 // (1 Shl 30)
    //
    public static double SEA_LEVEL = 0.333;

    private int[][] contiguousMap;

    private int worldW;
    private int worldH;
    private final Random r;
    private final MapData<Double> elevation;
    private final MapData<TileType> tiles;

    private final ElevationGenerationPhase elevationGeneration;
    private final TemperatureGenerationPhase temperatureGeneration;
    private final WindRainfallGenerationPhase windRainfallGeneration;
    private final RiverGenerationPhase riverGeneration;
    private final TerrainGenerationPhase terrainGeneration;

    public static void main(final String[] args) throws IOException {
        final int w = 800;
        final int h = 600;
        final MapData<Double> elevation = new DenseMapData<Double>(w, h);
        final MapData<Double> temperature = new DenseMapData<Double>(w, h);
        final MapData<Double> windz = new DenseMapData<Double>(w, h);
        final MapData<Double> rainfall = new DenseMapData<Double>(w, h);
        final MapData<TileType> tiles = new DenseMapData<TileType>(w, h);
        final MapData<Integer> waterSaturation = new DenseMapData<Integer>(w, h);

        final WorldGenerator world = new WorldGenerator(w, h, Hemisphere.North, new Random(),
                elevation, temperature, windz, rainfall, tiles, waterSaturation);
        System.out.println("Generating world...");
        world.execute();
        // wgen_SaveWorldToBin(worldFolder, prgGen)
        System.out.println("Writing 'rendered.png'");
        world.renderWorldToPng("rendered.png");
        System.out.println("Writing 'rendered.tmx'");
        world.renderWorldToTmx("rendered.tmx");
        // wgen_RenderHeightMapToPng(worldFolder + 'heightmap.png', prgGen)
        // wgen_RenderTemperaturesToPng(worldFolder + 'temperatures.png',
        // prgGen)
        // wgen_FreeWorld()
    }

    private void renderWorldToTmx(final String filename) throws IOException {
        final FileWriter fw = new FileWriter(filename);
        fw.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
        fw.write("<map version=\"1.0\" orientation=\"orthogonal\" width=\"800\" height=\"600\" tilewidth=\"32\" tileheight=\"32\">\n");
        fw.write(" <tileset firstgid=\"1\" name=\"dg_grounds32\" tilewidth=\"32\" tileheight=\"32\">\n");
        fw.write("  <image source=\"/Users/avh4/Documents/Graphics Library/Tiles/AngBandTk/dg_grounds32.gif\" width=\"288\" height=\"608\"/>\n");
        fw.write(" </tileset>\n");
        fw.write(" <layer name=\"Generated World\" width=\"800\" height=\"600\">\n");
        fw.write("  <data>\n");

        for (int y = 0; y < worldH; y++) {
            for (int x = 0; x < worldW; x++) {
                int gid = 0;
                switch (getTileType(x, y)) {
                    case Sea:
                        gid = 21 - (int) (getElevation(x, y) / SEA_LEVEL * 3);
                        break;
                    case Grassland:
                        gid = 10;
                        break;
                    case Forest:
                        gid = 56;
                        break;
                    case Jungle:
                        gid = 65;
                        break;
                    case Desert:
                        gid = 13;
                        break;
                    case GreenMountain:
                        gid = 118;
                        break;
                    case BarrenMountain:
                        gid = 125;
                        break;
                    case Frozen:
                        gid = 106;
                        break;
                    case River:
                        gid = 16;
                        break;
                    case Undefined:
                    default:
                        gid = 0;
                        break;
                }
                fw.write("   <tile gid=\"" + gid + "\"/>\n");
            }
        }
        fw.write("  </data>\n");
        fw.write(" </layer>\n");
        fw.write("</map>\n");
        fw.close();
    }

    private void renderWorldToPng(final String filename) throws IOException {
        final BufferedImage tmpImg = new BufferedImage(worldW, worldH,
                BufferedImage.TYPE_INT_RGB);
        final Graphics2D g = tmpImg.createGraphics();

        for (int y = 0; y < worldH; y++) {
            for (int x = 0; x < worldW; x++) {
                final Color c = colorFromTileTypeAndElevation(y, x);

                g.setColor(c);
                g.drawLine(x, y, x, y);
            }
        }

        g.dispose();

        ImageIO.write(tmpImg, "PNG", new File(filename));
    }

    private Color colorFromTileTypeAndElevation(final int y, final int x) {
        final float e = (float) getElevation(x, y);
        Color c;
        switch (getTileType(x, y)) {
            case Undefined:
                c = new Color(e, 0, 0);
                break;
            case Sea:
                c = new Color(0f, 0f, (float) (0.5 * e + 0.5));
                break;
            case Grassland:
                c = new Color(e * 0.5f, e, 0f);
                break;
            case Forest:
                c = new Color(0f, e * .75f, 0f);
                break;
            case Jungle:
                c = new Color(0f, 0.5f * e, 0f);
                break;
            case Desert:
                c = new Color(.75f * e, .75f * e, 0);
                break;
            case GreenMountain:
                c = new Color(.35f * e, .5f * e, .35f * e);
                break;
            case BarrenMountain:
                c = new Color(.5f * e, .35f * e, .35f * e);
                break;
            case Frozen:
                c = new Color(.25f + .75f * e, .25f + .75f * e, .25f + .75f * e);
                break;
            case River:
                c = new Color(0, 0, e);
                break;
            default:
                c = new Color(r.nextFloat(), r.nextFloat(), r.nextFloat());
        }
        return c;
    }

    @SuppressWarnings("unused")
    private Color colorFromRegion(final int y, final int x) {
        return new Color(contiguousMap[x][y] * 40 % 256,
                contiguousMap[x][y] * 40 % 256, contiguousMap[x][y] * 40 % 256);
    }

    public WorldGenerator(int width, int height, Hemisphere hemisphere, Random r, MapData<Double> elevation,
                          MapData<Double> temperature, MapData<Double> windz, MapData<Double> rainfall,
                          MapData<TileType> tiles, MapData<Integer> waterSaturation) {
        validateWorldSize(width, height);
        this.worldW = width;
        this.worldH = height;
        this.r = r;
        this.elevation = elevation;
        this.tiles = tiles;
        elevationGeneration = new ElevationGenerationPhase(r, elevation);
        temperatureGeneration = new TemperatureGenerationPhase(r, hemisphere, elevation, temperature);
        windRainfallGeneration = new WindRainfallGenerationPhase(r, elevation, temperature, rainfall, windz);
        riverGeneration = new RiverGenerationPhase(r, elevation, rainfall, waterSaturation);
        terrainGeneration = new TerrainGenerationPhase(elevation, temperature, rainfall, waterSaturation, tiles);
    }

    @Override
    public void execute() {
        do {
            elevationGeneration.execute();
        } while (getLandMassPercent() < 0.15 || getAverageElevation() < 0.1);
        temperatureGeneration.execute();
        windRainfallGeneration.execute();
        riverGeneration.execute();
        terrainGeneration.execute();
        determineContiguousAreas();
    }

    private float getAverageElevation() {
        // TODO Auto-generated method stub
        return .5f;
    }

    private float getLandMassPercent() {
        // TODO Auto-generated method stub
        return .5f;
    }

    private void validateWorldSize(int w, int h) {
        if (w > MAX_WORLD_X || h > MAX_WORLD_Y) {
            throw new RuntimeException(String.format("%d x %d is to large. Maximum map size is %d x %d",
                    w, h, MAX_WORLD_X, MAX_WORLD_Y));
        }
        if (w < 32 || h < 32) {
            throw new RuntimeException(String.format("%d x %d is too small. Minimum map size is 32 x 32",
                    w, h));
        }
    }

    private void determineContiguousAreas() {
        contiguousMap = new int[worldW][worldH];
        for (int y = 0; y < worldH; y++) {
            for (int x = 0; x < worldW; x++) {
                contiguousMap[x][y] = 1;
            }
        }

        // Step 1 - identify groups
        int i = 2;
        for (int y = 1; y < worldH; y++) {
            for (int x = 1; x < worldW; x++) {
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

        int contiguousAreaCount = i;

        // Step 2a - merge rivers
        for (int x = 1; x < worldW - 1; x++) {
            for (int y = 1; y < worldH - 1; y++) {
                if (getTileType(x, y) == TileType.River) {
                    contiguousMap[x][y] = 1;
                }
            }
        }

        // Step 2b - merge groups
        for (int x = 1; x < worldW - 1; x++) {
            for (int y = 1; y < worldH - 1; y++) {

                for (int x2 = -1; x2 <= 1; x2++) {
                    for (int y2 = -1; y2 <= 1; y2++) {
                        if (x2 != 0 || y2 != 0) {
                            if (contiguousMap[x][y] != contiguousMap[x + x2][y
                                    + y2]) {
                                if (getTileType(x, y) == getTileType(x
                                        + x2, y + y2)) {
                                    final int adjust = contiguousMap[x + x2][y
                                            + y2];
                                    for (int x3 = 0; x3 < worldW; x3++) {
                                        for (int y3 = 0; y3 < worldH; y3++) {
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
        int lowest = worldW * worldH + 1;
        boolean done = false;
        do {
            done = true;

            for (int x = 0; x < worldW; x++) {
                for (int y = 0; y < worldH; y++) {
                    if (contiguousMap[x][y] < lowest
                            && contiguousMap[x][y] > limit) {
                        lowest = contiguousMap[x][y];
                    }
                }
            }

            for (int x = 0; x < worldW; x++) {
                for (int y = 0; y < worldH; y++) {
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

        contiguousAreaCount = limit;
    }

    private double getElevation(int x, int y) {
        return elevation.getData(x, y, 0.0);
    }

    private TileType getTileType(int x, int y) {
        return tiles.getData(x, y);
    }
}
