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


generateMap seed =
    initialMap
    |> (flip (,)) seed
    |> Elevation.generate
    |> \(map,seed) -> { map = map, seed = seed }


render : (Int,Int) -> (a -> Float) -> Matrix a -> Element
render (mapWidth,mapHeight) extract map =
    let
        boxWidth = (toFloat mapWidth) / (toFloat <| Matrix.colCount map)
        boxHeight = (toFloat mapHeight) / (toFloat <| Matrix.rowCount map)
        box = C.rect boxWidth boxHeight

        colorFor value =
            rgb (floor <| 255 * 0.75 * value) (floor <| 255 * 0.75 * value) 0

        cell value =
            [ C.filled (colorFor value) box ]
            |> C.collage (floor boxWidth) (floor boxHeight)
    in
        map
        |> Matrix.map (extract >> cell)
        |> Matrix.toList
        |> List.map (flow right)
        |> flow down


type Action =
    NewSeed

update msg model =
    case msg of
        NewSeed ->
            generateMap model.seed


messages = Time.every (5 * Time.second) |> Signal.map (always NewSeed)

main =
    Signal.foldp update (generateMap <| Random.initialSeed 42) messages
    |> Signal.map (.map >> render (512,512) .elevation)


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

