import Graphics.Collage as C exposing (..)
import Graphics.Element as E exposing (..)
import Color exposing (..)
import Matrix exposing (Matrix)
import Random exposing (Seed)
import Text
import Debug
import Maybe exposing (map, withDefault, andThen, Maybe (..) )
import Array
import Time

import Elevation


initialMap = Matrix.matrix 100 100 (always {})

type alias World a =
    { seaLevel : Float
    , map : Matrix a
    }

defaultSeaLevel = 0.2

generateWorld seed =
    { seaLevel = defaultSeaLevel
    , map = generateMap seed |> fst
    }

generateMap seed =
    initialMap
    |> (flip (,)) seed
    |> Elevation.generate


render : (Int,Int) -> (a -> Float) -> World a -> Element
render (mapWidth,mapHeight) extract world =
    let
        map = world.map
        boxWidth = (toFloat mapWidth) / (toFloat <| Matrix.colCount map)
        boxHeight = (toFloat mapHeight) / (toFloat <| Matrix.rowCount map)
        box = C.rect boxWidth boxHeight

        colorFor elevation =
            let
                belowSeaLevel =
                    elevation < world.seaLevel

                elevationDiff =
                    elevation - world.seaLevel |> abs
            in
                if | belowSeaLevel -> rgb 0 0 (floor <| 255 * (0.5 * (elevation) + 0.5))
                   | otherwise -> rgb (floor <| 255 * 0.75 * elevation) (floor <| 255 * 0.75 * elevation) 0

        cell value =
            [ C.filled (colorFor value) box ]
            |> C.collage (floor boxWidth) (floor boxHeight)
    in
        map
        |> Matrix.map (extract >> cell)
        |> Matrix.toList
        |> List.map (flow right)
        |> flow down


type Action
    = NewSeed Seed

update msg model =
    case msg of
        NewSeed seed ->
            generateWorld seed


messages
    = Time.every (5 * Time.second)
    |> Signal.map (floor >> Random.initialSeed >> NewSeed)

main =
    Signal.foldp update (generateWorld <| Random.initialSeed 42) messages
    |> Signal.map (render (512,512) .elevation)


--type alias Map = Matrix Value

--rainfall : Stuff -> Map -> Map


--elevation : OtherStuff -> Map -> Map

--transformations =
--    let
--        ts =
--        [ rainfall rainfallData
--        , elevation elevationData
--        ]
--    foldr (\currentMap transformationFunction -> transformationFunction currentMap) initialMap ts



--elevation : Matrix a -> Matrix { a | elevation : Double }

--rainfall : Int -> Matrix { a | elevation : Double } -> Matrix { a | rainfall : Double }

--main =
--    Matrix.square 100 100 {}
--    |> elevation
--    |> rainfall 42
--    |> view
--    --|> Matrix.map .rainfall
--    --|> render

