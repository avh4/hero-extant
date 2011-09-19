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
Program (icon:"lib\hex.ico")
Uses
    cobra2d,
    hagC2D,
    keyset,
    //hexVm,
    hexCommon,
    hexWorldGen,
    hexTextwrap    

Const
    VERSION = 20100714

    MAIN_MENU_EXIT = 1
    MAIN_MENU_WGEN = 2
    MAIN_MENU_CGEN = 3
    MAIN_MENU_LOAD = 4
    MAIN_MENU_CREDITS = 5
    
    MAIN_MENU_MAX_BGS = 32
    MAIN_MENU_MAX_BGS_M1 = MAIN_MENU_MAX_BGS - 1 

Type mainMenuOptions = Record
    e: Element
    x1, y1, x2, y2: Integer
    code: Integer = 0
EndType

Var
    logo, gplLogo, thsLogo: Element
    
    credits: Element
    creditsAlpha: Real = 0.0
    
    nyi: Element // Not yet implemented
    nyiAlpha: Real = 0.0
    
    bg: Array [MAIN_MENU_MAX_BGS] of Element
    bgAlpha: Array [MAIN_MENU_MAX_BGS] of Real
    totalBgs: Integer
    
    music: Element
    musicChannel: Element
    
    mainMenuOptionList: List of mainMenuOptions

Procedure LoadMainMenu()
Var
    i: Integer
    y: Integer
    p: String
Begin

    For i = 0 to (MAIN_MENU_MAX_BGS-1)
        p = path_mainMenu_background+ToString(i+1)+".jpg"
        If FileExists(p) = FALSE then break
        bg[i] = LoadSprite(p)
        bgAlpha[i] = 0.0
        SpriteWidth(bg[i], gfx_width)
        SpriteHeight(bg[i], gfx_height)
    Next
    totalBgs = i
    
    logo = LoadSprite(path_mainMenu_logo)
    PositionSprite(logo, (gfx_width - SpriteWidth(logo)) / 2, 120 - SpriteHeight(logo))
    SpriteAlpha(logo, 16)
    
    gplLogo = LoadSprite(path_gplLogo)
    PositionSprite(gplLogo, 60, gfx_height - (SpriteHeight(gplLogo)) - 30)
    SpriteVisible(gplLogo, FALSE)
    
    thsLogo = LoadSprite(path_thsLogo)
    PositionSprite(thsLogo, gfx_width - (SpriteWidth(thsLogo) * 1.0) - 60, gfx_height - SpriteHeight(thsLogo) - 30)
    SpriteVisible(thsLogo, FALSE)
    
    AADraw(4)
    // Credits
    credits = CreateSprite(512, 512)
    SetFont("arial", 12, 1, credits)
    PenColor(ToRGBA(255, 255, 255), credits)
    SpriteVisible(credits, FALSE)
    y = hTextWrap(0, 0, 400, FileGetContents(path_credits), credits)
    PositionSprite(credits, Max(((gfx_width - 400) / 2), 400), (gfx_height - y) / 2)
    
    // Not yet Implemented
    nyi = CreateSprite(512, 512)
    SetFont("arial", 12, 1, nyi)
    PenColor(ToRGBA(255, 255, 255), nyi)
    SpriteVisible(nyi, FALSE)
    y = hTextWrap(0, 0, 350, FileGetContents('global\nyi.txt'), nyi)
    PositionSprite(nyi, Max(((gfx_width - 400) / 2), 400), (gfx_height - y) / 2)
    AADraw(0)
    
    If music_enabled then
        music = LoadSound(path_mainMenu_music)
        musicChannel = PlaySound(music)
        ChannelVolume(musicChannel, 100 * music_volume)
    Endif
    
    AddMainMenuOption(MAIN_MENU_WGEN,       "Generate new world")
    AddMainMenuOption(MAIN_MENU_CGEN,       "Create new character")
    AddMainMenuOption(MAIN_MENU_LOAD,       "Load existing character")
    AddMainMenuOption(MAIN_MENU_CREDITS,    "View credits")
    AddMainMenuOption(MAIN_MENU_EXIT,       "Exit game")

End

Procedure UpdateMainMenuBackground()
Var
    i, d, d2: Integer
    m, m2: Static Integer = 0
    currentBg: Static Integer = -1
    lastBg: Static Integer = MAIN_MENU_MAX_BGS_M1
Begin
    d = Millisecs - m
    d2 = Millisecs - m2
    m2 = Millisecs
    
    If (d > 5000) or (currentBg = -1) then
    
        m = Millisecs
        
        For i = 0 to (totalBgs - 1)
            bgAlpha[i] = 0.0
            SpriteVisible(bg[i], FALSE)
        Next
        
        lastBg = currentBg
        If lastBg = -1 then lastBg = (totalBgs - 1)
        Inc(currentBg)              
        If currentBg = totalBgs then currentBg = 0
        bgAlpha[currentBg] = 0.0
        bgAlpha[lastBg] = 255.0
    
    Endif
    
    SpriteVisible(bg[currentBg], TRUE)
    If bgAlpha[currentBg] < 255.0 then bgAlpha[currentBg] = bgAlpha[currentBg] + (ToReal(d2) / 5.0)
    If bgAlpha[currentBg] > 255.0 then bgAlpha[currentBg] = 255
    SpriteAlpha(bg[currentBg], ToInt(bgAlpha[currentBg]))
    
    SpriteVisible(bg[lastBg], TRUE)
    If bgAlpha[lastBg] > 0.0 then bgAlpha[lastBg] = bgAlpha[lastBg] - (ToReal(d2) / 5.0)
    If bgAlpha[lastBg] < 0.0 then bgAlpha[lastBg] = 0
    SpriteAlpha(bg[lastBg], ToInt(bgAlpha[lastBg]))
    
    If creditsAlpha < 120.0 then creditsAlpha = creditsAlpha + (ToReal(d2) / 5.0)
    If creditsAlpha > 120.0 then creditsAlpha = 120.0
    SpriteAlpha(credits, creditsAlpha)
    SpriteAlpha(gplLogo, creditsAlpha)
    SpriteAlpha(thsLogo, creditsAlpha)
                                      
    If nyiAlpha < 120.0 then nyiAlpha = nyiAlpha + (ToReal(d2) / 5.0)
    If nyiAlpha > 120.0 then nyiAlpha = 120.0
    SpriteAlpha(nyi, nyiAlpha)
    
End

Procedure FreeMainMenu()
Var
    mainMenuOption: ^mainMenuOptions
    i: Integer
Begin

    Loop mainMenuOption through mainMenuOptionList
        FreeSprite(mainMenuOption.e)
        Free(mainMenuOption)
    EndLoop
    
    FreeSprite(logo)
    FreeSprite(gplLogo)
    FreeSprite(thsLogo)
    
    For i = 0 to (totalBgs-1)
        FreeSprite(bg[i])
    Next
    
    If music_enabled and ChannelPlaying(musicChannel) then ChannelVolume(musicChannel, 0)
    Pause(20)
End

Procedure ShowMainMenu(show: Boolean)
Var
    mainMenuOption: ^mainMenuOptions
    i: Integer
Begin
    SpriteVisible(logo, show)

    Loop mainMenuOption through mainMenuOptionList
        SpriteVisible(mainMenuOption.e, show)
    EndLoop
    
    For i = 0 to (totalBgs-1)
        SpriteVisible(bg[i], FALSE)
    Next
    
    If show = FALSE then
        SpriteVisible(credits, FALSE)
        SpriteVisible(gplLogo, FALSE)
        SpriteVisible(thsLogo, FALSE)
        SpriteVisible(nyi, FALSE)
    Endif
    
End

Procedure AddMainMenuOption(code: Integer, s: String)
Var
    mainMenuOption: ^mainMenuOptions
    y: Static Integer = -1 
Begin
    If y = -1 then y = (gfx_height / 2) - 75
    SetFont("arial", 18, 1, logo)
    AADraw(4)
    
    mainMenuOption = NewItem(mainMenuOptionList)
    mainMenuOption.code = code
    
    mainMenuOption.e = CreateSprite(TextWidth(s, logo), TextHeight(s, logo))
    SetFont("arial", 18, 1, mainMenuOption.e)
    PenColor(ToRGBA(255, 255, 255), mainMenuOption.e)
    Text(0, 0, s, mainMenuOption.e)
    PositionSprite(mainMenuOption.e, 60, y)
    y = y + 30
    
    mainMenuOption.x1 = SpriteX(mainMenuOption.e)
    mainMenuOption.y1 = SpriteY(mainMenuOption.e)
    mainMenuOption.x2 = mainMenuOption.x1 + SpriteWidth(mainMenuOption.e)
    mainMenuOption.y2 = mainMenuOption.y1 + SpriteHeight(mainMenuOption.e) 
    
    AADraw(0)
End

Procedure LoopMainMenu()
Var
    action: Integer = 0
    mx, my: Integer
    mh: Boolean
    mainMenuOption: ^mainMenuOptions
Begin

    ShowMainMenu(TRUE)

    FlushKeys()
    FlushMouse()
    RequestExit(0)
    
    While action = 0
        mx = MouseX
        my = MouseY
        mh = (MouseHits(0) > 0)
        
        Loop mainMenuOption through mainMenuOptionList
            If (mx > mainMenuOption.x1) and (mx < mainMenuOption.x2) and (my > mainMenuOption.y1) and (my < mainMenuOption.y2) then
                SpriteAlpha(mainMenuOption.e, 150)
                If mh then action = mainMenuOption.code
            Else
                SpriteAlpha(mainMenuOption.e, 60)
            Endif
        EndLoop
        
        If ExitRequested or (KeyHits(VK_ESCAPE) > 0) then action = MAIN_MENU_EXIT
        
        UpdateMainMenuBackground()       
    
        Flip
        Pause(1)
    Wend
    
    ShowMainMenu(FALSE)
    RequestExit(0)
    
    Case action of
        (MAIN_MENU_EXIT): RequestExit
        (MAIN_MENU_WGEN): wgen_LoopWgenMenu()
        (MAIN_MENU_CREDITS):
            SpriteVisible(credits, TRUE)
            SpriteVisible(gplLogo, TRUE)
            SpriteVisible(thsLogo, TRUE)
            creditsAlpha = 0.0
            
        Default:
            SpriteVisible(nyi, TRUE)
            nyiAlpha = 0.0
    EndCase
    
    FlushKeys()
    FlushMouse()
    
End

Begin

    // Load cfg
    common_LoadCfg()
    
    // Init Graphics
    SetAppName("Hero Extant")
    If gfx_width  <= 0 then gfx_width    = SelWidth
    If gfx_height <= 0 then gfx_height   = SelHeight
    If gfx_width  < 1024 then gfx_width  = 1024
    If gfx_height <  768 then gfx_height = 768
    OpenScreen(gfx_width, gfx_height, gfx_depth, gfx_fullscreen, gfx_flags)
    VSync(gfx_vsync)
    Randomize(Millisecs)
    
    // Init Main Menu
    LoadMainMenu()

    // Init GUI    
    HagBaseDir(hag_baseDir)
    HagInit(gfx_width, gfx_height, 0)
    HagEnableDebugLog(hag_debug)    
    HagLoadGuiTheme(hag_theme)
    
    // Loop
    While Not ExitRequested
        LoopMainMenu()
    Wend
    
    // End
    HagFreeAll()
    FreeMainMenu()    
    CloseScreen

End