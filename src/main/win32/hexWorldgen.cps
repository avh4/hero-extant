{
    
    Copyright (C) 2010 Ben Golightly

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
}
Unit
    Uses
        cobra2d,
        hagC2D,
        hexCommon,
        hexWorldgen_backend,
        keyset

Const
    WGEN_EXIT = 1
    
    WGEN_STATE_MENU = 1
    WGEN_STATE_WGEN = 2
    

Var
    init: Boolean = FALSE
    
    background: Element

    frmMainMenu: ^forms
        fraMainMenu: ^frames
        txtMainMenu: ^hTexts
            txtWorldSize: ^hTexts
            ddbWorldSize: ^dropDowns
            txtAreaSize: ^hTexts
            ddbAreaSize: ^dropDowns
            txtWorldName: ^hTexts
            tbxWorldName: ^textBoxes
            txtZlevels: ^hTexts
            ddbZlevels: ^dropDowns
            tbxLatitude: ^hTexts
            ddbLatitude: ^dropDowns
            cbxDoLocalAreas: ^checkBoxes
            cbxExportPngs: ^checkBoxes
            btnBack: ^buttons
            btnStart: ^buttons
    
    frmGen: ^forms
        fraGen: ^frames
            fraGenCanvas: ^frames
                cnvGenCanvas: ^canvases
            prgGen: ^progressBars
            cnvGenTxt: ^canvases
    
    frmGenConfirm: ^forms
        fraGenConfirm: ^frames
            btnGenConfirmYes, btnGenConfirmNo: ^buttons
            ddbGenRenderChoice: ^dropDowns
            

Procedure wgen_init()
Var
    x, y, w: Integer
Begin

    background = LoadSprite(path_wgenMenu_background)
    SpriteWidth(background, gfx_width)
    SpriteHeight(background, gfx_height)
    hag_index  = SpriteIndex(background) + 1

    frmMainMenu = CreateForm("wgen.frmMainMenu")
        fraMainMenu = CreateFrame(frmMainMenu, 20, 20, 240, gfx_height-40, FRAME_STYLE_SQUARESOLID)
        SpriteAlpha(fraMainMenu.e, 128)
        txtMainMenu = CreateText(frmMainMenu, 40, 40, "World Gen", -1, -1, TXT_TYPE_TITLE)
            txtWorldName = CreateText(frmMainMenu, 40, 85, "World Name:")
            tbxWorldName = CreateTextBox(frmMainMenu, 140, 80, 100, "Yrdd")
            txtWorldSize = CreateText(frmMainMenu, 40, 115, "World Size:")
            ddbWorldSize = CreateDropDown(frmMainMenu, 140, 110, 100, "512")
                DropDownAddOption(ddbWorldSize,   "64")
                DropDownAddOption(ddbWorldSize,  "128")
                DropDownAddOption(ddbWorldSize,  "256")
                DropDownAddOption(ddbWorldSize,  "512")
                DropDownAddOption(ddbWorldSize, "1024")
                DropDownAddOption(ddbWorldSize, "2048")
                DropDownAddOption(ddbWorldSize, "3072")
                DropDownAddOption(ddbWorldSize, "4096")
            {txtAreaSize = CreateText(frmMainMenu, 40, 145, "Area Sizes:")
            ddbAreaSize = CreateDropDown(frmMainMenu, 140, 140, 100, "256")
                DropDownAddOption(ddbAreaSize,  "128")
                DropDownAddOption(ddbAreaSize,  "256")
                DropDownAddOption(ddbAreaSize,  "512")}
            txtZlevels = CreateText(frmMainMenu, 40, 145, "Area Z-Levels:")
            ddbZlevels = CreateDropDown(frmMainMenu, 140, 140, 100, "12")
                DropDownAddOption(ddbZlevels, "4")
                DropDownAddOption(ddbZlevels, "8")
                DropDownAddOption(ddbZlevels, "12")
                DropDownAddOption(ddbZlevels, "16")                                               
                DropDownAddOption(ddbZlevels, "24")
                DropDownAddOption(ddbZlevels, "32")
                DropDownAddOption(ddbZlevels, "48")
                DropDownAddOption(ddbZlevels, "64")
            tbxLatitude = CreateText(frmMainMenu, 40, 175, "Latitude:")
            ddbLatitude = CreateDropDown(frmMainMenu, 140, 170, 100, "Equatorial")
                DropDownAddOption(ddbLatitude, "Northern")
                DropDownAddOption(ddbLatitude, "Equatorial")
                DropDownAddOption(ddbLatitude, "Southern")
            
            //cbxDoLocalAreas = CreateCheckBox(frmMainMenu, 40, 215, 200, "History & Local Areas", TRUE)
            cbxExportPngs   = CreateCheckBox(frmMainMenu, 40, 215, 200, "Export PNG renders", TRUE) // 240
            
            btnBack  = CreateButton(frmMainMenu, 40, gfx_height - 60, 95, "Back")
            btnStart = CreateButton(frmMainMenu, 145, gfx_height - 60, 95, "Generate")
        
    frmGen = CreateForm("wgen.frmGen")
        fraGen = CreateFrame(frmGen, 0, 0, 560, 600, FRAME_STYLE_SQUARESOLID)
        SpriteAlpha(fraGen.e, 128)
            x = (560 - 514)/2
            w = (gfx_width + 260 - 20 - 560) / 2
            fraGenCanvas = CreateFrame(frmGen, x, 20, 514, 514, FRAME_STYLE_SQUAREBORDER)
                cnvGenCanvas = CreateCanvas(frmGen, x + 1, 21, 512, 512)
            prgGen = CreateProgressBar(frmGen, x, 600 - 40, 560 -x-x)
            cnvGenTxt = CreateCanvas(frmGen, 60, 541, 440, 20)
        
    PositionForm(frmGen, w, (gfx_height - 600) / 2)
    
    frmGenConfirm = CreateForm("wgen.frmGenConfirm")
        x = (560 - 514)/2
        fraGenConfirm = CreateFrame(frmGenConfirm, x + 1, 534-31, 512, 31, FRAME_STYLE_SQUARESOLID)
        SpriteAlpha(fraGenConfirm.e, 128)
            btnGenConfirmYes = CreateButton(frmGenConfirm, x + 4, 534-28, 160, "Accept Map")
            btnGenConfirmNo  = CreateButton(frmGenConfirm, x + 4 + 163, 534-28, 160, "Reject Map")
            ddbGenRenderChoice = CreateDropDown(frmgenConfirm, x + 514 - 145, 534-28, 140, "Rendered")
                DropDownAddOption(ddbGenRenderChoice, "Rendered")
                DropDownAddOption(ddbGenRenderChoice, "Terrain")
                DropDownAddOption(ddbGenRenderChoice, "Heightmap")
                DropDownAddOption(ddbGenRenderChoice, "Temperatures")
                DropDownAddOption(ddbGenRenderChoice, "Wind & Rain")
                DropDownAddOption(ddbGenRenderChoice, "Continuity")
        
    PositionForm(frmGenConfirm, w, (gfx_height - 600) / 2)
            
        


End

Procedure wgen_LoopWgenMenu() ; export
Var
    i, m: Integer = 0
    action: Integer = 0
    state: Integer = WGEN_STATE_MENU
    hemisphere: Integer
    ok, restart: Boolean
    worldFolder: String
    size: Integer
    execString: String
Begin
    If init = FALSE then
        wgen_init()
        init = TRUE
    Endif
    
    FlushButton(btnBack)
    FlushButton(btnStart)    
    FocusButton(btnStart)
    HagUpdateOnce()
    
    wgen_show(TRUE)
    
    While action = 0 
        
        HagUpdateAll_AutoKeys()
        ok = TRUE
        restart = FALSE   
    
        Case state of
            (WGEN_STATE_MENU):
            
                If ButtonClicked(btnStart) then
                    FlushButton(btnBack)
                    FlushButton(btnStart)
                    EnableForm(frmMainMenu, FALSE, TRUE)
                    state = WGEN_STATE_WGEN
                Endif
                If ButtonClicked(btnBack) then action = WGEN_EXIT
            
            (WGEN_STATE_WGEN):
                CLS(ToRGBA(0,0,0), cnvGenCanvas.e)
                wgen_SetText("Creating World...", 20)
                wgen_CreateWorld(ToInt(ddbWorldSize.txt), ToInt(ddbWorldSize.txt))

                wgen_SetText("Creating Heightmap...", 40)
                wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_ELEVATION, cnvGenCanvas.e)
                
                wgen_SetText("Clamping...", 60)
                wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_ELEVATION + WGEN_PREVIEW_SEALEVEL, cnvGenCanvas.e)
                
                wgen_SetText("Validating...", 80)
                If (wgen_LandMassPercent() < 15) or (wgen_AverageElevation()<0.1)
                    wgen_SetText("Map Rejected!", 4)
                    Pause(200)
                    ok = FALSE
                    restart = TRUE
                Endif
                
                If ok then
                    wgen_SetText("Is this map acceptable?", 100)
                    If wgen_Acceptable() = FALSE then ok = FALSE
                Endif
                
                If ok then
                    wgen_SetText("Calculating temperature bands...", 0)
                    Case ddbLatitude.txt of
                        "Northern":     hemisphere = WGEN_HEMISPHERE_NORTH
                        "Equatorial":   hemisphere = WGEN_HEMISPHERE_EQUATOR
                        "Southern":     hemisphere = WGEN_HEMISPHERE_SOUTH
                        Default:        MessageBox("Unkown hemisphere of '"+ddbLatitude.txt+"'")
                    EndCase
                    wgen_CalculateTemperatures(hemisphere, prgGen)
                    wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_TEMPERATURE, cnvGenCanvas.e)
                    
                    wgen_SetText("Simulating wind & rain...", 0)
                    wgen_CalculateWind(prgGen)
                    wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_WIND + WGEN_PREVIEW_RAINFALL, cnvGenCanvas.e)
                    
                    wgen_SetText("Simulating rain flow...", 0)
                    wgen_CalculateWaterFlow(prgGen)
                    wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_RIVERS, cnvGenCanvas.e)
                    
                    wgen_SetText("Determining terrain types...", 0)
                    wgen_DetermineWorldTerrainTypes(prgGen)
                    wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_COLOR, cnvGenCanvas.e)
                    
                    wgen_SetText("Determining contiguous areas...", 0)
                    wgen_DetermineContiguousAreas(prgGen)            
                    wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_CONTIGUOUS, cnvGenCanvas.e)
                    Pause(200)
                    
                    wgen_SetText("Is this map acceptable?", 100)
                    wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_COLOR_ELEVATION, cnvGenCanvas.e)
                    If wgen_Acceptable(TRUE) = FALSE then ok = FALSE
                Endif
                
                If ok then
                    worldFolder = ".\"+path_worlds+"WORLD."+Sanitize_WorldName(TextBoxContents(tbxWorldName))+"."+DateTimeToString(Now,'%yyyy%mm%dd.%hh%nn%ss')+"\"

                    wgen_SetText("Exporting world.bin...", 0)
                    wgen_SaveWorldToBin(worldFolder, prgGen)
                    wgen_SetText("Exporting world.bin...", 100)
                    
                    size = GetFileSize(worldFolder+"world.bin")
                    
                    If compress_enabled then
                        wgen_SetText("Compressing...", 10)
                        execString = ""
                        execString = execString + Replace(compress_cmdCompress, "$1", worldFolder+"world.bin", TRUE)  
                        ExecFile(execString)
                        While FileExists(worldFolder+"world.bin")
                            Flip
                            Pause(10)
                        Wend
                        wgen_SetText("Compressing...", 100)
                    Endif
                    
                    If CheckBoxChecked(cbxExportPngs) then
                        wgen_SetText("Exporting rendered.png...", 0)
                        wgen_RenderWorldToPng(worldFolder + 'rendered.png', prgGen)
                        wgen_SetText("Exporting terrains.png...", 0)
                        wgen_RenderTerrainsToPng(worldFolder + 'terrains.png', prgGen)
                        wgen_SetText("Exporting heightmap.png...", 0)
                        wgen_RenderHeightMapToPng(worldFolder + 'heightmap.png', prgGen)
                        wgen_SetText("Exporting temperatures.png...", 0)
                        wgen_RenderTemperaturesToPng(worldFolder + 'temperatures.png', prgGen)
                    Endif
                Endif
                
                
                // --- Finish ---
                wgen_SetText("Cleaning up...", 0)
                wgen_FreeWorld()
                
                If ok then
                    wgen_SetText("Finished! This world has been saved.", 0)
                Else
                    wgen_SetText("Aborted", 0)
                Endif
                If restart then
                    wgen_SetText("Retrying...", 100)
                Else
                    state = WGEN_STATE_MENU
                    EnableForm(frmMainMenu, TRUE, TRUE)
                Endif
                           
            
        EndCase
        
        If (KeyHits(VK_ESCAPE) > 0) then action = WGEN_EXIT            
        
        Flip
        Pause(1)
    Wend

    wgen_show(FALSE)
End

Procedure wgen_show(show: Boolean)
Begin
    SpriteVisible(background, show)
    ShowForm(frmMainMenu, show)
    ShowForm(frmGen, show)
    ShowForm(frmGenConfirm, FALSE)
    CLS(ToRGBA(0,0,0,0), cnvGenCanvas.e)
    CLS(ToRGBA(0,0,0, 0), cnvGenTxt.e)
    wgen_SetPercent(0)
End

Procedure wgen_SetPercent(pc: Integer)
Begin
    ProgressBarPercent(prgGen, pc)
    HagUpdateOnce()
End

Procedure wgen_SetText(s: String, pc: Integer = -1)
Var
    w: Integer
Begin
    CLS(ToRGBA(0,0,0, 0), cnvGenTxt.e)
    PenColor(ToRGBA(255, 255, 255), cnvGenTxt.e)
    SetFont("arial", 10, 0, cnvGenTxt.e)
    w = TextWidth(s, cnvGenTxt.e)
    Text((SpriteWidth(cnvGenTxt.e) - w) / 2, 0, s, cnvGenTxt.e)
    
    If pc > -1 then
        wgen_SetPercent(pc)
        Flip
    Else
        Flip
    Endif
End

Function wgen_Acceptable(choice: Boolean = FALSE) : Boolean
Var
    xit: Boolean = FALSE
Begin
    result = FALSE
    
    ShowForm(frmGenConfirm, TRUE)
    ShowDropDown(ddbGenRenderChoice, choice)
    
    FlushKeys()
    FlushMouse()
    
    FlushButton(btnGenConfirmYes)
    FlushButton(btnGenConfirmNo)
    FocusButton(btnGenConfirmYes)

    While xit = FALSE
        
        If choice and DropDownUpdated(ddbGenRenderChoice) then
            Case ddbGenRenderChoice.txt of
                "Heightmap":    wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_ELEVATION + WGEN_PREVIEW_SEALEVEL, cnvGenCanvas.e)
                "Continuity":   wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_CONTIGUOUS, cnvGenCanvas.e)
                "Temperatures": wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_TEMPERATURE, cnvGenCanvas.e)
                "Wind & Rain":  wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_WIND + WGEN_PREVIEW_RAINFALL, cnvGenCanvas.e)
                "Terrain":      wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_COLOR, cnvGenCanvas.e)
                "Rendered":     wgen_DrawWorld(worldW, worldH, WGEN_PREVIEW_COLOR_ELEVATION, cnvGenCanvas.e)
            EndCase
        Endif
        
        If ButtonClicked(btnGenConfirmYes) then
            xit = TRUE
            result = TRUE
        Endif
        
        If ButtonClicked(btnGenConfirmNo) then
            xit = TRUE
            result = FALSE
        Endif
        
        If (KeyHits(VK_ESCAPE) > 0) then
            xit = TRUE
            result = FALSE
        Endif
            
        HagUpdateAll_AutoKeys()
        Flip
        Pause(1)
    Wend
    
    FlushKeys()
    FlushMouse()    
    
    ShowForm(frmGenConfirm, FALSE)
End

Begin
End