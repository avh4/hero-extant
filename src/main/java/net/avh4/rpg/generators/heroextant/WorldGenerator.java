package net.avh4.rpg.generators.heroextant;

import net.avh4.rpg.generators.heroextant.datastore.MemoryDataStore;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class WorldGenerator {

	private static final int MAX_WORLD_X = 2048 * 2;
	private static final int MAX_WORLD_Y = MAX_WORLD_X;

	// MAX_WORLD_SUMSQR = 0 + ((MAX_WORLD_X * MAX_WORLD_X) + (MAX_WORLD_Y *
	// MAX_WORLD_Y))
	//
	// MAX_WIND_X = MAX_WORLD_X
	// MAX_WIND_Y = MAX_WIND_X
	//
	// PRECOMPRESS_ABS_OFFSET = 1073741824 // (1 Shl 30)
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

    private final DataStore data;

	private int[][] contiguousMap;

	private int worldW;
	private int worldH;
	private double worldWindDir;
	private final Random r;

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

    public WorldGenerator(final int width, final int height,
                          final Hemisphere hemisphere) {
        this(width, height, hemisphere, new MemoryDataStore());
    }

    public WorldGenerator(final int width, final int height,
                          final Hemisphere hemisphere, DataStore data) {
		this(width, height, hemisphere, new Random(), data);
    }

    public WorldGenerator(final int width, final int height,
                          final Hemisphere hemisphere, final Random r) {
        this(width, height, hemisphere, r, new MemoryDataStore());
    }

    public WorldGenerator(final int width, final int height,
                          final Hemisphere hemisphere, final Random r, DataStore data) {
		this.r = r;
        this.data = data;
        do {
			createWorld(width, height);
		} while (getLandMassPercent() < 0.15 || getAverageElevation() < 0.1);
		calculateTemperatures(hemisphere);
		calculateWind();
		calculateWaterFlow();
		determineWorldTerrainTypes();
		determineContiguousAreas();
	}

	/**
	 * Attempt to classify each temperature/rain/waterSaturation combo as a
	 * terrain type
	 */
	private void determineWorldTerrainTypes() {
		for (int y = 0; y < worldH; y++) {
			for (int x = 0; x < worldW; x++) {
				if (getElevation(x, y) <= SEA_LEVEL) {
					setTileType(x, y, TileType.Sea);
				} else if (getTemperature(x, y) < 0.15) {
					setTileType(x, y, TileType.Frozen);
				} else if (getTileType(x, y) == TileType.River) {
					; // already a river
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
			if (getElevation(x, y) > SEA_LEVEL
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

				if (getElevation(x, y) > SEA_LEVEL && (x > 0) && (y > 0)
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
					cost[1][0] = (getElevation(x, y - 1))
							- (getElevation(x, y));
					// cost[2][0] = ((worldTile[x + 1][y - 1].elevation) -
					// (worldTile[x][y].elevation)); // 1.41

					// Mid
					cost[0][1] = (getElevation(x - 1, y))
							- (getElevation(x, y));
					cost[2][1] = (getElevation(x + 1, y))
							- (getElevation(x, y));

					// Bottom
					// cost[0][2] = ((worldTile[x - 1][y + 1].elevation) -
					// (worldTile[x][y].elevation)); // 1.41
					cost[1][2] = (getElevation(x, y + 1))
							- (getElevation(x, y));
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

		// Make rivers
		for (int y = 0; y < worldH; y++) {
			for (int x = 0; x < worldW; x++) {
				if (getWaterSaturation(x, y) > 0) {
                    TileType tileType = TileType.River;
                    setTileType(x, y, tileType);
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

							final double windz = getElevation((int) (windx + x), (int) (windy + y));
							wind[x][y] = Math.max(wind[x][y] * WIND_GRAVITY,
									windz);

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

					if (getElevation(x, y) < SEA_LEVEL) {
						// Water tiles
						if (y > band[x]) {
                            setTemperature(x, y, bandtemp * 0.7);
                        }
					} else {
						// Land tiles
						if (y > band[x]) {
							setTemperature(x, y, bandtemp
									* (1.0 - (getElevation(x, y) - SEA_LEVEL)));
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

        data.init(w, h);

		// Recursively divide for Random fractal landscape
		divideWorld(0, 0, worldW - 1, worldH - 1, roughness, elevation);

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

		double d = (((double) (w + h) / 2) / (worldW + worldH));
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

    public TileType getTerrainAtLocation(final int x, final int y) {
		return getTileType(x, y);
	}

    private void setRainfall(int x, int y, double rainfall) {
        data.setRainfall(x, y, rainfall);
    }

    private void setWindz(int x, int y, double windz) {
        data.setWindz(x, y, windz);
    }

    private void setTemperature(int x, int y, double v) {
        data.setTemperature(x, y, v);
    }

    private double getTemperature(int x, int y) {
        return data.getTemperature(x, y);
    }

    private void setElevation(int x, int y, double v) {
        data.setElevation(x, y, v);
    }

    private double getElevation(int x, int y) {
        return data.getElevation(x, y);
    }

    private double getRainfall(int x, int y) {
        return data.getRainfall(x, y);
    }

    private void setWaterSaturation(int x, int y, int waterSaturation) {
        data.setWaterSaturation(x, y, waterSaturation);
    }

    private int getWaterSaturation(int x, int y) {
        return data.getWaterSaturation(x, y);
    }

    private void setTileType(int x, int y, TileType tileType) {
        data.setTileType(x, y, tileType);
    }

    private TileType getTileType(int x, int y) {
        return data.getTileType(x, y);
    }


}
