package net.avh4.rpg.generators.heroextant.datastore;

import net.avh4.rpg.generators.heroextant.TileType;

public class Tile {
	TileType tileType = TileType.Undefined;
	double elevation = 0;
	double windz = 0;
	double rainfall = 0;
	int waterSaturation = 0; // float
	double temperature = 0;
}
