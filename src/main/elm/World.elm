module World where

import Matrix exposing (Matrix)

type alias Tile =
    { elevation : Float
    }

tile : Tile
tile =
    { elevation = 0.0
    }

initialMap = Matrix.matrix 100 100 (always tile)

type alias World =
    { seaLevel : Float
    , map : Matrix Tile
    }

defaultSeaLevel = 0.2

