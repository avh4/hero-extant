import Graphics.Collage as C exposing (..)
import Graphics.Element as E exposing (..)
import Color exposing (..)
import Matrix exposing (Matrix, get, set, loc, row, col, Location)
import Random exposing (Seed)
import Text
import Debug
import Maybe exposing (map, withDefault, andThen, Maybe (..) )
import List exposing (sum, foldr)
import Array

all : List (Maybe a) -> Maybe (List a)
all =
    foldr (
        \maybeItem total ->
            case total of
                Nothing -> Nothing
                Just list ->
                    case maybeItem of
                        Nothing -> Nothing
                        Just item -> Just (item :: list)
    ) (Just [])

update location f m =
  Maybe.withDefault m <| (
    get location m
    |> Maybe.map f
    |> Maybe.map (
      \value ->
        let
          maybeOldRow = Array.get (row location) m

        in
          case maybeOldRow of
            Just oldRow ->
              Array.set (col location) (value) oldRow
              |> (\newRow -> Array.set (row location) newRow m)

            Nothing -> m
    )
  )

mapWidth = 512
mapHeight = 512

matrixWidth = 100
matrixHeight = 100

initialMap = Matrix.matrix matrixWidth matrixHeight (always {})

elevation : (Matrix a, Seed) -> (Matrix { a | elevation : Float }, Seed)
elevation (input, seed) =
    let
        roughness = 100.0 / 20
        elevation = 100.0 / 200
        w = Debug.log "w" <| Matrix.colCount input
        h = Debug.log "h" <| Matrix.rowCount input

        divideWorld : Int -> Int -> Int -> Int -> Float -> Float -> Matrix { a | elevation : Float } -> Matrix { a | elevation : Float }
        divideWorld x1 y1 x2 y2 roughness midinit map =
            let
                w' = Debug.log "w'" <| x2 - x1
                h' = Debug.log "h'" <| y2 - y1
                midx = Debug.log "midx" <| (x1 + x2) // 2
                midy = Debug.log "midy" <| (y1 + y2) // 2

                d = (((w' + h' |> toFloat) / 2) / (w + h |> toFloat))
                random1 = 0.7 -- TODO r.nextDouble()
                d' = d * (random1 * 2 - 1) * roughness

                getElevation loc matrix =
                    Maybe.map (.elevation) (Matrix.get loc matrix)

                setElevation loc v matrix =
                    update loc (\r -> { r | elevation <- v }) matrix

                updater inputLocs destination valueComputer map' =
                    let
                        allElevations =
                            List.map ((flip getElevation) map') inputLocs
                            |> all
                    in
                        allElevations
                        |> Maybe.map (\inputs ->
                            setElevation destination (valueComputer inputs) map'
                        )
                        |> Maybe.withDefault map'

                computer inputs = sum inputs / 2
            in
                if w' > 1 || h' > 1
                then
                    map
                    |> updater
                        [ loc x1 y1
                        , loc x2 y1
                        ]
                        (loc midx y1)
                        computer
                    |> updater
                        [ loc x1 y2
                        , loc x2 y2
                        ]
                        (loc midx y2)
                        computer
                    |> updater
                        [ loc x1 y1
                        , loc x1 y2
                        ]
                        (loc x1 midy)
                        computer
                    |> updater
                        [ loc x2 y1
                        , loc x2 y2
                        ]
                        (loc x2 midy)
                        computer
                    |> updater
                        [ loc x1 y1
                        , loc x1 y2
                        , loc x2 y1
                        , loc x2 y2
                        ]
                        (loc midx midy)
                        (\inputs -> sum inputs / 4 + d)
                    |> (\map' -> if midinit > -1 then setElevation (loc midx midy) midinit map' else map')
                    |> divideWorld x1 y1 midx midy roughness -1
                    |> divideWorld midx y1 x2 midy roughness -1
                    |> divideWorld x1 midy midx y2 roughness -1
                    |> divideWorld midx midy x2 y2 roughness -1

                else map
        result =
            Matrix.map (\r -> { r | elevation = 0}) input
            |> divideWorld 0 0 w h roughness elevation
    in
    (result, seed)

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
    |> elevation
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

