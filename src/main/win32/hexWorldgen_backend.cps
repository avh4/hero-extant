{  
    
    Copyright (c) 2010 Ben Golightly

    Permission is hereby granted, free of charge, to any person
    obtaining a copy of this software and associated documentation
    files (the "Software"), to deal in the Software without
    restriction, including without limitation the rights to use,
    copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following
    conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
    OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
    HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
    OTHER DEALINGS IN THE SOFTWARE.
    
    ---------------------------------------------------------------------------
    
    This back-end is messy, but it's simple enough to use... plugs straight into
    any front-end you want (I previously used a "text-only" interface).
    
    Unlike most of the code, this section is licensed under the more
    permissive MIT license so that you are able to adapt & use this page
    in your own work without having to apply the GPL to your project.
    
    I would request (though of course, I can't legally enforce this!) that any
    modified versions of this page that are open source are also MIT licensed
    rather than put under the GPL.
    
    ---------------------------------------------------------------------------
    
    These are the steps, in order, needed to generate a world: 
        (prgGen is a projess bar handle)
    
    wgen_CreateWorld(worldW, worldH)
    If (wgen_LandMassPercent() < 15) or (wgen_AverageElevation()<0.1) then REJECT
    wgen_CalculateTemperatures(hemisphere, prgGen)
    wgen_CalculateWind(prgGen)                    
    wgen_CalculateWaterFlow(prgGen)
    wgen_DetermineWorldTerrainTypes(prgGen)
    wgen_DetermineContiguousAreas(prgGen)            
    wgen_SaveWorldToBin(worldFolder, prgGen)
    wgen_RenderWorldToPng(worldFolder + 'rendered.png', prgGen)
    wgen_RenderHeightMapToPng(worldFolder + 'heightmap.png', prgGen)
    wgen_RenderTemperaturesToPng(worldFolder + 'temperatures.png', prgGen)
    wgen_FreeWorld() 
    
    These are ways to preview the world visually: 
    
    wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_ELEVATION, canvas)
    wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_ELEVATION + WGEN_PREVIEW_SEALEVEL, canvas)
    wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_TEMPERATURE, canvas)
    wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_WIND + WGEN_PREVIEW_RAINFALL, canvas)
    wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_RIVERS, canvas)
    wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_COLOR, canvas)        
    wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_CONTIGUOUS, canvas)

     
}
Unit
    Uses
        cobra2D,
        hagC2D

Const
    WGEN_BIN_COMPAT_ID      = 2

    MAX_WORLD_X = 2048 * 2
    MAX_WORLD_Y = MAX_WORLD_X
    MAX_WORLD_SUMSQR = 0 + ((MAX_WORLD_X * MAX_WORLD_X) + (MAX_WORLD_Y * MAX_WORLD_Y)) 
    
    MAX_WIND_X = MAX_WORLD_X
    MAX_WIND_Y = MAX_WIND_X
    
    PRECOMPRESS_ABS_OFFSET   = 1073741824 // (1 Shl 30)
    
    TILE_TYPE_UNDEFINED       = 0
    TILE_TYPE_SEA             = 1
    TILE_TYPE_GRASSLAND       = 2
    TILE_TYPE_FOREST          = 3
    TILE_TYPE_JUNGLE          = 4
    TILE_TYPE_DESERT          = 5
    TILE_TYPE_GREEN_MOUNTAIN  = 6
    TILE_TYPE_BARREN_MOUNTAIN = 7
    TILE_TYPE_FROZEN          = 8
    TILE_TYPE_RIVER           = 9

    TILE_FLAG_GRASSLAND       = 1
    TILE_FLAG_FOREST          = 2
    TILE_FLAG_JUNGLE          = 4
    TILE_FLAG_DESERT          = 8
    TILE_FLAG_GREEN_MOUNTAIN  = 16
    TILE_FLAG_BARREN_MOUNTAIN = 32
    TILE_FLAG_FROZEN          = 64
    
    WGEN_HEMISPHERE_NORTH   = 1 ; export
    WGEN_HEMISPHERE_EQUATOR = 2 ; export
    WGEN_HEMISPHERE_SOUTH   = 3 ; export
    
    WGEN_PREVIEW_ELEVATION          = 1   ; export
    WGEN_PREVIEW_COLOR              = 2   ; export
    WGEN_PREVIEW_WIND               = 4   ; export
    WGEN_PREVIEW_RAINFALL           = 8   ; export
    WGEN_PREVIEW_SEALEVEL           = 16  ; export
    WGEN_PREVIEW_TEMPERATURE        = 32  ; export
    WGEN_PREVIEW_RIVERS             = 64  ; export
    WGEN_PREVIEW_COLOR_ELEVATION    = 128 ; export
    WGEN_PREVIEW_CONTIGUOUS         = 256 ; export
    WGEN_PREVIEW_TEMPERATURE_RAW    = 512  ; export
    
    
    WGEN_SEA_LEVEL = 0.333
    WGEN_WIND_GRAVITY = 0.975
    WGEN_WIND_RESOLUTION = 4 // 1 is perfect, higher = rougher
    TEMPERATURE_BAND_RESOLUTION = 2 // 1 is perfect, higher = rougher
    WGEN_RAIN_FALLOFF = 0.2 // Default 0.2 - less for less rain, more for more rain
    WGEN_MAX_TEMPERATURE = 40
    WGEN_MIN_TEMPERATURE = -60 
    
    WIND_OFFSET = 180
    WIND_PARITY = -1 // -1 or 1

Type rivers = Record
    x, y: Integer
EndType

Type worldTiles = Record
    tileType: Integer = TILE_TYPE_UNDEFINED
    elevation: Real = 0.0
    windz: Real = 0.0
    rainfall: Real = 0.0
    waterSaturation: Integer = 0 //Real = 0.0
    temperature: Real = 0.0
EndType

Var
    worldTile: Array [MAX_WORLD_X, MAX_WORLD_Y] of ^worldTiles
    
    // Wind and rain!
    wind: Array[MAX_WIND_X, MAX_WIND_Y] of Real  // elevation
    windr: Array[MAX_WIND_X, MAX_WIND_Y] of Real // rainfall
    windx, windy: Real
    windw, windh: Integer    
    
    // Ccontiguous areas
    contiguousMap: Array[MAX_WORLD_X, MAX_WORLD_Y] of Integer
    contiguousAreaCount: Integer
    
    worldW, worldH: Integer ; export
    worldWindDir: Real ; export
    
    resultString: String = "" ; export

Procedure SetPc(prg: ^progressbars, pc: Integer)
Begin
    ProgressBarPercent(prg, pc)
    prg.toRender = TRUE
    HagRenderAll()
    Flip
End

Procedure wgen_CreateWorld(w: Integer, h: Integer) ; export
Var
    x, y: Integer
    z: Real
    roughness: Real
    elevation: Real
Begin
    roughness = 100.0/20
    elevation = 100.0/200

    If w > MAX_WORLD_X then w = MAX_WORLD_X
    If h > MAX_WORLD_Y then h = MAX_WORLD_Y
    If w < 32 then w = 32
    If h < 32 then h = 32
    worldW = w
    worldH = h
    z = ToReal(elevation) / 100.0
    
    // World Globals
    worldWindDir = Rnd(0, 360) 
    
    // Init tiles
    For x = 0 to (w-1)
        For y = 0 to (h-1)
            New(worldTile[x,y])
        Next
    Next
    
    // Recursively divide for Random fractal landscape
    DivideWorld(0,0,worldW-1,worldH-1,roughness,elevation)
    
    // Clamp
    For x = 0 to (w-1)
        For y = 0 to (h-1)
            If x = 0 then worldTile[x,y].elevation = 0
            If y = 0 then worldTile[x,y].elevation = 0
            If x = (w-1) then worldTile[x,y].elevation = 0
            If y = (h-1) then worldTile[x,y].elevation = 0
            If worldTile[x,y].elevation > 1 then worldTile[x,y].elevation = 1
            If worldTile[x,y].elevation < 0 then worldTile[x,y].elevation = 0 
        Next
    Next

End

Procedure wgen_FreeWorld() ; export
Var
    x, y: Integer
Begin
    For x = 0 to (worldW-1)
        For y = 0 to (worldH-1)
            Free(worldTile[x,y])
        Next
    Next
End

Function wgen_WindDirInt() : Integer ; export
Begin
    result = ToInt(worldWindDir) 
End

Function wgen_TempAsAbsolute(temp: Real) : Real ; export
Begin
    result = WGEN_MAX_TEMPERATURE - ((1-temp) * (WGEN_MAX_TEMPERATURE - WGEN_MIN_TEMPERATURE)) 
End

Function wgen_AverageElevation() : Real ; export
Var
    x, y, c: Integer = 0
Begin
    For x = 0 to (worldW-1)
        For y = 0 to (worldH-1)
            result = result + worldTile[x,y].elevation
            Inc(c)
        Next
    Next
    
    result = result / c
End

Function wgen_LandMassPercent() : Real ; export
Var
    x, y: Integer
Begin
    result = 0
    For x = 0 to (worldW-1)
        For y = 0 to (worldH-1)
            If worldTile[x,y].elevation > WGEN_SEA_LEVEL then result = result + 1
        Next
    Next
    
    result = 100.0 * result / (worldW * worldH) 
End

Function wgen_LandMassAbsolute() : Real ; export
Var
    x, y: Integer
Begin
    result = 0
    For x = 0 to (worldW-1)
        For y = 0 to (worldH-1)
            If worldTile[x,y].elevation > WGEN_SEA_LEVEL then result = result + 1
        Next
    Next 
End

Function wgen_TileAboveSeaLevel(x, y) : Boolean ; export
Begin
    If worldTile[x,y].elevation > WGEN_SEA_LEVEL then result = TRUE else result = FALSE
End

Function wgen_LandTouchesMapEdge(): Boolean ; export
Var
    x, y: Integer
Begin
    result = FALSE

    For x = 4 to (worldW-5)
        If worldTile[x,4].elevation > WGEN_SEA_LEVEL then result = TRUE ; exit
        If worldTile[x,worldH-5].elevation > WGEN_SEA_LEVEL then result = TRUE ; exit
    Next
    
    For y = 4 to (worldH-5)
        If worldTile[4,y].elevation > WGEN_SEA_LEVEL then result = TRUE ; exit
        If worldTile[worldW-5,y].elevation > WGEN_SEA_LEVEL then result = TRUE ; exit
    Next

End

Procedure DivideWorld(x1: Integer, y1: Integer, x2: Integer, y2: Integer, roughness: Real, midinit: Real = -1)
Var
    w, h : Integer
    midx, midy: Integer
    c, d: Real
Begin
    
    w = x2-x1
    h = y2-y1
    midx = (x1+x2)/2
    midy = (y1+y2)/2
    
    d = ((ToReal(w+h)/2) / ToReal(worldW + worldH))
    d = d * Rnd(-1,1) * roughness
    
    If (w > 1) or (h > 1) then
    
        worldTile[midx, y1].elevation = (worldTile[x1, y1].elevation + worldTile[x2, y1].elevation) / 2
        worldTile[midx, y2].elevation = (worldTile[x1, y2].elevation + worldTile[x2, y2].elevation) / 2
        worldTile[x1, midy].elevation = (worldTile[x1, y1].elevation + worldTile[x1, y2].elevation) / 2
        worldTile[x2, midy].elevation = (worldTile[x2, y1].elevation + worldTile[x2, y2].elevation) / 2
        worldTile[midx, midy].elevation = d + ((worldTile[x1, y1].elevation + worldTile[x1, y2].elevation + worldTile[x2, y1].elevation + worldTile[x2, y2].elevation) / 4)
        
        If midinit > -1 then worldTile[midx, midy].elevation = midinit
    
        DivideWorld(x1,y1,midx,midy,roughness)
        DivideWorld(midx,y1,x2,midy,roughness)
        DivideWorld(x1,midy,midx,y2,roughness)
        DivideWorld(midx,midy,x2,y2,roughness)

    Endif

End

Procedure wgen_CalculateWind(prg: ^progressBars) ; export
{
    Orographic effect:
    # Warm, moist air carried in by wind
    # Mountains forces air upwards, where it cools and condenses (rains)
    # The leeward side of the mountain is drier and casts a "rain shadow".
    
    Wind is modelled here as a square of particles of area
        worldW * worldH
    and
        Sqrt(worldW^2+worldH^2) away
    The wind travels in direction of worldWinDir
    
}
Var
    rainFall: Real = 1.0
    x, y, d, pcinc: Integer
    r: Real
    windz, windh: Real
    theta1, theta2: Real
    sinT1, sinT2: Real
    rlost, rainRemaining: Real
    mapsqrt: Real
    pc: String
Begin    
    // Init wind x,y,w,h
    r = Sqrt(ToReal(worldW*worldW) + ToReal(worldH*worldH))
    theta1 = worldWindDir * WIND_PARITY + WIND_OFFSET
    theta2 = 180 - 90 - (worldWindDir * WIND_PARITY + WIND_OFFSET)
    sinT1 = Sin(theta1)
    sinT2 = Sin(theta2)    
    windw = (worldW)
    windh = (worldH)
    mapsqrt = Sqrt((WorldW*WorldW) + (WorldH*WorldH))
    
    // Init wind   
    For x = 0 to (windw-1)
        For y = 0 to (windh-1)
            wind[x,y] = 0
            windr[x,y] = ((rainfall * mapsqrt) / WGEN_WIND_RESOLUTION) * WGEN_RAIN_FALLOFF
        Next
    Next
    
    // Cast wind
    For d = r to 0 step -WGEN_WIND_RESOLUTION
        windx = d * SinT1
        windy = d * SinT2
        
        Inc(pcinc)
        If (pcinc mod WGEN_WIND_RESOLUTION) = 1 then
            pc = ToInt(ToReal(r-d)/ToReal(r) * 100)
            SetPc(prg, pc)
        Endif
     
        For x = 0 to (windw-1)
            For y = 0 to (windh-1)
                If (ToInt(windx + x) > -1) and (ToInt(windy + y) > -1) then
                    If (ToInt(windx + x) < (worldW)) and (ToInt(windy + y) < (worldH)) then
                    
                        windz = worldTile[ToInt(windx+x),ToInt(windy+y)].elevation
                        wind[x,y] = Max(wind[x,y] * WGEN_WIND_GRAVITY, windz)
                        
                        rainRemaining = windr[x,y] / (((rainfall * mapsqrt) / WGEN_WIND_RESOLUTION) * WGEN_RAIN_FALLOFF) * (1.0-(worldTile[x,y].temperature/2.0))
                        rlost = (wind[x,y]) * rainRemaining
                        If rlost < 0 then rlost = 0
                        windr[x,y] = windr[x,y] - rlost                       
                        If windr[x,y] <= 0 then windr[x,y] = 0
                         
                        worldTile[ToInt(windx+x),ToInt(windy+y)].windz = wind[x,y]
                        worldTile[ToInt(windx+x),ToInt(windy+y)].rainfall = rlost
                        
                    Endif
                Endif
            Next
        Next
        
    Next
    


End

Procedure wgen_CalculateTemperatures(hemisphere: Integer, prg: ^progressBars) ; export
Var
    i, x, y: Integer
    
    band: Array [MAX_WORLD_X] of Integer
    bandy, bandrange: Integer
    bandtemp: Real
    dir, diradj, dirsin: Real
    steps: Integer
    pc: Integer
Begin

    For i = 0 to worldH step (TEMPERATURE_BAND_RESOLUTION)
        
        // Generate band
        bandy = i
        bandrange = 7
        
        Case hemisphere of
            (WGEN_HEMISPHERE_NORTH):
                // 0, 0.5, 1
                bandtemp = ToReal(i)/worldH
            (WGEN_HEMISPHERE_EQUATOR):
                // 0, 1, 0
                If i < (WorldH/2) then
                    bandtemp = ToReal(i)/worldH
                    bandtemp = bandtemp * 2.0
                Else
                    bandtemp = 1.0 - ToReal(i)/worldH
                    bandtemp = bandtemp * 2.0
                Endif
            (WGEN_HEMISPHERE_SOUTH):
                // 1, 0.5, 0
                bandtemp = 1.0 - ToReal(i)/worldH
        EndCase
        bandtemp = Max(bandtemp, 0.075) 

        // Initialise at bandy
        For x = 0 to (WorldW-1)
            band[x] = bandy 
        Next
        
        // Randomise
        dir = 1.0
        diradj = 1
        dirsin = Rnd(1,8)         
        For x = 0 to (worldW-1)
            band[x] = band[x] + dir
            dir = dir + Rnd(0.0, Sin(dirsin*x)*diradj)
            If dir > bandrange then diradj = -1 ; dirsin = Rnd(1,8) 
            If dir < -bandrange then diradj = 1 ; dirsin = Rnd(1,8)
        Next
    
    
        For x = 0 to (worldW-1)
            For y = 0 to (worldH-1)
            
                If worldTile[x,y].elevation < WGEN_SEA_LEVEL then
                    // Water tiles
                    If (y > band[x]) then worldTile[x,y].temperature = bandtemp * 0.7
                Else
                    // Land tiles
                    If (y > band[x]) then worldTile[x,y].temperature = bandtemp * (1.0 - (worldTile[x,y].elevation-WGEN_SEA_LEVEL)) 
                Endif
            
            Next
        Next
        
        pc = ToInt(ToReal(i)/ToReal(worldH) * 100)
        SetPc(prg, pc)
        Inc(steps)
    Next
    
End

Procedure wgen_CalculateWaterFlow(prg: ^progressBars) ; export
Var
    x, y, i, j, k: Integer
    mvx, mvy: Integer
    moves, lastMoves, steps, maxSteps: Integer
    countMoves: Integer = 0
    movesString: String = ""
    pc: Real
    
    cost: Array [3,3] of Real
    spentCost, highestCost: Real
    
    riverList: List of rivers
    river: ^rivers
Begin
    steps = 0
    maxSteps = Sqrt((worldW*worldW) + (worldH*worldH)) / 2
    //maxSteps = worldW / 2
    resultString = ""

    // Init rivers
    pc = -1
    For i = 0 to (maxSteps*8)
    
        If (i mod (8*10)) = 0 then
            pc = (ToReal(i)/ToReal(maxSteps*8)) * 90.0
            SetPc(prg, ToInt(pc))
        Endif
                
        x = Rand(1, worldW-2)
        y = Rand(1, worldH-2)        
        If (worldTile[x,y].elevation > WGEN_SEA_LEVEL) and (worldTile[x,y].elevation < 1.0) then
            If Rnd(0, worldTile[x,y].rainfall) > 0.125 then
                river = NewItem(riverList)
                river.x = x
                river.y = y
            Endif
        Endif
    Next    
    

    // Water flow
    SetPc(prg, 95)
    lastMoves = 0
    pc = -1
    Repeat
        lastMoves = moves
        moves = 0
        Inc(steps)        
        
        // Water physics
        Loop river through riverList
            x = river.x
            y = river.y
            
            If (worldTile[x,y].elevation > WGEN_SEA_LEVEL) and (x > 0) and (y > 0) and (x < (WorldW-1)) and (y < (WorldH-1)) then
                    
                // Water flows based on cost, seeking the higest elevation difference
                // biggest difference = lower (negative) cost
                    
                // Cost
                // 0,0 1,0 2,0
                // 0,1 *** 2,1
                // 0,2 1,2 2,2
                cost[0,0] = 0 ; cost[1,0] = 0 ; cost[2,0] = 0
                cost[0,1] = 0 ;                 cost[2,1] = 0
                cost[0,2] = 0 ; cost[1,2] = 0 ; cost[2,2] = 0

                // Top
                cost[0,0] = ((worldTile[x-1,y-1].elevation) - (worldTile[x,y].elevation) ) //1.41
                cost[1,0] =  (worldTile[x  ,y-1].elevation) - (worldTile[x,y].elevation)
                cost[2,0] = ((worldTile[x+1,y-1].elevation) - (worldTile[x,y].elevation) ) //1.41

                // Mid
                cost[0,1] =  (worldTile[x-1,y  ].elevation) - (worldTile[x,y].elevation)
                cost[2,1] =  (worldTile[x+1,y  ].elevation) - (worldTile[x,y].elevation)

                // Bottom
                cost[0,2] = ((worldTile[x-1,y+1].elevation) - (worldTile[x,y].elevation) ) //1.41
                cost[1,2] =  (worldTile[x  ,y+1].elevation) - (worldTile[x,y].elevation)
                cost[2,2] = ((worldTile[x+1,y+1].elevation) - (worldTile[x,y].elevation) ) //1.41
                    
                // Randomise flow */ 2
                cost[0,0] = cost[0,0] * Rnd(0.5, 2)
                cost[1,0] = cost[1,0] * Rnd(0.5, 2)
                cost[2,0] = cost[2,0] * Rnd(0.5, 2)
                cost[0,1] = cost[0,1] * Rnd(0.5, 2)
                cost[2,1] = cost[2,1] * Rnd(0.5, 2)
                cost[0,2] = cost[0,2] * Rnd(0.5, 2)
                cost[1,2] = cost[1,2] * Rnd(0.5, 2)
                cost[2,2] = cost[2,2] * Rnd(0.5, 2)
                    
                // Highest Cost
                highestCost = Min(cost[0,0],   cost[1,0])
                highestCost = Min(highestCost, cost[2,0])
                highestCost = Min(highestCost, cost[0,1])
                highestCost = Min(highestCost, cost[2,1])
                highestCost = Min(highestCost, cost[0,2])
                highestCost = Min(highestCost, cost[1,2])
                highestCost = Min(highestCost, cost[2,2])
                    
                For i = 0 to 2
                    For j = 0 to 2
                        If (((i = 1) and (j = 1)) = FALSE) then //and (cost[i,j] < 0) then
                                
                            // Divide water up...
                            If (cost[i,j] = highestCost) then
                                river.x = x+(i-1)
                                river.y = y+(j-1)
                                worldTile[x,y].waterSaturation = 1
                                Inc(moves)
                            Endif
                                
                        Endif
                    Next
                Next
            
            Endif
              
        EndLoop      
        
        countMoves = countMoves + moves

    Until ((moves = 0) or (steps > (maxSteps-1)))
    
    SetPc(prg, 100)
    
    
    // Free List
    Loop river through riverList
        Free(river)
    EndLoop
    
    // Make rivers
    For y = 0 to (worldH-1)
        For x = 0 to (worldW-1)
            If worldTile[x,y].waterSaturation > 0 then worldTile[x,y].tileType = TILE_TYPE_RIVER 
        Next
    Next
    
    // Done!
    //resultString = "Moves: "+ToString(countMoves)

End

Procedure wgen_DetermineWorldTerrainTypes(pc: ^progressBars) ; export
Var
    x, y: Integer
Begin
    {
        Attempt to classify each temperature/rain/waterSaturation combo as a terrain type
        
        Rainfall:
        
    }
    
    For y = 0 to (worldH-1)
        For x = 0 to (worldW-1)
        
            Conditions
                (worldTile[x,y].elevation <= WGEN_SEA_LEVEL): worldTile[x,y].tileType = TILE_TYPE_SEA
                (worldTile[x,y].temperature < 0.15): worldTile[x,y].tileType = TILE_TYPE_FROZEN
                
                (worldTile[x,y].tileType = TILE_TYPE_RIVER): // already a river
                
                (worldTile[x,y].elevation > 0.666):
                    Conditions
                        (worldTile[x,y].temperature <= 0.15): worldTile[x,y].tileType = TILE_TYPE_FROZEN
                        (worldTile[x,y].rainfall < 0.4): worldTile[x,y].tileType = TILE_TYPE_BARREN_MOUNTAIN
                        Default:                         worldTile[x,y].tileType = TILE_TYPE_GREEN_MOUNTAIN
                    EndConditions
                
                (worldTile[x,y].rainfall < 0.150): worldTile[x,y].tileType = TILE_TYPE_DESERT // 0.125
                (worldTile[x,y].rainfall < 0.250): worldTile[x,y].tileType = TILE_TYPE_GRASSLAND // 0.250
                (worldTile[x,y].rainfall < 0.325): worldTile[x,y].tileType = TILE_TYPE_FOREST // 0.760
                (worldTile[x,y].rainfall <= 1.0):
                    Conditions
                        (worldTile[x,y].temperature > 0.3):
                            worldTile[x,y].tileType = TILE_TYPE_JUNGLE
                        Default: worldTile[x,y].tileType = TILE_TYPE_FOREST
                    EndConditions               
            
            
            EndConditions
        
        Next
        
        If (y mod 10) = 0 then SetPc(pc, ToInt((ToReal(y)/ToReal(worldH))*100))
    Next

End

Procedure wgen_DetermineContiguousAreas(prg: ^progressBars) ; export
Var
    x, y, i, mincg1, mincg2, x2, y2, x3, y3, pc, adjust: Integer
    done: Boolean
    lowest, limit: Integer
Begin
    
    //Init map
    For y = 0 to (worldH-1)
        For x = 0 to (worldW-1)
            contiguousMap[x,y] = 1
        Next
    Next
    
    // Step 1 - identify groups
    i = 2
    For y = 1 to (worldH-1)
        For x = 1 to (worldW-1)        
            
            If (worldTile[x,y].tileType <> worldTile[x-1,y].tileType) and (worldTile[x,y].tileType <> worldTile[x,y-1].tileType) then
                contiguousMap[x,y] = i
                Inc(i)
            Else
                mincg1 = 0
                mincg2 = 0
                
                If (worldTile[x,y].tileType = worldTile[x,y-1].tileType) then
                    contiguousMap[x,y] = contiguousMap[x,y-1]
                    mincg1 = contiguousMap[x,y-1] 
                Endif
                
                If (worldTile[x,y].tileType = worldTile[x-1,y].tileType) then
                    contiguousMap[x,y] = contiguousMap[x-1,y]
                    mincg2 = contiguousMap[x-1,y]
                Endif
                
                If (mincg1 <> 0) and (mincg2 <> 0) then
                    contiguousMap[x,y] = Min(mincg1, mincg2)
                Endif
                
            Endif

        Next

    Next
    contiguousAreaCount = i

    // Step 2a - merge rivers
    For x = 1 to (worldW-2)
        For y = 1 to (worldH-2)
            If (worldTile[x,y].tileType = TILE_TYPE_RIVER) then contiguousMap[x,y] = 1
        Next
    Next
    
    // Step 2b - merge groups
    For x = 1 to (worldW-2)
        For y = 1 to (worldH-2)
            
            For x2 = -1 to 1
                For y2 = -1 to 1
                    If ((x2 <> 0) or (y2 <> 0)) then
                        If contiguousMap[x,y] <> contiguousMap[x+x2,y+y2] then
                            If worldTile[x,y].tileType = worldTile[x+x2,y+y2].tileType then
                                adjust = contiguousMap[x+x2,y+y2]
                                For x3 = 0 to (worldW-1)
                                    For y3 = 0 to (worldH-1)
                                        If contiguousMap[x3,y3] = adjust then
                                            contiguousMap[x3,y3] = contiguousMap[x,y]
                                        Endif
                                    Next
                                Next
                            Endif
                        Endif
                    Endif
                Next
            Next

        Next
        
        pc = ToInt((ToReal(x)/ToReal(worldW-2)) * 90)
        SetPc(prg, pc)
    Next
    
    // Stage 3 - reduce groups (This bit is very unoptimised and I don't think does the job completely)
    limit = 0        
    lowest = worldW * worldH + 1
    Repeat
        done = TRUE

        For x = 0 to (worldW-1)
            For y = 0 to (worldH-1)                
                If (contiguousMap[x,y] < lowest) and (contiguousMap[x,y] > limit) then lowest = contiguousMap[x,y]
            Next
        Next
        
        For x = 0 to (worldW-1)
            For y = 0 to (worldH-1)
                If lowest = contiguousMap[x,y] then
                    contiguousMap[x,y] = limit + 1
                    done = FALSE
                Endif
            Next 
        Next
        If lowest = (limit+1) then
            Inc(limit)
        Endif
             
    Until done
    
    SetPc(prg, 100)
    
    contiguousAreaCount = limit

End

Procedure wgen_DrawWorld(w: Integer, h: Integer, style: Integer, canvas: Element) ; export
Var
    x, y: Integer
    divisor_x, divisor_y: Real
    c, rgba: Integer
    e, r: Real
Begin

    If w > worldW then w = worldW
    If h > worldH then h = worldH 
    divisor_x = ToReal(worldW) / 512
    divisor_y = ToReal(worldH) / 512
    
    For y = 0 to h-1
        For x = 0 to w-1
            
            rgba = ToRGBA(128,0,0)
            If ((style and WGEN_PREVIEW_ELEVATION) = WGEN_PREVIEW_ELEVATION) then
                c = 255.0 * worldTile[x,y].elevation
                rgba = ToRGBA(c,c,c)
            Endif
            
            If ((style and WGEN_PREVIEW_SEALEVEL) = WGEN_PREVIEW_SEALEVEL) then
                e = worldTile[x,y].elevation
                If e <= WGEN_SEA_LEVEL then rgba = ToRGBA(0,0,255*e)
            Endif

            If ((style and WGEN_PREVIEW_WIND) = WGEN_PREVIEW_WIND) then
                e = worldTile[x,y].windz
                rgba = ToRGBA(0,255*e,0)
            Endif

            If ((style and WGEN_PREVIEW_RAINFALL) = WGEN_PREVIEW_RAINFALL) then
                r = worldTile[x,y].rainfall 
                rgba = ToRGBA(100*r,100*r,255*r)
            Endif

            If ((style and WGEN_PREVIEW_WIND) = WGEN_PREVIEW_WIND) and ((style and WGEN_PREVIEW_RAINFALL) = WGEN_PREVIEW_RAINFALL) then
                e = worldTile[x,y].windz
                r = worldTile[x,y].rainfall 
                rgba = ToRGBA(0,255*e,255*r)
            Endif
            
            If ((style and WGEN_PREVIEW_TEMPERATURE) = WGEN_PREVIEW_TEMPERATURE) then
                e = worldTile[x,y].temperature
                rgba = ToRGBA(e*255,e*128,255*(1-e))
            Endif
            
            If ((style and WGEN_PREVIEW_TEMPERATURE_RAW) = WGEN_PREVIEW_TEMPERATURE_RAW) then
                e = worldTile[x,y].temperature
                rgba = ToRGBA(e*255,e*255,e*255)
            Endif
            
            If ((style and WGEN_PREVIEW_RIVERS) = WGEN_PREVIEW_RIVERS) then
                e = worldTile[x,y].elevation
                rgba = ToRGBA(0,e*128,0)
                
                If  worldTile[x,y].tileType = TILE_TYPE_RIVER then
                    rgba = ToRGBA(0,0,255*e)
                Endif
                
                If e <= WGEN_SEA_LEVEL then rgba = ToRGBA(0,0,255*e)
            Endif
            
            If ((style and WGEN_PREVIEW_CONTIGUOUS) = WGEN_PREVIEW_CONTIGUOUS) then
                e = worldTile[x,y].elevation
                r = ToReal(contiguousMap[x,y]) / ToReal(contiguousAreaCount)
                
                //If e > WGEN_SEA_LEVEL then
                    rgba = ToRGBA(255*r, 255*r, 255*r)
                //Else
                //    rgba = ToRGBA(200*r, 200*r, 255)
                //Endif
            Endif                
            
            
            If ((style and WGEN_PREVIEW_COLOR) = WGEN_PREVIEW_COLOR) then
                
                Case (worldTile[x,y].tileType) of
                    (TILE_TYPE_UNDEFINED): rgba = ToRGBA(255,0,0)
                    (TILE_TYPE_SEA): rgba = ToRGBA(0,0,128)
                    (TILE_TYPE_GRASSLAND): rgba = ToRGBA(128,255,000)
                    (TILE_TYPE_FOREST): rgba = ToRGBA(000,200,000)
                    (TILE_TYPE_JUNGLE): rgba = ToRGBA(000,128,000)
                    (TILE_TYPE_DESERT): rgba = ToRGBA(200,200,000)
                    (TILE_TYPE_GREEN_MOUNTAIN): rgba = ToRGBA(90,128,90)
                    (TILE_TYPE_BARREN_MOUNTAIN): rgba = ToRGBA(128,90,90)
                    (TILE_TYPE_FROZEN): rgba = ToRGBA(255,255,255)
                    (TILE_TYPE_RIVER): rgba = ToRGBA(000,000,255)
                EndCase
            Endif
            
            If ((style and WGEN_PREVIEW_COLOR_ELEVATION) = WGEN_PREVIEW_COLOR_ELEVATION) then
                e = worldTile[x,y].elevation
                
                Case (worldTile[x,y].tileType) of
                    (TILE_TYPE_UNDEFINED): rgba = ToRGBA(255*e,0,0)
                    (TILE_TYPE_SEA): rgba = ToRGBA(0,0,128*e + 128)
                    (TILE_TYPE_GRASSLAND): rgba = ToRGBA(128*e,255*e,000)
                    (TILE_TYPE_FOREST): rgba = ToRGBA(000,200*e,000)
                    (TILE_TYPE_JUNGLE): rgba = ToRGBA(000,128*e,000)
                    (TILE_TYPE_DESERT): rgba = ToRGBA(200*e,200*e,000)
                    (TILE_TYPE_GREEN_MOUNTAIN): rgba = ToRGBA(90*e,128*e,90*e)
                    (TILE_TYPE_BARREN_MOUNTAIN): rgba = ToRGBA(128*e,90*e,90*e)
                    (TILE_TYPE_FROZEN): rgba = ToRGBA(200+55*e,200+55*e,200+55*e)
                    (TILE_TYPE_RIVER): rgba = ToRGBA(000,000,255*e)
                    Default:
                        rgba = ToRGBA(Rand(0,255), Rand(0,255), Rand(0,255))
                EndCase
            Endif
            
            
            
            
            If divisor_x >= 1 then
                Pixel((x / divisor_x), (y / divisor_y), rgba, canvas)
            Else
                Rect((x / divisor_x), (y / divisor_y), 1 / divisor_x, 1 / divisor_y, rgba, TRUE, canvas)
            Endif
            
            
            
            
        Next
    Next
    
    Flip

End

Procedure wgen_SaveWorldToBin(folder: String, prg: ^progressBars) ; export
Var
    f: Element
    x,y: Integer
    e: Real
    binPath: String
Begin
    {
        Saves world data as binary
        
        A 512x512 map is approx 5.3 MB uncompressed, so every effort should
        be made to make the data as compressable as possible.
        
        This is done by:
        
          * Arranging like-blocks together
          * Taking advantage of the 2D nature of the data by writing only
            differences between value(x) and value(x-1)
        
    }

    CreateDir(folder)
    If FileExists(folder, TRUE) = FALSE then
        MessageBox("Couldn't create folder in wgen_SaveWorldToBin('"+binPath+"') - binary export skipped.", "Warning")
        exit
    Endif
    binPath = folder + "world.bin"    

    f = CreateMemFile()
    If f = NULL then
        MessageBox("Couldn't create mem file in wgen_SaveWorldToBin('"+binPath+"') - binary export skipped.", "Warning")
        exit
    Endif
    
    // Identifier (helps compression program)
    // Compreses best if the program thinks it's a BMP
    // So Write a BMP header
    // Headers can be as long as 8 bytes. We want to be able to change the header
    // without affecting loading the file back, so even a single byte BMP header
    // should be padded to the full 8 bytes.
    // TODO: Try PNG
    // BMP - 77, 0, 0, 0
    WriteByte(f, 077) ; WriteByte(f, 000) ; WriteByte(f, 000) ; WriteByte(f, 000)
    WriteByte(f, 000) ; WriteByte(f, 000) ; WriteByte(f, 000) ; WriteByte(f, 000)
    
    // Header 
    WriteInt(f, WGEN_BIN_COMPAT_ID) // compat id, please increment when updating the format of the exported data
    WriteInt(f, WorldW)
    WriteInt(f, WorldH)
    WriteInt(f, CompressReal(worldWindDir/360.0)) // Real
    
    // Note that each block is done separately to aid compressability and the
    // effectiveness of the precompression stage
    
    // Tile Types
    For y = 0 to worldH-1
        For x = 0 to worldW-1 
            If x = 0 then
                WriteByte(f, worldTile[x,y].tileType + 128)
            Else
                WriteByte(f, (worldTile[x,y].tileType - worldTile[x-1,y].tileType) + 128) // precompression filter
            Endif
        Next
        
        If (y mod 20) = 0 then SetPc(prg,  ((100/6)*0) + ((100/6) * (ToReal(y) / ToReal(worldW - 1))) )
    Next
    
    For y = 0 to worldH-1
        For x = 0 to worldW-1
            If x = 0 then
                WriteInt(f, contiguousMap[x,y] + PRECOMPRESS_ABS_OFFSET)
            Else
                WriteInt(f, (contiguousMap[x,y] - contiguousMap[x-1,y]) + PRECOMPRESS_ABS_OFFSET)
            Endif
        Next
            
        If (y mod 20) = 0 then SetPc(prg,  ((100/6)*1) + ((100/6) * (ToReal(y) / ToReal(worldW - 1))) )
    Next
    
    For y = 0 to worldH-1
        For x = 0 to worldW-1
            If x = 0 then
                WriteInt(f, CompressReal(worldTile[x,y].elevation))
            Else
                WriteInt(f, CompressReal(worldTile[x,y].elevation - worldTile[x-1,y].elevation))
            Endif
        Next
            
        If (y mod 20) = 0 then SetPc(prg,  ((100/6)*2) + ((100/6) * (ToReal(y) / ToReal(worldW - 1))) )
    Next
    
    For y = 0 to worldH-1
        For x = 0 to worldW-1
            If x = 0 then
                WriteInt(f, CompressReal(worldTile[x,y].windz))
            Else
                WriteInt(f, CompressReal(worldTile[x,y].windz - worldTile[x-1,y].windz))
            Endif
        Next
            
        If (y mod 20) = 0 then SetPc(prg,  ((100/6)*3) + ((100/6) * (ToReal(y) / ToReal(worldW - 1))) )
    Next
    
    For y = 0 to worldH-1
        For x = 0 to worldW-1
            If x = 0 then
                WriteInt(f, CompressReal(worldTile[x,y].rainfall))
            Else
                WriteInt(f, CompressReal(worldTile[x,y].rainfall - worldTile[x-1,y].rainfall))
            Endif
        Next
            
        If (y mod 20) = 0 then SetPc(prg,  ((100/6)*4) + ((100/6) * (ToReal(y) / ToReal(worldW - 1))) )
    Next
    
    For y = 0 to worldH-1
        For x = 0 to worldW-1
            If x = 0 then
                WriteInt(f, CompressReal(worldTile[x,y].temperature))
            Else
                WriteInt(f, CompressReal(worldTile[x,y].temperature - worldTile[x-1,y].temperature))
            Endif
        Next
            
        If (y mod 20) = 0 then SetPc(prg,  ((100/6)*5) + ((100/6) * (ToReal(y) / ToReal(worldW - 1))) )
    Next        
    
    SaveMemFile(f, binPath)
    Closefile(f)
    
    SetPc(prg, 100)

End

Function CompressReal(r: Real) : Integer
Begin
    result = ToInt((r + 1.0) * 3600)
End

Function DecompressReal(r: Integer) : Real
Begin
    result = (ToReal(r) / 3600.0) - 1.0
End

Function wgen_LoadWorldFromBin(fn: String, prg: ^progressBars) : Boolean ; export
Var
    f: Element
    x,y: Integer
    e: Real
    
    iVal: Integer
Begin

    result = FALSE   
    SetPc(prg, 2)
    
    f = CreateMemFile()    
    LoadToMemFile(f, fn)
    
    // Skip identifier
    FileSeek(f, 8)
    
    // Header
    SetPc(prg, 5)
    iVal = ReadInt(f)
    If iVal <> WGEN_BIN_COMPAT_ID then
        MessageBox("wgen_LoadWorldFromBin: File not compatable!")
        exit
    Endif
    
    // Size
    SetPc(prg, 8)
    worldW = ReadInt(f)
    worldH = ReadInt(f)  
    worldWindDir = DecompressReal(ReadInt(f)) * 360.0
    
    If (worldW > MAX_WORLD_X) or (worldH > MAX_WORLD_Y) or (worldW < 32) or (worldH < 32) then
        MessageBox("wgen_LoadWorldFromBin: Invalid map size!")
        exit
    Endif

    // Init blank world
    SetPc(prg, 10)
    For x = 0 to (worldW-1)
        For y = 0 to (worldH-1)
            New(worldTile[x,y])
        Next
    Next
    SetPc(prg, (100.0/7))     

    // tileType    
    For y = 0 to worldH-1
        For x = 0 to worldW-1 
            If x = 0 then
                worldTile[x,y].tileType = ReadByte(f) - 128
            Else
                worldTile[x,y].tileType = (ReadByte(f) - 128) + worldTile[x-1,y].tileType
            Endif
        Next
        
        If (y mod 20) = 0 then SetPc(prg,  ((100.0/7)*1) + ((100.0/7) * (ToReal(y) / ToReal(worldW - 1))) )
    Next
    
    // contiguity
    For y = 0 to worldH-1
        For x = 0 to worldW-1
            If x = 0 then
                contiguousMap[x,y] = ReadInt(f) - PRECOMPRESS_ABS_OFFSET
            Else
                contiguousMap[x,y] = (ReadInt(f) - PRECOMPRESS_ABS_OFFSET) + contiguousMap[x-1,y]
            Endif
        Next
            
        If (y mod 20) = 0 then SetPc(prg,  ((100.0/7)*2) + ((100.0/7) * (ToReal(y) / ToReal(worldW - 1))) )
    Next
    
    // elevation
    For y = 0 to worldH-1
        For x = 0 to worldW-1
            If x = 0 then
                worldTile[x,y].elevation = DecompressReal(ReadInt(f))   
            Else
                worldTile[x,y].elevation = DecompressReal(ReadInt(f))
                worldTile[x,y].elevation = worldTile[x,y].elevation + worldTile[x-1,y].elevation
            Endif
            
            If worldTile[x,y].elevation < 0.0 then worldTile[x,y].elevation = 0.0
            If worldTile[x,y].elevation > 1.0 then worldTile[x,y].elevation = 1.0
        Next
            
        If (y mod 20) = 0 then SetPc(prg,  ((100.0/7)*3) + ((100.0/7) * (ToReal(y) / ToReal(worldW - 1))) )
    Next
    
    // windz
    For y = 0 to worldH-1
        For x = 0 to worldW-1
            If x = 0 then
                worldTile[x,y].windz = DecompressReal(ReadInt(f)) 
            Else
                worldTile[x,y].windz = DecompressReal(ReadInt(f))
                worldTile[x,y].windz = worldTile[x,y].windz + worldTile[x-1,y].windz
            Endif
            
            If worldTile[x,y].windz < 0.0 then worldTile[x,y].windz = 0.0
            If worldTile[x,y].windz > 1.0 then worldTile[x,y].windz = 1.0
        Next
            
        If (y mod 20) = 0 then SetPc(prg,  ((100.0/7)*4) + ((100.0/7) * (ToReal(y) / ToReal(worldW - 1))) )
    Next
    
    // rainfall
    For y = 0 to worldH-1
        For x = 0 to worldW-1
            If x = 0 then
                worldTile[x,y].rainfall = DecompressReal(ReadInt(f))
            Else
                worldTile[x,y].rainfall = DecompressReal(ReadInt(f))
                worldTile[x,y].rainfall = worldTile[x,y].rainfall + worldTile[x-1,y].rainfall
            Endif
            
            If worldTile[x,y].rainfall < 0.0 then worldTile[x,y].rainfall = 0.0
            If worldTile[x,y].rainfall > 1.0 then worldTile[x,y].rainfall = 1.0
        Next
            
        If (y mod 20) = 0 then SetPc(prg,  ((100.0/7)*5) + ((100.0/7) * (ToReal(y) / ToReal(worldW - 1))) )
    Next
    
    // temperature
    For y = 0 to worldH-1
        For x = 0 to worldW-1
            If x = 0 then
                worldTile[x,y].temperature = DecompressReal(ReadInt(f)) 
            Else
                worldTile[x,y].temperature = DecompressReal(ReadInt(f))
                worldTile[x,y].temperature = worldTile[x,y].temperature + worldTile[x-1,y].temperature
            Endif
            
            If worldTile[x,y].temperature < 0.0 then worldTile[x,y].temperature = 0.0
            If worldTile[x,y].temperature > 1.0 then worldTile[x,y].temperature = 1.0
        Next
            
        If (y mod 20) = 0 then SetPc(prg,  ((100.0/7)*6) + ((100.0/7) * (ToReal(y) / ToReal(worldW - 1))) )
    Next     
    
    SetPc(prg, 100)
    
    Closefile(f)
    result = TRUE

End

Procedure wgen_RenderWorldToPng(pngPath: String, prg: ^progressBars) ; export
Var
    tmpImg: Element
    x,y,rgba: Integer
    e: Real
Begin 

    tmpImg = CreateImage(worldW, worldH)
    If tmpImg = NULL then
        MessageBox("Couldn't create canvas in wgen_RenderWorldToPng('"+pngPath+"') - png export skipped.", "Warning")
        exit
    Endif
    
    For y = 0 to worldH-1
        For x = 0 to worldW-1
            

            e = worldTile[x,y].elevation
                
            Case (worldTile[x,y].tileType) of
                (TILE_TYPE_UNDEFINED): rgba = ToRGBA(255*e,0,0)
                (TILE_TYPE_SEA): rgba = ToRGBA(0,0,128*e + 128)
                (TILE_TYPE_GRASSLAND): rgba = ToRGBA(128*e,255*e,000)
                (TILE_TYPE_FOREST): rgba = ToRGBA(000,200*e,000)
                (TILE_TYPE_JUNGLE): rgba = ToRGBA(000,128*e,000)
                (TILE_TYPE_DESERT): rgba = ToRGBA(200*e,200*e,000)
                (TILE_TYPE_GREEN_MOUNTAIN): rgba = ToRGBA(90*e,128*e,90*e)
                (TILE_TYPE_BARREN_MOUNTAIN): rgba = ToRGBA(128*e,90*e,90*e)
                (TILE_TYPE_FROZEN): rgba = ToRGBA(200+55*e,200+55*e,200+55*e)
                (TILE_TYPE_RIVER): rgba = ToRGBA(000,000,255*e)
                Default:
                    rgba = ToRGBA(Rand(0,255), Rand(0,255), Rand(0,255))
            EndCase
            
            Pixel(x, y, rgba, tmpImg)
        Next
        
        If (y mod 20) = 0 then SetPc(prg, 100.0 * ToReal(y) / ToReal(WorldH-1))
    Next
    
    SetPc(prg, 100)
    SaveImage(pngPath, tmpImg)
    
    FreeImage(tmpImg)

End

Procedure wgen_RenderTerrainsToPng(pngPath: String, prg: ^progressBars) ; export
Var
    tmpImg: Element
    x,y,rgba: Integer
    e: Real
Begin 

    tmpImg = CreateImage(worldW, worldH)
    If tmpImg = NULL then
        MessageBox("Couldn't create canvas in wgen_RenderRerrainsToPng('"+pngPath+"') - png export skipped.", "Warning")
        exit
    Endif
    
    For y = 0 to worldH-1
        For x = 0 to worldW-1
            

            e = worldTile[x,y].elevation
                
            Case (worldTile[x,y].tileType) of
                    (TILE_TYPE_UNDEFINED): rgba = ToRGBA(255,0,0)
                    (TILE_TYPE_SEA): rgba = ToRGBA(0,0,128)
                    (TILE_TYPE_GRASSLAND): rgba = ToRGBA(128,255,000)
                    (TILE_TYPE_FOREST): rgba = ToRGBA(000,200,000)
                    (TILE_TYPE_JUNGLE): rgba = ToRGBA(000,128,000)
                    (TILE_TYPE_DESERT): rgba = ToRGBA(200,200,000)
                    (TILE_TYPE_GREEN_MOUNTAIN): rgba = ToRGBA(90,128,90)
                    (TILE_TYPE_BARREN_MOUNTAIN): rgba = ToRGBA(128,90,90)
                    (TILE_TYPE_FROZEN): rgba = ToRGBA(255,255,255)
                    (TILE_TYPE_RIVER): rgba = ToRGBA(000,000,255)
                Default:
                    rgba = ToRGBA(255,128,0)
            EndCase
            
            Pixel(x, y, rgba, tmpImg)
        Next
        
        If (y mod 20) = 0 then SetPc(prg, 100.0 * ToReal(y) / ToReal(WorldH-1))
    Next
    
    SetPc(prg, 100)
    SaveImage(pngPath, tmpImg)
    
    FreeImage(tmpImg)

End

Procedure wgen_RenderHeightmapToPng(pngPath: String, prg: ^progressBars) ; export
Var
    tmpImg: Element
    x,y,rgba: Integer
    e: Real
Begin   

    tmpImg = CreateImage(worldW, worldH)
    If tmpImg = NULL then
        MessageBox("Couldn't create canvas in wgen_RenderHeightmapToPng('"+pngPath+"') - png export skipped.", "Warning")
        exit
    Endif
    
    For y = 0 to worldH-1
        For x = 0 to worldW-1

            e = worldTile[x,y].elevation
            rgba = ToRGBA(e*255, e*255, e*255)
            
            Pixel(x, y, rgba, tmpImg)
        Next
        
        If (y mod 20) = 0 then SetPc(prg, 100.0 * ToReal(y) / ToReal(WorldH-1))
    Next
    
    SaveImage(pngPath, tmpImg)
    
    FreeImage(tmpImg)
    
    SetPc(prg, 100)

End

Procedure wgen_RenderTemperaturesToPng(pngPath: String, prg: ^progressBars) ; export
Var
    tmpImg: Element
    x,y,rgba: Integer
    e: Real
Begin  

    tmpImg = CreateImage(worldW, worldH)
    If tmpImg = NULL then
        MessageBox("Couldn't create canvas in wgen_RenderTemperaturesToPng('"+pngPath+"') - png export skipped.", "Warning")
        exit
    Endif
    
    For y = 0 to worldH-1
        For x = 0 to worldW-1
            
            e = worldTile[x,y].temperature
            rgba = ToRGBA(e*255, e*255, e*255)
            
            Pixel(x, y, rgba, tmpImg)
        Next
        
        If (y mod 20) = 0 then SetPc(prg, 100.0 * ToReal(y) / ToReal(WorldH-1))
    Next
    
    SaveImage(pngPath, tmpImg)
    
    FreeImage(tmpImg)
    
    SetPc(prg, 100)

End

Begin
End