{
    Quick example showing how to read saved world.bin data
}
Program (icon:"lib\hex.ico")
    Uses
        cobra2d,
        hagC2d,
        lexini,
        keyset,
        hexCommon,
        hexWorldgen_backend

Var
    mapExists: Boolean = FALSE

Procedure LoadWorld(wdir: String)
Var
    fn, execString: String
Begin
    fn = wdir + 'world.bin'
    
    If mapExists then wgen_FreeWorld()
    
    // Unpack
    If FileExists(fn+'.packed') then
        SetText("Decompressing...", 10)
        execString = ""
        execString = execString + Replace(compress_cmdDecompress, "$1", fn, TRUE)  
        ExecFile(execString)
        While FileExists(fn+".packed")
            Flip
            Pause(10)
        Wend
        SetText("Decompressing...", 100)
    Endif
    
    If FileExists(fn) = FALSE then
        SetText("File not found!", 0)
        exit
    Endif
    
    
    SetText("Loading...", 0)
    If wgen_LoadWorldFromBin(fn, prgLoad) then
        SetText("Rendering...", 100)
        wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_COLOR_ELEVATION, cnvWorld.e)
        
        If compress_enabled then
            SetText("Recompressing...", 10)
            execString = ""
            execString = execString + Replace(compress_cmdCompress, "$1", fn, TRUE)  
            ExecFile(execString)
            While FileExists(fn)
                Flip
                Pause(10)
            Wend
            SetText("Recompressing...", 100)
        Endif
        
        SetText("Size: "+worldW+"x"+worldH+", wind: "+ToInt(worldWindDir)+"°", 0)
        mapExists = TRUE
    Else
        SetText("There was an error reading the file.", 0)
        wgen_FreeWorld()
    Endif
    
End

Procedure SetText(s: String, pc: Integer = -1)
Var
    w: Integer
Begin
    CLS(ToRGBA(0,0,0, 0), cnvLoad.e)
    PenColor(ToRGBA(255, 255, 255), cnvLoad.e)
    SetFont("arial", 10, 0, cnvLoad.e)
    w = TextWidth(s, cnvLoad.e)
    Text((SpriteWidth(cnvLoad.e) - w) / 2, 0, s, cnvLoad.e)
    
    If pc > -1 then
        ProgressBarPercent(prgLoad, pc)
        HagUpdateOnce()
        Flip
    Else
        Flip
    Endif
End

Var
    frmMain: ^forms
        lbxWorlds: ^listBoxes
        btnLoad: ^buttons
        prgLoad: ^progressBars
        cnvLoad: ^canvases
    frmWorld: ^forms
        fraWorld: ^frames
        cnvWorld: ^canvases
        ddbWorld: ^dropDowns
    
    background: Element
    dir: Element
    fn: String

Begin

    // Load cfg
    common_LoadCfg()
    
    // Init Graphics
    SetAppName("Hero Extant - World Viewer")
    gfx_width  = 1024
    gfx_height = 768
    gfx_fullscreen = FALSE
    OpenScreen(gfx_width, gfx_height, gfx_depth, gfx_fullscreen, gfx_flags)
    VSync(gfx_vsync)
    Randomize(Millisecs)
    
    // Background
    background = LoadSprite(path_wgenMenu_background)
    SpriteWidth(background, gfx_width)
    SpriteHeight(background, gfx_height)

    // Init GUI    
    HagBaseDir(hag_baseDir)
    HagInit(gfx_width, gfx_height, 1)
    HagEnableDebugLog(hag_debug)    
    HagLoadGuiTheme(hag_theme)
    
    frmMain = CreateForm("frmMain")
        lbxWorlds = CreateListBox(frmMain, 20, 20, 360, gfx_height - 160)
        btnLoad = CreateButton(frmMain, 20, gfx_height - 130, 360, "Load World")
        prgLoad = CreateProgressBar(frmMain, 20, gfx_height - 50, 360)
        cnvLoad = CreateCanvas(frmMain, 20, gfx_height-70, 360, 20)
        
    frmWorld = CreateForm("frmWorld")
        fraWorld = CreateFrame(frmWorld, 0, 0, 514, 514, FRAME_STYLE_SQUAREBORDER)
            cnvWorld = CreateCanvas(frmWorld, 1, 1, 512, 512)
            CLS(ToRGBA(0,0,0,0), cnvWorld.e)
            ddbWorld = CreateDropDown(frmWorld, 0, -25, 140, "Rendered")
                DropDownAddOption(ddbWorld, "Rendered")
                DropDownAddOption(ddbWorld, "Terrain")
                DropDownAddOption(ddbWorld, "Heightmap")
                DropDownAddOption(ddbWorld, "Heightmap - raw")
                DropDownAddOption(ddbWorld, "Rivers")
                DropDownAddOption(ddbWorld, "Temperatures")
                DropDownAddOption(ddbWorld, "Temperatures - raw")
                DropDownAddOption(ddbWorld, "Wind & Rain")
                DropDownAddOption(ddbWorld, "Just Wind")
                DropDownAddOption(ddbWorld, "Just Rain")
        PositionForm(frmWorld, (gfx_width + 380 - 514) / 2, gfx_height - 150 - 514)
    
    SetText("Waiting for user...", 0)

    // Find file
    dir = OpenDir(path_worlds+'*', CFA_READONLY + CFA_HIDDEN + CFA_DIRECTORY)
    fn = NextFile(dir)
  
    While (fn <> '')
        If (fn <> '.') and (fn <> '..') then ListBoxAddOption(lbxWorlds, fn)
        fn = NextFile(dir)
    Wend
    
    CloseDir(dir)
    

    // Main Loop
    HagUpdateOnce()
    FlushKeys()
    FlushMouse()
    
    While Not ExitRequested
    
        HagUpdateAll_AutoKeys()
        If ListBoxSelectionExists(lbxWorlds) then
            If btnLoad.enabled = FALSE then EnableButton(btnLoad, TRUE)
        Else
            If btnLoad.enabled = TRUE then EnableButton(btnLoad, FALSE)
        Endif
        If mapExists then
            If ddbWorld.enabled = FALSE then EnableDropDown(ddbWorld, TRUE)
        Else
            If ddbWorld.enabled = TRUE then EnableDropDown(ddbWorld, FALSE)            
        Endif
        
        If ButtonClicked(btnLoad) then LoadWorld(path_worlds + ListBoxSelectionString(lbxWorlds) + '\')
        If DropDownUpdated(ddbWorld) then
            Case ddbWorld.txt of
                "Heightmap":            wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_ELEVATION + WGEN_PREVIEW_SEALEVEL, cnvWorld.e)
                "Heightmap - raw":      wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_ELEVATION, cnvWorld.e)
                "Temperatures":         wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_TEMPERATURE, cnvWorld.e)
                "Rivers":               wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_RIVERS, cnvWorld.e)
                "Temperatures - raw":   wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_TEMPERATURE_RAW, cnvWorld.e)
                "Wind & Rain":          wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_WIND + WGEN_PREVIEW_RAINFALL, cnvWorld.e)
                "Just Wind":            wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_WIND, cnvWorld.e)
                "Just Rain":            wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_RAINFALL, cnvWorld.e)
                "Terrain":              wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_COLOR, cnvWorld.e)
                "Rendered":             wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_COLOR_ELEVATION, cnvWorld.e)
            EndCase
        Endif
        
        Flip
        Pause(1)
        If KeyHits(VK_ESCAPE) > 0 then RequestExit
    Wend
    
    // End
    HagFreeAll() 
    CloseScreen

End
