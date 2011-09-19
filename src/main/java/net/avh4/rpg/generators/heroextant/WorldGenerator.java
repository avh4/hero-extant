package net.avh4.rpg.generators.heroextant;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;

public class WorldGenerator {

	// WGEN_BIN_COMPAT_ID = 2
	//
	private static int MAX_WORLD_X = 2048 * 2;
	private static int MAX_WORLD_Y = MAX_WORLD_X;

	// MAX_WORLD_SUMSQR = 0 + ((MAX_WORLD_X * MAX_WORLD_X) + (MAX_WORLD_Y *
	// MAX_WORLD_Y))
	//
	// MAX_WIND_X = MAX_WORLD_X
	// MAX_WIND_Y = MAX_WIND_X
	//
	// PRECOMPRESS_ABS_OFFSET = 1073741824 // (1 Shl 30)
	//
	// TILE_FLAG_GRASSLAND = 1
	// TILE_FLAG_FOREST = 2
	// TILE_FLAG_JUNGLE = 4
	// TILE_FLAG_DESERT = 8
	// TILE_FLAG_GREEN_MOUNTAIN = 16
	// TILE_FLAG_BARREN_MOUNTAIN = 32
	// TILE_FLAG_FROZEN = 64
	//
	// WGEN_PREVIEW_ELEVATION = 1 ; export
	// WGEN_PREVIEW_COLOR = 2 ; export
	// WGEN_PREVIEW_WIND = 4 ; export
	// WGEN_PREVIEW_RAINFALL = 8 ; export
	// WGEN_PREVIEW_SEALEVEL = 16 ; export
	// WGEN_PREVIEW_TEMPERATURE = 32 ; export
	// WGEN_PREVIEW_RIVERS = 64 ; export
	// WGEN_PREVIEW_COLOR_ELEVATION = 128 ; export
	// WGEN_PREVIEW_CONTIGUOUS = 256 ; export
	// WGEN_PREVIEW_TEMPERATURE_RAW = 512 ; export
	//
	//
	private static double SEA_LEVEL = 0.333;
	// WGEN_WIND_GRAVITY = 0.975
	// WGEN_WIND_RESOLUTION = 4 // 1 is perfect, higher = rougher
	private static int TEMPERATURE_BAND_RESOLUTION = 2; // 1 is perfect, higher
														// = rougher
	// WGEN_RAIN_FALLOFF = 0.2 // Default 0.2 - less for less rain, more for
	// more rain
	// WGEN_MAX_TEMPERATURE = 40
	// WGEN_MIN_TEMPERATURE = -60
	//
	// WIND_OFFSET = 180
	// WIND_PARITY = -1 // -1 or 1

	private Tile worldTile[][];
	//
	// // Wind and rain!
	// wind: Array[MAX_WIND_X, MAX_WIND_Y] of Real // elevation
	// windr: Array[MAX_WIND_X, MAX_WIND_Y] of Real // rainfall
	// windx, windy: Real
	// windw, windh: Integer
	//
	// // Ccontiguous areas
	// contiguousMap: Array[MAX_WORLD_X, MAX_WORLD_Y] of Integer
	// contiguousAreaCount: Integer
	//
	private int worldW;
	private int worldH;
	private double worldWindDir;
	private final Random r;

	//
	// resultString: String = "" ; export

	public static void main(final String[] args) throws IOException {
		final WorldGenerator w = new WorldGenerator(800, 600, Hemisphere.North);
		// wgen_SaveWorldToBin(worldFolder, prgGen)
		w.renderWorldToPng("rendered.png");
		// wgen_RenderHeightMapToPng(worldFolder + 'heightmap.png', prgGen)
		// wgen_RenderTemperaturesToPng(worldFolder + 'temperatures.png',
		// prgGen)
		// wgen_FreeWorld()
	}

	private void renderWorldToPng(final String filename) throws IOException {
		final BufferedImage tmpImg = new BufferedImage(worldW, worldH,
				BufferedImage.TYPE_INT_RGB);
		final Graphics2D g = tmpImg.createGraphics();

		for (int y = 0; y < worldH; y++) {
			for (int x = 0; x < worldW; x++) {
				final float e = (float) worldTile[x][y].temperature;
				Color c;
				switch (worldTile[x][y].tileType) {
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
					c = new Color(.25f + .75f * e, .25f + .75f * e,
							.25f + .75f * e);
					break;
				case River:
					c = new Color(0, 0, e);
					break;
				default:
					c = new Color(r.nextFloat(), r.nextFloat(), r.nextFloat());
				}

				g.setColor(c);
				g.drawLine(x, y, x, y);
			}
		}

		g.dispose();

		ImageIO.write(tmpImg, "PNG", new File(filename));
	}

	public WorldGenerator(final int width, final int height,
			final Hemisphere hemisphere) {
		r = new Random();
		do {
			createWorld(width, height);
		} while (getLandMassPercent() < 0.15 || getAverageElevation() < 0.1);
		calculateTemperatures(hemisphere);
		calculateWind();
		calculateWaterFlow();
		determineWorldTerrainTypes();
	}

	private void determineWorldTerrainTypes() {
		// TODO Auto-generated method stub

	}

	private void calculateWaterFlow() {
		// TODO Auto-generated method stub

	}

	private void calculateWind() {
		// TODO Auto-generated method stub

	}

	private void calculateTemperatures(final Hemisphere hemisphere) {
		for (int i = 0; i < worldH; i += TEMPERATURE_BAND_RESOLUTION) {

			// Generate band
			final int bandy = i;
			final int bandrange = 7;

			double bandtemp;
			switch (hemisphere) {
			case North:
				// 0, 0.5, 1
				bandtemp = (double) i / worldH;
				break;
			case Equator:
				// 0, 1, 0
				if (i < worldH / 2) {
					bandtemp = (double) i / worldH;
					bandtemp = bandtemp * 2.0;
				} else {
					bandtemp = 1.0 - (double) i / worldH;
					bandtemp = bandtemp * 2.0;
				}
				break;
			case South:
				// 1, 0.5, 0
				bandtemp = 1.0 - (double) i / worldH;
				break;
			default:
				bandtemp = 0;
				break;
			}
			bandtemp = Math.max(bandtemp, 0.075);

			final int[] band = new int[worldW];
			for (int x = 0; x < worldW; x++) {
				band[x] = bandy;
			}

			// Randomize
			double dir = 1.0;
			double diradj = 1;
			double dirsin = r.nextDouble() * 7 + 1;
			for (int x = 0; x < worldW; x++) {
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

			for (int x = 0; x < worldW; x++) {
				for (int y = 0; y < worldH; y++) {

					if (worldTile[x][y].elevation < SEA_LEVEL) {
						// Water tiles
						if (y > band[x]) {
							worldTile[x][y].temperature = bandtemp * 0.7;
						}
					} else {
						// Land tiles
						if (y > band[x]) {
							worldTile[x][y].temperature = bandtemp
									* (1.0 - (worldTile[x][y].elevation - SEA_LEVEL));
						}
					}
				}
			}
		}

	}

	private float getAverageElevation() {
		// TODO Auto-generated method stub
		return .5f;
	}

	private float getLandMassPercent() {
		// TODO Auto-generated method stub
		return .5f;
	}

	private void createWorld(int w, int h) {
		final double roughness = 100.0 / 20;
		final double elevation = 100.0 / 200;

		if (w > MAX_WORLD_X) {
			w = MAX_WORLD_X;
		}
		if (h > MAX_WORLD_Y) {
			h = MAX_WORLD_Y;
		}
		if (w < 32) {
			w = 32;
		}
		if (h < 32) {
			h = 32;
		}
		worldW = w;
		worldH = h;
		final double z = elevation / 100.0;

		// World Globals
		worldWindDir = r.nextDouble() * 360;

		// Init tiles
		worldTile = new Tile[w][h];
		for (int x = 0; x < w; x++) {
			for (int y = 0; y < h; y++) {
				worldTile[x][y] = new Tile();
			}
		}

		// Recursively divide for Random fractal landscape
		divideWorld(0, 0, worldW - 1, worldH - 1, roughness, elevation);

		// Clamp
		for (int x = 0; x < w; x++) {
			for (int y = 0; y < h; y++) {
				if (x == 0) {
					worldTile[x][y].elevation = 0;
				}
				if (y == 0) {
					worldTile[x][y].elevation = 0;
				}
				if (x == w - 1) {
					worldTile[x][y].elevation = 0;
				}
				if (y == h - 1) {
					worldTile[x][y].elevation = 0;
				}
				if (worldTile[x][y].elevation > 1) {
					worldTile[x][y].elevation = 1;
				}
				if (worldTile[x][y].elevation < 0) {
					worldTile[x][y].elevation = 0;
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

		double d = (((double) (w + h) / 2) / (worldW + worldH));
		d = d * (r.nextDouble() * 2 - 1) * roughness;

		if (w > 1 || h > 1) {

			worldTile[midx][y1].elevation = (worldTile[x1][y1].elevation + worldTile[x2][y1].elevation) / 2;
			worldTile[midx][y2].elevation = (worldTile[x1][y2].elevation + worldTile[x2][y2].elevation) / 2;
			worldTile[x1][midy].elevation = (worldTile[x1][y1].elevation + worldTile[x1][y2].elevation) / 2;
			worldTile[x2][midy].elevation = (worldTile[x2][y1].elevation + worldTile[x2][y2].elevation) / 2;
			worldTile[midx][midy].elevation = d
					+ ((worldTile[x1][y1].elevation
							+ worldTile[x1][y2].elevation
							+ worldTile[x2][y1].elevation + worldTile[x2][y2].elevation) / 4);

			if (midinit > -1) {
				worldTile[midx][midy].elevation = midinit;
			}

			divideWorld(x1, y1, midx, midy, roughness, -1);
			divideWorld(midx, y1, x2, midy, roughness, -1);
			divideWorld(x1, midy, midx, y2, roughness, -1);
			divideWorld(midx, midy, x2, y2, roughness, -1);

		}
	}
}
