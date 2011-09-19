package net.avh4.rpg.generators.heroextant;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
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
	private static double WIND_GRAVITY = 0.975;
	private static int WIND_RESOLUTION = 4; // 1 is perfect, higher = rougher
	private static int TEMPERATURE_BAND_RESOLUTION = 2; // 1 is perfect, higher
														// = rougher
	private static double RAIN_FALLOFF = 0.2; // Default 0.2 - less for less
												// rain, more for
	// more rain
	// WGEN_MAX_TEMPERATURE = 40
	// WGEN_MIN_TEMPERATURE = -60
	//
	private static double WIND_OFFSET = 180;
	private static int WIND_PARITY = -1; // -1 or 1

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
		w.renderWorldToTmx("rendered.tmx");
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
				switch (worldTile[x][y].tileType) {
				case Sea:
					gid = 21 - (int) (worldTile[x][y].elevation / SEA_LEVEL * 3);
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
				final float e = (float) worldTile[x][y].elevation;
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

	/**
	 * Attempt to classify each temperature/rain/waterSaturation combo as a
	 * terrain type
	 */
	private void determineWorldTerrainTypes() {
		for (int y = 0; y < worldH; y++) {
			for (int x = 0; x < worldW; x++) {
				if (worldTile[x][y].elevation <= SEA_LEVEL) {
					worldTile[x][y].tileType = TileType.Sea;
				} else if (worldTile[x][y].temperature < 0.15) {
					worldTile[x][y].tileType = TileType.Frozen;
				} else if (worldTile[x][y].tileType == TileType.River) {
					; // already a river
				} else if (worldTile[x][y].elevation > 0.666) {
					if (worldTile[x][y].temperature <= 0.15) {
						worldTile[x][y].tileType = TileType.Frozen;
					} else if (worldTile[x][y].rainfall < 0.4) {
						worldTile[x][y].tileType = TileType.BarrenMountain;
					} else {
						worldTile[x][y].tileType = TileType.GreenMountain;
					}
				} else if (worldTile[x][y].rainfall < 0.150) {
					worldTile[x][y].tileType = TileType.Desert;
				} else if (worldTile[x][y].rainfall < 0.250) {
					worldTile[x][y].tileType = TileType.Grassland;
				} else if (worldTile[x][y].rainfall < 0.325) {
					worldTile[x][y].tileType = TileType.Forest;
				} else if (worldTile[x][y].rainfall <= 1.0) {
					if (worldTile[x][y].temperature > 0.3) {
						worldTile[x][y].tileType = TileType.Jungle;
					} else {
						worldTile[x][y].tileType = TileType.Forest;
					}
				}
			}
		}

	}

	private void calculateWaterFlow() {
		int steps = 0;
		final double maxSteps = Math
				.sqrt((worldW * worldW) + (worldH * worldH)) / 2;
		// maxSteps = worldW / 2
		final String resultString = "";

		// Init rivers
		final List<River> riverList = new ArrayList<River>();
		for (int i = 0; i < maxSteps * 8; i++) {
			final int x = r.nextInt(worldW - 3) + 1;
			final int y = r.nextInt(worldH - 3) + 1;
			if (worldTile[x][y].elevation > SEA_LEVEL
					&& worldTile[x][y].elevation < 1.0) {
				if (r.nextDouble() * worldTile[x][y].rainfall > 0.125) {
					final River river = new River();
					riverList.add(river);
					river.x = x;
					river.y = y;
				}
			}
		}

		// Water flow
		int countMoves = 0;
		int lastMoves = 0;
		int moves = 0;
		do {

			lastMoves = moves;
			moves = 0;
			steps++;

			// Water physics
			for (final River river : riverList) {

				final int x = river.x;
				final int y = river.y;

				if (worldTile[x][y].elevation > SEA_LEVEL && (x > 0) && (y > 0)
						&& (x < worldW - 1) && (y < worldH - 1)) {
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
					cost[1][0] = (worldTile[x][y - 1].elevation)
							- (worldTile[x][y].elevation);
					// cost[2][0] = ((worldTile[x + 1][y - 1].elevation) -
					// (worldTile[x][y].elevation)); // 1.41

					// Mid
					cost[0][1] = (worldTile[x - 1][y].elevation)
							- (worldTile[x][y].elevation);
					cost[2][1] = (worldTile[x + 1][y].elevation)
							- (worldTile[x][y].elevation);

					// Bottom
					// cost[0][2] = ((worldTile[x - 1][y + 1].elevation) -
					// (worldTile[x][y].elevation)); // 1.41
					cost[1][2] = (worldTile[x][y + 1].elevation)
							- (worldTile[x][y].elevation);
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
							if ((i == 1 && j == 1) == false) /*
															 * and (cost[i,j] <
															 * 0)
															 */{
								// Divide water up...
								if (cost[i][j] == highestCost) {
									river.x = x + (i - 1);
									river.y = y + (j - 1);
									worldTile[x][y].waterSaturation = 1;
									moves++;
								}
							}
						}
					}
				}

			}

			countMoves = countMoves + moves;

		} while (moves != 0 && steps <= maxSteps - 1);

		// Make rivers
		for (int y = 0; y < worldH; y++) {
			for (int x = 0; x < worldW; x++) {
				if (worldTile[x][y].waterSaturation > 0) {
					worldTile[x][y].tileType = TileType.River;
				}
			}
		}

		// Done!
		// resultString = "Moves: "+ToString(countMoves)
	}

	/**
	 * Orographic effect:
	 * 
	 * # Warm, moist air carried in by wind<br/>
	 * # Mountains forces air upwards, where it cools and condenses (rains)<br/>
	 * # The leeward side of the mountain is drier and casts a "rain shadow".
	 * 
	 * Wind is modeled here as a square of particles of area<br/>
	 * worldW * worldH<br/>
	 * and<br/>
	 * Sqrt(worldW^2+worldH^2) away<br/>
	 * The wind travels in direction of worldWinDir
	 */
	private void calculateWind() {
		// Init wind x,y,w,h
		final double r = Math.sqrt((double) (worldW * worldW)
				+ (double) (worldH * worldH));
		final double theta1 = worldWindDir * WIND_PARITY + WIND_OFFSET;
		final double theta2 = 180 - 90 - (worldWindDir * WIND_PARITY + WIND_OFFSET);
		final double sinT1 = Math.sin(theta1);
		final double sinT2 = Math.sin(theta2);
		final int windw = (worldW);
		final int windh = (worldH);
		final double mapsqrt = Math.sqrt((worldW * worldW) + (worldH * worldH));

		// Init wind
		final double[][] wind = new double[windw][windh];
		final double rainfall = 1.0;
		final double[][] windr = new double[windw][windh];
		for (int x = 0; x < windw; x++) {
			for (int y = 0; y < windh; y++) {
				wind[x][y] = 0;
				windr[x][y] = ((rainfall * mapsqrt) / WIND_RESOLUTION)
						* RAIN_FALLOFF;
			}
		}

		// Cast wind
		for (double d = r; d >= 0; d -= WIND_RESOLUTION) {

			final double windx = d * sinT1;
			final double windy = d * sinT2;

			for (int x = 0; x < windw; x++) {
				for (int y = 0; y < windh; y++) {

					if (windx + x > -1 && windy + y > -1) {
						if (windx + x < worldW && windy + y < worldH) {

							final double windz = worldTile[(int) (windx + x)][(int) (windy + y)].elevation;
							wind[x][y] = Math.max(wind[x][y] * WIND_GRAVITY,
									windz);

							final double rainRemaining = windr[x][y]
									/ (((rainfall * mapsqrt) / WIND_RESOLUTION) * RAIN_FALLOFF)
									* (1.0 - (worldTile[x][y].temperature / 2.0));
							double rlost = (wind[x][y]) * rainRemaining;
							if (rlost < 0) {
								rlost = 0;
							}
							windr[x][y] = windr[x][y] - rlost;
							if (windr[x][y] < 0) {
								windr[x][y] = 0;
							}

							worldTile[(int) (windx + x)][(int) (windy + y)].windz = wind[x][y];
							worldTile[(int) (windx + x)][(int) (windy + y)].rainfall = rlost;
						}
					}

				}
			}

		}

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
