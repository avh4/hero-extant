import Graphics.Collage as C exposing (..)
import Graphics.Element as E exposing (..)
import Color exposing (..)
import Matrix exposing (Matrix)
import Random exposing (Seed)
import Text
import Debug
import Maybe exposing (map, withDefault, andThen, Maybe (..) )
import Array

import Elevation

mapWidth = 512
mapHeight = 512

matrixWidth = 100
matrixHeight = 100

initialMap = Matrix.matrix matrixWidth matrixHeight (always {})


render : Matrix { a | elevation : Float } -> Element
render map =
    map
    |> Matrix.map (.elevation)
    |> Matrix.map renderElevation
    |> Matrix.toList
    |> List.map (flow right)
    |> flow down


boxWidth = (toFloat mapWidth) / (toFloat matrixWidth)
boxHeight = (toFloat mapHeight) / (toFloat matrixHeight)

box = C.rect boxWidth boxHeight

renderElevation : Float -> Element
renderElevation elevation =
    let
        colorFor : Float -> Color
        colorFor e =
            rgb (floor <| 255 * 0.75 * e) (floor <| 255 * 0.75 * e) 0
    in
        [C.filled (colorFor elevation) box]
        |> C.collage (floor boxWidth) (floor boxHeight)

main =
    (initialMap, Random.initialSeed 42)
    |> Elevation.generate
    |> fst
    |> render


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

