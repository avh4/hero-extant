import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Matrix exposing (Matrix)
import Random exposing (Seed)
import Text
import Array
import Debug

set (x,y) a m =
  case Array.get (x-1) m of
    Nothing -> m
    Just inner ->
      Array.set (x-1) (Array.set (y-1) a inner) m

initialMap = Matrix.square 20 (always {})

elevation : (Matrix a,Seed) -> (Matrix { a | elevation : Float },Seed)
elevation (input,seed) =
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

                getElevation x y matrix =
                    case Matrix.elementAt (x,y) matrix of
                        Just v -> v.elevation
                setElevation x y v matrix =
                    case Matrix.elementAt (x,y) matrix of
                        Just r -> set (x,y) { r | elevation <- v } matrix
                        Nothing -> matrix

            in
                if w' > 1 || h' > 1
                then
                    map
                    |> (\map' -> setElevation midx y1 (((getElevation x1 y1 map') + (getElevation x2 y1 map')) / 2) map')
                    --|> (\map' -> setElevation midx y2 )
            --setElevation(midx, y2, (getElevation(x1, y2) + getElevation(x2, y2)) / 2);
            --setElevation(x1, midy, (getElevation(x1, y1) + getElevation(x1, y2)) / 2);
            --setElevation(x2, midy, (getElevation(x2, y1) + getElevation(x2, y2)) / 2);
                    |> (\map' -> setElevation midx midy 
                        ([(x1,y1), (x1,y2), (x2,y1), (x2,y2)]
                            |> List.map (\(x,y) -> getElevation x y map')
                            |> List.sum
                            |> (flip (/)) 4
                            |> (+) d)
                        map')
                    |> divideWorld x1 y1 midx midy roughness -1

                else map
        result =
            Matrix.map (\r -> { r | elevation = 0}) input
            |> divideWorld 0 0 (w-1) (h-1) roughness elevation
    in
    (result, seed)

render : Matrix { a | elevation : Float } -> Element
render map =
    map
    |> Matrix.map (.elevation >> toString >> txt)
    |> Matrix.toList
    |> List.map (flow right)
    |> flow down

txt str =
    Text.fromString str
    |> Text.monospace
    |> centered

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

