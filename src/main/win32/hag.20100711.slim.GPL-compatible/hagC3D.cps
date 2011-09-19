Unit
    Uses
        cobra3d,        // works with pure2d, cobra2d, cobra3d - no other modifications needed
        keyset

Const
    VERSION = "20100711"
    // Update - fixed button text y-center
    // Update - fixed crash in PositionForm with sliders & progressbars
    // Update - flushButton now clears focus.

{

    Hag GUI library for Cobra (P2D/C2D/C3D)
        
    Hag is a fully-featured that makes implementing GUI elements such
    as buttons, textboxes, listboxes, checkboxes, etc. easy.
    
    Hag stands for "Half A Gui". If you want a window manager, you'll
    have to write the other half :-)   
    
    ---------------------------------------
    
    Updates:
        http://www.tophatstuff.co.uk/?p=42
        http://www.tophatstuff.co.uk/?section=updates
        http://www.tophatstuff.co.uk/packages/cobra/units/hag/
    
    Documentation:
        http://www.tophatstuff.co.uk/?p=42
    
    Support:
        golightly.ben@googlemail.com
    
    ---------------------------------------
    
    Copyright (c) 2008 - 2010 Ben Golightly

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
    
    ---------------------------------------
    
    Following variable prefixes are suggested:
        frm:  Form
        btn:  Button
        cvs:  Canvas
        cbx:  CheckBox
        rdo:  Radio Buttons
        prog: ProgressBar (alternative: prg)
        tab:  Tabs
        fra:  Frames
        tbx:  Textboxes
        ddb:  DropDown Box
        lbx:  List Box
        tbx:  Text Box
        sbr:  Scrollbar
        sli:  Slider
    
}

    { Versions and Compatibility }
    HAG_VERSION = VERSION ; Export
    THEME_COMPATIBLE = 2
    
    { Graphics Engines }
    GFX_P2D = 0
    GFX_C2D = 1
    GFX_C3D = 2
    GFX_USES = GFX_P2D  // Uses an alternative MouseSprite method - as of a
                        // recent Cobra update this is the only method that
                        // works, so leave this as GFX_P2D no matter the
                        // engine you compile for.
                        // Uses FindMouseSprite() as alternative to MouseSprite.
                        
    { Mechanincs }
    OBSCURE_MTICK_DELAY_MS      = 200   

    { Preferences : Enable Booleans }
    HAG_PREF_ENABLE_TILE_CACHE  = 0 ; Export
    HAG_PREF_ENABLE_ERROR_LOG   = 1 ; Export
    HAG_PREF_ENABLE_DEBUG_LOG   = 2 ; Export
    HAG_PREF_ENABLE_PERF_LOG    = 3 ; Export
    HAG_PREF_ENABLE_AADRAW      = 4 ; Export
    MAX_PREF_ENABLES            = 5 ; Export

    { Preferences : Default Enable Booleans }
    DEFAULT_PREF_ENABLE_TILE_CACHE  = TRUE
    DEFAULT_PREF_ENABLE_ERROR_LOG   = TRUE
    DEFAULT_PREF_ENABLE_DEBUG_LOG   = FALSE
    DEFAULT_PREF_ENABLE_PERF_LOG    = TRUE
    DEFAULT_PREF_ENABLE_AADRAW      = TRUE

    { Logs }
    LOG_ERROR       = "err.log"
    LOG_DEBUG       = "dbg.log"
    LOG_PERF        = "perf.log"
    
    { Mouse }
    HAG_MOUSE_NORMAL        = 0 ; Export // Default
    HAG_MOUSE_HAND          = 1 ; Export
    HAG_MOUSE_TEXT          = 2 ; Export
    HAG_MOUSE_BUSY          = 3 ; Export // Not Implemented
    
    { GUI Element Types }
    GET_BUTTON              = 0
    GET_PROGRESSBAR         = 1
    GET_RADIOGROUP          = 2 
    GET_RADIOBUTTON         = 3
    GET_CHECKBOX            = 4
    GET_TEXTBOX             = 5
    GET_TEXT                = 6
    GET_RICHTEXT            = 7 // IGNORE - GET_TEXT is already rich-text
    GET_CANVAS              = 8
    GET_DROPDOWN            = 9
    GET_LISTBOX             = 10   
    GET_TIMER               = 11
    GET_TAB                 = 12
    GET_FRAME               = 13
    GET_MENU                = 14 // Not Yet Implemented
    GET_SCROLLBAR           = 15
    GET_SLIDER              = 16
    MAX_GETS                = 17

    { Extended Types (for tiled image cache) }    
    GET_DROPDOWNBOX         = 18
    
    { GUI Theme Types }
    THEME_TYPE_GUI      = 0
    THEME_TYPE_AUDIO    = 1
    
    { Button Parts }
    BTN_PART_MID    = 0
    BTN_PART_LEFT   = 1
    BTN_PART_RIGHT  = 2
    MAX_BTN_PARTS   = 3

    { Button States }
    BTN_STATE_NORMAL    = 0
    BTN_STATE_HOVER     = 1
    BTN_STATE_FOCUSED   = 2
    BTN_STATE_ACTIVE    = 3
    BTN_STATE_DISABLED  = 4
    MAX_BTN_STATES      = 5
    
    { Progress Bar Parts }
    PROG_PART_MID       = 0
    PROG_PART_LEFT      = 1
    PROG_PART_RIGHT     = 2
    PROG_PART_ITEM      = 3
    MAX_PROG_PARTS      = 4
    
    { Progress Bar States }
    PROG_STATE_HORIZ    = 0
    PROG_STATE_VERT     = 1
    MAX_PROG_STATES     = 2
    
    { Slider Parts }
    SLI_PART_MID       = 0
    SLI_PART_LEFT      = 1
    SLI_PART_RIGHT     = 2
    SLI_PART_SLIDER    = 3
    SLI_PART_MARKING   = 4
    MAX_SLI_PARTS      = 5
    
    { Slider States }
    SLI_STATE_HORIZ    = 0
    SLI_STATE_VERT     = 1
    MAX_SLI_STATES     = 2

    { Slider Slider States }
    SLI_SLIDER_STATE_HORIZ_NORMAL   = 0
    SLI_SLIDER_STATE_HORIZ_HOVER    = 1
    SLI_SLIDER_STATE_HORIZ_DISABLED = 2
    SLI_SLIDER_STATE_VERT_NORMAL    = 3
    SLI_SLIDER_STATE_VERT_HOVER     = 4
    SLI_SLIDER_STATE_VERT_DISABLED  = 5
    MAX_SLI_SLIDER_STATES           = 6
    SLI_SLIDER_ORI_OFFSET = 3
  
    { Radio Button States }
    RDO_STATE_NORMAL    = 0
    RDO_STATE_HOVER     = 1
    RDO_STATE_ACTIVE    = 2
    RDO_STATE_DISABLED  = 3
    RDO_STATE_NORMAL_UNSELECTED     = 0 // Alias of RDO_STATE_NORMAL
    RDO_STATE_HOVER_UNSELECTED      = 1
    RDO_STATE_ACTIVE_UNSELECTED     = 2
    RDO_STATE_DISABLED_UNSELECTED   = 3
    RDO_STATE_NORMAL_SELECTED       = 4
    RDO_STATE_HOVER_SELECTED        = 5
    RDO_STATE_ACTIVE_SELECTED       = 6
    RDO_STATE_DISABLED_SELECTED     = 7
    MAX_RDO_STATES                  = 8
    RDO_SELECT_DIFF                 = 4 // Add RDO_SELECT_DIFF to go from unselected to selected 

    { Checkbox States }
    CBX_STATE_NORMAL    = 0
    CBX_STATE_HOVER     = 1
    CBX_STATE_ACTIVE    = 2
    CBX_STATE_DISABLED  = 3
    CBX_STATE_NORMAL_UNSELECTED     = 0 // Alias of CBX_STATE_NORMAL
    CBX_STATE_HOVER_UNSELECTED      = 1
    CBX_STATE_ACTIVE_UNSELECTED     = 2
    CBX_STATE_DISABLED_UNSELECTED   = 3
    CBX_STATE_NORMAL_SELECTED       = 4
    CBX_STATE_HOVER_SELECTED        = 5
    CBX_STATE_ACTIVE_SELECTED       = 6
    CBX_STATE_DISABLED_SELECTED     = 7
    MAX_CBX_STATES                  = 8
    CBX_SELECT_DIFF                 = 4 // Add CBX_SELECT_DIFF to go from unselected to selected

    { Textbox Parts }
    TBX_PART_MID    = 0
    TBX_PART_LEFT   = 1
    TBX_PART_RIGHT  = 2
    MAX_TBX_PARTS   = 3
    
    { Textbox States }
    TBX_STATE_NORMAL    = 0 ; export
    TBX_STATE_HOVER     = 1 ; export
    TBX_STATE_FOCUSED   = 2 ; export
    TBX_STATE_DISABLED  = 3 ; export
    MAX_TBX_STATES      = 4
    
    { Text Types }
    TXT_TYPE_NORMAL = 0 ; Export
    TXT_TYPE_TITLE  = 1 ; Export
    TXT_TYPE_HREF   = 2 ; Export
    MAX_TXT_TYPES   = 3

    { DropDown Parts }
    DDB_PART_MID    = 0
    DDB_PART_LEFT   = 1
    DDB_PART_RIGHT  = 2
    MAX_DDB_PARTS   = 3
    
    { DropDown Box Parts }
    DDB_PART_BOX_TOP_LEFT       = 1
    DDB_PART_BOX_TOP_MID        = 2
    DDB_PART_BOX_TOP_RIGHT      = 3
    DDB_PART_BOX_MID_LEFT       = 4
    DDB_PART_BOX_MID_MID        = 5
    DDB_PART_BOX_MID_RIGHT      = 6
    DDB_PART_BOX_BOTTOM_LEFT    = 7
    DDB_PART_BOX_BOTTOM_MID     = 8
    DDB_PART_BOX_BOTTOM_RIGHT   = 9
    MAX_DDB_BOX_PARTS           = 10

    { DropDown States }
    DDB_STATE_NORMAL        = 0
    DDB_STATE_HOVER         = 1
    DDB_STATE_ACTIVE        = 2
    DDB_STATE_DISABLED      = 3
    MAX_DDB_STATES          = 4
     
    DDB_BOX_STATE_NORMAL    = 4
    DDB_BOX_STATE_HOVER     = 5
    MAX_DDB_BOX_STATES      = 6
    
    { ListBox Parts }
    LBX_PART_TOP_LEFT       = 1
    LBX_PART_TOP_MID        = 2
    LBX_PART_TOP_RIGHT      = 3
    LBX_PART_MID_LEFT       = 4
    LBX_PART_MID_MID        = 5
    LBX_PART_MID_RIGHT      = 6
    LBX_PART_BOTTOM_LEFT    = 7
    LBX_PART_BOTTOM_MID     = 8
    LBX_PART_BOTTOM_RIGHT   = 9
    MAX_LBX_PARTS           = 10
    
    { ListBox States }
    LBX_STATE_NORMAL        = 0
    LBX_STATE_DISABLED      = 1
    MAX_LBX_STATES          = 2
    
    LBX_ITEM_STATE_NORMAL   = 2
    LBX_ITEM_STATE_HOVER    = 3
    LBX_ITEM_STATE_ACTIVE   = 4
    LBX_ITEM_STATE_DISABLED = 5
    MAX_LBX_ITEM_STATES     = 6
    
    { Timer Methods }
    TMR_METHOD_MILLISECS    = 0 ; Export
    TMR_METHOD_FRAMES       = 1 ; Export
    MAX_TMR_METHODS         = 2 

    { Tab Parts }
    TAB_PART_MID    = 0
    TAB_PART_LEFT   = 1
    TAB_PART_RIGHT  = 2
    MAX_TAB_PARTS   = 3

    { Tab States }
    TAB_STATE_INACTIVE  = 0
    TAB_STATE_HOVER     = 1
    TAB_STATE_ACTIVE    = 2
    MAX_TAB_STATES      = 3

    { Frame Parts }
    FRA_PART_TOP_LEFT       = 0
    FRA_PART_TOP_MID        = 1
    FRA_PART_TOP_RIGHT      = 2
    FRA_PART_MID_LEFT       = 3
    FRA_PART_MID_MID        = 4
    FRA_PART_MID_RIGHT      = 5
    FRA_PART_BOTTOM_LEFT    = 6
    FRA_PART_BOTTOM_MID     = 7
    FRA_PART_BOTTOM_RIGHT   = 8
    MAX_FRA_PARTS           = 9

    { Frame Types }
    FRAME_STYLE_TAB             = 0 ; Export
    FRAME_STYLE_ROUNDBORDER     = 1 ; Export
    FRAME_STYLE_ROUNDSOLID      = 2 ; Export
    FRAME_STYLE_SQUAREBORDER    = 3 ; Export
    FRAME_STYLE_SQUARESOLID     = 4 ; Export
    FRAME_STYLE_MOCKWINDOW      = 5 ; Export
    FRAME_STYLE_HEADER          = 6 ; Export
    //FRAME_STYLE_SIDEBAR = 7 // To Do (e.g. vista Blue-Green, xp grey)
    MAX_FRA_STYLES              = 7
    
    { Scrollbar Parts }
    SBR_PART_UP         = 0 ; export
    SBR_PART_DOWN       = 1 ; export
    SBR_PART_SLIDER     = 2 ; export
    SBR_PART_BAR        = 3 ; export
    MAX_SBR_PARTS       = 4 ; export
    
    { Scrollbar States }
    SBR_STATE_NORMAL    = 0 ; export
    SBR_STATE_HOVER     = 1 ; export
    SBR_STATE_ACTIVE    = 2 ; export
    SBR_STATE_DISABLED  = 3 ; export
    MAX_SBR_STATES      = 4 ; export
    
    { General }
    MAX_STATES = 8 // e.g. BTN_STATE_*. This is used for the theme font/text styles array
    
    { Font Flags }
    HAG_FONT_NORMAL         = 0 ; Export
    HAG_FONT_BOLD           = 1 ; Export
    HAG_FONT_ITALIC         = 2 ; Export
    HAG_FONT_UNDERLINE      = 4 ; Export
    HAG_FONT_UNDERLINED     = 4 ; Export
    HAG_FONT_STRIKETHROUGH  = 8 ; Export
    
    { Text Alignment }
    HAG_TEXT_LEFT       = 0 ; Export
    HAG_TEXT_CENTER     = 1 ; Export
    HAG_TEXT_RIGHT      = 2 ; Export
    
    { Orientation }
    HAG_HORIZONTAL      = 0 ; Export
    HAG_VERTICAL        = 1 ; Export
    
    { Default Styles }
    DEFAULT_FONT_NAME       = "arial"
    DEFAULT_FONT_SIZE       = 10
    DEFAULT_FONT_STYLE      = HAG_FONT_NORMAL
    DEFAULT_TEXT_ALIGNMENT  = HAG_TEXT_LEFT
    DEFAULT_TEXT_AALIASING  = FALSE
    
    { Misc }
    WWRAP_LINE_PADDING = 0
    CURSOR_BLINK_SPEED = 450 


Type buttons = Record

    { Properties }
    x, y    : Integer
    w, h    : Integer
    txt     : String
    tooltip : String
    e       : Element
    state   : Integer = BTN_STATE_NORMAL
    visible : Boolean = TRUE
    enabled : Boolean = TRUE
    
    { Extended Properties }
    isImageButton   : Boolean = FALSE
    image           : Element
    
    { Styles }
    fontName        : Array [MAX_BTN_STATES] of String
    fontSize        : Array [MAX_BTN_STATES] of Integer
    fontStyle       : Array [MAX_BTN_STATES] of Integer
    fontColor       : Array [MAX_BTN_STATES] of Integer
    textAlignment   : Array [MAX_BTN_STATES] of Integer
    textAAliasing   : Array [MAX_BTN_STATES] of Boolean 

    { Mechanics }    
    lastState       : Integer = BTN_STATE_NORMAL
    wasFocused      : Boolean = FALSE
    isMouseTarget   : Boolean = FALSE
    isKeyboardTarget: Boolean = FALSE
    hook            : String = ""

    { Flags }    
    toRender        : Boolean = TRUE
    gotLeftClicked  : Boolean = FALSE
    gotRightClicked : Boolean = FALSE
    
EndType ; Export

Type canvases = Record

    { Properties }
    x, y    : Integer
    w, h    : Integer
    tooltip : String
    e       : Element
    visible : Boolean = TRUE
    enabled : Boolean = TRUE

    { Mechanics }    
    isMouseTarget   : Boolean = FALSE
    hook            : String = ""

    { Flags }    
    gotLeftClicked  : Boolean = FALSE
    gotRightClicked : Boolean = FALSE
    
EndType ; Export

Type progressBars = Record

    { Properties }
    x, y    : Integer
    w, h    : Integer
    tooltip : String = ""
    e       : Element
    percent : Integer = 0
    state   : Integer = HAG_HORIZONTAL
    visible : Boolean = TRUE
    enabled : Boolean = TRUE

    { Mechanics }    
    isMouseTarget   : Boolean = FALSE
    hook            : String = ""

    { Flags }    
    toRender        : Boolean = TRUE
    gotLeftClicked  : Boolean = FALSE
    gotRightClicked : Boolean = FALSE
    
EndType ; Export

Type sliders = Record

    { Properties }
    x, y    : Integer
    w, h    : Integer
    tooltip : String = ""
    e       : Element
    state   : Integer = HAG_HORIZONTAL
    visible : Boolean = TRUE
    enabled : Boolean = TRUE

    { Slider Options }
    sliOffset           : Integer = 0
    sliLastOffset       : Integer = -1
    sliDivisions        : Integer = 0
    sliState: Integer = SLI_SLIDER_STATE_HORIZ_NORMAL

    { Mechanics }    
    isMouseTarget   : Boolean = FALSE
    hook            : String = ""
    
    { Flags }    
    toRender        : Boolean = TRUE
    gotUpdated      : Boolean = TRUE
    gotLeftClicked  : Boolean = FALSE
    gotRightClicked : Boolean = FALSE
    
EndType ; Export

Type radioButtons = Record

    { Properties }
    x, y    : Integer
    w, h    : Integer
    txt     : String
    tooltip : String
    e       : Element
    state   : Integer = RDO_STATE_NORMAL
    selected: Boolean = FALSE
    visible : Boolean = TRUE
    enabled : Boolean = TRUE
    
    { Styles }
    fontName        : Array [MAX_RDO_STATES] of String
    fontSize        : Array [MAX_RDO_STATES] of Integer
    fontStyle       : Array [MAX_RDO_STATES] of Integer
    fontColor       : Array [MAX_RDO_STATES] of Integer
    textAlignment   : Array [MAX_RDO_STATES] of Integer
    textAAliasing   : Array [MAX_RDO_STATES] of Boolean 
    
    { Mechanics }
    lastState       : Integer = RDO_STATE_NORMAL
    isMouseTarget   : Boolean = FALSE
    hook            : String = ""
    
    { Flags }
    toRender        : Boolean = TRUE
    gotLeftClicked  : Boolean = FALSE
    gotRightClicked : Boolean = FALSE     
    
EndType ; Export

Type radioGroups = Record

    { Properties }
    x, y    : Integer = 0
    visible : Boolean = TRUE
    enabled : Boolean = TRUE

    { Element List }
    grpRadioButtonList : List of radioButtons
    
    { Mechanics }
    hook            : String = ""
    
EndType ; Export

Type checkBoxes = Record

    { Properties }
    x, y    : Integer
    w, h    : Integer
    txt     : String
    tooltip : String
    e       : Element
    state   : Integer = CBX_STATE_NORMAL
    checked : Boolean = FALSE
    visible : Boolean = TRUE
    enabled : Boolean = TRUE
    
    { Styles }
    fontName        : Array [MAX_CBX_STATES] of String
    fontSize        : Array [MAX_CBX_STATES] of Integer
    fontStyle       : Array [MAX_CBX_STATES] of Integer
    fontColor       : Array [MAX_CBX_STATES] of Integer
    textAlignment   : Array [MAX_CBX_STATES] of Integer
    textAAliasing   : Array [MAX_CBX_STATES] of Boolean 
    
    { Mechanics }
    lastState       : Integer = CBX_STATE_NORMAL
    isMouseTarget   : Boolean = FALSE
    hook            : String = ""
    
    { Flags }
    toRender        : Boolean = TRUE
    gotLeftClicked  : Boolean = FALSE
    gotRightClicked : Boolean = FALSE     
    
EndType ; Export

Type tbxChars = Record

    { Properties }
    s   : String
    
    { Cached Properties }
    w, h    : Integer    

    { Styles }
    fontName        : String
    fontSize        : Integer
    fontStyle       : Integer
    fontColor       : Integer
     
EndType ; Export

Type textBoxes = Record

    { Properties }
    x, y    : Integer
    w, h    : Integer
    tooltip : String
    e       : Element
    state   : Integer = TBX_STATE_NORMAL
    visible : Boolean = TRUE
    enabled : Boolean = TRUE
    
    { Mechanics }
    cursorPos       : Integer = 1
    selectionLeft   : Integer
    selectionRight  : Integer
    lastState       : Integer
    isMouseTarget   : Boolean = FALSE
    hook            : String = ""

    { Lists }
    tbxCharList   : List of tbxChars
    
    { Flags }
    toRender        : Boolean = TRUE
    password        : Boolean = FALSE
    gotLeftClicked  : Boolean = FALSE
    gotRightClicked : Boolean = FALSE
    gotUpdated      : Boolean = TRUE    
    
EndType ; Export

Type hTexts = Record

    { Properties }
    x, y    : Integer
    w, h    : Integer
    txt     : String
    tooltip : String = ""
    href    : String = ""
    e       : Element
    style   : Integer
    visible : Boolean = TRUE
    enabled : Boolean = TRUE
    
    { Styles }
    fontName        : Array [MAX_TXT_TYPES] of String
    fontSize        : Array [MAX_TXT_TYPES] of Integer
    fontStyle       : Array [MAX_TXT_TYPES] of Integer
    fontColor       : Array [MAX_TXT_TYPES] of Integer
    textAlignment   : Array [MAX_TXT_TYPES] of Integer
    textAAliasing   : Array [MAX_TXT_TYPES] of Boolean 
    
    { Mechanics }
    isMouseTarget   : Boolean = FALSE
    hook            : String = ""
    
    { Flags }
    toRender        : Boolean = TRUE
    gotLeftClicked  : Boolean = FALSE
    gotRightClicked : Boolean = FALSE     
    
EndType ; Export

Type dropOptions = Record

    { Properties }
    name    : String
    state   : Integer = DDB_BOX_STATE_NORMAL
    
    { Mechanics }
    laststate   : Integer = DDB_BOX_STATE_NORMAL
    
EndType ; Export

Type dropDowns = Record

    { Properties }
    x, y    : Integer
    w, h    : Integer
    txt     : String
    tooltip : String = ""
    e       : Element
    ebx     : Element
    state   : Integer = DDB_STATE_NORMAL
    visible : Boolean = TRUE
    enabled : Boolean = TRUE
    
    { Styles }
    fontName        : Array [MAX_DDB_BOX_STATES] of String
    fontSize        : Array [MAX_DDB_BOX_STATES] of Integer
    fontStyle       : Array [MAX_DDB_BOX_STATES] of Integer
    fontColor       : Array [MAX_DDB_BOX_STATES] of Integer
    backColor       : Array [MAX_DDB_BOX_STATES] of Integer
    textAlignment   : Array [MAX_DDB_BOX_STATES] of Integer
    textAAliasing   : Array [MAX_DDB_BOX_STATES] of Boolean
    
    { Mechanics }
    lastState       : Integer = DDB_STATE_NORMAL
    isMouseTarget   : Boolean = FALSE
    hook            : String = ""
    
    { Lists }
    ddbOptionList   : List of dropOptions
    
    { Flags }
    toRender        : Boolean = TRUE
    toRenderBox     : Boolean = TRUE
    toIndex         : Boolean = TRUE
    isDown          : Boolean = FALSE
    gotLeftClicked  : Boolean = FALSE
    gotRightClicked : Boolean = FALSE
    gotUpdated      : Boolean = TRUE     
    
EndType ; Export

Type timers = Record

    { Properties }
    freq    : Integer = 1000
    method  : Integer = TMR_METHOD_MILLISECS 
    enabled : Boolean = TRUE
    
    { Mechanics }
    hook            : String = ""
    startTime       : Integer
    
    { Flags }
    toSync          : Boolean = TRUE
    gotActivated    : Boolean = FALSE    
    
EndType ; Export

Type tabs = Record

    { Properties }
    x, y    : Integer
    w, h    : Integer
    txt     : String
    tooltip : String
    e       : Element
    state   : Integer = TAB_STATE_INACTIVE
    selected: Boolean = FALSE
    visible : Boolean = TRUE
    enabled : Boolean = TRUE
    
    { Styles }
    fontName        : Array [MAX_TAB_STATES] of String
    fontSize        : Array [MAX_TAB_STATES] of Integer
    fontStyle       : Array [MAX_TAB_STATES] of Integer
    fontColor       : Array [MAX_TAB_STATES] of Integer
    textAlignment   : Array [MAX_TAB_STATES] of Integer
    textAAliasing   : Array [MAX_TAB_STATES] of Boolean 
    
    { Mechanics }
    lastState       : Integer = TAB_STATE_INACTIVE
    isMouseTarget   : Boolean = FALSE
    hook            : String = ""
    
    { Flags }
    toRender        : Boolean = TRUE
    gotLeftClicked  : Boolean = FALSE
    gotRightClicked : Boolean = FALSE     
    
EndType ; Export

Type tabGroups = Record

    { Properties }
    x, y    : Integer = 0
    visible : Boolean = TRUE
    enabled : Boolean = TRUE

    { Element List }
    grpTabList : List of tabs
    
    { Mechanics }
    hook            : String = ""
    
EndType ; Export

Type frames = Record

    { Properties }
    x, y    : Integer
    w, h    : Integer
    txt     : String
    e       : Element
    visible : Boolean = TRUE
    style   : Integer

    { Styles }
    fontName        : Array [MAX_FRA_STYLES] of String
    fontSize        : Array [MAX_FRA_STYLES] of Integer
    fontStyle       : Array [MAX_FRA_STYLES] of Integer
    fontColor       : Array [MAX_FRA_STYLES] of Integer
    textAlignment   : Array [MAX_FRA_STYLES] of Integer
    textAAliasing   : Array [MAX_FRA_STYLES] of Boolean
    
    { Mechanics }
    hook            : String = ""

    { Flags }
    toRender        : Boolean = TRUE
    
EndType ; Export

Type listOptions = Record

    { Properties }
    name    : String
    state   : Integer = LBX_ITEM_STATE_NORMAL
    
    { Styles}
    fontColor       : Array [MAX_LBX_ITEM_STATES] of Integer
    fontStyle       : Array [MAX_LBX_ITEM_STATES] of Integer

EndType ; export

Type scrollBars = Record

    { Properties }
    e       : Element
    x, y    : Integer = 0
    w, h    : Integer = 0
    visible : Boolean = TRUE
    enabled : Boolean = TRUE
    state   : Integer = SBR_STATE_NORMAL
    
    { Scroll }
    sbrOffset       : Integer = 0
    sbrLastOffset   : Integer = -1
    sbrLength       : Integer = 0
    mWheel          : Integer = 0
    scrollTarget    : Element = NULL
    scrollSpeed     : Integer = 1
    
    { Mechanics }
    lastOffset      : Integer = 0
    hook            : String = ""
    
    { Parts }
    stateUp         : Integer = SBR_STATE_NORMAL
    stateDown       : Integer = SBR_STATE_NORMAL
    stateSlider     : Integer = SBR_STATE_NORMAL   
    
    { Flags }
    toRender        : Boolean = TRUE
    gotLeftClicked  : Boolean = FALSE
    gotRightClicked : Boolean = FALSE
    gotUpdated      : Boolean = FALSE
    

EndType ; export

Type listBoxes = Record

    { Properties }
    x, y    : Integer
    w, h    : Integer
    scrolly : Integer = 0
    tooltip : String
    e       : Element
    state   : Integer = LBX_STATE_NORMAL
    visible : Boolean = TRUE
    enabled : Boolean = TRUE
    
    { ScrollBar }
    sbr     : ^scrollBars
    
    { Lists }
    lbxOptionList   : List of listOptions

    { Styles }
    fontName        : Array [MAX_LBX_ITEM_STATES] of String
    fontSize        : Array [MAX_LBX_ITEM_STATES] of Integer
    fontStyle       : Array [MAX_LBX_ITEM_STATES] of Integer
    fontColor       : Array [MAX_LBX_ITEM_STATES] of Integer
    backColor       : Array [MAX_LBX_ITEM_STATES] of Integer
    textAlignment   : Array [MAX_LBX_ITEM_STATES] of Integer
    textAAliasing   : Array [MAX_LBX_ITEM_STATES] of Boolean
    
    { Options }
    optionSelected  : ^listOptions
    
    { Mechanics }
    isMouseTarget   : Boolean = FALSE
    lastState       : Integer
    hook            : String = ""
    
    { Flags }
    toRender        : Boolean = TRUE
    gotLeftClicked  : Boolean = FALSE
    gotRightClicked : Boolean = FALSE
    gotUpdated      : Boolean = FALSE  
    
EndType ; Export

Type forms = Record

    { Properties }
    name    : String
    x, y    : Integer = 0
    visible : Boolean = TRUE
    enabled : Boolean = TRUE

    { Element Lists }   
    frmFormList         : List of forms
    frmButtonList       : List of buttons
    frmCanvasList       : List of canvases
    frmProgressBarList  : List of progressBars
    frmRadioGroupList   : List of radioGroups
    frmCheckBoxList     : List of checkBoxes
    frmTextBoxList      : List of textBoxes
    frmTextList         : List of hTexts
    frmDropDownList     : List of dropDowns
    frmTimerList        : List of timers
    frmTabGroupList     : List of tabGroups
    frmFrameList        : List of frames
    frmScrollBarList    : List of scrollBars
    frmListBoxList      : List of listBoxes
    frmSliderList       : List of sliders
    
    { Mechanics }
    hook            : String = ""
    
EndType ; Export

Type tileCaches = Record
    eGet    : Integer // (GUI Element Type)
    ePart   : Integer
    eState  : Integer
    w       : Integer
    h       : Integer
    e       : Element
EndType

Type wstrs = Record // Word wrapping
    t: String
EndType

Var
    { Important Globals }
    hag_start           : Integer
    hag_baseDir         : String = "hag\"
    hag_screenw         : Integer = 0
    hag_screenh         : Integer = 0
    hag_hasGuiTheme     : Boolean = FALSE
    hag_errors          : Integer = 0
    hag_elements        : Integer = 0 // count
    hag_index           : Integer = 0 ; Export
    hag_mouse           : Integer = HAG_MOUSE_NORMAL ; Export
    hag_clipboard       : String = "" ; Export
    hag_tooltip         : String = "" ; Export
    
    { Obscurers }
    mtick               : Integer // delay based on dropdowns obscuring elements
    
    { Performance }
    hag_atpu            : Real = -1 // avg time per update
    hag_ram             : Integer

    { Lists and Pointers }
    
        { GUI Elements }
        button              : ^buttons
        buttonList          : List of buttons
        canvas              : ^canvases
        canvasList          : List of canvases
        progressBar         : ^progressBars
        progressBarList     : List of progressBars
        radioGroup          : ^radioGroups
        radioGroupList      : List of radioGroups
        radioButton         : ^radioButtons
        radioButtonList     : List of radioButtons
        checkBox            : ^checkBoxes
        checkBoxList        : List of checkBoxes
        tbxChar             : ^tbxChars
        tbxCharList         : List of tbxChars
        textBox             : ^textBoxes
        textBoxList         : List of textBoxes
        hText               : ^hTexts
        hTextList           : List of hTexts
        dropOption          : ^dropOptions
        dropOptionList      : List of dropOptions
        dropDown            : ^dropDowns
        dropDownList        : List of dropDowns
        timer               : ^timers
        timerList           : List of timers
        tabGroup            : ^tabGroups
        tabGroupList        : List of tabGroups
        tab                 : ^tabs
        tabList             : List of tabs
        frame               : ^frames
        frameList           : List of frames
        listBox             : ^listBoxes
        listBoxList         : List of listBoxes
        listOption          : ^listOptions
        listOptionList      : List of listOptions
        scrollBar           : ^scrollBars
        scrollBarList       : List of scrollBars
        slider              : ^sliders
        sliderList          : List of sliders
        
        { Form }    
        form                : ^forms
        formList            : List of forms

        { Misc }    
        tileCache           : ^tileCaches
        tileCacheList       : List of tileCaches
        wstr                : ^wstrs
        wstrl               : List of wstrs
    
    { Preferneces }
    hag_prefEnable      : Array [MAX_PREF_ENABLES] of Boolean   ; Export

    { GUI Template Elements }
    gte_button          : Array [MAX_BTN_PARTS,     MAX_BTN_STATES]     of Element
    gte_progressBar     : Array [MAX_PROG_PARTS,    MAX_PROG_STATES]    of Element
    gte_radioButton     : Array [MAX_RDO_STATES]    of Element
    gte_checkBox        : Array [MAX_CBX_STATES]    of Element
    gte_tab             : Array [MAX_TAB_PARTS,     MAX_TAB_STATES]     of Element
    gte_frame           : Array [MAX_FRA_PARTS,     MAX_FRA_STYLES]     of Element
    gte_textBox         : Array [MAX_TBX_PARTS,     MAX_TBX_STATES]     of Element
    gte_dropdown        : Array [MAX_DDB_PARTS,     MAX_DDB_STATES]     of Element
    gte_dropdownbox     : Array [MAX_DDB_BOX_PARTS] of Element
    gte_listBox         : Array [MAX_LBX_PARTS,     MAX_LBX_STATES]     of Element
    gte_scrollBar       : Array [MAX_SBR_PARTS,     MAX_SBR_STATES]     of Element
    gte_slider          : Array [MAX_SLI_PARTS,     MAX_SLI_SLIDER_STATES] of Element

    { Styles }
    fontName        : Array [MAX_GETS,MAX_STATES] of String
    fontSize        : Array [MAX_GETS,MAX_STATES] of Integer
    fontStyle       : Array [MAX_GETS,MAX_STATES] of Integer
    fontColor       : Array [MAX_GETS,MAX_STATES] of Integer
    backColor       : Array [MAX_GETS,MAX_STATES] of Integer
    textAlignment   : Array [MAX_GETS,MAX_STATES] of Integer
    textAAliasing   : Array [MAX_GETS,MAX_STATES] of Boolean
    
    { Textbox Styles }
    tbxDisabled_fontColor : Integer
    tbxSelection_fontColor : Integer
    tbxSelection_backColor : Integer
    tbx_cursorColor : Integer 
    tbx_cursorWidth : Integer
    tbx_cursorHeight : Integer
    tbx_cursorTimer : Integer
    tbx_cursorState : Boolean
    tbx_pointerWidth : Integer
    
    { Drop Downs }
    dropDown_above_yoffset : Integer
    dropDown_below_yoffset : Integer 
    
    { Misc }
    log_indent      : Integer = 1






Function CreateForm(name:String="Untitled") : ^forms ; Export
{
    Creates an (invisible) form to attach gui elements to, and returns
    a pointer.
}
Begin
    Inc(hag_elements)

    form = NewItem(formList)
    If Assigned(form)
    
        form.name = name
        
         HagLog(LOG_DEBUG,"CreateForm: Created a form: '"+name+"'")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateForm: ('"+name+"') Assignment Error - out of memory?")
    EndIf
    
    Result = form
    
End

Function CreateChildForm(frm: ^forms, name:String="Untitled") : ^forms ; Export
{
    Creates an (invisible) form to attach gui elements to, and returns
    a pointer.
}
Begin
    Inc(hag_elements)

    form = NewItem(frm.frmFormList)
    If Assigned(form)
    
        form.name = name
        
         HagLog(LOG_DEBUG,"CreateChildForm: Created a form: '"+name+"'")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateChildForm: ('"+name+"') Assignment Error - out of memory?")
    EndIf
    
    Result = form
    
End

Function CreateButton(frm:^forms, x:Integer, y:Integer, w:Integer, txt:String, tooltip:String="") : ^buttons ; Export
{
    Creates a button, attaches it to a form and returns a pointer
}
Var
    i: Integer
Begin
    Inc(hag_elements)

    button = NewItem(frm.frmButtonList)
    If Assigned(button)
    
        button.x = x
        button.y = y
        button.w = w
        button.h = ImageHeight(gte_button[BTN_PART_MID,BTN_STATE_NORMAL])
        button.txt = txt
        button.tooltip = tooltip
        button.e = CreateGuiSprite(button.x,button.y,button.w,button.h,TRUE)

        SpriteIndex(button.e,hag_index)
        Inc(hag_index)
                
        For i = 0 to (MAX_BTN_STATES-1)
            button.fontName[i]      = fontName[GET_BUTTON,i]
            button.fontSize[i]      = fontSize[GET_BUTTON,i]
            button.fontStyle[i]     = fontStyle[GET_BUTTON,i]
            button.fontColor[i]     = fontColor[GET_BUTTON,i]
            button.textAlignment[i] = textAlignment[GET_BUTTON,i]
            button.textAAliasing[i] = textAAliasing[GET_BUTTON,i]
        Next        
        
         HagLog(LOG_DEBUG,"CreateButton: Created a button: '"+txt+"' (form: '"+form.name+"')")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateButton: (form: "+form.name+") Assignment Error - out of memory?")
    EndIf
        
    Result = button
    
End

Function CreateCanvas(frm:^forms, x:Integer, y:Integer, w:Integer, h:Integer, tooltip:String="") : ^canvases ; Export
{
    Creates a canvas, attaches it to a form and returns a pointer
}
Var
    i: Integer
Begin
    Inc(hag_elements)

    canvas = NewItem(frm.frmCanvasList)
    If Assigned(canvas)
    
        canvas.x = x
        canvas.y = y
        canvas.w = w
        canvas.h = h
        canvas.tooltip = tooltip
        canvas.e = CreateGuiSprite(canvas.x,canvas.y,canvas.w,canvas.h,TRUE)

        SpriteIndex(canvas.e,hag_index)
        Inc(hag_index)        
        
         HagLog(LOG_DEBUG,"CreateCanvas: Created a canvas at "+x+", "+y+", measuring "+w+", "+h+", (form: '"+form.name+"')")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateCanvas: (form: "+form.name+") Assignment Error - out of memory?")
    EndIf
        
    Result = canvas
    
End

Function CreateProgressBar(frm:^forms, x:Integer, y:Integer, l:Integer, ori:Integer=HAG_HORIZONTAL, tooltip:String="") : ^progressBars ; Export
{
    Creates a progress bar, attaches it to a form and returns a pointer
}
Begin
    Inc(hag_elements)

    progressBar = NewItem(frm.frmProgressBarList)
    If Assigned(progressBar)
    
        progressBar.x = x
        progressBar.y = y
        If ori = HAG_HORIZONTAL then
            progressBar.w = l
            progressBar.h = ImageHeight(gte_progressBar[PROG_PART_MID, PROG_STATE_HORIZ])
        Else
            progressBar.w = ImageWidth(gte_progressBar[PROG_PART_MID, PROG_STATE_VERT])
            progressBar.h = l
        Endif 
        progressBar.tooltip = tooltip
        progressBar.state = ori
        progressBar.e = CreateGuiSprite(progressBar.x,progressBar.y,progressBar.w,progressBar.h,TRUE)
        
        SpriteIndex(progressBar.e,hag_index)
        Inc(hag_index)      
        
         HagLog(LOG_DEBUG,"CreateProgressBar: Created a ProgressBar: ("+ToString(x)+" by "+ToString(y)+", form: '"+form.name+"')")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateProgressBar: (form: "+form.name+") Assignment Error - out of memory?")
    EndIf
        
    Result = progressBar
    
End

Function CreateSlider(frm:^forms, x:Integer, y:Integer, l:Integer, divisions: Integer = 0, ori:Integer=HAG_HORIZONTAL, tooltip:String="") : ^sliders ; Export
{
    Creates a slider, attaches it to a form and returns a pointer
}
Begin
    Inc(hag_elements)

    slider = NewItem(frm.frmSliderList)
    If Assigned(slider)
    
        slider.x = x
        slider.y = y
        If ori = HAG_HORIZONTAL then
            slider.w = l
            slider.h = ImageHeight(gte_slider[SLI_PART_MID, SLI_STATE_HORIZ])
        Else
            slider.w = ImageWidth(gte_slider[SLI_PART_MID, SLI_STATE_VERT])
            slider.h = l
        Endif
        slider.tooltip = tooltip
        slider.state = ori
        slider.sliDivisions = divisions
        slider.e = CreateGuiSprite(slider.x,slider.y,slider.w,slider.h,TRUE)
        
        SpriteIndex(slider.e,hag_index)
        Inc(hag_index)      
        
         HagLog(LOG_DEBUG,"CreateSlider: Created a Slider: ("+ToString(x)+" by "+ToString(y)+", form: '"+form.name+"')")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateSlider: (form: "+form.name+") Assignment Error - out of memory?")
    EndIf
        
    Result = slider
    
End

Function CreateRadioGroup(frm: ^forms) : ^radioGroups ; Export
{
    Creates an (invisible) group to attach radio buttons to, and returns
    a pointer.
}
Begin
    Inc(hag_elements)

    radioGroup = NewItem(frm.frmRadioGroupList)
    If Assigned(radioGroup)
         HagLog(LOG_DEBUG,"CreateRadioGroup: (form: '"+form.name+"')")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateRadioGroup: (form '"+form.name+"') Assignment Error - out of memory?")
    EndIf
    
    Result = radioGroup
    
End

Function CreateRadioButton(grp: ^radioGroups, x:Integer, y:Integer, w:Integer, txt:String, selected:Boolean=FALSE, tooltip:String="") : ^radioButtons ; Export
{
    Creates a radio button, attaches it to a radio group attached to a form,
    and returns a pointer.
}
Var
    i: Integer
Begin
    Inc(hag_elements)

    radioButton = NewItem(grp.grpRadioButtonList)
    If Assigned(radioButton)

        radioButton.x = x
        radioButton.y = y
        radioButton.w = w
        radioButton.h = ImageHeight(gte_radioButton[RDO_STATE_NORMAL])
        radioButton.txt = txt
        radioButton.tooltip = tooltip
        radioButton.selected = selected
        radioButton.e = CreateGuiSprite(radioButton.x,radioButton.y,radioButton.w,radioButton.h,TRUE)
        
        SpriteIndex(radioButton.e,hag_index)
        Inc(hag_index)
        
        For i = 0 to (MAX_RDO_STATES-1)
            radioButton.fontName[i]      = fontName[GET_RADIOBUTTON,i]
            radioButton.fontSize[i]      = fontSize[GET_RADIOBUTTON,i]
            radioButton.fontStyle[i]     = fontStyle[GET_RADIOBUTTON,i]
            radioButton.fontColor[i]     = fontColor[GET_RADIOBUTTON,i]
            radioButton.textAlignment[i] = textAlignment[GET_RADIOBUTTON,i]
            radioButton.textAAliasing[i] = textAAliasing[GET_RADIOBUTTON,i]
        Next 

         HagLog(LOG_DEBUG,"CreateRadioButton: Created a radio button: '"+txt+"'")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateRadioButton: Assignment Error - out of memory?")
    EndIf
    
    Result = radioButton
    
End

Function CreateCheckBox(frm: ^forms, x:Integer, y:Integer, w:Integer, txt:String, checked:Boolean=FALSE, tooltip:String="") : ^checkBoxes ; Export
{
    Creates a check box, attaches it to a form, and returns a pointer.
}
Var
    i: Integer
Begin
    Inc(hag_elements)

    checkBox = NewItem(frm.frmCheckBoxList)
    If Assigned(checkBox)

        checkBox.x = x
        checkBox.y = y
        checkBox.w = w
        checkBox.h = ImageHeight(gte_checkBox[CBX_STATE_NORMAL])
        checkBox.txt = txt
        checkBox.tooltip = tooltip
        checkBox.checked = checked
        checkBox.e = CreateGuiSprite(checkBox.x,checkBox.y,checkBox.w,checkBox.h,TRUE)
        
        SpriteIndex(checkBox.e,hag_index)
        Inc(hag_index)
        
        For i = 0 to (MAX_CBX_STATES-1)
            checkBox.fontName[i]      = fontName[GET_CHECKBOX,i]
            checkBox.fontSize[i]      = fontSize[GET_CHECKBOX,i]
            checkBox.fontStyle[i]     = fontStyle[GET_CHECKBOX,i]
            checkBox.fontColor[i]     = fontColor[GET_CHECKBOX,i]
            checkBox.textAlignment[i] = textAlignment[GET_CHECKBOX,i]
            checkBox.textAAliasing[i] = textAAliasing[GET_CHECKBOX,i]
        Next 

         HagLog(LOG_DEBUG,"CreateCheckBox: Created a checkbox: '"+txt+"' (form: '"+form.name+"')")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateCheckBox: Assignment Error - out of memory?")
    EndIf
    
    Result = checkBox
    
End

Function CreateTextBox(frm: ^forms, x:Integer, y:Integer, w:Integer, txt:String, tooltip:String="") : ^textBoxes ; Export
{
    Creates a text box, attaches it to a form, and returns a pointer.
}
Begin
    Inc(hag_elements)

   textBox = NewItem(frm.frmTextBoxList)
    If Assigned(textBox)

        textBox.x = x
        textBox.y = y
        textBox.w = w
        textBox.h = ImageHeight(gte_textBox[TBX_PART_MID, TBX_STATE_NORMAL])
        textBox.tooltip = tooltip
        textBox.e = CreateGuiSprite(textBox.x,textBox.y,textBox.w,textBox.h,TRUE)
        
        SpriteIndex(textBox.e,hag_index)
        Inc(hag_index)
        
        TextBoxInit(textBox)
        TextBoxAppendText(textBox,txt)

         HagLog(LOG_DEBUG,"CreateTextBox: Created a textbox: '"+txt+"' (form: '"+form.name+"')")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateTextBox: Assignment Error - out of memory?")
    EndIf
    
    Result = textBox
    
End


Function CreatePasswordBox(frm: ^forms, x:Integer, y:Integer, w:Integer, txt:String, tooltip:String="") : ^textBoxes ; Export
Begin
    
    result = CreateTextBox(frm,x,y,w,txt,tooltip)
    result.password = TRUE
    
End

Function CreateText(frm: ^forms, x:Integer, y:Integer, txt:String, w:Integer=-1, h:Integer=-1, ttype:Integer=TXT_TYPE_NORMAL, tooltip:String="") : ^hTexts ; Export
{
    Creates a hag Text element, attaches it to a form, and returns a pointer.
}
Var
    i: Integer
Begin
    Inc(hag_elements)

    hText = NewItem(frm.frmTextList)
    If Assigned(hText)

        hText.x = x
        hText.y = y
        hText.txt = txt
        hText.tooltip = tooltip
        hText.style = ttype
        
        For i = 0 to (MAX_TXT_TYPES-1)
            hText.fontName[i]      = fontName[GET_TEXT,i]
            hText.fontSize[i]      = fontSize[GET_TEXT,i]
            hText.fontStyle[i]     = fontStyle[GET_TEXT,i]
            hText.fontColor[i]     = fontColor[GET_TEXT,i]
            hText.textAlignment[i] = textAlignment[GET_TEXT,i]
            hText.textAAliasing[i] = textAAliasing[GET_TEXT,i]
        Next 

        hText.e = CreateGuiSprite(0,0,16,16,TRUE)
        
        { Auto Text Size }
        If (w = -1) or (h = -1) then
            SetFont(hText.fontName[ttype],hText.fontSize[ttype],hText.fontStyle[ttype],hText.e)
            If hText.textAAliasing[ttype] then AADraw(1)

            If (w > -1) and (h = -1) then
                h = TextWrap(0,0,w,hText.e,0,txt)
            Else
                If h = -1 then h = TextHeight(txt,hText.e)
            Endif             
            If w = -1 then w = TextWidth(txt,hText.e)
            
            If hText.textAAliasing[ttype] then AADraw(0)
        Endif
        
        FreeSprite(hText.e)
        hText.w = w
        hText.h = h
        hText.e = CreateGuiSprite(hText.x,hText.y,hText.w,hText.h,TRUE)

        SpriteIndex(hText.e,hag_index)
        Inc(hag_index)        

         HagLog(LOG_DEBUG,"CreateText: Created a hText element: '"+txt+"' (form: '"+form.name+"')")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateText: Assignment Error - out of memory?")
    EndIf
    
    Result = hText
    
End

Function CreateDropDown(frm: ^forms, x:Integer, y:Integer, w:Integer, txt:String, tooltip:String="") : ^dropDowns ; Export
{
    Creates a DropDown element, attaches it to a form, and returns a pointer.
}
Var
    i: Integer
Begin
    Inc(hag_elements)

    dropDown = NewItem(frm.frmDropDownList)
    If Assigned(dropDown)

        dropDown.x = x
        dropDown.y = y
        dropDown.w = w
        dropDown.h = ImageHeight(gte_dropDown[DDB_PART_MID, DDB_STATE_NORMAL])
        dropDown.txt = txt
        dropDown.tooltip = tooltip
        
        For i = 0 to (MAX_DDB_BOX_STATES-1)
            dropDown.fontName[i]      = fontName[GET_DROPDOWN,i]
            dropDown.fontSize[i]      = fontSize[GET_DROPDOWN,i]
            dropDown.fontStyle[i]     = fontStyle[GET_DROPDOWN,i]
            dropDown.fontColor[i]     = fontColor[GET_DROPDOWN,i]
            dropDown.backColor[i]     = backColor[GET_DROPDOWN,i]
            dropDown.textAlignment[i] = textAlignment[GET_DROPDOWN,i]
            dropDown.textAAliasing[i] = textAAliasing[GET_DROPDOWN,i]
        Next 

        dropDown.e = CreateGuiSprite(dropDown.x,dropDown.y,dropDown.w,dropDown.h,TRUE)
        dropDown.ebx = CreateGuiSprite(dropDown.x,dropDown.y,16,16,TRUE)
        SpriteVisible(dropDown.ebx,FALSE)

        SpriteIndex(dropDown.e,hag_index)
        Inc(hag_index)        

         HagLog(LOG_DEBUG,"CreateDropDown: Created a drop down element: '"+txt+"' (form: '"+form.name+"')")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateDropDown: Assignment Error - out of memory?")
    EndIf
    
    Result = dropDown
    
End

Function CreateListBox(frm: ^forms, x:Integer, y:Integer, w:Integer, h:Integer, tooltip:String="") : ^listBoxes ; Export
{
    Creates a ListBox element, attaches it to a form, and returns a pointer.
}
Var
    i: Integer
    ofsx, ofsy: Integer
Begin
    Inc(hag_elements)

    listBox = NewItem(frm.frmListBoxList)
    If Assigned(listBox)

        listBox.x = x
        listBox.y = y
        listBox.w = w
        listBox.h = h
        listBox.tooltip = tooltip
        
        For i = MAX_LBX_STATES to (MAX_LBX_ITEM_STATES-1)
            listBox.fontName[i]      = fontName[GET_LISTBOX,i]
            listBox.fontSize[i]      = fontSize[GET_LISTBOX,i]
            listBox.fontStyle[i]     = fontStyle[GET_LISTBOX,i]
            listBox.fontColor[i]     = fontColor[GET_LISTBOX,i]
            listBox.backColor[i]     = backColor[GET_LISTBOX,i]
            listBox.textAlignment[i] = textAlignment[GET_LISTBOX,i]
            listBox.textAAliasing[i] = textAAliasing[GET_LISTBOX,i]
        Next 

        listBox.e = CreateGuiSprite(listBox.x,listBox.y,listBox.w,listBox.h,TRUE)

        SpriteIndex(listBox.e,hag_index)
        Inc(hag_index)
        
        ofsx = ImageWidth(gte_listBox[LBX_PART_MID_RIGHT, LBX_STATE_NORMAL])
        ofsy = ImageHeight(gte_listBox[LBX_PART_TOP_MID, LBX_STATE_NORMAL])        
        listBox.sbr = CreateScrollBar(frm, listBox.x + listBox.w - ofsx, listBox.y + ofsy, listBox.h - (ofsy * 2))
        SetScrollBarMouseWheelTargetElement(listBox.sbr, listBox.e)        

         HagLog(LOG_DEBUG,"CreateListBox: Created a list box element (form: '"+form.name+"')")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateListBox: Assignment Error - out of memory?")
    EndIf
    
    Result = listBox
    
End

Function CreateScrollbar(frm:^forms, x:Integer, y:Integer, h:Integer) : ^scrollBars ; Export
{
    Creates a scrollbar, attaches it to a form, and returns a pointer
}
Var
    i: Integer
Begin
    Inc(hag_elements)

    scrollBar = NewItem(frm.frmScrollBarList)
    If Assigned(scrollBar)
    
        scrollBar.w = ImageWidth(gte_scrollbar[SBR_PART_BAR, SBR_STATE_NORMAL])
        scrollBar.h = h
        scrollBar.x = x - scrollBar.w
        scrollBar.y = y
        scrollBar.e = CreateGuiSprite(scrollBar.x,scrollBar.y,scrollBar.w,scrollBar.h,FALSE)
        
        scrollBar.mWheel = MouseWheel()
        
        SpriteIndex(scrollBar.e,hag_index)
        Inc(hag_index)       
        
         HagLog(LOG_DEBUG,"CreateScrollBar: Created a scrollbar: ("+ToString(scrollBar.x)+" by "+ToString(scrollBar.y)+", dimensions "+scrollBar.w+" by "+scrollBar.h+" form: '"+form.name+"')")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateScrollBar: (form: "+form.name+") Assignment Error - out of memory?")
    EndIf
        
    Result = scrollBar
    
End

Function CreateHyperlink(frm: ^forms, x:Integer, y:Integer, txt:String, href:String) : ^hTexts ; Export
Begin
    result = CreateText(frm,x,y,txt,-1,-1,TXT_TYPE_HREF)
    result.href = href
    result.tooltip = href
End

Function CreateTimer(frm: ^forms, freq:Integer = 1000, method:Integer=TMR_METHOD_MILLISECS) : ^timers ; Export
{
    Creates a timer, attaches it to a form, and returns a pointer.
}
Begin
    Inc(hag_elements)

    timer = NewItem(frm.frmTimerList)
    If Assigned(timer)

        timer.freq = freq
        timer.method = method     

         HagLog(LOG_DEBUG,"CreateTimer: Created a timer: '"+ToString(freq)+"','"+ToString(method)+"' (form: '"+form.name+"')")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateTimer: Assignment Error - out of memory?")
    EndIf
    
    Result = timer
    
End

Function CreateTabGroup(frm: ^forms) : ^tabGroups ; Export
{
    Creates an (invisible) group to attach tabs to, and returns
    a pointer.
}
Begin
    Inc(hag_elements)

    tabGroup = NewItem(frm.frmTabGroupList)
    If Assigned(tabGroup)
         HagLog(LOG_DEBUG,"CreateTabGroup: (form: '"+form.name+"')")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateTabGroup: (form '"+form.name+"') Assignment Error - out of memory?")
    EndIf
    
    Result = tabGroup
    
End

Function CreateTab(grp: ^tabGroups, x:Integer, y:Integer, w:Integer, txt:String, selected:Boolean=FALSE, tooltip:String="") : ^tabs ; Export
{
    Creates a tab, attaches it to a tab group attached to a form,
    and returns a pointer.
}
Var
    i: Integer
Begin
    Inc(hag_elements)

    tab = NewItem(grp.grpTabList)
    If Assigned(tab)

        tab.x = x
        tab.y = y
        tab.w = w
        tab.h = ImageHeight(gte_tab[TAB_PART_MID, TAB_STATE_ACTIVE])
        tab.txt = txt
        tab.tooltip = tooltip
        tab.selected = selected
        If selected then tab.state = TAB_STATE_ACTIVE
        tab.e = CreateGuiSprite(tab.x,tab.y,tab.w,tab.h,TRUE)
        
        SpriteIndex(tab.e,hag_index)
        Inc(hag_index)  
        
        For i = 0 to (MAX_TAB_STATES-1)
            tab.fontName[i]      = fontName[GET_TAB,i]
            tab.fontSize[i]      = fontSize[GET_TAB,i]
            tab.fontStyle[i]     = fontStyle[GET_TAB,i]
            tab.fontColor[i]     = fontColor[GET_TAB,i]
            tab.textAlignment[i] = textAlignment[GET_TAB,i]
            tab.textAAliasing[i] = textAAliasing[GET_TAB,i]
        Next 

         HagLog(LOG_DEBUG,"CreateTab: Created a tab: '"+txt+"'")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateTab: Assignment Error - out of memory?")
    EndIf
    
    Result = tab
    
End

Function CreateFrame(frm:^forms, x:Integer, y:Integer, w:Integer, h:Integer, style:Integer, title:String="") : ^frames ; Export
{
    Creates a frame, attaches it to a form and returns a pointer
}
Var
    i: Integer
Begin
    Inc(hag_elements)

    frame = NewItem(frm.frmFrameList)
    If Assigned(frame)
    
        frame.x = x
        frame.y = y
        frame.w = w
        frame.h = h
        frame.txt = title
        frame.style = style
        frame.e = CreateGuiSprite(frame.x,frame.y,frame.w,frame.h,FALSE)
        
        SpriteIndex(frame.e,hag_index)
        Inc(hag_index)      
        
        For i = 0 to (MAX_FRA_STYLES-1)
            frame.fontName[i]      = fontName[GET_FRAME,i]
            frame.fontSize[i]      = fontSize[GET_FRAME,i]
            frame.fontStyle[i]     = fontStyle[GET_FRAME,i]
            frame.fontColor[i]     = fontColor[GET_FRAME,i]
            frame.textAlignment[i] = textAlignment[GET_FRAME,i]
            frame.textAAliasing[i] = textAAliasing[GET_FRAME,i]
        Next 
        
         HagLog(LOG_DEBUG,"CreateFrame: Created a frame: ("+ToString(x)+" by "+ToString(y)+", form: '"+form.name+"')")
    Else
         HagLog(LOG_ERROR,"FATAL: CreateFrame: (form: "+form.name+") Assignment Error - out of memory?")
    EndIf
        
    Result = frame
    
End

Function CreateGuiSprite(x:Integer, y:Integer, w:Integer, h:Integer, maware:Boolean) : Element
Begin

    result = CreateSprite(w,h)
    CLS(ToRGBA(0,0,255,100),result)
    SpriteX(result,x)
    SpriteY(result,y)
    SpriteMouseAware(result,maware)

End






(* -------------------------------------------------------------------------- *)
(* FORMS *)
(* -------------------------------------------------------------------------- *)

Procedure PositionForm(frm: ^forms, x:Integer, y:Integer) ; Export
{
    Repositions a form, updating the positions of all child elements.
}
Var
    dx, dy: Integer
Begin
     HagLog(LOG_DEBUG,"PositionForm: ("+ToString(x)+","+ToString(y)+") '"+frm.name+"'")

    dx = x - frm.x
    dy = y - frm.y

    Loop form through frm.frmFormList
        PositionForm(form, form.x + dx, form.y + dy)
    EndLoop
    
    Loop button through frm.frmButtonList
        button.x = button.x + dx
        button.y = button.y + dy
        SpriteX(button.e,button.x)
        SpriteY(button.e,button.y)
    EndLoop

    Loop canvas through frm.frmCanvasList
        canvas.x = canvas.x + dx
        canvas.y = canvas.y + dy
        SpriteX(canvas.e,canvas.x)
        SpriteY(canvas.e,canvas.y)
    EndLoop
    
    Loop progressBar through frm.frmProgressBarList
        progressBar.x = progressBar.x + dx
        progressBar.y = progressBar.y + dy
        SpriteX(progressBar.e,progressBar.x)
        SpriteY(progressBar.e,progressBar.y)
    EndLoop

    Loop slider through frm.frmSliderList
        slider.x = slider.x + dx
        slider.y = slider.y + dy
        SpriteX(slider.e,slider.x)
        SpriteY(slider.e,slider.y)
    EndLoop
    
    Loop radioGroup through frm.frmRadioGroupList
        PositionRadioGroup(radioGroup, radioGroup.x + dx, radioGroup.y + dy)
    EndLoop

    Loop checkBox through frm.frmCheckBoxList
        checkBox.x = checkBox.x + dx
        checkBox.y = checkBox.y + dy
        SpriteX(checkBox.e,checkBox.x)
        SpriteY(checkBox.e,checkBox.y)
    EndLoop

    Loop textBox through frm.frmTextBoxList
        textBox.x = textBox.x + dx
        textBox.y = textBox.y + dy
        SpriteX(textBox.e,textBox.x)
        SpriteY(textBox.e,textBox.y)
    EndLoop
    
    Loop hText through frm.frmTextList
        hText.x = hText.x + dx
        hText.y = hText.y + dy
        SpriteX(hText.e,hText.x)
        SpriteY(hText.e,hText.y)
    EndLoop

    Loop dropDown through frm.frmDropDownList
        dropDown.x = dropDown.x + dx
        dropDown.y = dropDown.y + dy
        SpriteX(dropDown.e,dropDown.x)
        SpriteY(dropDown.e,dropDown.y)
        SpriteX(dropDown.ebx,dropDown.x)
        SpriteY(dropDown.ebx,dropDown.y)
    EndLoop

    Loop listBox through frm.frmListBoxList
        listBox.x = listBox.x + dx
        listBox.y = listBox.y + dy
        SpriteX(listBox.e,listBox.x)
        SpriteY(listBox.e,listBox.y)
    EndLoop

    Loop scrollBar through frm.frmScrollBarList
        scrollBar.x = scrollBar.x + dx
        scrollBar.y = scrollBar.y + dy
        SpriteX(scrollBar.e,scrollBar.x)
        SpriteY(scrollBar.e,scrollBar.y)
    EndLoop
    
    Loop tabGroup through frm.frmTabGroupList
        PositionTabGroup(tabGroup, tabGroup.x + dx, tabGroup.y + dy)
    EndLoop
    
    Loop frame through frm.frmFrameList
        frame.x = frame.x + dx
        frame.y = frame.y + dy
        SpriteX(frame.e,frame.x)
        SpriteY(frame.e,frame.y)
    EndLoop

    frm.x = x
    frm.y = y
End

Procedure EnableForm(frm: ^forms, enable:Boolean=TRUE, allChildren:Boolean=FALSE) ; Export
{
    Enables or disables a form for input, optionally updating all child
    elements in the same way.
}
Begin
     HagLog(LOG_DEBUG,"EnableForm: ("+ToString(enable)+") '"+frm.name+"'")
    
    frm.enabled = enable
    
    If allChildren then
            
        Loop form through frm.frmFormList
            ShowForm(form)
        EndLoop
        
        Loop button through frm.frmButtonList
            EnableButton(button,enable)
        EndLoop
        
        Loop canvas through frm.frmCanvasList
            EnableCanvas(canvas,enable)
        EndLoop

        Loop slider through frm.frmSliderList
            EnableSlider(slider,enable)
        EndLoop
        
        Loop radioGroup through frm.frmRadioGroupList
            EnableRadioGroup(radioGroup,enable)
        EndLoop
        
        Loop checkBox through frm.frmCheckBoxList
            EnableCheckBox(checkBox,enable)
        EndLoop

        Loop textBox through frm.frmTextBoxList
            EnableTextBox(textBox,enable)
        EndLoop
        
        Loop hText through frm.frmTextList
            EnableText(hText,enable)
        EndLoop
        
        Loop dropDown through frm.frmDropDownList
            EnableDropDown(dropDown,enable)
        EndLoop
        
        Loop listBox through frm.frmListBoxList
            EnableListBox(listBox,enable)
        EndLoop
        
        Loop scrollBar through frm.frmScrollBarList
            EnableScrollBar(scrollBar,enable)
        EndLoop
        
        Loop tabGroup through frm.frmTabGroupList
            EnableTabGroup(tabGroup,enable)
        EndLoop 
        
    Endif
    
End

Procedure DisableForm(frm: ^forms, allChildren:Boolean=FALSE) ; Export
Begin
    EnableForm(frm, FALSE, allChildren)
End

Procedure ShowForm(frm: ^forms, show:Boolean=TRUE) ; Export
{
    Shows or hides all child elements of a form
}
Begin
     HagLog(LOG_DEBUG,"ShowForm: ("+ToString(show)+") '"+frm.name+"'")

    frm.visible = show
        
    Loop form through frm.frmFormList
        ShowForm(form)
    EndLoop

    Loop button through frm.frmButtonList
        ShowButton(button,show)
    EndLoop

    Loop canvas through frm.frmCanvasList
        ShowCanvas(canvas,show)
    EndLoop
    
    Loop progressBar through frm.frmProgressBarList
        ShowProgressBar(progressBar,show)
    EndLoop

    Loop slider through frm.frmSliderList
        ShowSlider(slider,show)
    EndLoop
    
    Loop radioGroup through frm.frmRadioGroupList
        ShowRadioGroup(radioGroup,show)
    EndLoop
    
    Loop checkBox through frm.frmCheckBoxList
        ShowCheckBox(checkBox,show)
    EndLoop

    Loop textBox through frm.frmTextBoxList
        ShowTextBox(textBox,show)
    EndLoop

    Loop hText through frm.frmTextList
        ShowText(hText,show)
    EndLoop
    
    Loop dropDown through frm.frmDropDownList
        ShowDropDown(dropDown,show)
    EndLoop
    
    Loop listBox through frm.frmListBoxList
        ShowListBox(listBox,show)
    EndLoop  
    
    Loop tabGroup through frm.frmTabGroupList
        ShowTabGroup(tabGroup,show)
    EndLoop
    
    Loop frame through frm.frmFrameList
        ShowFrame(frame,show)
    EndLoop 
    
End

Procedure HideForm(frm: ^forms) ; Export
Begin
    ShowForm(frm,FALSE)
End

Procedure FreeForm(frm:^forms) ; Export
{
    Safely frees a form, clearing all child elements.
}
Begin
     HagLog(LOG_DEBUG,"FreeForm: '"+frm.name+"'")
    Inc(log_indent)
        
        Loop form through frm.frmFormList
            FreeForm(form)
        EndLoop
    
        Loop button through frm.frmButtonList
            FreeButton(button)
        EndLoop

        Loop canvas through frm.frmCanvasList
            FreeCanvas(canvas)
        EndLoop 
       
        Loop progressBar through frm.frmProgressBarList
            FreeProgressBar(progressBar)
        EndLoop

        Loop slider through frm.frmSliderList
            FreeSlider(slider)
        EndLoop
        
        Loop radioGroup through frm.frmRadioGroupList
            FreeRadioGroup(radioGroup)            
        EndLoop
        
        Loop checkBox through frm.frmCheckBoxList
            FreeCheckBox(checkBox)
        EndLoop

        Loop textBox through frm.frmTextBoxList
            FreeTextBox(textBox)
        EndLoop
        
        Loop hText through frm.frmTextList
            FreeText(hText)
        EndLoop
        
        Loop dropDown through frm.frmDropDownList
            FreeDropDown(dropDown)
        EndLoop
        
        Loop listBox through frm.frmListBoxList
            FreeListBox(listBox)
        EndLoop

        Loop scrollBar through frm.frmScrollBarList
            FreeScrollBar(scrollBar)
        EndLoop
        
        Loop timer through frm.frmTimerList
            FreeTimer(timer)
        EndLoop
        
        Loop tabGroup through frm.frmTabGroupList
            FreeTabGroup(tabGroup)            
        EndLoop
        
        Loop frame through frm.frmFrameList
            FreeFrame(frame)
        EndLoop
            
        Free(frm)
    
    Dec(log_indent)
End








(* -------------------------------------------------------------------------- *)
(* BUTTONS *)
(* -------------------------------------------------------------------------- *)

Procedure RenderButton(btn:^buttons)
{
    Renders a complete button of a given state (e.g. hover) to the button canvas
}
Begin
    
     //HagLog(LOG_DEBUG,"RenderButton: '"+btn.txt+"'")
    Inc(log_indent)

        { Clear }
        CLS(ToRGBA(0,0,0,0),btn.e)
        
        { Image }
        DrawImage(gte_button[BTN_PART_LEFT,btn.state],  0, 0, btn.e)
        DrawTiledImage(GET_BUTTON, BTN_PART_MID, btn.state, ImageWidth(gte_button[BTN_PART_LEFT,btn.state]), 0, btn.w - ImageWidth(gte_button[BTN_PART_RIGHT,btn.state]), btn.h, btn.e)
        DrawImage(gte_button[BTN_PART_RIGHT,btn.state], btn.w - ImageWidth(gte_button[BTN_PART_RIGHT,btn.state]), 0, btn.e)
        
        { Image Button }
        If btn.isImageButton then DrawImage(btn.image, btn.w/2 - ImageWidth(btn.image)/2, btn.h/2 - ImageHeight(btn.image)/2, btn.e)

        { Aliasing On? }
        If hag_prefEnable[HAG_PREF_ENABLE_AADRAW] and btn.textAAliasing[btn.state] then AADraw(1)
        
        { Text }
        SetFont(btn.fontName[btn.state],btn.fontSize[btn.state],btn.fontStyle[btn.state],btn.e)
        PenColor(btn.fontColor[btn.state],btn.e)
        JustifiedButtonText(btn)
        AADraw(0)

        { Done! }
        SpriteRefresh(btn.e)
        btn.toRender = FALSE
    
     //HagLog(LOG_DEBUG,"RenderButton: End")
    Dec(log_indent)
End

Procedure PositionButton(btn: ^buttons, x:Integer, y:Integer) ; Export
{
    Repositions a button, updating the sprite and the position variables 
}
Var
    dx, dy: Integer
Begin
     HagLog(LOG_DEBUG,"PositionButton: ("+ToString(x)+","+ToString(y)+") '"+btn.txt+"'")

    dx = x - btn.x
    dy = y - btn.y
    
    btn.x = btn.x + dx
    btn.y = btn.y + dy
    SpriteX(btn.e,btn.x)
    SpriteY(btn.e,btn.y)

End

Procedure ResizeButton(btn: ^buttons, w:Integer) ; Export
{
    Resizes a button 
}
Begin
     HagLog(LOG_DEBUG,"ResizeButton: ("+ToString(btn.w)+" -> "+ToString(w)+") '"+btn.txt+"'")

    FreeSprite(btn.e)
    
    btn.w = w
    btn.e = CreateGuiSprite(btn.x,btn.y,btn.w,btn.h,TRUE)
  
    RenderButton(btn)
End

Procedure ButtonText(btn: ^buttons, txt: String) ; Export
Begin
     HagLog(LOG_DEBUG,"ButtonText: '"+btn.txt+"' --> '"+txt+"'")

    btn.txt = txt
    btn.toRender = TRUE

End

Procedure EnableButton(btn: ^buttons, enable:Boolean=TRUE) ; Export
Begin
     HagLog(LOG_DEBUG,"EnableButton: ("+ToString(enable)+") '"+btn.txt+"'")
    
    btn.enabled = enable
    If enable then
        btn.state = BTN_STATE_NORMAL
    Else
        btn.state = BTN_STATE_DISABLED
    Endif
    btn.toRender = TRUE
End

Procedure DisableButton(btn: ^buttons) ; Export
Begin
    EnableButton(btn,FALSE)
End

Procedure ShowButton(btn: ^buttons, show:Boolean=TRUE) ; Export
{
    Shows or hides a button
}
Begin
     HagLog(LOG_DEBUG,"ShowButton: ("+ToString(show)+") '"+btn.txt+"'")
    
    btn.visible = show
    SpriteVisible(btn.e, show)
End

Procedure HideButton(btn: ^buttons) ; Export
Begin
    ShowButton(btn,FALSE)
End

Procedure FocusButton(btn: ^buttons) ; Export
{
    Proivdes a nice interface to set the button style to focused, so that
    if you hit enter it will activate it.
}
Begin
     HagLog(LOG_DEBUG,"FocusButton: '"+btn.txt+"'")
    
    btn.state = BTN_STATE_FOCUSED
End

Procedure ButtonFontName(btn: ^buttons, name: String) ; Export
{
    Provides a nice interface to update the font name for every state in a
    button element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"ButtonFontName: ("+ToString(name)+") '"+btn.txt+"'")

    For i = 0 to (MAX_BTN_STATES-1)
        btn.fontName[i] = name
    Next
    
    btn.toRender = TRUE
    
End

Procedure ButtonFontSize(btn: ^buttons, size: Integer) ; Export
{
    Provides a nice interface to update the font size for every state in a
    button element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"ButtonFontSize: ("+ToString(size)+") '"+btn.txt+"'")

    For i = 0 to (MAX_BTN_STATES-1)
        btn.fontSize[i] = size
    Next
    
    btn.toRender = TRUE
    
End

Procedure ButtonFontStyle(btn: ^buttons, flags: Integer) ; Export
{
    Provides a nice interface to update the font style for every state in a
    button element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"ButtonFontStyle: ("+ToString(flags)+") '"+btn.txt+"'")

    For i = 0 to (MAX_BTN_STATES-1)
        btn.fontStyle[i] = flags
    Next
    
    btn.toRender = TRUE
    
End

Procedure ButtonFontColor(btn: ^buttons, rgba: Integer) ; Export
{
    Provides a nice interface to update the font colour for every state in a
    button element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"ButtonFontColor: ("+ToString(rgba)+") '"+btn.txt+"'")

    For i = 0 to (MAX_BTN_STATES-1)
        btn.fontColor[i] = rgba
    Next
    
    btn.toRender = TRUE
    
End

Procedure ButtonFontColour(btn: ^buttons, rgba: Integer) ; Export
Begin
    ButtonFontColor(btn,rgba)
End

Procedure ButtonTextAlignment(btn: ^buttons, align: Integer) ; Export
{
    Provides a nice interface to update the textalignment for every state in a
    button element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"ButtonTextAlignment: ("+ToString(align)+") '"+btn.txt+"'")

    For i = 0 to (MAX_BTN_STATES-1)
        btn.textAlignment[i] = align
    Next
    
    btn.toRender = TRUE
    
End

Procedure ButtonTextAAliasing(btn: ^buttons, aa: Boolean) ; Export
{
    Provides a nice interface to update the Text AntiAlias level for every state
    in a button element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"ButtonTextAAliasing: ("+ToString(aa)+") '"+btn.txt+"'")

    For i = 0 to (MAX_BTN_STATES-1)
        btn.textAAliasing[i] = aa
    Next
    
    btn.toRender = TRUE
    
End

Procedure ImageButton(btn: ^buttons, img:Element) ; Export
{
    Provides a nice interface to create an image button.
    
    Note that the img element should be unique for each button (not a shared
    pointer), so either pass an image handle that won't be used again or call
    this procedure as ButtonImage(mybutton, LoadImage("foobar.png"))
}
Begin
     HagLog(LOG_DEBUG,"ButtonImage: '"+btn.txt+"'")

    If img = NULL then
        HagLog(LOG_ERROR,"WARNING: ButtonImage: ('"+btn.txt+"') Image element is NULL.")
        img = CreateImage(25,25)
        CLS(ToRGBA(255,128,0),img)
    Endif
    
    btn.isImageButton = TRUE
    btn.image = img
End

Function ButtonClicked(btn: ^buttons) : Boolean ; Export
Begin
    result = ButtonLeftClicked(btn)
End

Function ButtonLeftClicked(btn: ^buttons) : Boolean ; Export
Begin
    result = btn.gotLeftClicked
    btn.gotLeftClicked = FALSE
End

Function ButtonRightClicked(btn: ^buttons) : Boolean ; Export
Begin
    result = btn.gotRightClicked
    btn.gotRightClicked = FALSE
End

Function ButtonDown(btn: ^buttons) : Boolean ; Export
Begin
    result = (btn.state = BTN_STATE_ACTIVE)
End

Procedure FlushButton(btn: ^buttons) ; Export
{
    Provides a nice interface to reset the button click flags
}
Begin
    HagLog(LOG_DEBUG,"FlushButton")
    
    btn.state = BTN_STATE_NORMAL
    btn.gotLeftClicked = FALSE
    btn.gotRightClicked = FALSE
End

Procedure JustifiedButtonText(btn:^buttons)
{
    Renders Text of a given justification to a button canvas
}
Begin

    Case btn.textAlignment[btn.state] of
    
        (HAG_TEXT_LEFT):
            Text(ImageWidth(gte_button[BTN_PART_LEFT,btn.state]), Ceil(0.0 + btn.h/2.0 - TextHeight(btn.txt,btn.e)/2.0)-1, btn.txt, btn.e)
            
        (HAG_TEXT_CENTER):
            Text(btn.w/2 - TextWidth(btn.txt,btn.e)/2, Ceil(0.0 + btn.h/2.0 - TextHeight(btn.txt,btn.e)/2.0) -1, btn.txt, btn.e)
            
        (HAG_TEXT_RIGHT):
            Text(btn.w - ImageWidth(gte_button[BTN_PART_RIGHT,btn.state]) - TextWidth(btn.txt,btn.e), Ceil(0.0 + btn.h/2.0 - TextHeight(btn.txt,btn.e)/2.0)-1, btn.txt, btn.e)

        Default:
             HagLog(LOG_ERROR,"WARNING: JustifiedButtonText: The type of text-alignment '"+ToString(btn.textAlignment[btn.state])+"' is not implemented.")
                    
    EndCase
    
End

Procedure FreeButton(btn:^buttons) ; Export
{
    Safely frees a button.
}
Begin
     HagLog(LOG_DEBUG,"FreeButton: '"+btn.txt+"'")
    
    FreeSprite(btn.e)
    If btn.isImageButton then FreeImage(btn.image)
    Free(btn)
    
End








(* -------------------------------------------------------------------------- *)
(* CANVAS *)
(* -------------------------------------------------------------------------- *)



Procedure EnableCanvas(cvs: ^canvases, enable:Boolean=TRUE) ; Export
Begin
     HagLog(LOG_DEBUG,"EnableCanvas: ("+ToString(enable)+")")
    
    cvs.enabled = enable
End

Procedure DisableCanvas(cvs: ^canvases) ; Export
Begin
    EnableCanvas(cvs,FALSE)
End

Procedure ShowCanvas(cvs: ^canvases, show:Boolean=TRUE) ; Export
{
    Shows or hides a canvas
}
Begin
     HagLog(LOG_DEBUG,"ShowCanvas: ("+ToString(show)+")")
    
    cvs.visible = show
    SpriteVisible(cvs.e, show)
End

Procedure HideCanvas(cvs: ^canvases) ; Export
Begin
    ShowCanvas(cvs,FALSE)
End

Procedure FreeCanvas(cvs: ^canvases) ; Export
Begin
    HagLog(LOG_DEBUG,"FreeCanvas:")
    
    FreeSprite(cvs.e)
    Free(cvs)
End








(* -------------------------------------------------------------------------- *)
(* PROGRESS BARS *)
(* -------------------------------------------------------------------------- *)

Procedure RenderProgressBar(prg:^progressBars)
{
    Renders a complete progress bar of a given state (e.g. horizontal/verical)
    to the canvas
}
Var
    imgpercentH, imgpercentV: Integer = 0
Begin
    
     //HagLog(LOG_DEBUG,"RenderProgressBar")
    Inc(log_indent)

        { Clear }
        CLS(ToRGBA(0,0,0,0),prg.e)
        
        If prg.percent > 0 then
            imgpercentH = ToInt(ToReal(prg.w - ImageWidth(gte_progressBar[PROG_PART_LEFT,prg.state]) - ImageWidth(gte_progressBar[PROG_PART_RIGHT,prg.state])) * (ToReal(prg.percent) / 100.0))
            imgpercentV = ToInt(ToReal(prg.h - ImageHeight(gte_progressBar[PROG_PART_LEFT,prg.state]) - ImageHeight(gte_progressBar[PROG_PART_RIGHT,prg.state])) * (ToReal(prg.percent) / 100.0))
        Endif
        
        { Image }                           
        If prg.state = PROG_STATE_HORIZ then
            DrawImage(gte_progressBar[PROG_PART_LEFT, prg.state],  0, 0, prg.e)
            DrawTiledImage(GET_PROGRESSBAR, PROG_PART_MID, prg.state, ImageWidth(gte_progressBar[PROG_PART_LEFT,prg.state]), 0, prg.w - ImageWidth(gte_progressBar[PROG_PART_RIGHT,prg.state]), prg.h, prg.e)
            If imgpercentH > 0 then TileImage(gte_progressBar[PROG_PART_ITEM, prg.state], ImageWidth(gte_progressBar[PROG_PART_LEFT,prg.state]), 0, ImageWidth(gte_progressBar[PROG_PART_LEFT,prg.state]) + imgpercentH, prg.h, prg.e)
            DrawImage(gte_progressBar[PROG_PART_RIGHT, prg.state],  prg.w - ImageWidth(gte_progressBar[PROG_PART_RIGHT,prg.state]), 0, prg.e)
        Else
            DrawImage(gte_progressBar[PROG_PART_LEFT, prg.state],  0, 0, prg.e)
            DrawTiledImage(GET_PROGRESSBAR, PROG_PART_MID, prg.state, 0, ImageHeight(gte_progressBar[PROG_PART_LEFT,prg.state]), prg.w, prg.h - ImageHeight(gte_progressBar[PROG_PART_RIGHT,prg.state]), prg.e)
            If imgpercentV > 0 then TileImage(gte_progressBar[PROG_PART_ITEM, prg.state], 0, (prg.h - ImageHeight(gte_progressBar[PROG_PART_RIGHT,prg.state])) - imgpercentV, prg.w, prg.h - ImageHeight(gte_progressBar[PROG_PART_RIGHT,prg.state]), prg.e)
            DrawImage(gte_progressBar[PROG_PART_RIGHT, prg.state],  0, prg.h - ImageHeight(gte_progressBar[PROG_PART_RIGHT,prg.state]), prg.e)
        Endif

        { Done! }
        SpriteRefresh(prg.e)
        prg.toRender = FALSE
    
     //HagLog(LOG_DEBUG,"RenderProgressBar: End")
    Dec(log_indent)
End

Procedure PositionProgressBar(prg: ^progressBars, x:Integer, y:Integer) ; Export
{
    Repositions a progress bar, updating the sprite and the position variables 
}
Var
    dx, dy: Integer
Begin
     HagLog(LOG_DEBUG,"PositionProgressBar: ("+ToString(x)+","+ToString(y)+")")

    dx = x - prg.x
    dy = y - prg.y
    
    prg.x = prg.x + dx
    prg.y = prg.y + dy
    SpriteX(prg.e,prg.x)
    SpriteY(prg.e,prg.y)

End

Procedure ResizeProgressBar(prg: ^progressBars, l:Integer) ; Export
{
    Resizes a button 
}
Begin

    FreeSprite(prg.e)
    
    If progressBar.state = HAG_HORIZONTAL then
             HagLog(LOG_DEBUG,"ResizeProgressBar: ("+ToString(prg.w)+" -> "+ToString(l)+")")
            
            prg.w = l
            prg.h = ImageHeight(gte_progressBar[PROG_PART_MID, PROG_STATE_HORIZ])
        Else
             HagLog(LOG_DEBUG,"ResizeProgressBar: ("+ToString(prg.h)+" -> "+ToString(l)+")")
            
            prg.w = ImageWidth(gte_progressBar[PROG_PART_MID, PROG_STATE_VERT])
            prg.h = l
        Endif 
    
    prg.e = CreateGuiSprite(prg.x,prg.y,prg.w,prg.h,TRUE)
  
    RenderProgressBar(prg)
End

Procedure EnableProgressBar(prg: ^progressBars, enable:Boolean=TRUE) ; Export
Begin
     HagLog(LOG_DEBUG,"EnableProgressBar: ("+ToString(enable)+")")
    
    prg.enabled = enable
End

Procedure DisableProgressBar(prg: ^progressBars) ; Export
Begin
    EnableProgressBar(prg,FALSE)
End

Procedure ShowProgressBar(prg: ^progressBars, show:Boolean=TRUE) ; Export
{
    Shows or hides a progress bar
}
Begin
     HagLog(LOG_DEBUG,"ShowProgressBar: ("+ToString(show)+")")
    
    prg.visible = show
    SpriteVisible(prg.e, show)
End

Procedure HideProgressBar(prg: ^progressBars) ; Export
Begin
    ShowProgressBar(prg,FALSE)
End

Procedure ProgressBarPercent(prg: ^progressBars, p:Integer) ; Export
{
    Provides a nice interface into setting the progress bar percent
}
Begin

    If p < 0 then p = 0
    If p > 100 then p = 100
        
    If p <> prg.percent then
         HagLog(LOG_DEBUG,"ProgressBarPercent: ("+ToString(prg.percent)+" -> "+ToString(p)+"%)")
        
        prg.percent = p
        prg.toRender = TRUE
    Endif
End

Function ProgressBarClicked(prg:^progressBars) : Boolean ; Export
Begin
    result = ProgressBarLeftClicked(prg)
End

Function ProgressBarLeftClicked(prg:^progressBars) : Boolean ; Export
Begin
    result = prg.gotLeftClicked
    prg.gotLeftClicked = FALSE
End

Function ProgressBarRightClicked(prg:^progressBars) : Boolean ; Export
Begin
    result = prg.gotRightClicked
    prg.gotRightClicked = FALSE
End

Procedure FlushProgressBar(prg:^progressBars) ; Export
{
    Provides a nice interface to reset the progress bar click flags
}
Begin
     HagLog(LOG_DEBUG,"FlushProgressBar")
    
    prg.gotLeftClicked = FALSE
    prg.gotRightClicked = FALSE
End

Procedure FreeProgressBar(prg:^progressBars) ; Export
{
    Safely frees a progress bar.
}
Begin
     HagLog(LOG_DEBUG,"FreeProgressBar")
    
    FreeSprite(prg.e)
    Free(prg)    
End







(* -------------------------------------------------------------------------- *)
(* SLIDERS *)
(* -------------------------------------------------------------------------- *)

Procedure RenderSlider(sli:^sliders)
{
    Renders a complete slider of a given state (e.g. horizontal/verical)
    to the canvas
}
Var
    i, o: Integer
Begin
    
    Inc(log_indent)

        { Clear }
        CLS(ToRGBA(0,0,0,0),sli.e)
        
        { Image }                           
        If sli.state = SLI_STATE_HORIZ then
            DrawImage(gte_slider[SLI_PART_LEFT, sli.state],  0, 0, sli.e)
            DrawTiledImage(GET_SLIDER, SLI_PART_MID, sli.state, ImageWidth(gte_slider[SLI_PART_LEFT,sli.state]), 0, sli.w - ImageWidth(gte_slider[SLI_PART_RIGHT,sli.state]), sli.h, sli.e)
            DrawImage(gte_slider[SLI_PART_RIGHT, sli.state], sli.w - ImageWidth(gte_slider[SLI_PART_LEFT, sli.state]), 0, sli.e)
            
            If sli.sliDivisions > 2 then
                For i = 1 to (sli.sliDivisions-2)
                    o = (ToReal(i) / ToReal(sli.sliDivisions-1)) * ToReal(sli.w)  
                    DrawImage(gte_slider[SLI_PART_MARKING, sli.state], o, 0, sli.e)
                Next 
            Endif
            
            DrawImage(gte_slider[SLI_PART_SLIDER, sli.sliState], sli.sliOffset, 0, sli.e)
        Else
            DrawImage(gte_slider[SLI_PART_LEFT, sli.state],  0, 0, sli.e)
            DrawTiledImage(GET_SLIDER, SLI_PART_MID, sli.state, 0, ImageHeight(gte_slider[SLI_PART_LEFT,sli.state]), sli.w, sli.h - ImageHeight(gte_slider[SLI_PART_RIGHT,sli.state]), sli.e)
            DrawImage(gte_slider[SLI_PART_RIGHT, sli.state], 0, sli.h - ImageHeight(gte_slider[SLI_PART_LEFT, sli.state]), sli.e)

            If sli.sliDivisions > 2 then
                For i = 1 to (sli.sliDivisions-2)
                    o = (ToReal(i) / ToReal(sli.sliDivisions-1)) * ToReal(sli.h)  
                    DrawImage(gte_slider[SLI_PART_MARKING, sli.state], 0, o, sli.e)
                Next 
            Endif
            
            DrawImage(gte_slider[SLI_PART_SLIDER, sli.sliState+SLI_SLIDER_ORI_OFFSET], 0, sli.h - sli.sliOffset - ImageHeight(gte_slider[SLI_PART_SLIDER, sli.sliState+SLI_SLIDER_ORI_OFFSET]), sli.e)
        Endif

        { Done! }
        SpriteRefresh(sli.e)
        sli.toRender = FALSE
    
    Dec(log_indent)
End

Procedure SliderSetDivisions(sli: ^sliders, divisions: Integer) ; export
Begin
    sli.sliDivisions = divisions
    sli.gotUpdated = TRUE
    sli.toRender = TRUE
End

Procedure SliderSetPercent(sli: ^sliders, percent: Integer) ; export
Begin
    If sli.state = SLI_STATE_HORIZ then
        sli.sliOffset = (ToReal(percent)/100.0) * ToReal(sli.w)
    Else
        sli.sliOffset = (ToReal(percent)/100.0) * ToReal(sli.h)
    Endif 
End

Procedure SliderSetDivision(sli: ^sliders, division: Integer) ; export
Var
    o: Integer
Begin
    If sli.state = SLI_STATE_HORIZ then
        o = sli.w/(sli.sliDivisions-1)
        sli.sliOffset = division * o
    Else
        o = sli.h/(sli.sliDivisions-1)
        sli.sliOffset = division * o
    Endif

End

Function SliderUpdated(sli: ^sliders): Boolean ; export
Begin

    If sli.gotUpdated then
        sli.gotUpdated = FALSE
        result = TRUE
    else
        result = FALSE
    Endif

End

Function SliderGetPercent(sli: ^sliders): Integer ; export
Begin

    If sli.state = SLI_STATE_HORIZ then
        result = ToReal(sli.sliOffset) / ToReal(sli.w - ImageWidth(gte_slider[SLI_PART_SLIDER,sli.state])) * 100.0
    Else
        result = ToReal(sli.sliOffset) / ToReal(sli.h - ImageHeight(gte_slider[SLI_PART_SLIDER,sli.state+SLI_SLIDER_ORI_OFFSET])) * 100.0
    Endif

End

Function SliderGetDivision(sli: ^sliders): Integer ; export
Var
    o: Real
Begin
    If sli.sliDivisions < 1 then exit

    If sli.state = SLI_STATE_HORIZ then
        o = ToReal(sli.w)/ToReal(sli.sliDivisions-1)
        result = Ceil(ToReal(sli.sliOffset) / o)
    Else
        o = ToReal(sli.h)/ToReal(sli.sliDivisions-1)
        result = Ceil(ToReal(sli.sliOffset) / o)
    Endif

End

Procedure EnableSlider(sli: ^sliders, enable:Boolean=TRUE) ; Export
Begin
    HagLog(LOG_DEBUG,"EnableSlider: ("+ToString(enable)+")")
    
    sli.enabled = enable
    If enable then slider.sliState = SLI_SLIDER_STATE_HORIZ_NORMAL else slider.sliState = SLI_SLIDER_STATE_HORIZ_DISABLED
    sli.toRender = TRUE
End

Procedure DisableSlider(sli: ^sliders) ; Export
Begin
    EnableSlider(sli,FALSE)
End

Procedure ShowSlider(sli: ^sliders, show:Boolean=TRUE) ; Export
{
    Shows or hides a slider
}
Begin
     HagLog(LOG_DEBUG,"ShowSlider: ("+ToString(show)+")")
    
    sli.visible = show
    SpriteVisible(sli.e, show)
End

Procedure HideSlider(sli: ^sliders) ; Export
Begin
    ShowSlider(sli,FALSE)
End

Procedure FlushSlider(sli:^sliders) ; Export
{
    Provides a nice interface to reset the slider flags
}
Begin
    HagLog(LOG_DEBUG,"FlushSlider")
    
    sli.gotUpdated = FALSE
End

Procedure FreeSlider(sli:^sliders) ; Export
{
    Safely frees a progress bar.
}
Begin
    HagLog(LOG_DEBUG,"FreeSlider")
    
    FreeSprite(sli.e)
    Free(sli)    
End









(* -------------------------------------------------------------------------- *)
(* RADIO GROUPS *)
(* -------------------------------------------------------------------------- *)

Procedure PositionRadioGroup(grp: ^radioGroups, x:Integer, y:Integer) ; Export
{
    Repositions a radio group, updating the positions of all child elements.
}
Var
    dx, dy: Integer
Begin
     HagLog(LOG_DEBUG,"PositionRadioGroup: ("+ToString(x)+","+ToString(y)+")")

    dx = x - grp.x
    dy = y - grp.y
    
    Loop radioButton through grp.grpRadioButtonList
        radioButton.x = radioButton.x + dx
        radioButton.y = radioButton.y + dy
        SpriteX(radioButton.e,radioButton.x)
        SpriteY(radioButton.e,radioButton.y)
    EndLoop

    grp.x = x
    grp.y = y
End

Procedure EnableRadioGroup(grp: ^radioGroups, enable:Boolean=TRUE, allChildren:Boolean=FALSE) ; Export
{
    Enables or disables a radio group for input, optionally updating all child
    elements in the same way.
}
Begin
     HagLog(LOG_DEBUG,"EnableRadioGroup: ("+ToString(enable)+")")
    Inc(log_indent)
        
        If allChildren then
            Loop radioButton through grp.grpRadioButtonList
                EnableRadioButton(radioButton,enable)
            EndLoop
        Endif
    
    grp.enabled = enable
    
    Dec(log_indent)
End

Procedure DisableRadioGroup(grp: ^radioGroups, allChildren:Boolean=FALSE) ; Export
Begin
    EnableRadioGroup(grp,FALSE, allChildren)
End

Procedure ShowRadioGroup(grp: ^radioGroups, show:Boolean) ; Export
{
    Shows or hides all child elements of a radio group
}
Begin
     HagLog(LOG_DEBUG,"ShowRadioGroup: ("+ToString(show)+")")
    Inc(log_indent)

        Loop radioButton through grp.grpRadioButtonList
            ShowRadioButton(radioButton,show)
        EndLoop
    
    grp.visible = show
    
    Dec(log_indent)
End

Procedure HideRadioGroup(grp: ^radioGroups) ; Export
Begin
    ShowRadioGroup(grp,FALSE)
End

Procedure RadioGroupTextAlignment(grp: ^radioGroups, alignment:Integer) ; Export
{
    Sets the Text alignment of every child radio button in the group
}
Begin
     HagLog(LOG_DEBUG,"RadioGroupTextAlignment: ("+ToString(alignment)+")")
    Inc(log_indent)

        Loop radioButton through grp.grpRadioButtonList
            RadioButtonTextAlignment(radioButton,alignment)
        EndLoop
    
    Dec(log_indent)
End

Function SelectedRadioButtonExists(grp: ^radioGroups) : Boolean ; Export
Begin

        Loop radioButton through grp.grpRadioButtonList
            If radioButton.selected then
                 HagLog(LOG_DEBUG,"SelectedRadioButtonExists: TRUE ('"+radioButton.txt+"')")
                result = TRUE
                Exit
            Endif
        EndLoop

     HagLog(LOG_DEBUG,"SelectedRadioButtonExists: FALSE.")

End

Function SelectedRadioButton(grp: ^radioGroups) : ^ radioButtons ; Export
Begin

        Loop radioButton through grp.grpRadioButtonList
            If radioButton.selected then
                 HagLog(LOG_DEBUG,"SelectedRadioButton: '"+radioButton.txt+"'")
                result = radioButton
                Exit
            Endif
        EndLoop

     HagLog(LOG_DEBUG,"SelectedRadioButton: Nothing selected.")

End

Procedure FreeRadioGroup(grp: ^radioGroups) ; Export
{
    Safely frees a radio button group.
}
Begin
     HagLog(LOG_DEBUG,"FreeRadioGroup")
    Inc(log_indent)
    
        Loop radioButton through grp.grpRadioButtonList
            FreeRadioButton(radioButton)
        EndLoop
         
        Free(grp)
    
    Dec(log_indent)
End






(* -------------------------------------------------------------------------- *)
(* RADIO BUTTONS *)
(* -------------------------------------------------------------------------- *)

Procedure RenderRadioButton(rdb :^radioButtons)
{
    Renders a complete radio button of a given state (e.g. hover/selected) to the canvas
}
Var
    soffset: Integer = 0
Begin
    
     //HagLog(LOG_DEBUG,"RenderRadioButton: '"+rdb.txt+"'")
    Inc(log_indent)
    
        If rdb.selected then soffset = RDO_SELECT_DIFF

        { Clear }
        CLS(ToRGBA(0,0,0,0),rdb.e)
        
        { Image }
        Case rdb.textAlignment[rdb.state+soffset] of
            (HAG_TEXT_LEFT):
                DrawImage(gte_radioButton[rdb.state+soffset], 0, 0, rdb.e)
            (HAG_TEXT_RIGHT):
                DrawImage(gte_radioButton[rdb.state+soffset], rdb.w - ImageWidth(gte_radioButton[rdb.state+soffset]), 0, rdb.e)
        EndCase
        
        { Aliasing On? }
        If hag_prefEnable[HAG_PREF_ENABLE_AADRAW] and rdb.textAAliasing[rdb.state+soffset] then AADraw(1)
        
        { Text }
        SetFont(rdb.fontName[rdb.state+soffset],rdb.fontSize[rdb.state+soffset],rdb.fontStyle[rdb.state+soffset],rdb.e)
        PenColor(rdb.fontColor[rdb.state+soffset],rdb.e)
        
        Case rdb.textAlignment[rdb.state+soffset] of
    
            (HAG_TEXT_LEFT):
                Text(ImageWidth(gte_radioButton[rdb.state+soffset]), Ceil(0.0 + rdb.h/2.0 - TextHeight(rdb.txt,rdb.e)/2.0), rdb.txt, rdb.e)
            
            (HAG_TEXT_RIGHT):
                Text(rdb.w - ImageWidth(gte_radioButton[rdb.state+soffset]) - TextWidth(rdb.txt, rdb.e), Ceil(0.0 + rdb.h/2.0 - TextHeight(rdb.txt,rdb.e)/2.0), rdb.txt, rdb.e)

            Default:
                 HagLog(LOG_ERROR,"WARNING: RenderRadioButton: The type of text-alignment '"+ToString(rdb.textAlignment[rdb.state])+"' is not implemented.")                    
        EndCase
        
        AADraw(0)

        { Done! }
        SpriteRefresh(rdb.e)
        rdb.toRender = FALSE
    
     //HagLog(LOG_DEBUG,"RenderRadioButton: End")
    Dec(log_indent)
End

Procedure PositionRadioButton(rdb: ^radiobuttons, x:Integer, y:Integer) ; Export
{
    Repositions a radio button, updating the sprite and the position variables 
}
Var
    dx, dy: Integer
Begin
     HagLog(LOG_DEBUG,"PositionRadioButton: ("+ToString(x)+","+ToString(y)+") '"+rdb.txt+"'")

    dx = x - rdb.x
    dy = y - rdb.y
    
    rdb.x = rdb.x + dx
    rdb.y = rdb.y + dy
    SpriteX(rdb.e,rdb.x)
    SpriteY(rdb.e,rdb.y)

End

Procedure ResizeRadioButton(rdb: ^radiobuttons, w:Integer) ; Export
{
    Resizes a radio button 
}
Begin
     HagLog(LOG_DEBUG,"ResizeRadioButton: ("+ToString(rdb.w)+" -> "+ToString(w)+") '"+rdb.txt+"'")

    FreeSprite(rdb.e)
    
    rdb.w = w
    rdb.e = CreateGuiSprite(rdb.x,rdb.y,rdb.w,rdb.h,TRUE)
  
    RenderRadioButton(rdb)
End

Procedure EnableRadioButton(rdb: ^radiobuttons, enable:Boolean=TRUE) ; Export
Begin
     HagLog(LOG_DEBUG,"EnableRadioButton: ("+ToString(enable)+") '"+rdb.txt+"'")
    
    rdb.enabled = enable
    If enable then
        rdb.state = RDO_STATE_NORMAL
    Else
        rdb.state = RDO_STATE_DISABLED
    Endif
    rdb.toRender = TRUE
End

Procedure DisableRadioButton(rdb: ^radiobuttons) ; Export
Begin
    EnableRadioButton(rdb,FALSE)
End

Procedure ShowRadioButton(rdb: ^radiobuttons, show:Boolean=TRUE) ; Export
{
    Shows or hides a radio button
}
Begin
     HagLog(LOG_DEBUG,"ShowRadioButton: ("+ToString(show)+") '"+rdb.txt+"'")
    
    rdb.visible = show
    SpriteVisible(rdb.e, show)
End

Procedure HideRadioButton(rdb: ^radiobuttons) ; Export
Begin
    ShowRadioButton(rdb,FALSE)
End

Procedure RadioButtonFontName(rdb :^radioButtons, name: String) ; Export
{
    Provides a nice interface to update the font name for every state in a
    radio button element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"RadioButtonFontName: ("+ToString(name)+") '"+rdb.txt+"'")

    For i = 0 to (MAX_RDO_STATES-1)
        rdb.fontName[i] = name
    Next
    
    rdb.toRender = TRUE
    
End

Procedure RadioButtonFontSize(rdb: ^radioButtons, size: Integer) ; Export
{
    Provides a nice interface to update the font size for every state in a
    radio button element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"RadioButtonFontSize: ("+ToString(size)+") '"+rdb.txt+"'")

    For i = 0 to (MAX_RDO_STATES-1)
        rdb.fontSize[i] = size
    Next
    
    rdb.toRender = TRUE
    
End

Procedure RadioButtonFontStyle(rdb: ^radioButtons, flags: Integer) ; Export
{
    Provides a nice interface to update the font style for every state in a
    radio button element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"RadioButtonFontStyle: ("+ToString(flags)+") '"+rdb.txt+"'")

    For i = 0 to (MAX_RDO_STATES-1)
        rdb.fontStyle[i] = flags
    Next
    
    rdb.toRender = TRUE
    
End

Procedure RadioButtonFontColor(rdb: ^radioButtons, rgba: Integer) ; Export
{
    Provides a nice interface to update the font colour for every state in a
    radio button element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"RadioButtonFontColor: ("+ToString(rgba)+") '"+rdb.txt+"'")

    For i = 0 to (MAX_RDO_STATES-1)
        rdb.fontColor[i] = rgba
    Next
    
    rdb.toRender = TRUE
    
End

Procedure RadioButtonFontColour(rdb: ^radioButtons, rgba: Integer) ; Export
Begin
    RadioButtonFontColor(rdb,rgba)
End

Procedure RadioButtonTextAlignment(rdb: ^radioButtons, align: Integer) ; Export
{
    Provides a nice interface to update the textalignment for every state in a
    radio button element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"RadioButtonTextAlignment: ("+ToString(align)+") '"+rdb.txt+"'")

    For i = 0 to (MAX_RDO_STATES-1)
        rdb.textAlignment[i] = align
    Next
    
    rdb.toRender = TRUE
    
End

Procedure RadioButtonTextAAliasing(rdb: ^radioButtons, aa: Boolean) ; Export
{
    Provides a nice interface to update the Text AntiAlias level for every state
    in a radio button element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"RadioButtonTextAAliasing: ("+ToString(aa)+") '"+rdb.txt+"'")

    For i = 0 to (MAX_RDO_STATES-1)
        rdb.textAAliasing[i] = aa
    Next
    
    rdb.toRender = TRUE
    
End

Function RadioButtonClicked(rdb: ^radioButtons) : Boolean ; Export
Begin
    result = RadioButtonLeftClicked(rdb)
End

Function RadioButtonLeftClicked(rdb: ^radioButtons) : Boolean ; Export
Begin
    result = rdb.gotLeftClicked
    rdb.gotLeftClicked = FALSE
End

Function RadioButtonRightClicked(rdb: ^radioButtons) : Boolean ; Export
Begin
    result = rdb.gotRightClicked
    rdb.gotRightClicked = FALSE
End

Procedure FlushRadioButton(rdb: ^radioButtons) ; Export
{
    Provides a nice interface to reset the radio button click flags
}
Begin
     HagLog(LOG_DEBUG,"FlushRadioButton")
    
    rdb.gotLeftClicked = FALSE
    rdb.gotRightClicked = FALSE
End

Procedure FreeRadioButton(rdb: ^radioButtons) ; Export
{
    Safely frees a radio button.
}
Begin
     HagLog(LOG_DEBUG,"FreeRadioButton: '"+rdb.txt+"'")
    
    FreeImage(rdb.e)         
    Free(rdb)
    
End








(* -------------------------------------------------------------------------- *)
(* Check Boxes *)
(* -------------------------------------------------------------------------- *)

Procedure RenderCheckBox(cbx: ^checkBoxes)
{
    Renders a complete check box of a given state (e.g. hover/selected) to the canvas
}
Var
    soffset: Integer = 0
Begin
    
     //HagLog(LOG_DEBUG,"RenderCheckBox: '"+cbx.txt+"'")
    Inc(log_indent)
    
        If cbx.checked then soffset = CBX_SELECT_DIFF

        { Clear }
        CLS(ToRGBA(0,0,0,0),cbx.e)
        
        { Image }
        Case cbx.textAlignment[cbx.state+soffset] of
            (HAG_TEXT_LEFT):
                DrawImage(gte_checkBox[cbx.state+soffset], 0, 0, cbx.e)
            (HAG_TEXT_RIGHT):
                DrawImage(gte_checkBox[cbx.state+soffset], cbx.w - ImageWidth(gte_checkBox[cbx.state+soffset]), 0, cbx.e)
        EndCase
        
        { Aliasing On? }
        If hag_prefEnable[HAG_PREF_ENABLE_AADRAW] and cbx.textAAliasing[cbx.state+soffset] then AADraw(1)
        
        { Text }
        SetFont(cbx.fontName[cbx.state+soffset],cbx.fontSize[cbx.state+soffset],cbx.fontStyle[cbx.state+soffset],cbx.e)
        PenColor(cbx.fontColor[cbx.state+soffset],cbx.e)
        
        Case cbx.textAlignment[cbx.state+soffset] of
    
            (HAG_TEXT_LEFT):
                Text(ImageWidth(gte_checkBox[cbx.state+soffset]), Ceil(0.0 + cbx.h/2.0 - TextHeight(cbx.txt,cbx.e)/2.0), cbx.txt, cbx.e)
            
            (HAG_TEXT_RIGHT):
                Text(cbx.w - ImageWidth(gte_checkBox[cbx.state+soffset]) - TextWidth(cbx.txt, cbx.e), Ceil(0.0 + cbx.h/2.0 - TextHeight(cbx.txt,cbx.e)/2.0), cbx.txt, cbx.e)

            Default:
                 HagLog(LOG_ERROR,"WARNING: RenderCheckBox: The type of text-alignment '"+ToString(cbx.textAlignment[cbx.state])+"' is not implemented.")                    
        EndCase
        
        AADraw(0)

        { Done! }
        SpriteRefresh(cbx.e)
        cbx.toRender = FALSE
    
     //HagLog(LOG_DEBUG,"RenderCheckBox: End")
    Dec(log_indent)
End

Procedure PositionCheckBox(cbx: ^checkBoxes, x:Integer, y:Integer) ; Export
{
    Repositions a checkbox, updating the sprite and the position variables 
}
Var
    dx, dy: Integer
Begin
     HagLog(LOG_DEBUG,"PositionCheckBox: ("+ToString(x)+","+ToString(y)+") '"+cbx.txt+"'")

    dx = x - cbx.x
    dy = y - cbx.y
    
    cbx.x = cbx.x + dx
    cbx.y = cbx.y + dy
    SpriteX(cbx.e,cbx.x)
    SpriteY(cbx.e,cbx.y)

End

Procedure ResizeCheckBox(cbx: ^checkBoxes, w:Integer) ; Export
{
    Resizes a check box 
}
Begin
     HagLog(LOG_DEBUG,"ResizeCheckBox: ("+ToString(cbx.w)+" -> "+ToString(w)+") '"+cbx.txt+"'")

    FreeSprite(cbx.e)
    
    cbx.w = w
    cbx.e = CreateGuiSprite(cbx.x,cbx.y,cbx.w,cbx.h,TRUE)
  
    RenderCheckBox(cbx)
End

Procedure EnableCheckBox(cbx: ^checkBoxes, enable:Boolean=TRUE) ; Export
Begin
     HagLog(LOG_DEBUG,"EnableCheckBox: ("+ToString(enable)+") '"+cbx.txt+"'")
    
    cbx.enabled = enable
    cbx.state = CBX_STATE_DISABLED
    cbx.toRender = TRUE
End

Procedure DisableCheckBox(cbx: ^radiobuttons) ; Export
Begin
    EnableCheckBox(cbx,FALSE)
End

Procedure ShowCheckBox(cbx: ^checkBoxes, show:Boolean=TRUE) ; Export
{
    Shows or hides a check box
}
Begin
     HagLog(LOG_DEBUG,"ShowCheckBox: ("+ToString(show)+") '"+cbx.txt+"'")
    
    cbx.visible = show
    SpriteVisible(cbx.e, show)
End

Procedure HideCheckBox(cbx: ^checkBoxes) ; Export
Begin
    ShowCheckBox(cbx,FALSE)
End

Procedure TickCheckBox(cbx: ^checkBoxes, checked:Boolean) ; Export
Begin
     HagLog(LOG_DEBUG,"TickCheckBox: ("+ToString(checked)+") '"+cbx.txt+"'")
    
    cbx.checked = checked
    cbx.toRender = TRUE
End

Procedure CheckBoxFontName(cbx: ^checkBoxes, name: String) ; Export
{
    Provides a nice interface to update the font name for every state in a
    check box element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"CheckBoxFontName: ("+ToString(name)+") '"+cbx.txt+"'")

    For i = 0 to (MAX_CBX_STATES-1)
        cbx.fontName[i] = name
    Next
    
    cbx.toRender = TRUE
    
End

Procedure CheckBoxFontSize(cbx: ^checkBoxes, size: Integer) ; Export
{
    Provides a nice interface to update the font size for every state in a
    checkbox element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"CheckBoxFontSize: ("+ToString(size)+") '"+cbx.txt+"'")

    For i = 0 to (MAX_CBX_STATES-1)
        cbx.fontSize[i] = size
    Next
    
    cbx.toRender = TRUE
    
End

Procedure CheckBoxFontStyle(cbx: ^checkBoxes, flags: Integer) ; Export
{
    Provides a nice interface to update the font style for every state in a
    check box element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"CheckBoxFontStyle: ("+ToString(flags)+") '"+cbx.txt+"'")

    For i = 0 to (MAX_CBX_STATES-1)
        cbx.fontStyle[i] = flags
    Next
    
    cbx.toRender = TRUE
    
End

Procedure CheckBoxFontColor(cbx: ^checkBoxes, rgba: Integer) ; Export
{
    Provides a nice interface to update the font colour for every state in a
    check box element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"CheckBoxFontColor: ("+ToString(rgba)+") '"+cbx.txt+"'")

    For i = 0 to (MAX_CBX_STATES-1)
        cbx.fontColor[i] = rgba
    Next
    
    cbx.toRender = TRUE
    
End

Procedure CheckBoxFontColour(cbx: ^checkBoxes, rgba: Integer) ; Export
Begin
    CheckBoxFontColor(cbx,rgba)
End

Procedure CheckBoxTextAlignment(cbx: ^checkBoxes, align: Integer) ; Export
{
    Provides a nice interface to update the textalignment for every state in a
    check box element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"CheckBoxTextAlignment: ("+ToString(align)+") '"+cbx.txt+"'")

    For i = 0 to (MAX_CBX_STATES-1)
        cbx.textAlignment[i] = align
    Next
    
    cbx.toRender = TRUE
    
End

Procedure CheckBoxTextAAliasing(cbx: ^checkBoxes, aa: Boolean) ; Export
{
    Provides a nice interface to update the Text AntiAlias level for every state
    in a checkbox element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"CheckBoxTextAAliasing: ("+ToString(aa)+") '"+cbx.txt+"'")

    For i = 0 to (MAX_RDO_STATES-1)
        cbx.textAAliasing[i] = aa
    Next
    
    cbx.toRender = TRUE
    
End

Function CheckBoxClicked(cbx: ^checkBoxes) : Boolean ; Export
Begin
    result = CheckBoxLeftClicked(cbx)
End

Function CheckBoxLeftClicked(cbx: ^checkBoxes) : Boolean ; Export
Begin
    result = cbx.gotLeftClicked
    cbx.gotLeftClicked = FALSE
End

Function CheckBoxRightClicked(cbx: ^checkBoxes) : Boolean ; Export
Begin
    result = cbx.gotRightClicked
    cbx.gotRightClicked = FALSE
End

Function CheckBoxChecked(cbx: ^checkBoxes) : Boolean ; Export
Begin
    result = cbx.checked
End

Procedure FlushCheckBox(cbx: ^checkBoxes) ; Export
{
    Provides a nice interface to reset the check box click flags
}
Begin
     HagLog(LOG_DEBUG,"FlushCheckBox")
    
    cbx.gotLeftClicked = FALSE
    cbx.gotRightClicked = FALSE
End

Procedure FreeCheckBox(cbx: ^checkBoxes) ; Export
{
    Safely frees a checkbox.
}
Begin
     HagLog(LOG_DEBUG,"FreeCheckBox: '"+cbx.txt+"'")
    
    FreeImage(cbx.e)         
    Free(cbx)
    
End









(* -------------------------------------------------------------------------- *)
(* TextBoxes *)
(* -------------------------------------------------------------------------- *)

Procedure RenderTextbox(tbx:^textBoxes)
{
    Renders a complete textbox of a given state (e.g. hover) to the texbox canvas
}
Var
    cx: Integer = 0
    cnt: Integer = 0
    tx, ty : Integer
    sl, sr: Integer
Begin
    
     //HagLog(LOG_DEBUG,"RenderTextbox:")
    Inc(log_indent)
    
        sl = tbx.selectionLeft
        sr = tbx.selectionRight
        If sl > sr then
	        sl = sl Xor sr
            sr = sr Xor sl
            sl = sl Xor sr
        Endif

        { Clear }
        CLS(ToRGBA(0,0,0,0),tbx.e)
        
        { Image }
        DrawImage(gte_textbox[TBX_PART_LEFT,tbx.state],  0, 0, tbx.e)
        DrawTiledImage(GET_TEXTBOX, TBX_PART_MID, tbx.state, ImageWidth(gte_textbox[TBX_PART_LEFT,tbx.state]), 0, tbx.w - ImageWidth(gte_textbox[TBX_PART_RIGHT,tbx.state]), tbx.h, tbx.e)
        DrawImage(gte_textbox[TBX_PART_RIGHT,tbx.state], tbx.w - ImageWidth(gte_textbox[TBX_PART_RIGHT,tbx.state]), 0, tbx.e)
               
        { Text }
        Loop tbxChar through tbx.tbxCharList
            If cnt > 0 then
                           
                If tbxChar.w > 0 then
                    SetFont(tbxChar.fontName,tbxChar.fontSize,tbxChar.fontStyle,tbx.e)
                    PenColor(tbxChar.fontColor,tbx.e)
                    If tbx.enabled = FALSE then PenColor(tbxDisabled_fontColor,tbx.e)

                    tx = ImageWidth(gte_textbox[TBX_PART_LEFT,tbx.state])+cx
                    ty =(ImageHeight(gte_textbox[TBX_PART_MID,tbx.state])/2)-(tbxChar.h/2)

                    If tbx.password =FALSE then
                        If (sl <> sr) and (sl <= cnt) and (sr >= cnt) then
                            Rect(tx,(ImageHeight(gte_textbox[TBX_PART_MID,tbx.state])/2)-(tbx_cursorHeight/2),tbxChar.w,tbx_cursorHeight,tbxSelection_backColor,TRUE,tbx.e)
                            PenColor(tbxSelection_fontColor,tbx.e)
                        Endif
                                        
                        Text(tx,ty,tbxChar.s,tbx.e)
                        
                        If (tbx.state = TBX_STATE_FOCUSED) and (cnt = tbx.cursorPos) and (tbx_cursorState = TRUE) then
                            tx = ImageWidth(gte_textbox[TBX_PART_LEFT,tbx.state]) + cx 
                            ty = (ImageHeight(gte_textbox[TBX_PART_MID,tbx.state])/2)-(tbx_cursorHeight/2)
                     
                            Rect(tx, ty, tbx_cursorWidth, tbx_cursorHeight, tbx_cursorColor, TRUE, tbx.e)
                        Endif
                                            
                        cx = cx + tbxChar.w
                    Else
                        If (sl <> sr) and (sl <= cnt) and (sr >= cnt) then
                            Rect(tx,(ImageHeight(gte_textbox[TBX_PART_MID,tbx.state])/2)-(tbx_cursorHeight/2),TextWidth("*",tbx.e),tbx_cursorHeight,tbxSelection_backColor,TRUE,tbx.e)
                            PenColor(tbxSelection_fontColor,tbx.e)
                        Endif
                        
                        Text(tx,ty,"*",tbx.e)
                        
                        If (tbx.state = TBX_STATE_FOCUSED) and (cnt = tbx.cursorPos) and (tbx_cursorState = TRUE) then
                            tx = ImageWidth(gte_textbox[TBX_PART_LEFT,tbx.state]) + cx 
                            ty = (ImageHeight(gte_textbox[TBX_PART_MID,tbx.state])/2)-(tbx_cursorHeight/2)
                     
                            Rect(tx, ty, tbx_cursorWidth, tbx_cursorHeight, tbx_cursorColor, TRUE, tbx.e)
                        Endif
                        
                        cx = cx + TextWidth("*",tbx.e)
                    Endif
                
                Else
                    If (tbx.state = TBX_STATE_FOCUSED) and (cnt = tbx.cursorPos) and (tbx_cursorState = TRUE) then
                        tx = ImageWidth(gte_textbox[TBX_PART_LEFT,tbx.state]) + cx 
                        ty = (ImageHeight(gte_textbox[TBX_PART_MID,tbx.state])/2)-(tbx_cursorHeight/2)
                     
                        Rect(tx, ty, tbx_cursorWidth, tbx_cursorHeight, tbx_cursorColor, TRUE, tbx.e)
                    Endif
                Endif
                
            Endif
            Inc(cnt)
        EndLoop

        { Done! }
        SpriteRefresh(tbx.e)
        tbx.toRender = FALSE
    
     //HagLog(LOG_DEBUG,"RenderTextBox: End")
    Dec(log_indent)
End

Procedure PositionTextBox(tbx: ^textBoxes, x:Integer, y:Integer) ; Export
{
    Repositions a textbox, updating the sprite and the position variables 
}
Var
    dx, dy: Integer
Begin
     HagLog(LOG_DEBUG,"PositionTextBox: ("+ToString(x)+","+ToString(y)+")")

    dx = x - tbx.x
    dy = y - tbx.y
    
    tbx.x = tbx.x + dx
    tbx.y = tbx.y + dy
    SpriteX(tbx.e,tbx.x)
    SpriteY(tbx.e,tbx.y)

End

Procedure ResizeTextBox(tbx: ^textBoxes, w:Integer) ; Export
{
    Resizes a Text box 
}
Begin
     HagLog(LOG_DEBUG,"ResizeTextBox: ("+ToString(tbx.w)+" -> "+ToString(w)+")")

    FreeSprite(tbx.e)
    
    tbx.w = w
    tbx.e = CreateGuiSprite(tbx.x,tbx.y,tbx.w,tbx.h,TRUE)
  
    RenderTextBox(tbx)
End

Procedure EnableTextBox(tbx: ^textBoxes, enable:Boolean=TRUE) ; Export
Begin
     HagLog(LOG_DEBUG,"EnableTextBox: ("+ToString(enable)+")")
    
    tbx.enabled = enable
    If enable then
        tbx.state = TBX_STATE_NORMAL
    Else
        tbx.state = TBX_STATE_DISABLED
    Endif
    tbx.toRender = TRUE
End

Procedure DisableTextBox(tbx: ^textBoxes) ; Export
Begin
    EnableTextBox(tbx,FALSE)
End

Procedure ShowTextBox(tbx: ^textBoxes, show:Boolean=TRUE) ; Export
{
    Shows or hides a Text box
}
Begin
     HagLog(LOG_DEBUG,"ShowTextBox: ("+ToString(show)+")")
    
    tbx.visible = show
    SpriteVisible(tbx.e, show)
End

Procedure HideTextBox(tbx: ^textBoxes) ; Export
Begin
    ShowTextBox(tbx,FALSE)
End

Procedure FocusTextBox(tbx: ^textBoxes) ; Export
{
    Proivdes a nice interface to set the Text box style to focused, so that
    you can start typing in it.
}
Begin
     HagLog(LOG_DEBUG,"FocusTextBox:")

    tbx.cursorPos = CountList(tbx.tbxCharList) - 1    
    tbx.state = TBX_STATE_FOCUSED
    FlushKeys()
End

Procedure TextBoxInit(tbx: ^textBoxes) ; Export
{
    Creates two empty textbox chars: the first is kept at the front of the
    list, the second must be kept at the end.
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"TextBoxInit:")
    
    For i = 0 to 1
        tbxChar = NewItem(tbx.tbxCharList)
        If Assigned(tbxChar)
            tbxChar.s = ""
            tbxChar.w = 0
            tbxChar.h = 0 
        Else
             HagLog(LOG_ERROR,"FATAL: TextBoxInit: Could not create char")
        Endif
    Next
    
End

Procedure TextBoxAppendText(tbx: ^textBoxes, txt:String) ; Export
Var
    i : Integer
    insc : ^ tbxChars
Begin
     HagLog(LOG_DEBUG,"TextBoxAppendText: '"+txt+"'")
   
    For i = 1 to Length(txt)
        insc = IndexedItem(tbx.tbxCharList,CountList(tbx.tbxCharList)-2) // one before the last
        TextBoxAddCharAfter(tbx,insc,Mid(txt,i,1))
    Next
    
    tbx.gotUpdated = TRUE
End

Procedure TextBoxInsertText(tbx: ^textBoxes, start: Integer, txt:String) ; Export
Var
    i : Integer
    insc : ^ tbxChars
Begin
     HagLog(LOG_DEBUG,"TextBoxInsertText: '"+txt+"',"+ToString(start))
      
    For i = 1 to Length(txt)
        insc = IndexedItem(tbx.tbxCharList,start)
        TextBoxAddCharAfter(tbx,insc,Mid(txt,i,1))
        Inc(start)
    Next
    
    tbx.gotUpdated = TRUE
End

Procedure TextBoxAddCharAfter(tbx: ^textBoxes, tbxc: ^tbxChars, c:String)
Begin
    tbxChar = NewItemAfter(tbx.tbxCharList,tbxc)
    If Assigned(tbxChar)
        tbxChar.s = c
        tbxChar.fontName = fontName[GET_TEXTBOX,0]
        tbxChar.fontSize = fontSize[GET_TEXTBOX,0]
        tbxChar.fontStyle = fontStyle[GET_TEXTBOX,0]
        tbxChar.fontColor = fontColor[GET_TEXTBOX,0]
        
        SetFont(tbxChar.fontName,tbxChar.fontSize,tbxChar.fontStyle,tbx.e)
        tbxChar.w = TextWidth(tbxChar.s,tbx.e)
        tbxChar.h = TextHeight(tbxChar.s,tbx.e)
         
    Else
         HagLog(LOG_ERROR,"FATAL: TextBoxAddChar: Could not create char")
    Endif
End

Procedure TextBoxToggleFontStyle(tbx: ^textBoxes, sl:Integer, sr:Integer, style:Integer) ; Export
Var
    cnt: Integer = 0
Begin
     HagLog(LOG_DEBUG,"TextBoxToggleFontStyle: '"+ToString(sl)+"' to '"+ToString(sr)+"' -> style '"+ToString(style)+"'")

    If sl > sr then
        sl = sl Xor sr
        sr = sr Xor sl
        sl = sl Xor sr
    Endif
    
    Loop tbxChar through tbx.tbxCharList
        If cnt > 0 then
                
            If tbxChar.w > 0 then

                If (sl <> sr) and (sl <= cnt) and (sr >= cnt) then
                    If Has(tbxChar.fontStyle, style) then
                        tbxChar.fontStyle = tbxChar.fontStyle - style
                    Else
                        tbxChar.fontStyle = tbxChar.fontStyle + style
                    Endif

                    SetFont(tbxChar.fontName,tbxChar.fontSize,tbxChar.fontStyle,tbx.e)
                    tbxChar.w = TextWidth(tbxChar.s,tbx.e)

                Endif
            Endif
                
        Endif
        Inc(cnt)
    EndLoop
    
    tbx.toRender = TRUE
    tbx.gotUpdated = TRUE
End

Procedure TextBoxSetFontStyle(tbx: ^textBoxes, sl:Integer, sr:Integer, style:Integer) ; Export
Var
    cnt: Integer = 0
Begin
     HagLog(LOG_DEBUG,"TextBoxSetFontStyle: '"+ToString(sl)+"' to '"+ToString(sr)+"' -> style '"+ToString(style)+"'")

    If sl > sr then
        sl = sl Xor sr
        sr = sr Xor sl
        sl = sl Xor sr
    Endif
    
    Loop tbxChar through tbx.tbxCharList
        If cnt > 0 then
                
            If tbxChar.w > 0 then

                //If (sl <> sr) and (sl <= cnt) and (sr >= cnt) then
                If (sl <= cnt) and (sr >= cnt) then
                    tbxChar.fontStyle = style

                    SetFont(tbxChar.fontName,tbxChar.fontSize,tbxChar.fontStyle,tbx.e)
                    tbxChar.w = TextWidth(tbxChar.s,tbx.e)

                Endif
            Endif
                
        Endif
        Inc(cnt)
    EndLoop
    
    tbx.toRender = TRUE
    tbx.gotUpdated = TRUE
End

Procedure TextBoxSetFontColor(tbx: ^textBoxes, sl:Integer, sr:Integer, rgba:Integer) ; Export
Var
    cnt: Integer = 0
Begin
     HagLog(LOG_DEBUG,"TextBoxSetFontColor: '"+ToString(sl)+"' to '"+ToString(sr)+"' -> rgba '"+ToString(rgba)+"'")

    If sl > sr then
        sl = sl Xor sr
        sr = sr Xor sl
        sl = sl Xor sr
    Endif
    
    Loop tbxChar through tbx.tbxCharList
        If cnt > 0 then
                
            If tbxChar.w > 0 then

                //If (sl <> sr) and (sl <= cnt) and (sr >= cnt) then
                If (sl <= cnt) and (sr >= cnt) then
                    tbxChar.fontColor = rgba
                Endif
            Endif
                
        Endif
        Inc(cnt)
    EndLoop
    
    tbx.toRender = TRUE
    tbx.gotUpdated = TRUE
End

Function TextBoxContents(tbx: ^textBoxes) : String ; Export
Begin
    result = ""
    
    Loop tbxChar through tbx.tbxCharList              
        If tbxChar.w > 0 then            
            result = result + tbxChar.s               
        Endif
    EndLoop

End

Procedure TextBoxSetContent(tbx: ^textBoxes, txt:String) ; Export
{
    Provides a nice interface to set the content of a Text-box.
}
Begin
    TextBoxAppendText(tbx,"__")
    TextBoxRemoveChars(tbx,1,TextBoxLength(tbx))
    TextBoxAppendText(tbx,txt)
    TextBoxPositionCursor(tbx,TextBoxLength(tbx))
End

Procedure TextBoxSetContents(tbx: ^textBoxes, txt:String) ; Export
Begin
    TextBoxSetContent(tbx, txt)
End



Function TextBoxLength(tbx: ^textBoxes) : Integer ; Export
Begin
    
    result = CountList(tbx.tbxCharList) - 2 // one before last

End

Procedure TextBoxCopy(tbx: ^textBoxes,sl:Integer, sr:Integer, remove:Boolean=FALSE) ; Export
Var
    cnt: Integer = 0
Begin
    If tbx.password then Exit

    If sl > sr then
        sl = sl Xor sr
        sr = sr Xor sl
        sl = sl Xor sr
    Endif

    hag_clipboard = ""
    
    Loop tbxChar through tbx.tbxCharList
        If cnt > 0 then                
            If tbxChar.w > 0 then
                If (sl <> sr) and (sl <= cnt) and (sr >= cnt) then
                    hag_clipboard = hag_clipboard + tbxChar.s
                Endif
            Endif                
        Endif
        Inc(cnt)
    EndLoop

    If remove then TextBoxRemoveChars(tbx,sl,sr)
    tbx.toRender = TRUE
    tbx.gotUpdated = TRUE

End

Function TextBoxPaste(tbx: ^textBoxes, cpos:Integer) : Integer ; Export
Begin

    If (cpos-1 > TextBoxLength(tbx)) then cpos = TextBoxLength(tbx)    
    TextBoxInsertText(tbx, cpos-1, hag_clipboard)
    tbx.toRender = TRUE
    tbx.gotUpdated = TRUE
    
    result = Length(hag_clipboard)

End

Function TextBoxRemoveChar(tbx: ^textBoxes, pos: Integer) : Boolean
Var
    i : Integer
    c : ^ tbxChars
Begin
   
    c = IndexedItem(tbx.tbxCharList,pos)
    
    If (c <> FirstItem(tbx.tbxCharList)) and (c <> LastItem(tbx.tbxCharList)) then
        Free(c)
        result = TRUE
    Else
        result = FALSE
    Endif
    
    tbx.gotUpdated = TRUE
End

Procedure TextBoxRemoveChars(tbx: ^textBoxes,sl:Integer,sr:Integer) ; Export
Var
    cnt: Integer = 0
Begin
     HagLog(LOG_DEBUG,"TextBoxRemoveChars: '"+ToString(sl)+"' to '"+ToString(sr)+"'")

    If sl > sr then
        sl = sl Xor sr
        sr = sr Xor sl
        sl = sl Xor sr
    Endif
    
    Loop tbxChar through tbx.tbxCharList
        If cnt > 0 then
                
            If tbxChar.w > 0 then

                If (sl <> sr) and (sl <= cnt) and (sr >= cnt) then 

                    Free(tbxChar)

                Endif
            Endif
                
        Endif
        Inc(cnt)
    EndLoop
    
    tbx.toRender = TRUE
    tbx.gotUpdated = TRUE
End

Function TextBoxClicked(tbx: ^textBoxes) : Boolean ; Export
Begin
    result = TextBoxLeftClicked(tbx)
End

Function TextBoxLeftClicked(tbx: ^textBoxes) : Boolean ; Export
Begin
    result = tbx.gotLeftClicked
    tbx.gotLeftClicked = FALSE
End

Function TextBoxRightClicked(tbx: ^textBoxes) : Boolean ; Export
Begin
    result = tbx.gotRightClicked
    tbx.gotRightClicked = FALSE
End

Function TextBoxFocused(tbx: ^textBoxes) : Boolean ; Export
Begin
    If tbx.state = TBX_STATE_FOCUSED then result = TRUE else result = FALSE
End

Function TextBoxUpdated(tbx: ^textBoxes) : Boolean ; Export
Begin
    result = tbx.gotUpdated
    FlushTextBox(tbx)
End

Function GetTextBoxCursorPosition(tbx: ^textBoxes, mx:Integer) : Integer
{
    Gets cursror position from the mouse
}
Var
    cx, cnt: Integer = 0
    bestcx : Integer = -1
    bestcnt : Integer = 0
Begin
    mx = (mx - tbx.x) + (tbx_pointerWidth/2)
    cx = ImageWidth(gte_textbox[TBX_PART_LEFT,tbx.state])

    Loop tbxChar through tbx.tbxCharList
                
        If tbxChar.w > 0 then
            Inc(cnt)

            If tbx.password = FALSE then                   
                cx = cx + tbxChar.w
            Else
                cx = cx + TextWidth("*",tbx.e)
            Endif
        Endif
        
        If (Abs(mx - cx) < bestcx) or (bestcx = -1) then
            bestcx = Abs(mx - cx)
            bestcnt = cnt
        Endif 
        
    EndLoop
    
    result = bestcnt + 1
    
End

Procedure TextBoxPositionCursor(tbx: ^textBoxes, pos:Integer) ; Export
{
    Provides a nice interface to shove the text-cursor to
    a certain position.
}
Begin   
     HagLog(LOG_DEBUG,"TextBoxPositionCursor: "+ToString(pos))

    tbx.cursorPos = pos + 1
    ForceVisibleTextBoxCursor()
    tbx.toRender = TRUE
End

Procedure FlushTextBox(tbx: ^textBoxes) ; Export
{
    Provides a nice interface to reset the textbox click flags
}
Begin
     HagLog(LOG_DEBUG,"FlushTextBox")
    
    tbx.gotLeftClicked = FALSE
    tbx.gotRightClicked = FALSE
    tbx.gotUpdated = FALSE
End

Procedure FreeTextBox(tbx: ^textBoxes) ; Export
{
    Safely frees a text box
}
Begin
     HagLog(LOG_DEBUG,"FreeTextBox:")
    
    FreeImage(tbx.e)         
    Free(tbx)
End





(* -------------------------------------------------------------------------- *)
(* Text *)
(* -------------------------------------------------------------------------- *)

Procedure RenderText(htx: ^hTexts)
{
    Renders a hText element of a given type (e.g. normal/title) to the canvas
}
Begin
    
     //HagLog(LOG_DEBUG,"RenderText:")
    Inc(log_indent)
    
        { Clear }
        CLS(ToRGBA(0,0,0,0),htx.e)
        
        { Aliasing On? }
        If hag_prefEnable[HAG_PREF_ENABLE_AADRAW] and htx.textAAliasing[htx.style] then AADraw(1)
        
        { Text }
        SetFont(htx.fontName[htx.style],htx.fontSize[htx.style],htx.fontStyle[htx.style],htx.e)
        PenColor(htx.fontColor[htx.style],htx.e)
        
        Case htx.textAlignment[htx.style] of
    
            (HAG_TEXT_LEFT):
                If (TextWidth(htx.txt,htx.e) > htx.w) or (Instr(htx.txt, "\n") > 0) then
                    TextWrap(0,0,htx.w,htx.e,0,htx.txt)                    
                Else
                    Text(0,0,htx.txt,htx.e)
                Endif 
            
            Default:
                 HagLog(LOG_ERROR,"WARNING: RenderText: The type of text-alignment '"+ToString(htx.textAlignment[htx.style])+"' is not yet implemented.")                    
        EndCase
        
        AADraw(0)

        { Done! }
        SpriteRefresh(htx.e)
        htx.toRender = FALSE
    
     //HagLog(LOG_DEBUG,"RenderText: End")
    Dec(log_indent)
End

Procedure PositionText(htx: ^hTexts, x:Integer, y:Integer) ; Export
{
    Repositions a hText element, updating the sprite and the position variables 
}
Var
    dx, dy: Integer
Begin
     HagLog(LOG_DEBUG,"PositionText: ("+ToString(x)+","+ToString(y)+")")

    dx = x - htx.x
    dy = y - htx.y
    
    htx.x = htx.x + dx
    htx.y = htx.y + dy
    SpriteX(htx.e,htx.x)
    SpriteY(htx.e,htx.y)

End

Procedure TextText(htx: ^hTexts, txt:String, w:Integer=-1, h:Integer=-1, ttype:Integer=TXT_TYPE_NORMAL) ; Export
{
    Changes the Text of a hText element 
}
Begin
    If htx.txt <> txt then
         HagLog(LOG_DEBUG,"TextText: ('"+htx.txt+"' -> '"+txt+"')")

        { Auto Text Size }
        If (w = -1) or (h = -1) then
            SetFont(htx.fontName[ttype],htx.fontSize[ttype],htx.fontStyle[ttype],htx.e)
            If htx.textAAliasing[ttype] then AADraw(1)

            If (w > -1) and (h = -1) then
                h = TextWrap(0,0,w,htx.e,0,txt)
            Else
                If h = -1 then h = TextHeight(txt,htx.e)
            Endif             
            If w = -1 then w = TextWidth(txt,htx.e)
            
            If htx.textAAliasing[ttype] then AADraw(0)
        Endif
        
        FreeSprite(htx.e)
        htx.w = w
        htx.h = h
        htx.txt = txt
        htx.style = ttype
        htx.e = CreateGuiSprite(htx.x,htx.y,htx.w,htx.h,TRUE)
        
        RenderText(htx)
    Endif
End

Procedure EnableText(htx: ^hTexts, enable:Boolean=TRUE) ; Export
Begin
     HagLog(LOG_DEBUG,"EnableText: ("+ToString(enable)+")")
    
    htx.enabled = enable
End

Procedure DisableText(htx: ^hTexts) ; Export
Begin
    EnableText(htx,FALSE)
End

Procedure ShowText(htx: ^hTexts, show:Boolean=TRUE) ; Export
{
    Shows or hides text
}
Begin
     HagLog(LOG_DEBUG,"ShowText: ("+ToString(show)+")")
    
    htx.visible = show
    SpriteVisible(htx.e, show)
End

Procedure HideText(htx: ^hTexts) ; Export
Begin
    ShowText(htx,FALSE)
End

Procedure TextFontName(htx: ^hTexts, name: String) ; Export
{
    Provides a nice interface to update the font name for every state in a
    hText element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"TextFontName: ("+ToString(name)+")")

    For i = 0 to (MAX_TXT_TYPES-1)
        htx.fontName[i] = name
    Next
    
    htx.ToRender = TRUE
    
End

Procedure TextFontSize(htx: ^hTexts, size: Integer) ; Export
{
    Provides a nice interface to update the font size for every state in a
    hText element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"TextFontSize: ("+ToString(size)+")")

    For i = 0 to (MAX_TXT_TYPES-1)
        htx.fontSize[i] = size
    Next
    
    htx.toRender = TRUE
    
End

Procedure TextFontStyle(htx: ^hTexts, flags: Integer) ; Export
{
    Provides a nice interface to update the font style for every state in a
    hText element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"TextFontStyle: ("+ToString(flags)+")")

    For i = 0 to (MAX_TXT_TYPES-1)
        htx.fontStyle[i] = flags
    Next
    
    htx.toRender = TRUE
    
End

Procedure TextFontColor(htx: ^hTexts, rgba: Integer) ; Export
{
    Provides a nice interface to update the font colour for every state in a
    hText element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"ButtonFontColor: ("+ToString(rgba)+")")

    For i = 0 to (MAX_TXT_TYPES-1)
        htx.fontColor[i] = rgba
    Next
    
    htx.toRender = TRUE
    
End

Procedure TextFontColour(htx: ^hTexts, rgba: Integer) ; Export
Begin
    TextFontColor(htx,rgba)
End

Procedure TextTextAlignment(htx: ^hTexts, align: Integer) ; Export
{
    Provides a nice interface to update the textalignment for every state in a
    hText element
}
Var
    i: Integer
Begin
    { Not yet implemented }    
End

Procedure TextTextAAliasing(htx: ^hTexts, aa: Boolean) ; Export
{
    Provides a nice interface to update the Text AntiAlias level for every state
    in a hText element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"TextTextAAliasing: ("+ToString(aa)+") '"+htx.txt+"'")

    For i = 0 to (MAX_TXT_TYPES-1)
        htx.textAAliasing[i] = aa
    Next
    
    htx.toRender = TRUE
    
End

Function TextClicked(htx: ^hTexts) : Boolean ; Export
Begin
    result = TextLeftClicked(htx)
End

Function TextLeftClicked(htx: ^hTexts) : Boolean ; Export
Begin
    result = htx.gotLeftClicked
    htx.gotLeftClicked = FALSE
End

Function TextRightClicked(htx: ^hTexts) : Boolean ; Export
Begin
    result = htx.gotRightClicked
    htx.gotRightClicked = FALSE
End

Procedure FlushText(htx: ^hTexts) ; Export
{
    Provides a nice interface to reset a hText element click flags
}
Begin
     HagLog(LOG_DEBUG,"FlushText")
    
    htx.gotLeftClicked = FALSE
    htx.gotRightClicked = FALSE
End

Procedure FreeText(htx: ^hTexts) ; Export
{
    Safely frees a hText element.
}
Begin
     HagLog(LOG_DEBUG,"FreeText:")
    
    FreeImage(htx.e)         
    Free(htx)
    
End












(* -------------------------------------------------------------------------- *)
(* Drop Downs *)
(* -------------------------------------------------------------------------- *)

Procedure RenderDropDown(ddb:^dropDowns)
{
    Renders a complete drop down of a given state (e.g. hover) to the dropdown
    canvas
}
Begin    
    //HagLog(LOG_DEBUG,"RenderDropDown:")
    Inc(log_indent)
        { Clear }
        CLS(ToRGBA(0,0,0,0),ddb.e)
        
        { Image }
        DrawImage(gte_dropdown[DDB_PART_LEFT,ddb.state],  0, 0, ddb.e)
        DrawTiledImage(GET_DROPDOWN, DDB_PART_MID, ddb.state, ImageWidth(gte_dropdown[DDB_PART_LEFT,ddb.state]), 0, ddb.w - ImageWidth(gte_dropdown[DDB_PART_RIGHT,ddb.state]), ddb.h, ddb.e)
        DrawImage(gte_dropdown[DDB_PART_RIGHT,ddb.state], ddb.w - ImageWidth(gte_dropdown[DDB_PART_RIGHT,ddb.state]), 0, ddb.e)
        
        { AAliasing On? }
        If hag_prefEnable[HAG_PREF_ENABLE_AADRAW] and ddb.textAAliasing[ddb.state] then AADraw(1)
        
        { Text }
        SetFont(ddb.fontName[ddb.state],ddb.fontSize[ddb.state],ddb.fontStyle[ddb.state],ddb.e)
        PenColor(ddb.fontColor[ddb.state],ddb.e)
        JustifiedDropDownText(ddb)
        AADraw(0)
        
        { Done! }
        SpriteRefresh(ddb.e)
        ddb.toRender = FALSE
    
    //HagLog(LOG_DEBUG,"RenderDropDown: End")
    Dec(log_indent)
End

Procedure RenderDropDownBox(ddb:^dropDowns)
Var
    byo: Integer
    dh: Integer
    y, y2: Integer
    i: Integer    
Begin
    //HagLog(LOG_DEBUG,"RenderDropDownBox:")
    Inc(log_indent)

        
        { Yoffset }
        byo = dropDown_below_yoffset
        
        { Desired Height }
        dh = ImageHeight(gte_dropDownBox[DDB_PART_BOX_MID_MID]) * (CountList(ddb.ddbOptionList) + 1)
        dh = byo + ddb.h + dh + ImageHeight(gte_dropDownBox[DDB_PART_BOX_TOP_MID]) + ImageHeight(gte_dropDownBox[DDB_PART_BOX_BOTTOM_MID])
        dh = dh + (ImageHeight(gte_dropDownBox[DDB_PART_BOX_MID_MID])/2)
    
        { New }
        //If (SpriteWidth(ddb.ebx) <> ddb.w) or (SpriteHeight(ddb.ebx) <> dh) then
        If (SpriteWidth(ddb.ebx) <> ddb.w) or (SpriteWidth(ddb.ebx) <> dh) then
            FreeSprite(ddb.ebx)
            ddb.ebx = CreateGuiSprite(ddb.x,ddb.y,ddb.w,dh,TRUE)
        Endif        
    
        { Clear }
        CLS(ToRGBA(0,0,0,0),ddb.ebx)
        
        { Image }
            
            { Top }
            DrawImage(gte_dropdownbox[DDB_PART_BOX_TOP_LEFT],  0, ddb.h+byo, ddb.ebx)
            DrawTiledImage(GET_DROPDOWNBOX, DDB_PART_BOX_TOP_MID, 0, ImageWidth(gte_dropdownbox[DDB_PART_BOX_TOP_LEFT]), ddb.h+byo, ddb.w - ImageWidth(gte_dropdownbox[DDB_PART_BOX_TOP_RIGHT]), ImageHeight(gte_dropdownbox[DDB_PART_BOX_TOP_MID]) + ddb.h + byo, ddb.ebx)
            DrawImage(gte_dropdownbox[DDB_PART_BOX_TOP_RIGHT],  ddb.w - ImageWidth(gte_dropdownbox[DDB_PART_BOX_TOP_RIGHT]), ddb.h+byo, ddb.ebx)
            
            { Mid }
            y = ImageHeight(gte_dropdownbox[DDB_PART_BOX_TOP_LEFT])
            y2 = ImageHeight(gte_dropdownbox[DDB_PART_BOX_BOTTOM_LEFT]) 
            DrawTiledImage(GET_DROPDOWNBOX, DDB_PART_BOX_MID_LEFT, 0, 0, ddb.h+byo+y, ImageWidth(gte_dropdownbox[DDB_PART_BOX_MID_LEFT]), (dh-ddb.h)+byo-y2, ddb.ebx)
            DrawTiledImage(GET_DROPDOWNBOX, DDB_PART_BOX_MID_RIGHT, 0, ddb.w - ImageWidth(gte_dropdownbox[DDB_PART_BOX_MID_RIGHT]), ddb.h+byo+y, ddb.w, (dh-ddb.h)+byo-y2, ddb.ebx)
            
            { Mid Mid }
            DrawTiledImage(GET_DROPDOWNBOX, DDB_PART_BOX_MID_MID, 0, ImageWidth(gte_dropdownbox[DDB_PART_BOX_MID_LEFT]), ddb.h+byo+y, ddb.w - ImageWidth(gte_dropdownbox[DDB_PART_BOX_MID_RIGHT]), (dh-ddb.h)+byo-y2, ddb.ebx)
            
            { Bottom }
            y = - ImageHeight(gte_dropdownbox[DDB_PART_BOX_BOTTOM_LEFT])
            DrawImage(gte_dropdownbox[DDB_PART_BOX_BOTTOM_LEFT],  0, (dh-ddb.h)+byo+y, ddb.ebx)
            
            y = - ImageHeight(gte_dropdownbox[DDB_PART_BOX_BOTTOM_MID])
            DrawTiledImage(GET_DROPDOWNBOX, DDB_PART_BOX_BOTTOM_MID, 0, ImageWidth(gte_dropdownbox[DDB_PART_BOX_BOTTOM_LEFT]), (dh-ddb.h)+byo+y, ddb.w - ImageWidth(gte_dropdownbox[DDB_PART_BOX_BOTTOM_RIGHT]), (dh-ddb.h)+byo, ddb.ebx)
            
            y = - ImageHeight(gte_dropdownbox[DDB_PART_BOX_BOTTOM_RIGHT])
            DrawImage(gte_dropdownbox[DDB_PART_BOX_BOTTOM_RIGHT],  ddb.w - ImageWidth(gte_dropdownbox[DDB_PART_BOX_BOTTOM_RIGHT]), (dh-ddb.h)+byo+y, ddb.ebx) 
        
        { Text }
        y = ImageHeight(gte_dropdownbox[DDB_PART_BOX_TOP_MID]) + ddb.h + byo
        y2 = ImageHeight(gte_dropdownbox[DDB_PART_BOX_MID_MID])

        i = 0        
        Loop dropOption through ddb.ddbOptionList

            { AAliasing On? }
            If hag_prefEnable[HAG_PREF_ENABLE_AADRAW] and ddb.textAAliasing[dropOption.state] then AADraw(1)
            
            { Text }
            SetFont(ddb.fontName[dropOption.state],ddb.fontSize[dropOption.state],ddb.fontStyle[dropOption.state],ddb.ebx)
            PenColor(ddb.fontColor[dropOption.state],ddb.ebx)
            
            If dropOption.state = DDB_BOX_STATE_HOVER then
                Rect(ImageWidth(gte_dropdownbox[DDB_PART_BOX_MID_LEFT]), y+(y2*i), ddb.w - ImageWidth(gte_dropdownbox[DDB_PART_BOX_MID_RIGHT]), y2, ddb.backColor[dropOption.state], TRUE, ddb.ebx)
            Endif
            
            Text(ImageWidth(gte_dropdown[DDB_PART_LEFT,ddb.state])+1, y+(y2*i), dropOption.name, ddb.ebx)
            
            AADraw(0)
            Inc(i)
        EndLoop
        
        { Done! }
        SpriteVisible(ddb.ebx, ddb.isDown)
        SpriteRefresh(ddb.ebx)
        ddb.toRenderBox = FALSE
    
    //HagLog(LOG_DEBUG,"RenderDropDownBox: End")
    Dec(log_indent)
End

Procedure EnableDropDown(ddb:^dropDowns, enable:Boolean=TRUE) ; Export
Begin
     HagLog(LOG_DEBUG,"EnableDropDown: ("+ToString(enable)+")")
    
    ddb.enabled = enable
    If enable then
        ddb.state = DDB_STATE_NORMAL
    Else
        ddb.state = DDB_STATE_DISABLED
    Endif
    ddb.toRender = TRUE
End

Procedure DisableDropDown(ddb:^dropDowns) ; Export
Begin
    EnableDropDown(ddb,FALSE)
End

Procedure ShowDropDown(ddb:^dropDowns, show:Boolean=TRUE) ; Export
{
    Shows or hides a drop down box
}
Begin
     HagLog(LOG_DEBUG,"ShowDropDown: ("+ToString(show)+")")
    
    ddb.visible = show
    SpriteVisible(ddb.e, show)
End

Procedure HideDropDown(ddb:^dropDowns) ; Export
Begin
    ShowDropDown(ddb,FALSE)
End

Procedure DropDownText(ddb:^dropDowns, txt: String) ; Export
{
    Provides a nice interface to set the Text of a drop down box.
}
Begin
    HagLog(LOG_DEBUG,"DropDownText: '"+txt+"'")
    
    ddb.txt = txt
    ddb.toRender = TRUE
End

Procedure DropDownAddOption(ddb:^dropDowns, txt: String) ; Export
{
    Provides a nice interface to add an option to the drop down options list
}
Begin
    HagLog(LOG_DEBUG,"DropDownAddOption: '"+txt+"'")
    
    dropOption = NewItem(ddb.ddbOptionList)
    If Assigned(dropOption)
        dropOption.name = txt
    Else
        HagLog(LOG_ERROR,"FATAL: DropDownAddOption: ('"+txt+"') Assignment Error - out of memory?")
    Endif
    
End

Procedure DropDownClearOption(ddb:^dropDowns, n:Integer) ; Export
Begin
    HagLog(LOG_DEBUG,"DropDownClearOption: "+ToString(n))
    
    dropOption = IndexedItem(ddb.ddbOptionList,n)
    Free(dropOption)        
End

Procedure DropDownClearOptions(ddb:^dropDowns) ; Export
Begin
    HagLog(LOG_DEBUG,"DropDownClearOptions:")
    
    Loop dropOption Through ddb.ddbOptionList
        Free(dropOption)
    EndLoop
    
End

Function DropDownClicked(ddb:^dropDowns) : Boolean ; Export
Begin
    result = DropDownLeftClicked(ddb)
End

Function DropDownLeftClicked(ddb:^dropDowns) : Boolean ; Export
Begin
    result = ddb.gotLeftClicked
    ddb.gotLeftClicked = FALSE
End

Function DropDownRightClicked(ddb:^dropDowns) : Boolean ; Export
Begin
    result = ddb.gotRightClicked
    ddb.gotRightClicked = FALSE
End

Function DropDownUpdated(ddb:^dropDowns) : Boolean ; Export
Begin
    result = ddb.gotUpdated
    ddb.gotUpdated = FALSE
End

Procedure FlushDropDown(ddb:^dropDowns) ; Export
{
    Provides a nice interface to reset the drop down box click flags
}
Begin
    HagLog(LOG_DEBUG,"FlushDropDown")
    
    ddb.gotLeftClicked = FALSE
    ddb.gotRightClicked = FALSE
End

Procedure JustifiedDropDownText(ddb:^dropDowns)
{
    Renders Text of a given justification to a drop down canvas
}
Begin

    Case ddb.textAlignment[ddb.state] of
    
        (HAG_TEXT_LEFT):
            Text(ImageWidth(gte_dropdown[DDB_PART_LEFT,ddb.state])+1, Ceil(0.0 + ddb.h/2.0 - TextHeight(ddb.txt,ddb.e)/2.0), ddb.txt, ddb.e)
            
        (HAG_TEXT_CENTER):
            Text(ddb.w/2 - TextWidth(ddb.txt,ddb.e)/2, Ceil(0.0 + ddb.h/2.0 - TextHeight(ddb.txt,ddb.e)/2.0), ddb.txt, ddb.e)
            
        (HAG_TEXT_RIGHT):
            Text(ddb.w - ImageWidth(gte_dropdown[DDB_PART_RIGHT,ddb.state]) - TextWidth(ddb.txt,ddb.e), Ceil(0.0 + ddb.h/2.0 - TextHeight(ddb.txt,ddb.e)/2.0), ddb.txt, ddb.e)
            
        Default:
             HagLog(LOG_ERROR,"WARNING: JustifiedDropDownText: The type of text-alignment '"+ToString(ddb.textAlignment[ddb.state])+"' is not implemented.")
                    
    EndCase
    
End

Procedure FreeDropDown(ddb:^dropDowns) ; Export
{
    Safely frees a drop down box
}
Begin
    HagLog(LOG_DEBUG,"FreeDropDown:")
    
    DropDownClearOptions(ddb)
    
    FreeSprite(ddb.e)
    Free(ddb)
    
End






(* -------------------------------------------------------------------------- *)
(* List Boxes *)
(* -------------------------------------------------------------------------- *)

Procedure RenderListBox(lbx:^listBoxes)
Var
    y, y2: Integer
    i: Integer    
Begin
    //HagLog(LOG_DEBUG,"RenderListBoxBox:")
    Inc(log_indent)
 
    
        { Clear }
        CLS(ToRGBA(0,0,0,0),lbx.e)
        
        { Image }
            
            { Top }
            DrawImage(gte_listbox[LBX_PART_TOP_LEFT, lbx.state],  0, 0, lbx.e)
            DrawTiledImage(GET_LISTBOX, LBX_PART_TOP_MID, 0, ImageWidth(gte_listbox[LBX_PART_TOP_LEFT, lbx.state]), 0, lbx.w - ImageWidth(gte_listbox[LBX_PART_TOP_LEFT, lbx.state]), ImageHeight(gte_listbox[LBX_PART_TOP_MID, lbx.state]), lbx.e)
            DrawImage(gte_listbox[LBX_PART_TOP_RIGHT, lbx.state],  lbx.w - ImageWidth(gte_listbox[DDB_PART_BOX_TOP_RIGHT, lbx.state]), 0, lbx.e)
            
            { Mid }
            y = ImageHeight(gte_listbox[LBX_PART_TOP_LEFT, lbx.state])
            y2 = ImageHeight(gte_listbox[LBX_PART_BOTTOM_LEFT, lbx.state]) 
            DrawTiledImage(GET_LISTBOX, LBX_PART_MID_LEFT, lbx.state, 0, y, ImageWidth(gte_listbox[LBX_PART_MID_LEFT, lbx.state]), lbx.h - y, lbx.e)
            DrawTiledImage(GET_LISTBOX, LBX_PART_MID_RIGHT, lbx.state, lbx.w - ImageWidth(gte_listbox[LBX_PART_MID_RIGHT, lbx.state]), y2, lbx.w, lbx.h - y2, lbx.e)
            
            { Mid Mid }
            y = ImageHeight(gte_listbox[LBX_PART_TOP_MID, lbx.state])
            DrawTiledImage(GET_LISTBOX, LBX_PART_MID_MID, lbx.state, ImageWidth(gte_listbox[LBX_PART_MID_LEFT, lbx.state]), y, lbx.w - ImageWidth(gte_listbox[LBX_PART_MID_RIGHT, lbx.state]), lbx.h - y, lbx.e) 
            
            
        { Text }
        y = ImageHeight(gte_listbox[LBX_PART_TOP_MID, lbx.state])
        y2 = ImageHeight(gte_listbox[LBX_PART_MID_MID, lbx.state])        

        i = 0        
        Loop listOption through lbx.lbxOptionList

            { AAliasing On? }
            If hag_prefEnable[HAG_PREF_ENABLE_AADRAW] and lbx.textAAliasing[listOption.state] then AADraw(1)
            
            { Text }
            SetFont(lbx.fontName[listOption.state],lbx.fontSize[listOption.state],listOption.fontStyle[listOption.state],lbx.e)
            PenColor(listOption.fontColor[listOption.state],lbx.e)
            
            If (lbx.backColor[listOption.state] <> ToRGBA(255,255,255)) then
                Rect(ImageWidth(gte_listBox[LBX_PART_MID_LEFT, lbx.state]), y+(y2*i) -listBox.sbr.sbrOffset, lbx.w - ImageWidth(gte_listbox[LBX_PART_MID_RIGHT, lbx.state]) - ImageWidth(gte_listbox[LBX_PART_MID_LEFT, lbx.state]), y2, lbx.backColor[listOption.state], TRUE, lbx.e)
            Endif
            
            Text(ImageWidth(gte_listbox[LBX_PART_MID_LEFT,lbx.state])+3, y+(y2*i) -listBox.sbr.sbrOffset, listOption.name, lbx.e)
            
            AADraw(0)
            Inc(i)
        EndLoop
        
        { Image }
        
            { Bottom }
            y = ImageHeight(gte_listbox[LBX_PART_BOTTOM_LEFT, lbx.state])
            DrawImage(gte_listbox[LBX_PART_BOTTOM_LEFT, lbx.state],  0, lbx.h - y, lbx.e)
            
            y = ImageHeight(gte_listbox[LBX_PART_BOTTOM_MID, lbx.state])
            DrawTiledImage(GET_LISTBOX, LBX_PART_BOTTOM_MID, lbx.state, ImageWidth(gte_listbox[LBX_PART_BOTTOM_LEFT, lbx.state]), lbx.h - y, lbx.w - ImageWidth(gte_listbox[LBX_PART_BOTTOM_RIGHT, lbx.state]), lbx.h, lbx.e)
            
            y = ImageHeight(gte_listbox[LBX_PART_BOTTOM_RIGHT, lbx.state])
            DrawImage(gte_listbox[LBX_PART_BOTTOM_RIGHT, lbx.state],  lbx.w - ImageWidth(gte_listbox[LBX_PART_BOTTOM_RIGHT, lbx.state]), lbx.h - y, lbx.e)
        
        { Done! }
        SpriteRefresh(lbx.e)
        lbx.toRender = FALSE
    
    //HagLog(LOG_DEBUG,"RenderListBox: End")
    Dec(log_indent)
End

Procedure EnableListBox(lbx:^ListBoxes, enable:Boolean=TRUE) ; Export
Begin
     HagLog(LOG_DEBUG,"EnableListBpx: ("+ToString(enable)+")")
    
    lbx.enabled = enable
    If enable then
        lbx.state = LBX_STATE_NORMAL
        EnableScrollBar(lbx.sbr, TRUE)
        
        Loop listOption through lbx.lbxOptionList
            listOption.state = LBX_ITEM_STATE_NORMAL
        EndLoop
        
    Else
        lbx.state = LBX_STATE_DISABLED
        EnableScrollBar(lbx.sbr, FALSE)
        
        Loop listOption through lbx.lbxOptionList
            listOption.state = LBX_ITEM_STATE_DISABLED
        EndLoop
        
    Endif
    lbx.toRender = TRUE
End

Procedure DisableListBox(lbx:^ListBoxes) ; Export
Begin
    EnableListBox(lbx,FALSE)
End

Procedure ShowListBox(lbx:^listBoxes, show:Boolean=TRUE) ; Export
{
    Shows or hides a list box
}
Begin
     HagLog(LOG_DEBUG,"ShowListBox: ("+ToString(show)+")")
    
    lbx.visible = show
    SpriteVisible(lbx.e, show)
    ShowScrollBar(lbx.sbr, show)
End

Procedure HideListBox(lbx:^listBoxes) ; Export
Begin
    ShowListBox(lbx,FALSE)
End

Function ListBoxAddOption(lbx:^listBoxes, txt: String) : ^listOptions ; Export
{
    Provides a nice interface to add an option to the listBox list
}
Var
    i: Integer
Begin
    HagLog(LOG_DEBUG,"ListBoxAddOption: '"+txt+"'")
    
    listOption = NewItem(lbx.lbxOptionList)
    If Assigned(listOption)
        
        listOption.name = txt
        
        For i = 0 to (MAX_LBX_ITEM_STATES-1)
            listOption.fontStyle[i] = lbx.fontStyle[i]
            listOption.fontColor[i] = lbx.fontColor[i]
        Next
        
        result = listOption
    Else
        HagLog(LOG_ERROR,"FATAL: ListBoxAddOption: ('"+txt+"') Assignment Error - out of memory?")
    Endif
    
    lbx.gotUpdated = TRUE
    lbx.toRender = TRUE
    
End

Procedure ListOptionFontColor(lbx: ^listBoxes, lop: ^listOptions, rgba: Integer) ; Export
{
    Provides a nice interface to update the font colour of a single listOption
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"ListOptionFontColor: ("+ToString(rgba)+")")

    For i = 0 to (MAX_LBX_ITEM_STATES-1)
        lop.fontColor[i] = rgba
    Next
    
    lbx.toRender = TRUE
    
End

Procedure ListOptionFontStyle(lbx: ^listBoxes, lop: ^listOptions, style: Integer) ; Export
{
    Provides a nice interface to update the font style of a single listOption
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"ListOptionFontStyle: ("+ToString(style)+")")

    For i = 0 to (MAX_LBX_ITEM_STATES-1)
        lop.fontStyle[i] = style
    Next
    
    lbx.toRender = TRUE
    
End

Procedure EnableListOption(lbx: ^listBoxes, lop: ^listOptions, enable: Boolean=TRUE) ; Export
{
    Provides a nice interface to enable or disable listOptions
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"EnableListOption: ("+ToString(enable)+")")

    If enable then lop.state = LBX_ITEM_STATE_NORMAL else lop.state = LBX_ITEM_STATE_DISABLED
    
    lbx.toRender = TRUE
    
End

Procedure DisableListOption(lbx: ^listBoxes, lop: ^listOptions) ; Export
Begin
    EnableListOption(lbx, lop, FALSE)
End

Procedure ListBoxRemoveOption(lbx:^listBoxes, lop:^listOptions) ; Export
Begin
    HagLog(LOG_DEBUG,"ListBoxRemoveOption: '"+lop.name+"'")
    
    Free(lop)
    
    lbx.sbr.sbrOffset = 0
    lbx.gotUpdated = TRUE
    lbx.toRender = TRUE
End

Procedure ListBoxClearOptions(lbx:^listBoxes) ; Export
Begin
    HagLog(LOG_DEBUG,"ListBoxClearOptions:")
    
    Loop listOption Through lbx.lbxOptionList
        Free(listOption)
    EndLoop
    
    lbx.sbr.sbrOffset = 0
    lbx.gotUpdated = TRUE
    lbx.toRender = TRUE
End

Function ListBoxOptionsCount(lbx: ^listBoxes) : Integer ; Export
Begin

    result = CountList(lbx.lbxOptionList)

End

Function ListBoxOptionHandle(lbx: ^listBoxes, id: Integer) :^listOptions ; Export
Begin

    result = IndexedItem(lbx.lbxOptionList, id)

End

Function ListBoxSelectionExists(lbx: ^listBoxes) : Boolean ; Export
Begin

    result = ItemInList(lbx.lbxOptionList, lbx.optionSelected) > -1

End

Function ListBoxSelectionHandle(lbx: ^listBoxes) : ^listOptions ; export
Begin

    result = lbx.optionSelected

End

Function ListBoxSelectionId(lbx: ^listBoxes) : String ; export
Begin

    result = ItemInList(lbx.lbxOptionList, lbx.optionSelected)

End

Function ListBoxSelectionString(lbx: ^listBoxes) : String ; export
Begin

    result = lbx.optionSelected.name

End

Procedure ListBoxSetScrollSpeed(lbx: ^listBoxes, speed: Integer) ; Export
Begin
    ScrollbarSetSpeed(lbx.sbr, speed)
End

Procedure FlushListBox(lbx:^listBoxes) ; Export
{
    Provides a nice interface to reset the list box click flags
}
Begin
    HagLog(LOG_DEBUG,"FlushListBox")
    
    lbx.gotLeftClicked = FALSE
    lbx.gotRightClicked = FALSE
    lbx.gotUpdated = FALSE
End

Procedure FreeListBox(lbx:^listBoxes) ; Export
{
    Safely frees a list box
}
Begin
    HagLog(LOG_DEBUG,"FreeListBox:")
    
    ListBoxClearOptions(lbx)
    FreeScrollBar(lbx.sbr)
    
    FreeSprite(lbx.e)
    Free(lbx)
    
End








(* -------------------------------------------------------------------------- *)
(* Scrollbars *)
(* -------------------------------------------------------------------------- *)

Procedure RenderScrollBar(sbr:^scrollBars)
Var
    y1, y2, y3, y4: Integer
    i: Integer    
Begin
    //HagLog(LOG_DEBUG,"RenderScrollBar:")
    Inc(log_indent)
 
    
        { Clear }
        CLS(ToRGBA(0,0,0,0),sbr.e)
        
        { Image }
            
            { Bar }
            DrawTiledImage(GET_SCROLLBAR, SBR_PART_BAR, sbr.state, 0, 0, sbr.w, sbr.h, sbr.e)
        
            { Up }
            DrawImage(gte_scrollBar[SBR_PART_UP, sbr.stateUp],  0, 0, sbr.e)

            { Down }
            DrawImage(gte_scrollBar[SBR_PART_DOWN, sbr.stateDown],  0, sbr.h - ImageHeight(gte_scrollBar[SBR_PART_DOWN, sbr.stateUp]), sbr.e)
            
            { Mid }
            y1 = ImageHeight(gte_scrollBar[SBR_PART_UP, sbr.stateUp])
            y2 = sbr.h - ImageHeight(gte_scrollBar[SBR_PART_DOWN, sbr.stateUp]) - ImageHeight(gte_scrollBar[SBR_PART_SLIDER, sbr.stateSlider])
            y3 = y2 - y1

            If (sbr.state <> SBR_STATE_DISABLED) and (sbr.sbrLength > 0) then
                y4 = Floor(   (ToReal(sbr.sbrOffset) / ToReal(sbr.sbrLength - sbr.h)) * ToReal(y3) )

                DrawImage(gte_scrollBar[SBR_PART_SLIDER, sbr.stateSlider], 0, y1 + y4, sbr.e)
            Endif

            
        { Done! }
        SpriteRefresh(sbr.e)
        sbr.toRender = FALSE
    
    //HagLog(LOG_DEBUG,"RenderScrollBar: End")
    Dec(log_indent)
End

Procedure ResetScrollBar(sbr: ^scrollBars) ; export
Begin
    sbr.mWheel = MouseWheel
    sbr.sbrOffset = 0
    sbr.toRender = TRUE
End

Procedure SetScrollBarMouseWheelTargetElement(sbr: ^scrollBars, e: Element) ; export
Begin
    sbr.scrollTarget = e
End

Procedure EnableScrollBar(sbr: ^scrollBars, enable: Boolean = TRUE) ; export
Begin
    HagLog(LOG_DEBUG,"EnableScrollBar: ("+ToString(enable)+")")
    
    sbr.enabled = enable
    If enable then
        sbr.state = SBR_STATE_NORMAL
    Else
        sbr.state = SBR_STATE_DISABLED
    Endif
    sbr.toRender = TRUE
End

Procedure DisableScrollBar(sbr: ^scrollBars) ; export
Begin
    EnableScrollBar(sbr, FALSE)
End

Procedure ShowScrollBar(sbr: ^scrollBars, show: Boolean = TRUE) ; export
Begin
    HagLog(LOG_DEBUG,"HideScrollBar: ("+ToString(show)+")")
    
    sbr.visible = show
    SpriteVisible(sbr.e, show)
End

Procedure HideScrollBar(sbr: ^scrollBars) ; export
Begin
    ShowScrollBar(sbr, FALSE)
End

Procedure ScrollBarSetLength(sbr: ^scrollBars, sbrLength: Integer) ; export
Begin
    HagLog(LOG_DEBUG,"ScrollBarSetLength: ("+ToString(sbrLength)+")")

    sbr.sbrLength = sbrLength
End

Procedure ScrollBarSetOffset(sbr: ^scrollBars, sbrOffset: Integer) ; export
Begin
    HagLog(LOG_DEBUG,"ScrollBarSetOffset: ("+ToString(sbrOffset)+")")

    sbr.sbrOffset = sbrOffset
End

Procedure ScrollBarSetSpeed(sbr: ^scrollBars, speed: Integer) ; export
Begin
    HagLog(LOG_DEBUG,"ScrollBarSetSpeed: ("+ToString(speed)+")")

    sbr.scrollSpeed = speed
End

Function ScrollBarUpdated(sbr: ^scrollBars): Boolean ; export
Begin
    result = (sbr.sbrOffset <> sbr.sbrLastOffset)
    sbr.sbrLastOffset = sbr.sbrOffset 
End

Function ScrollBarOffset(sbr: ^scrollBars): Integer ; export
Begin
    result = sbr.sbrOffset
End

Function ScrollBarPercent(sbr: ^scrollBars): Real ; export
Begin
    result = (ToReal(sbr.sbrOffset) / ToReal(sbr.sbrLength - sbr.h)) * 100.0
End

Procedure FreeScrollBar(sbr: ^scrollBars) ; export
Begin
    FreeSprite(sbr.e)
    Free(sbr)
End













(* -------------------------------------------------------------------------- *)
(* Timers *)
(* -------------------------------------------------------------------------- *)

Function TimerActivated(tmr: ^timers) : Boolean ; Export
Begin
    result = tmr.gotActivated
    tmr.gotActivated = FALSE
End

Procedure FreeTimer(tmr: ^timers) ; Export
{
    Safely frees a timer element
}
Begin
     HagLog(LOG_DEBUG,"FreeTimer:")    
        
    Free(tmr)    
End









(* -------------------------------------------------------------------------- *)
(* Tab Groups *)
(* -------------------------------------------------------------------------- *)

Procedure PositionTabGroup(grp: ^tabGroups, x:Integer, y:Integer) ; Export
{
    Repositions a tab group, updating the positions of all child elements.
}
Var
    dx, dy: Integer
Begin
     HagLog(LOG_DEBUG,"PositionTabGroup: ("+ToString(x)+","+ToString(y)+")")

    dx = x - grp.x
    dy = y - grp.y
    
    Loop tab through grp.grpTabList
        tab.x = tab.x + dx
        tab.y = tab.y + dy
        SpriteX(tab.e,tab.x)
        SpriteY(tab.e,tab.y)
    EndLoop

    grp.x = x
    grp.y = y
End

Procedure EnableTabGroup(grp: ^tabGroups, enable:Boolean, allChildren:Boolean=FALSE) ; Export
{
    Enables or disables a tab group for input, optionally updating all child
    elements in the same way.
}
Begin
     HagLog(LOG_DEBUG,"EnableTabGroup: ("+ToString(enable)+")")
    Inc(log_indent)
        
        If allChildren then
            Loop tab through grp.grpTabList
                EnableTab(tab,enable)
            EndLoop
        Endif
    
    grp.enabled = enable
    
    Dec(log_indent)
End

Procedure DisableTabGroup(grp: ^tabGroups, allChildren:Boolean=FALSE) ; Export
Begin
    EnableTabGroup(grp,FALSE, allChildren)
End

Procedure ShowTabGroup(grp: ^tabGroups, show:Boolean) ; Export
{
    Shows or hides all child elements of a tab group
}
Begin
     HagLog(LOG_DEBUG,"ShowTabGroup: ("+ToString(show)+")")
    Inc(log_indent)

        Loop tab through grp.grpTabList
            ShowTab(tab,show)
        EndLoop
    
    grp.visible = show
    
    Dec(log_indent)
End

Procedure HideTabGroup(grp: ^tabGroups) ; Export
Begin
    ShowTabGroup(grp,FALSE)
End

Function SelectedTab(grp: ^tabGroups) : ^ tabs ; Export
Begin

        Loop tab through grp.grpTabList
            If tab.selected then
                result = tab
                Exit
            Endif
        EndLoop

     HagLog(LOG_ERROR,"WARNING: SelectedTabButton: Nothing selected (this should not happen)")

End

Procedure FreeTabGroup(grp: ^tabGroups) ; Export
{
    Safely frees a tab group.
}
Begin
     HagLog(LOG_DEBUG,"FreeTabGroup")
    Inc(log_indent)
    
        Loop tab through grp.grpTabList
            FreeTab(tab)
        EndLoop
         
        Free(grp)
    
    Dec(log_indent)
End








(* -------------------------------------------------------------------------- *)
(* Tabs *)
(* -------------------------------------------------------------------------- *)

Procedure RenderTab(tab:^tabs)
{
    Renders a complete button of a given state (e.g. hover) to the button canvas
}
Begin
    
     //HagLog(LOG_DEBUG,"RenderTab: '"+tab.txt+"'")
    Inc(log_indent)

        { Clear }
        CLS(ToRGBA(0,0,0,0),tab.e)
        
        { Image }
        DrawImage(gte_tab[TAB_PART_LEFT,tab.state],  0, tab.h - ImageHeight(gte_tab[TAB_PART_LEFT,tab.state]), tab.e)
        DrawTiledImage(GET_TAB, TAB_PART_MID, tab.state, ImageWidth(gte_tab[TAB_PART_LEFT,tab.state]), tab.h - ImageHeight(gte_tab[TAB_PART_MID,tab.state]), tab.w - ImageWidth(gte_tab[TAB_PART_RIGHT,tab.state]), tab.h, tab.e)
        DrawImage(gte_tab[TAB_PART_RIGHT,tab.state], tab.w - ImageWidth(gte_tab[TAB_PART_RIGHT,tab.state]), tab.h - ImageHeight(gte_tab[TAB_PART_RIGHT,tab.state]), tab.e)

        { Aliasing On? }
        If hag_prefEnable[HAG_PREF_ENABLE_AADRAW] and tab.textAAliasing[tab.state] then AADraw(1)
        
        { Text }
        SetFont(tab.fontName[tab.state],tab.fontSize[tab.state],tab.fontStyle[tab.state],tab.e)
        PenColor(tab.fontColor[tab.state],tab.e)
        JustifiedTabText(tab)
        AADraw(0)

        { Done! }
        SpriteRefresh(tab.e)
        tab.toRender = FALSE
    
     //HagLog(LOG_DEBUG,"RenderTab: End")
    Dec(log_indent)
End

Procedure PositionTab(tab: ^tabs, x:Integer, y:Integer) ; Export
{
    Repositions a tab, updating the sprite and the position variables 
}
Var
    dx, dy: Integer
Begin
     HagLog(LOG_DEBUG,"PositionTab: ("+ToString(x)+","+ToString(y)+") '"+tab.txt+"'")

    dx = x - tab.x
    dy = y - tab.y
    
    tab.x = tab.x + dx
    tab.y = tab.y + dy
    SpriteX(tab.e,tab.x)
    SpriteY(tab.e,tab.y)

End

Procedure ResizeTab(tab: ^tabs, w:Integer) ; Export
{
    Resizes a tab 
}
Begin
     HagLog(LOG_DEBUG,"ResizeTab: ("+ToString(tab.w)+" -> "+ToString(w)+") '"+tab.txt+"'")

    FreeSprite(tab.e)
    
    tab.w = w
    tab.e = CreateGuiSprite(tab.x,tab.y,tab.w,tab.h,TRUE)
  
    RenderTab(tab)
End

Procedure EnableTab(tab: ^tabs, enable:Boolean=TRUE) ; Export
Begin
     HagLog(LOG_DEBUG,"EnableTab: ("+ToString(enable)+") '"+tab.txt+"'")
    
    tab.enabled = enable
    tab.toRender = TRUE
End

Procedure DisableTab(tab: ^tabs) ; Export
Begin
    EnableTab(tab,FALSE)
End

Procedure ShowTab(tab: ^tabs, show:Boolean=TRUE) ; Export
{
    Shows or hides a tab
}
Begin
     HagLog(LOG_DEBUG,"ShowTab: ("+ToString(show)+") '"+tab.txt+"'")
    
    tab.visible = show
    SpriteVisible(tab.e, show)
End

Procedure HideTab(tab: ^tabs) ; Export
Begin
    ShowTab(tab,FALSE)
End

Procedure TabFontName(tab: ^tabs, name: String) ; Export
{
    Provides a nice interface to update the font name for every state in a
    tab element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"TabFontName: ("+ToString(name)+") '"+tab.txt+"'")

    For i = 0 to (MAX_TAB_STATES-1)
        tab.fontName[i] = name
    Next
    
    tab.toRender = TRUE
    
End

Procedure TabFontSize(tab: ^tabs, size: Integer) ; Export
{
    Provides a nice interface to update the font size for every state in a
    tab element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"TabFontSize: ("+ToString(size)+") '"+tab.txt+"'")

    For i = 0 to (MAX_TAB_STATES-1)
        tab.fontSize[i] = size
    Next
    
    tab.toRender = TRUE
    
End

Procedure TabFontStyle(tab: ^tabs, flags: Integer) ; Export
{
    Provides a nice interface to update the font style for every state in a
    tab element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"TabFontStyle: ("+ToString(flags)+") '"+tab.txt+"'")

    For i = 0 to (MAX_TAB_STATES-1)
        tab.fontStyle[i] = flags
    Next
    
    tab.toRender = TRUE
    
End

Procedure TabFontColor(tab: ^tabs, rgba: Integer) ; Export
{
    Provides a nice interface to update the font colour for every state in a
    tab element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"TabFontColor: ("+ToString(rgba)+") '"+tab.txt+"'")

    For i = 0 to (MAX_TAB_STATES-1)
        tab.fontColor[i] = rgba
    Next
    
    tab.toRender = TRUE
    
End

Procedure TabFontColour(tab: ^tabs, rgba: Integer) ; Export
Begin
    TabFontColor(tab,rgba)
End

Procedure TabTextAlignment(tab: ^tabs, align: Integer) ; Export
{
    Provides a nice interface to update the textalignment for every state in a
    tab element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"TabTextAlignment: ("+ToString(align)+") '"+tab.txt+"'")

    For i = 0 to (MAX_TAB_STATES-1)
        tab.textAlignment[i] = align
    Next
    
    tab.toRender = TRUE
    
End

Procedure TabTextAAliasing(tab: ^tabs, aa: Boolean) ; Export
{
    Provides a nice interface to update the Text AntiAlias level for every state
    in a tab element
}
Var
    i: Integer
Begin
     HagLog(LOG_DEBUG,"TabTextAAliasing: ("+ToString(aa)+") '"+tab.txt+"'")

    For i = 0 to (MAX_TAB_STATES-1)
        tab.textAAliasing[i] = aa
    Next
    
    tab.toRender = TRUE
    
End

Function TabClicked(tab: ^tabs) : Boolean ; Export
Begin
    result = TabLeftClicked(tab)
End

Function TabLeftClicked(tab: ^tabs) : Boolean ; Export
Begin
    result = tab.gotLeftClicked
    tab.gotLeftClicked = FALSE
End

Function TabRightClicked(tab: ^tabs) : Boolean ; Export
Begin
    result = tab.gotRightClicked
    tab.gotRightClicked = FALSE
End

Procedure FlushTab(tab: ^tabs) ; Export
{
    Provides a nice interface to reset the tab click flags
}
Begin
     HagLog(LOG_DEBUG,"FlushTab")
    
    tab.gotLeftClicked = FALSE
    tab.gotRightClicked = FALSE
End

Procedure JustifiedTabText(tab:^tabs)
{
    Renders Text of a given justification to a tab canvas
}
Var
    yMid: Integer
Begin

    yMid = tab.h - ImageHeight(gte_tab[TAB_PART_MID,tab.state])
    yMid = tab.h/2 - TextHeight(tab.txt,tab.e)/2 + yMid

    Case tab.textAlignment[tab.state] of
    
        (HAG_TEXT_LEFT):
            Text(ImageWidth(gte_tab[BTN_PART_LEFT,tab.state]), yMid, tab.txt, tab.e)
            
        (HAG_TEXT_CENTER):
            Text(tab.w/2 - TextWidth(tab.txt,tab.e)/2, yMid, tab.txt, tab.e)
            
        (HAG_TEXT_RIGHT):
            Text(tab.w - ImageWidth(gte_tab[TAB_PART_RIGHT,tab.state]) - TextWidth(tab.txt,tab.e), yMid, tab.txt, tab.e)

        Default:
             HagLog(LOG_ERROR,"WARNING: JustifiedTabText: The type of text-alignment '"+ToString(tab.textAlignment[tab.state])+"' is not implemented.")
                    
    EndCase
    
End

Procedure FreeTab(tab: ^tabs) ; Export
{
    Safely frees a tab.
}
Begin
     HagLog(LOG_DEBUG,"FreeTab: '"+tab.txt+"'")
    
    FreeImage(tab.e)         
    Free(tab)
    
End










(* -------------------------------------------------------------------------- *)
(* FRAMES *)
(* -------------------------------------------------------------------------- *)

Procedure RenderFrame(frame:^frames)
{
    Renders a complete frame of a given style (e.g. tab) to the frame canvas
}
Var
    topmid_xoffset : Integer = 0
Begin
    
    //HagLog(LOG_DEBUG,"RenderFrame: '"+frame.txt+"'")
    Inc(log_indent)

        { Aliasing On? }
        If hag_prefEnable[HAG_PREF_ENABLE_AADRAW] and frame.textAAliasing[frame.style] then AADraw(1)
        
        { Text }
        If frame.fontSize[frame.style] > 0 then
            SetFont(frame.fontName[frame.style],frame.fontSize[frame.style],frame.fontStyle[frame.style],frame.e)
            PenColor(frame.fontColor[frame.style],frame.e)
        Endif
        
        { Custom }
        Case frame.style of
            (FRAME_STYLE_ROUNDBORDER):
                If Length(frame.txt) > 0 then topmid_xoffset = TextWidth(frame.txt,frame.e) + 8
        EndCase
    
    

        { Clear }
        CLS(ToRGBA(0,0,0,0),frame.e)
        
        { Image : Top }
        DrawImage(gte_frame[FRA_PART_TOP_LEFT,frame.style],  0, 0, frame.e)
        DrawTiledImage(GET_FRAME, FRA_PART_TOP_MID, frame.style, ImageWidth(gte_frame[FRA_PART_TOP_LEFT,frame.style]) + topmid_xoffset, 0, frame.w - ImageWidth(gte_frame[FRA_PART_TOP_RIGHT,frame.style]), ImageHeight(gte_frame[FRA_PART_TOP_LEFT,frame.style]), frame.e)
        DrawImage(gte_frame[FRA_PART_TOP_RIGHT,frame.style],  frame.w - ImageWidth(gte_frame[FRA_PART_TOP_RIGHT,frame.style]), 0, frame.e)

        { Image : Middle }
        DrawTiledImage(GET_FRAME, FRA_PART_MID_LEFT, frame.style, 0, ImageHeight(gte_frame[FRA_PART_TOP_LEFT,frame.style]), ImageWidth(gte_frame[FRA_PART_MID_LEFT,frame.style]), frame.h - ImageHeight(gte_frame[FRA_PART_BOTTOM_LEFT,frame.style]), frame.e)
        DrawTiledImage(GET_FRAME, FRA_PART_MID_MID, frame.style, ImageWidth(gte_frame[FRA_PART_MID_LEFT,frame.style]), ImageHeight(gte_frame[FRA_PART_TOP_LEFT,frame.style]), frame.w - ImageWidth(gte_frame[FRA_PART_MID_RIGHT,frame.style]), frame.h - ImageHeight(gte_frame[FRA_PART_BOTTOM_MID,frame.style]), frame.e)
        DrawTiledImage(GET_FRAME, FRA_PART_MID_RIGHT, frame.style, frame.w - ImageWidth(gte_frame[FRA_PART_MID_RIGHT,frame.style]), ImageHeight(gte_frame[FRA_PART_TOP_LEFT,frame.style]), frame.w , frame.h - ImageHeight(gte_frame[FRA_PART_BOTTOM_LEFT,frame.style]), frame.e)
        
        { Image : Bottom }
        DrawImage(gte_frame[FRA_PART_BOTTOM_LEFT,frame.style],  0, frame.h - ImageHeight(gte_frame[FRA_PART_BOTTOM_MID,frame.style]), frame.e)
        DrawTiledImage(GET_FRAME, FRA_PART_BOTTOM_MID, frame.style, ImageWidth(gte_frame[FRA_PART_BOTTOM_LEFT,frame.style]), frame.h - ImageHeight(gte_frame[FRA_PART_BOTTOM_MID,frame.style]), frame.w - ImageWidth(gte_frame[FRA_PART_BOTTOM_RIGHT,frame.style]), frame.h, frame.e)
        DrawImage(gte_frame[FRA_PART_BOTTOM_RIGHT,frame.style],  frame.w - ImageWidth(gte_frame[FRA_PART_BOTTOM_RIGHT,frame.style]), frame.h - ImageHeight(gte_frame[FRA_PART_BOTTOM_MID,frame.style]), frame.e)

        
        If frame.fontSize[frame.style] > 0 then
            If Length(frame.txt) > 0 then FrameText(frame)
            AADraw(0)
        Endif

        { Done! }
        SpriteRefresh(frame.e)
        frame.toRender = FALSE
    
     //HagLog(LOG_DEBUG,"RenderFrame: End")
    Dec(log_indent)
End

Procedure PositionFrame(fra: ^frames, x:Integer, y:Integer) ; Export
{
    Repositions a frame, updating the sprite and the position variables 
}
Var
    dx, dy: Integer
Begin
     HagLog(LOG_DEBUG,"PositionFrame: ("+ToString(x)+","+ToString(y)+") '"+fra.txt+"'")

    dx = x - fra.x
    dy = y - fra.y
    
    fra.x = fra.x + dx
    fra.y = fra.y + dy
    SpriteX(fra.e,fra.x)
    SpriteY(fra.e,fra.y)

End

Procedure ResizeFrame(fra: ^frames, w:Integer) ; Export
{
    Resizes a frame
}
Begin
     HagLog(LOG_DEBUG,"ResizeTab: ("+ToString(fra.w)+" -> "+ToString(w)+") '"+fra.txt+"'")

    FreeSprite(fra.e)
    
    fra.w = w
    fra.e = CreateGuiSprite(fra.x,fra.y,fra.w,fra.h,TRUE)
  
    RenderFrame(fra)
End

Procedure ShowFrame(fra: ^frames, show:Boolean=TRUE) ; Export
{
    Shows or hides a frame
}
Begin
     HagLog(LOG_DEBUG,"ShowFrame: ("+ToString(show)+") '"+fra.txt+"'")
    
    fra.visible = show
    SpriteVisible(fra.e, show)
End

Procedure HideFrame(fra: ^frames) ; Export
Begin
    ShowFrame(fra,FALSE)
End

Procedure FrameText(fra: ^frames)
{
    Renders Text of a given justification / style to a frame canvas
}
Begin

    Case (fra.style) of
        
        (FRAME_STYLE_ROUNDBORDER):
            Text(ImageWidth(gte_frame[FRA_PART_TOP_LEFT,fra.style]) + 4, 0, fra.txt, fra.e)
        
        (FRAME_STYLE_ROUNDSOLID):
            Text(ImageWidth(gte_frame[FRA_PART_TOP_LEFT,fra.style]), ImageHeight(gte_frame[FRA_PART_TOP_MID,fra.style])/2, fra.txt, fra.e)
        
        (FRAME_STYLE_MOCKWINDOW):
            Text(ImageWidth(gte_frame[FRA_PART_TOP_LEFT,fra.style]), Ceil(0.0 + ImageHeight(gte_frame[FRA_PART_TOP_MID,fra.style])/2.0 - TextHeight(fra.txt,fra.e)/2.0) + 1, fra.txt, fra.e)
        
        (FRAME_STYLE_HEADER):
            Text(ImageWidth(gte_frame[FRA_PART_TOP_LEFT,fra.style])/2, ImageHeight(gte_frame[FRA_PART_TOP_MID,fra.style]), fra.txt, fra.e)
        
        Default:
             HagLog(LOG_ERROR,"WARNING: FrameText: The type of style '"+ToString(fra.style)+"' has no applicable text context. The theme author should specify a font-size of zero in the theme, or you may have an outdated version of hag.")
                    
    EndCase
    
End

Procedure FreeFrame(fra: ^frames) ; Export
{
    Safely frees a frame.
}
Begin
     HagLog(LOG_DEBUG,"FreeFrame: '"+fra.txt+"'")
    
    FreeImage(fra.e)         
    Free(fra)
    
End






(* -------------------------------------------------------------------------- *)
(* TILE CACHE *)
(* -------------------------------------------------------------------------- *)

Procedure DrawTiledImage(get:Integer, part:Integer, state:Integer, x1:Integer, y1:Integer, x2:Integer, y2:Integer, e:Element)
{
    Draws a tiled image to a given element.
    
    If the image hasn't been tiled before, the image is cached for next time.
    
    If the image has been drawn before, the cached image is drawn instead of
    tiling a new one.
    
    This saves time as tiling is an expensive procedure, however there is a
    trade-off with memory and time spent looking up cached images. Depending
    on your use, yoy may want to set HAG_PREF_ENABLE_TILE_CACHE to FALSE to
    disable this behaviour. 
}
Var
    ce: Element = NULL
    nt: ^tileCaches
Begin
    
    If hag_prefEnable[HAG_PREF_ENABLE_TILE_CACHE] then

        ce = TiledImageHandle(get, part, state, (x2-x1), (y2-y1))
        If ce = NULL then
             HagLog(LOG_DEBUG,"DrawTiledImage: Caching a new pre-tiled image...")
            Inc(log_indent)
            
            nt = NewTiledImage(get, part, state, (x2-x1), (y2-y1))
            RenderTiledImage(get, part, state, 0, 0, (x2-x1), (y2-y1), nt.e)
            ce = nt.e
            
            Dec(log_indent)
        Else
             //HagLog(LOG_DEBUG,"DrawTiledImage: Found existing cached image, using.") 
        Endif
    
        DrawImage(ce,x1,y1,e)        
    
    Else
         //HagLog(LOG_DEBUG,"DrawTiledImage: Tile Cache disabled, using RenderTiledImage on element directly")
         //HagLog(LOG_DEBUG,"*** If you see many of these messages, there may be a performance issue unless you set HAG_PREF_ENABLE_TILE_CACHE to TRUE ***")
        
        RenderTiledImage(get, part, state, x1, y1, x2, y2, e)    
    Endif

End

Procedure RenderTiledImage(get:Integer, part:Integer, state:Integer, x1:Integer, y1:Integer, x2:Integer, y2:Integer, e:Element)
{
    Renders a tiled image to the element, which is usually a cache canvas.
}
Begin
    
     //HagLog(LOG_DEBUG,"RenderTiledImage: ID("+ToString(get)+","+ToString(part)+","+ToString(state)+"), "+ToString(x2-x1)+" by "+ToString(y2-y1))
    
    Case get of
        (GET_BUTTON):        
            If (x2-x1) > 0 then TileImage(gte_button[part,state],x1,y1,x2,y2,e)
        
        (GET_PROGRESSBAR):        
            If (x2-x1) > 0 then TileImage(gte_progressBar[part,state],x1,y1,x2,y2,e)
            
        (GET_TEXTBOX):
            If (x2-x1) > 0 then TileImage(gte_textbox[part,state],x1,y1,x2,y2,e)

        (GET_DROPDOWN):        
            If (x2-x1) > 0 then TileImage(gte_dropdown[part,state],x1,y1,x2,y2,e)

        (GET_DROPDOWNBOX):
            If (x2-x1) > 0 then TileImage(gte_dropdownbox[part],x1,y1,x2,y2,e)
        
        (GET_TAB):        
            If (x2-x1) > 0 then TileImage(gte_tab[part,state],x1,y1,x2,y2,e)

        (GET_FRAME):       
            If (x2-x1) > 0 then TileImage(gte_frame[part,state],x1,y1,x2,y2,e)
 
        (GET_LISTBOX):       
            If (x2-x1) > 0 then TileImage(gte_listbox[part, state],x1,y1,x2,y2,e)

        (GET_SCROLLBAR):       
            If (x2-x1) > 0 then TileImage(gte_scrollbar[part, state],x1,y1,x2,y2,e)

        (GET_SLIDER):       
            If (x2-x1) > 0 then TileImage(gte_slider[part, state],x1,y1,x2,y2,e)
       
        Default:
             HagLog(LOG_ERROR,"RenderTiledImage: Unknown GUI Element Type: "+ToString(get))
    EndCase

End

Function NewTiledImage(get:Integer, part:Integer, state:Integer, w:Integer, h:Integer) : ^tileCaches
{
    Creates a blank cache canvas for tiling
}
Begin

    tileCache = NewItem(tileCacheList)
    If Assigned(tileCache)
    
        tileCache.eGet      = get
        tileCache.ePart     = part
        tileCache.eState    = state
        tileCache.w         = w
        tileCache.h         = h
        tileCache.e         = CreateImage(w,h)
        
         HagLog(LOG_DEBUG,"NewTiledImage: Created blank canvas: ID("+ToString(get)+","+ToString(part)+","+ToString(state)+"), "+ToString(w)+" by "+ToString(h))
    Else
         HagLog(LOG_ERROR,"FATAL: NewTiledImage: Assignment Error - out of memory?")
    EndIf
    
    result = tileCache
End

Function TiledImageHandle(get:Integer, part:Integer, state:Integer, w:Integer, h:Integer) : Element
{
    Returns a cached image handle that matches the given properties, or NULL if
    one was not found.
}
Begin

    result = NULL

    Loop tileCache through tileCacheList
        If (get = tileCache.eGet) and (part = tileCache.ePart) and (state = tileCache.eState) then
            If (w = tileCache.w) and (h = tileCache.h) then
                result = tileCache.e
                Exit
            Endif
        Endif
    EndLoop
         
End









(* -------------------------------------------------------------------------- *)
(* Misc Functions *)
(* -------------------------------------------------------------------------- *)

Function Has(a: Integer, b: Integer) : Boolean
Begin
    If (a AND b) = b then result = TRUE else result = FALSE
End

Function FileGetContents(fpath: String) : String
Var
  fs : Element  
Begin
  fs = ReadFile(fpath)
  
  result = ReadBStr(fs,FileSize(fs))
  
  CloseFile(fs)
End

Function TextWrap(x: Integer, y: Integer, w: Integer, e:Element, f:Integer, s:String) : Integer ; Export
{
    x: X position to start writing
    y: Y position to start writing
    w: Maximum width of text
    e: Element to write to (NULL for frontbufffer)
    f: Frame of the element to write to (0 as default)
    s: Text to write
    Returns the yoffset to continue writing from.
}
Var
    yoffset, lyoff: Integer
Begin
    ClearList(wstrl)
    
    If Instr(s," ") = 0 then
        s = s + " "
    Endif
    
    s = Replace(s, "\n", " \n ",FALSE)

    While Instr(s," ")>0
        wstr = NewItem(wstrl)
        wstr.t = StringField(s," ") + " "
        s = Right(s,Length(s)-Instr(s," "))
    Wend
    
    wstr = NewItem(wstrl)
    wstr.t = StringField(s," ")
    s = ""

    
    Loop wstr through wstrl        
        If (wstr.t = "\n ") then
            Text(x,y+yoffset,s,e,f)
            yoffset = yoffset + TextHeight((s+ wstr.t),e,f) + WWRAP_LINE_PADDING
            s = ""            
        Else
            If TextWidth((s+ wstr.t),e,f) < w then
                s = s + wstr.t
            Else
                Text(x,y+yoffset,s,e,f)
                s = wstr.t
                yoffset = yoffset + TextHeight((s+ wstr.t),e,f) + WWRAP_LINE_PADDING                
            Endif
        Endif
        lyoff = TextHeight((s+ wstr.t),e,f)
        Free(wstr) 
    EndLoop
    Text(x,y+yoffset,s,e,f)
    yoffset = yoffset + lyoff + WWRAP_LINE_PADDING
    
    Result = y + yoffset 
        
End

Function FindMouseSprite(frm: ^forms, mx: Integer, my:Integer) : Element
{
    Compatability: Work-around quirky P2D MouseSprite function.
    (This could be a problem with only my machine, but at least
    it's completely fixed by this function!)
    
    Update: recent update of Cobra has broken old MouseSprite method
    Set constant GFX_USED = GFX_P2D to use this method.
}
Begin

    If GFX_USES <> GFX_P2D then
         HagLog(LOG_ERROR,"WARNING: FindMouseSprite called when GFX_USES is not GFX_P2D")
    Endif

    Loop scrollBar through frm.frmScrollbarList
        If (mx > scrollbar.x) and (mx < (scrollbar.x + scrollbar.w))
            If (my > scrollbar.y) and (my < (scrollbar.y + scrollbar.h))
                result = scrollbar.e
                Exit
            Endif        
        Endif
    EndLoop
    
    Loop button through frm.frmButtonList
        If (mx > button.x) and (mx < (button.x + button.w))
            If (my > button.y) and (my < (button.y + button.h))
                result = button.e
                Exit
            Endif        
        Endif
    EndLoop

    Loop canvas through frm.frmCanvasList
        If (mx > canvas.x) and (mx < (canvas.x + canvas.w))
            If (my > canvas.y) and (my < (canvas.y + canvas.h))
                result = canvas.e
                Exit
            Endif        
        Endif
    EndLoop
    
    Loop progressBar through frm.frmProgressBarList
        If (mx > progressBar.x) and (mx < (progressBar.x + progressBar.w))
            If (my > progressBar.y) and (my < (progressBar.y + progressBar.h))
                result = progressBar.e
                Exit
            Endif        
        Endif
    EndLoop

    Loop slider through frm.frmSliderList
        If (mx > slider.x) and (mx < (slider.x + slider.w))
            If (my > slider.y) and (my < (slider.y + slider.h))
                result = slider.e
                Exit
            Endif        
        Endif
    EndLoop
    
    Loop radioGroup through frm.frmRadioGroupList
        Loop radioButton through radioGroup.grpRadioButtonList
            If (mx > radioButton.x) and (mx < (radioButton.x + radioButton.w))
                If (my > radioButton.y) and (my < (radioButton.y + radioButton.h))
                    result = radioButton.e
                    Exit
                Endif        
            Endif
        EndLoop
    EndLoop

    Loop checkBox through frm.frmCheckBoxList
        If (mx > checkBox.x) and (mx < (checkBox.x + checkBox.w))
            If (my > checkBox.y) and (my < (checkBox.y + checkBox.h))
                result = checkBox.e
                Exit
            Endif        
        Endif
    EndLoop

    Loop textBox through frm.frmTextBoxList
        If (mx > textBox.x) and (mx < (textBox.x + textBox.w))
            If (my > textBox.y) and (my < (textBox.y + textBox.h))
                result = textBox.e
                Exit
            Endif        
        Endif
    EndLoop
    
    Loop hText through frm.frmTextList
        If (mx > hText.x) and (mx < (hText.x + hText.w))
            If (my > hText.y) and (my < (hText.y + hText.h))
                result = hText.e
                Exit
            Endif        
        Endif
    EndLoop
    
    Loop dropDown through frm.frmDropDownList
        If (mx > dropDown.x) and (mx < (dropDown.x + dropDown.w))
            If (my > dropDown.y) and (my < (dropDown.y + dropDown.h))
                result = dropDown.e
                Exit
            Endif        
        Endif
    EndLoop

    Loop listBox through frm.frmListBoxList
        If (mx > listBox.x) and (mx < (listBox.x + listBox.w))
            If (my > listBox.y) and (my < (listBox.y + listBox.h))
                result = listBox.e
                exit
            Endif        
        Endif
    EndLoop
       
    Loop tabGroup through frm.frmTabGroupList
        Loop tab through tabGroup.grpTabList
            If (mx > tab.x) and (mx < (tab.x + tab.w))
                If (my > tab.y) and (my < (tab.y + tab.h))
                    result = tab.e
                    Exit
                Endif        
            Endif
        EndLoop
    EndLoop

End

Procedure ForceVisibleTextboxCursor()
Begin
    tbx_cursorTimer = Millisecs
    tbx_cursorState = TRUE
End










(* -------------------------------------------------------------------------- *)
(* HAG SYSTEM / IMPORTANT *)
(* -------------------------------------------------------------------------- *)

Procedure HagInit(sw: Integer, sh: Integer, index: Integer=0) ; Export
{
    Clears old log files, applies default preferences and starts logging
}
Var
    i, j: Integer 
Begin
    hag_start = Millisecs
    hag_ram = MemorySize(OSM_AVAILPHYS)
    hag_screenw = sw
    hag_screenh = sh
    
    { Old Logs }
    If FileExists(hag_baseDir+"Log\"+LOG_ERROR) then DeleteFile(hag_baseDir+"Log\"+LOG_ERROR)
    If FileExists(hag_baseDir+"Log\"+LOG_DEBUG) then DeleteFile(hag_baseDir+"Log\"+LOG_DEBUG)
    If FileExists(hag_baseDir+"Log\"+LOG_PERF)  then DeleteFile(hag_baseDir+"Log\"+LOG_PERF)

    { Enable Booleans }
    hag_prefEnable[HAG_PREF_ENABLE_TILE_CACHE]  = DEFAULT_PREF_ENABLE_TILE_CACHE
    hag_prefEnable[HAG_PREF_ENABLE_ERROR_LOG]   = DEFAULT_PREF_ENABLE_ERROR_LOG
    hag_prefEnable[HAG_PREF_ENABLE_DEBUG_LOG]   = DEFAULT_PREF_ENABLE_DEBUG_LOG
    hag_prefEnable[HAG_PREF_ENABLE_PERF_LOG]    = DEFAULT_PREF_ENABLE_PERF_LOG
    hag_prefEnable[HAG_PREF_ENABLE_AADRAW]      = DEFAULT_PREF_ENABLE_AADRAW
    
    { Default Theme }
    For i = 0 to MAX_GETS
        For j = 0 to MAX_STATES
            fontName[i,j]       = DEFAULT_FONT_NAME
            fontSize[i,j]       = DEFAULT_FONT_SIZE
            fontStyle[i,j]      = DEFAULT_FONT_STYLE
            fontColor[i,j]      = ToRGBA(0,0,0,255)
            backColor[i,j]      = ToRGBA(0,0,0,255)
            textAlignment[i,j]  = DEFAULT_TEXT_ALIGNMENT
            textAAliasing[i,j]  = DEFAULT_TEXT_AALIASING
        Next
    Next
    
    { Init Logs }
    HagLog(LOG_ERROR,"(Error Log Enabled as Default)")
    HagLog(LOG_ERROR,"(Error Log Started: "+DateTimeToString(Now,'%yyyy%mm%dd at %hh:%nn:%ss')+")")
    HagLog(LOG_ERROR,"(Hag Version: "+VERSION+")")
    HagLog(LOG_DEBUG,"(Debug Log Enabled as Default)")
    HagLog(LOG_DEBUG,"(Debug Log Started: "+DateTimeToString(Now,'%yyyy%mm%dd at %hh:%nn:%ss')+")")
    HagLog(LOG_DEBUG,"(Hag Version: "+VERSION+")")

    { Sprite Z-Indexing }
    hag_index = index
    
    { Timers }
    tbx_cursorTimer = Millisecs
End

Procedure HagUpdate(frm:^forms,md1:Boolean,mh2:Boolean,ksubmit:Boolean,ktab:Boolean,kshift:Boolean,kctrl:Boolean)
{
    The main hag logic loop. 
}
Var
    msprite: Element
Begin
    Inc(log_indent)

        msprite = MouseSprite
        
        { Compatibility }
        If GFX_USES = GFX_P2D then msprite = FindMouseSprite(frm,MouseX,MouseY)

        { GUI Elements }
        If frm.enabled and frm.visible then
            
            Loop form through frm.frmFormList
                HagUpdate(frm,md1,mh2,ksubmit,ktab,kshift,kctrl)
            EndLoop
                        
            HagUpdateDropDowns(frm,msprite,md1,mh2)
            HagUpdateButtons(frm,msprite,md1,mh2,ksubmit)
            HagUpdateCanvases(frm,msprite,md1,mh2,ksubmit)
            HagUpdateProgressBars(frm,msprite,md1,mh2)
            HagUpdateSliders(frm,msprite,md1,mh2)
            HagUpdateRadioButtons(frm,msprite,md1,mh2)
            HagUpdateCheckBoxes(frm,msprite,md1,mh2)
            HagUpdateTextBoxes(frm,msprite,md1,mh2,ktab,kshift,kctrl)
            HagUpdateText(frm,msprite,md1,mh2)
            HagUpdateScrollbars(frm,msprite,md1,mh2)
            HagUpdateListBoxes(frm,msprite,md1,mh2)
            HagUpdateTabs(frm,msprite,md1,mh2)
        Endif
        
        { Timers }
        If frm.enabled then
            HagUpdateTimers(frm)
        Endif
    
    Dec(log_indent)    
End

Procedure HagUpdateOnce() ; Export
Begin
    HagUpdateAll(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE)
End

Procedure HagUpdateAll_AutoKeys() ; Export
Begin
    HagUpdateAll(MouseDown(0), MouseHits(1)>0, KeyDown(VK_RETURN), KeyHits(VK_TAB)>0, KeyDown(VK_LSHIFT) or KeyDown(VK_RSHIFT), KeyDown(VK_LCONTROL) or KeyDown(VK_RCONTROL))
End

Procedure HagUpdateAll(md1:Boolean,mh2:Boolean,ksubmit:Boolean,ktab:Boolean,kshift:Boolean,kctrl:Boolean, renderAll:Boolean=FALSE) ; Export
Var
    m: Static Real
Begin

    { Performance }
    If hag_prefEnable[HAG_PREF_ENABLE_PERF_LOG] then
        If hag_atpu < 0 then hag_atpu = 60
        hag_atpu = ToReal(((Millisecs - m) + hag_atpu) / 2.0)
        m = Millisecs
    Endif

    { Mouse }    
    hag_mouse = HAG_MOUSE_NORMAL
    hag_tooltip = ""

    { Forms }
    Loop form through formList
        If form.visible and form.enabled then HagUpdate(form,md1,mh2,ksubmit,ktab,kshift,kctrl)
    EndLoop

    { Cursor Blink }    
    If (Millisecs-tbx_cursorTimer) > CURSOR_BLINK_SPEED then
        tbx_cursorTimer = Millisecs
        tbx_cursorState = Not tbx_cursorState
    Endif

    { Render }    
    HagRenderAll(renderAll)

End

Procedure HagUpdateButtons(frm:^forms,msprite:Element,md1:Boolean,mh2:Boolean,ksubmit:Boolean)
{
    The mechanics and behaviour of button gui elements
}
Var
    do_unfocus : Boolean = FALSE
    dont_unfocus :^buttons
Begin

    Loop button through frm.frmButtonList
        If button.visible and button.enabled then
        
            { Mouse }
            If (msprite = button.e) and ((Millisecs - mtick) > OBSCURE_MTICK_DELAY_MS) then
                hag_tooltip = button.tooltip
        
                If (button.state = BTN_STATE_NORMAL) or (button.state = BTN_STATE_FOCUSED) then
                    If button.state = BTN_STATE_FOCUSED then button.wasFocused = TRUE
                    button.state = BTN_STATE_HOVER
                Endif
            
                If md1 then
                    button.isMouseTarget = TRUE
                    button.state = BTN_STATE_ACTIVE
                Else
                    If button.isMouseTarget = TRUE then
                        button.isMouseTarget = FALSE
                        button.state = BTN_STATE_FOCUSED
                        button.gotLeftClicked = TRUE
                    Endif
                Endif
            
                If mh2 then
                    button.gotRightClicked = TRUE
                Endif
            
            Else
                If (button.isKeyboardTarget = FALSE) and (button.State <> BTN_STATE_FOCUSED) then
                    button.state = BTN_STATE_NORMAL
                    If button.wasFocused then button.State = BTN_STATE_FOCUSED
                Endif
                If button.isMouseTarget then button.state = BTN_STATE_FOCUSED
                If md1 = FALSE then button.isMouseTarget = FALSE        
            Endif

            { Keyboard }        
            If button.isKeyboardTarget = FALSE then
                If (button.state = BTN_STATE_FOCUSED) and ksubmit then
                    button.isKeyboardTarget = TRUE
                    button.state = BTN_STATE_ACTIVE
                Endif
            Else
                If ksubmit = FALSE then
                    button.isKeyboardTarget = FALSE
                    button.state = BTN_STATE_FOCUSED
                    button.gotLeftClicked = TRUE
                Endif                 
            Endif

        
            { Update }
            If button.state <> button.lastState then
        
                If button.state = BTN_STATE_FOCUSED then
                    do_unfocus = TRUE
                    dont_unfocus = button                
                Endif
            
                button.lastState = button.state
                button.toRender = TRUE
            Endif
        
        Endif  
    EndLoop
    
    { Clean Up : Prevent multiple focuses }
    If do_unfocus then
        Loop button through frm.frmButtonList
            If dont_unfocus <> button then
                button.wasFocused = FALSE
                If button.state = BTN_STATE_FOCUSED then
                    button.state = BTN_STATE_NORMAL
                    button.toRender = TRUE
                Endif
            Endif
        EndLoop
    Endif 

End

Procedure HagUpdateCanvases(frm:^forms,msprite:Element,md1:Boolean,mh2:Boolean,ksubmit:Boolean)
{
    The mechanics and behaviour of canvas gui elements
}
Begin

    Loop canvas through frm.frmCanvasList
        If canvas.visible and canvas.enabled then
        
            { Mouse }
            If (msprite = canvas.e) and ((Millisecs - mtick) > OBSCURE_MTICK_DELAY_MS) then
                hag_tooltip = canvas.tooltip
            Endif
            
        Endif
    EndLoop

End

Procedure HagUpdateProgressBars(frm:^forms,msprite:Element,md1:Boolean,mh2:Boolean)
{
    The mechanics and behaviour of progress bar gui elements
}
Begin

    Loop progressBar through frm.frmProgressBarList
        If progressBar.visible and progressBar.enabled then
        
            If (msprite = progressBar.e) and ((Millisecs - mtick) > OBSCURE_MTICK_DELAY_MS) then
                hag_tooltip = progressBar.tooltip
            
                If md1 then
                    progressBar.isMouseTarget = TRUE
                Else
                    If progressBar.isMouseTarget then
                        progressBar.isMouseTarget = FALSE
                        progressBar.gotLeftClicked = TRUE
                    Endif
                Endif
                
                If mh2 then
                    progressBar.gotRightClicked = TRUE
                Endif
                
            Endif
        
        Endif        
    EndLoop
    
End

Procedure HagUpdateSliders(frm:^forms,msprite:Element,md1:Boolean,mh2:Boolean)
{
    The mechanics and behaviour of slider gui elements
}
Var
    state, mx, my, offset, index, position: Integer
    o1, o2, o3: Integer
Begin

    Loop slider through frm.frmSliderList
        state = slider.sliState
        offset = slider.sliOffset
        mx = MouseX - slider.x
        my = MouseY - slider.y
    
        If slider.visible and slider.enabled then

            If md1 and ((slider.sliState = SLI_SLIDER_STATE_HORIZ_HOVER)) then

                If (slider.state = SLI_STATE_HORIZ) then
                    slider.sliOffset = (mx) - (ImageWidth(gte_slider[SLI_PART_SLIDER, slider.sliState])/2)
                Else
                    slider.sliOffset = slider.h-(my) - (ImageHeight(gte_slider[SLI_PART_SLIDER, slider.sliState+SLI_SLIDER_ORI_OFFSET])/2)                
                Endif
            Endif


            If (msprite = slider.e) and ((Millisecs - mtick) > OBSCURE_MTICK_DELAY_MS) then
                
                If md1 = FALSE then
                    If slider.state = SLI_STATE_HORIZ then
                        If (mx > slider.sliOffset) and (my > 0) and (mx < (slider.sliOffset+ImageWidth(gte_slider[SLI_PART_SLIDER, slider.sliState]))) and (my <  ImageHeight(gte_slider[SLI_PART_SLIDER, slider.sliState])) then
                            slider.sliState = SLI_SLIDER_STATE_HORIZ_HOVER
                        Else
                            slider.sliState = SLI_SLIDER_STATE_HORIZ_NORMAL
                        Endif
                    Else
                        If (mx > 0) and (my > slider.h-(slider.sliOffset)-ImageHeight(gte_slider[SLI_PART_SLIDER, slider.sliState+SLI_SLIDER_ORI_OFFSET])) and (mx < slider.w) and (my < slider.h-slider.sliOffset) then
                            slider.sliState = SLI_SLIDER_STATE_HORIZ_HOVER
                        Else
                            slider.sliState = SLI_SLIDER_STATE_HORIZ_NORMAL
                        Endif
                    Endif
                Endif

                hag_tooltip = slider.tooltip
            Else
                If md1 = FALSE then slider.sliState = SLI_SLIDER_STATE_HORIZ_NORMAL
            Endif
            
        Else
            If slider.enabled = FALSE then
                slider.sliState = SLI_SLIDER_STATE_HORIZ_DISABLED
            Endif
        Endif

        If md1 = FALSE then
            If slider.sliDivisions > 1 then
                If slider.state = SLI_STATE_HORIZ then                                
                    o1 = slider.sliOffset
                    o2 = slider.w/(slider.sliDivisions-1)
                    o3 = o1 mod o2 

                    If o3 > (o2/2) then
                        slider.sliOffset = slider.sliOffset + o2 - o3
                    Else
                        slider.sliOffset = slider.sliOffset - o3
                    Endif
                Else
                    o1 = slider.sliOffset
                    o2 = slider.h/(slider.sliDivisions-1)
                    o3 = o1 mod o2 
                    
                    If o3 > (o2/2) then
                        slider.sliOffset = slider.sliOffset + o2 - o3 - (ImageHeight(gte_slider[SLI_PART_SLIDER, slider.sliState+SLI_SLIDER_ORI_OFFSET]))
                    Else
                        slider.sliOffset = slider.sliOffset - o3 - (ImageHeight(gte_slider[SLI_PART_SLIDER, slider.sliState+SLI_SLIDER_ORI_OFFSET]))
                    Endif
                Endif
            Endif
        Endif
        
        If slider.sliOffset < 0 then slider.sliOffset = 0
        If (slider.state = SLI_STATE_HORIZ) and (slider.sliOffset > slider.w - ImageWidth(gte_slider[SLI_PART_SLIDER, slider.sliState])) then slider.sliOffset = slider.w - ImageWidth(gte_slider[SLI_PART_SLIDER, slider.sliState])
        If (slider.state = SLI_STATE_VERT)  and (slider.sliOffset > slider.h - ImageHeight(gte_slider[SLI_PART_SLIDER, slider.sliState+SLI_SLIDER_ORI_OFFSET])) then slider.sliOffset = slider.h - ImageHeight(gte_slider[SLI_PART_SLIDER, slider.sliState+SLI_SLIDER_ORI_OFFSET])
        
        If ((md1 = FALSE) or (slider.sliDivisions = 0)) and (slider.sliOffset <> slider.sliLastOffset) then
            slider.sliLastOffset = slider.sliOffset
            slider.gotUpdated = TRUE
            slider.toRender = TRUE
        Endif
        
        If slider.sliState <> state then slider.toRender = TRUE
        If slider.sliOffset <> offset then slider.toRender = TRUE     
    EndLoop
    
End

Procedure HagUpdateRadioButtons(frm:^forms,msprite:Element,md1:Boolean,mh2:Boolean)
{
    The mechanics and behaviour of radio button gui elements
}
Var
    do_unselect : Boolean = FALSE
    dont_unselect :^radioButtons
Begin

    Loop radioGroup through frm.frmRadioGroupList
        If radioGroup.visible and radioGroup.enabled then
            do_unselect = FALSE
    
            Loop radioButton through radioGroup.grpRadioButtonList
                If radioButton.visible and radioButton.enabled then
                    
                    { Mouse }
                    If (msprite = radioButton.e) and ((Millisecs - mtick) > OBSCURE_MTICK_DELAY_MS) then
                        hag_tooltip = radioButton.tooltip
            
                        If radioButton.state = RDO_STATE_NORMAL then radioButton.state = RDO_STATE_HOVER

                        If md1 then
                            radioButton.isMouseTarget = TRUE
                            radioButton.state = RDO_STATE_ACTIVE
                        Else
                            If radioButton.isMouseTarget = TRUE then
                                radioButton.isMouseTarget = FALSE
                                radioButton.gotLeftClicked = TRUE
                                radioButton.state = RDO_STATE_NORMAL
                                radioButton.selected = Not radioButton.selected
                                radioButton.toRender = TRUE
                                do_unselect = TRUE
                                dont_unselect = radioButton 
                            Endif
                        Endif

                        If mh2 then
                            radioButton.gotRightClicked = TRUE
                        Endif
            
                    Else
                        radioButton.state = RDO_STATE_NORMAL                
                    Endif
                
                Else
                    If radioButton.enabled = FALSE then radioButton.state = RDO_STATE_DISABLED
                Endif
        
                If radioButton.visible then
        
                    { Update }
                    If radioButton.state <> radioButton.lastState then            
                        radioButton.lastState = radioButton.state
                        radioButton.toRender = TRUE
                    Endif
            
                Endif

            EndLoop

            { Clean Up : Prevent multiple selections }
            If do_unselect then
                Loop radioButton through radioGroup.grpRadioButtonList
                    If dont_unselect <> radioButton then
                        If radioButton.selected then
                            radioButton.selected = FALSE
                            radioButton.toRender = TRUE
                        Endif
                    Endif
                EndLoop
            Endif
        
        Endif
    EndLoop        
   
End

Procedure HagUpdateCheckBoxes(frm:^forms,msprite:Element,md1:Boolean,mh2:Boolean)
{
    The mechanics and behaviour of check box gui elements
}
Begin
    
    Loop checkBox through frm.frmCheckBoxList
        If checkBox.visible and checkBox.enabled then
                    
            { Mouse }
            If (msprite = checkBox.e) and ((Millisecs - mtick) > OBSCURE_MTICK_DELAY_MS) then
                hag_tooltip = checkBox.tooltip
            
                If checkBox.state = CBX_STATE_NORMAL then checkBox.state = CBX_STATE_HOVER

                If md1 then
                    checkBox.isMouseTarget = TRUE
                    checkBox.state = CBX_STATE_ACTIVE
                Else
                    If checkBox.isMouseTarget = TRUE then
                        checkBox.isMouseTarget = FALSE
                        checkBox.gotLeftClicked = TRUE
                        checkBox.state = CBX_STATE_NORMAL
                        checkBox.checked = Not checkBox.checked
                        checkBox.toRender = TRUE
                    Endif
                Endif

                If mh2 then
                    checkBox.gotRightClicked = TRUE
                Endif
            
            Else
                checkBox.state = CBX_STATE_NORMAL                
            Endif
                
        Else
            If checkBox.enabled = FALSE then checkBox.state = CBX_STATE_DISABLED
        Endif
        
        If checkBox.visible then
        
            { Update }
            If checkBox.state <> checkBox.lastState then            
                checkBox.lastState = checkBox.state
                checkBox.toRender = TRUE
            Endif
            
        Endif

    EndLoop    
   
End

Procedure HagUpdateTextBoxes(frm:^forms,msprite:Element,md1:Boolean,mh2:Boolean,ktab:Boolean,kshift:Boolean,kctrl:Boolean)
{
    The mechanics and behaviour of text box gui elements
}
Var
    do_unfocus : Boolean = FALSE
    dont_unfocus :^textBoxes
    lastblink : Static Boolean
    key: Integer
    gtbcp: Integer
Begin

    Loop textBox through frm.frmTextBoxList
        If textBox.visible and textBox.enabled then 
        
            { Mouse }
            If (msprite = textBox.e) and ((Millisecs - mtick) > OBSCURE_MTICK_DELAY_MS) then
                hag_tooltip = textBox.tooltip
                hag_mouse = HAG_MOUSE_TEXT
        
                If textBox.state = TBX_STATE_NORMAL then
                    textBox.state = TBX_STATE_HOVER
                Endif
            
                If md1 and ((Millisecs - mtick) > OBSCURE_MTICK_DELAY_MS) then
                    If (textBox.isMouseTarget = FALSE) then
                        textBox.state = TBX_STATE_FOCUSED
                        textBox.cursorPos = GetTextBoxCursorPosition(textBox,MouseX)
                        textBox.selectionLeft = textBox.cursorPos
                        textBox.selectionRight = textBox.selectionLeft 
                        ForceVisibleTextboxCursor()
                        textBox.toRender = TRUE
                        textBox.isMouseTarget = TRUE
                        FlushKeys()
                    Endif                   
                Else
                    If textBox.isMouseTarget = TRUE then
                        textBox.isMouseTarget = FALSE
                        textBox.gotLeftClicked = TRUE
                    Endif
                Endif
            
                If mh2 then textBox.gotRightClicked = TRUE
            
            Else
            
                If textBox.state = TBX_STATE_HOVER then textBox.state = TBX_STATE_NORMAL
                If textBox.state = TBX_STATE_FOCUSED then
                    If (md1 = TRUE) and (textBox.isMouseTarget = FALSE) then
                        textBox.state = TBX_STATE_NORMAL
                    Endif
                Endif
                    
            Endif
            
            { Selection }
            If md1 then
                If textBox.state = TBX_STATE_FOCUSED then
                    gtbcp = GetTextBoxCursorPosition(textBox,MouseX)
                    If textBox.selectionRight <> gtbcp then
                        textBox.cursorPos = gtbcp 
                        textBox.selectionRight = gtbcp
                        textBox.toRender = TRUE
                    Endif
                Endif  
            Endif
            

            { Text Input }
            If textBox.state = TBX_STATE_FOCUSED then

                { Render Blink }
                If (lastblink <> tbx_cursorState) then
                    textBox.toRender = TRUE
                    lastblink = tbx_cursorState
                Endif
            
                { Left/Right}
                If KeyHits(VK_LEFT) > 0 then
                    If textbox.cursorPos > 1 then
                        
                        If (kshift = FALSE) or ((kshift = TRUE) and (textBox.selectionLeft = textBox.selectionRight)) then
                            textBox.selectionLeft = textBox.cursorPos
                            textBox.selectionRight = textBox.cursorPos
                        Endif
                         
                        Dec(textbox.cursorPos)
                        If kshift then Dec(textBox.selectionLeft)
                    Else
                        If kshift = FALSE then
                            textBox.selectionLeft = textbox.cursorPos
                            textBox.selectionRight = textbox.cursorPos
                        Endif                        
                    Endif
                    ForceVisibleTextboxCursor()
                    textbox.toRender = TRUE
                Endif
                If KeyHits(VK_RIGHT) > 0 then
                    If textbox.cursorPos < (CountList(textbox.tbxCharList)-1) then
                         
                        If (kshift = FALSE) or ((kshift = TRUE) and (textBox.selectionLeft = textBox.selectionRight)) then
                            textBox.selectionLeft = textBox.cursorPos
                            textBox.selectionRight = textBox.cursorPos
                        Endif
                         
                        Inc(textbox.cursorPos)
                        If kshift then Inc(textBox.selectionLeft) 
                    Else
                        If kshift = FALSE then
                            textBox.selectionLeft = textbox.cursorPos
                            textBox.selectionRight = textbox.cursorPos
                        Endif
                    Endif
                    ForceVisibleTextboxCursor()
                    textbox.toRender = TRUE
                Endif
                
                { Home/End }
                If KeyHits(VK_HOME) > 0 then
                    textBox.selectionLeft = 1
                    If kshift then textBox.selectionRight = textbox.cursorPos else textBox.selectionRight = 1 
                    textbox.cursorPos = 1
                    ForceVisibleTextboxCursor()
                    textbox.toRender = TRUE
                Endif
                If KeyHits(VK_END) > 0 then
                    gtbcp = (CountList(textbox.tbxCharList)-1) 
                    textBox.selectionLeft = gtbcp
                    If kshift then textBox.selectionRight = textbox.cursorPos else textBox.selectionRight = gtbcp
                    textbox.cursorPos = gtbcp 
                    ForceVisibleTextboxCursor()
                    textbox.toRender = TRUE
                Endif
                
                { Delete/Backspace }
                If KeyHits(VK_DELETE) > 0 then
                    If textBox.selectionLeft <> textBox.selectionRight then
                        TextBoxRemoveChars(textBox,textBox.selectionLeft,textBox.selectionRight)
                        textBox.cursorPos = Min(textBox.selectionLeft, textBox.selectionRight)
                        textBox.selectionLeft = 1
                        textBox.selectionRight = 1
                    Else
                        If TextBoxRemoveChar(textBox,textBox.cursorPos) then
                            ForceVisibleTextboxCursor()
                            textBox.toRender = TRUE
                        Endif
                    Endif                
                Endif
                If KeyHits(VK_BACK) > 0 then
                    If textBox.selectionLeft <> textBox.selectionRight then
                        TextBoxRemoveChars(textBox,textBox.selectionLeft,textBox.selectionRight)
                        textBox.cursorPos = Min(textBox.selectionLeft, textBox.selectionRight)
                        textBox.selectionLeft = 1
                        textBox.selectionRight = 1
                    Else
                        If TextBoxRemoveChar(textBox,textBox.cursorPos-1) then
                            Dec(textBox.cursorPos)
                            ForceVisibleTextboxCursor()
                            textBox.toRender = TRUE
                        Endif
                    Endif
                Endif
                
                { Tab }
                If ktab then
                    ktab = FALSE
                                       
                    If textBox = LastItem(frm.frmTextBoxList) then
                        dont_unfocus = FirstItem(frm.frmTextBoxList)
                    Else
                        dont_unfocus = NextItem(frm.frmTextBoxList,textBox)
                    Endif
                    
                    If dont_unfocus.enabled = FALSE then
                        do_unfocus = FALSE
                    Else
                        ForceVisibleTextboxCursor()
                        textbox.state = TBX_STATE_NORMAL
                        do_unfocus = TRUE
                        
                        dont_unfocus.cursorPos = CountList(dont_unfocus.tbxCharList) - 1
                        dont_unfocus.selectionLeft = 1
                        dont_unfocus.selectionRight = dont_unfocus.cursorPos                     
                        dont_unfocus.state = TBX_STATE_FOCUSED
                    Endif
                                       
                Endif
                
                { Control+ }
                If kctrl then
                
                    { Select All }
                    If KeyHits(VK_A)>0 then
                        textBox.selectionLeft = 1
                        textBox.selectionRight = CountList(textBox.tbxCharList) - 2
                        textBox.cursorPos = textBox.selectionRight
                        textBox.toRender = TRUE
                    Endif
                    
                    { Copy / Cut / Paste }
                    If KeyHits(VK_C)>0 then TextBoxCopy(textBox,textBox.selectionLeft,textBox.selectionRight,FALSE)
                    If KeyHits(VK_X)>0 then
                        TextBoxCopy(textBox,textBox.selectionLeft,textBox.selectionRight,TRUE)
                        textBox.cursorPos = Min(textBox.selectionLeft, textBox.selectionRight)
                        textBox.selectionLeft = 1
                        textBox.selectionRight = 1
                    Endif
                    If KeyHits(VK_V)>0 then
                        If (textBox.selectionLeft <> textBox.selectionRight) then
                            TextBoxRemoveChars(textBox,textBox.selectionLeft,textBox.selectionRight)
                            textBox.selectionLeft = 1
                            textBox.selectionRight = 1
                            textBox.cursorPos = 1
                        Endif
                        textBox.cursorPos = textBox.cursorPos + TextBoxPaste(textBox,textBox.cursorPos)                        
                        textBox.toRender = TRUE
                    Endif

                    { Formatting }                     
                    If KeyHits(VK_B)>0 then TextBoxToggleFontStyle(textBox,textBox.selectionLeft,textBox.selectionRight,HAG_FONT_BOLD)
                    If KeyHits(VK_I)>0 then TextBoxToggleFontStyle(textBox,textBox.selectionLeft,textBox.selectionRight,HAG_FONT_ITALIC)
                    If KeyHits(VK_U)>0 then TextBoxToggleFontStyle(textBox,textBox.selectionLeft,textBox.selectionRight,HAG_FONT_UNDERLINED)
                Endif
                
                { Text }
                If kctrl = FALSE then
                    key = GetKey
                    If key >= 32 then
                        If textBox.selectionLeft <> textBox.selectionRight then
                            TextBoxRemoveChars(textBox,textBox.selectionLeft,textBox.selectionRight)
                            textBox.cursorPos = Min(textBox.selectionLeft, textBox.selectionRight)
                            textBox.selectionLeft = 1
                            textBox.selectionRight = 1
                        Endif
                        TextBoxInsertText(textBox,textBox.cursorPos-1,Chr(key))
                        Inc(textBox.cursorPos)
                        textBox.toRender = TRUE
                        FlushKeys()
                    Endif
                Endif
                                
            Endif

        
            { Update }
            If textBox.state <> textBox.lastState then
        
                If textBox.state = TBX_STATE_FOCUSED then
                    do_unfocus = TRUE
                    dont_unfocus = textBox                
                Endif
            
                textBox.lastState = textBox.state
                textBox.toRender = TRUE
            Endif
        
        Endif  
    EndLoop
    
    { Clean Up : Prevent multiple focuses }
    { Also unselects text in unfocused boxes }
    If do_unfocus then
        Loop textBox through frm.frmTextBoxList
            If dont_unfocus <> textBox then

                If textBox.state = TBX_STATE_FOCUSED then
                    textBox.state = TBX_STATE_NORMAL
                    textBox.toRender = TRUE
                Endif
                
                If textBox.selectionLeft <> 0 then textBox.toRender = TRUE
                textBox.selectionLeft = 0
                textBox.selectionRight = 0
                
            Endif
        EndLoop
    Endif 

End

Procedure HagUpdateText(frm:^forms,msprite:Element,md1:Boolean,mh2:Boolean)
{
    The mechanics and behaviour of check box gui elements
}
Begin
    
    Loop hText through frm.frmTextList
        If hText.visible and hText.enabled then
        
            If (msprite = hText.e) and ((Millisecs - mtick) > OBSCURE_MTICK_DELAY_MS) then
                hag_tooltip = hText.tooltip
                If hText.style = TXT_TYPE_HREF then hag_mouse = HAG_MOUSE_HAND 
            
                If md1 then
                    hText.isMouseTarget = TRUE
                Else
                    If hText.isMouseTarget then
                        hText.isMouseTarget = FALSE
                        hText.gotLeftClicked = TRUE
                        If Length(hText.href) > 0 then
                            FlushMouse()
                            ExecFile(hText.href)
                        Endif 
                    Endif
                Endif
                
                If mh2 then
                    hText.gotRightClicked = TRUE
                Endif
                
            Endif

        Endif        
    EndLoop   
   
End

Procedure HagUpdateDropDowns(frm:^forms,msprite:Element,md1:Boolean,mh2:Boolean)
{
    The mechanics and behaviour of drop down gui elements
}
Var
    mx, my: Integer
Begin
    mx = MouseX
    my = MouseY
    
    Loop dropDown through frm.frmDropDownList
        If dropDown.visible and dropDown.enabled then
            
            If dropDown.isDown then
                HagUpdateDropDownBoxes(dropDown,md1,mx,my)
                mtick = Millisecs // Drop-down box selection musn't affect any gui elements underneath
            Endif
                
            { Mouse }
            If (msprite = dropDown.e) and ((Millisecs - mtick) > OBSCURE_MTICK_DELAY_MS) then
                hag_tooltip = dropDown.tooltip
            
                If dropDown.isDown = FALSE then
                    dropDown.state = DDB_STATE_HOVER
                Else
                    dropDown.state = DDB_STATE_NORMAL
                Endif

                If (md1=TRUE) then
                    dropDown.isMouseTarget = TRUE
                    dropDown.state = DDB_STATE_ACTIVE
                Else
                    If (dropDown.isMouseTarget=TRUE) then
                        dropDown.gotLeftClicked = TRUE
                        dropDown.isMouseTarget = FALSE
                        dropDown.isDown = TRUE
                    Endif
                Endif

                If mh2 then
                    dropDown.gotRightClicked = TRUE
                Endif
            
            Else
                dropDown.state = DDB_STATE_NORMAL
                If md1 then
                    dropDown.isDown = FALSE
                    dropDown.toRenderBox = TRUE
                Endif                 
            Endif
                
        Else
            If dropDown.enabled = FALSE then dropDown.state = DDB_STATE_DISABLED
        Endif
        
        If dropDown.visible then
        
            { Update }
            If dropDown.state <> dropDown.lastState then            
                dropDown.lastState = dropDown.state
                dropDown.toRender = TRUE
                dropDown.toRenderBox = TRUE
            Endif
            
        Endif
        
        If dropDown.toIndex then
            dropDown.toIndex = FALSE
            SpriteIndex(dropDown.ebx,hag_index)
            Inc(hag_index)
        Endif

    EndLoop    
   
End

Procedure HagUpdateDropDownBoxes(ddb:^DropDowns, md:Boolean, mx:Integer, my:Integer)
Var
    byo, dh, y, y2, i : Integer
Begin
    { Yoffset }
    byo = dropDown_below_yoffset
        
    { Desired Height }
    dh = ImageHeight(gte_dropDownBox[DDB_PART_BOX_MID_MID]) * (CountList(ddb.ddbOptionList) + 1)
    dh = byo + ddb.h + dh + ImageHeight(gte_dropDownBox[DDB_PART_BOX_TOP_MID]) + ImageHeight(gte_dropDownBox[DDB_PART_BOX_BOTTOM_MID])
    dh = dh + (ImageHeight(gte_dropDownBox[DDB_PART_BOX_MID_MID])/2)

    y = ImageHeight(gte_dropdownbox[DDB_PART_BOX_TOP_MID]) + ddb.h + byo
    y2 = ImageHeight(gte_dropdownbox[DDB_PART_BOX_MID_MID])

    If md then
        If (mx > ddb.x) and (my < ImageHeight(gte_dropdownbox[DDB_PART_BOX_TOP_MID]) + ddb.y)
            If (mx < ddb.x+ddb.w) and (my > ddb.y) then
                ddb.isMouseTarget = FALSE
                ddb.isDown = FALSE
                ddb.toRender = TRUE
                Exit
            Endif
        Endif
    Endif
    
    my = my - ddb.y
    
    i = 0        
    Loop dropOption through ddb.ddbOptionList

        dropOption.state = DDB_BOX_STATE_NORMAL
            
        If (mx > ddb.x) and (my > y+(y2*i))
            If (mx < (ddb.x+ddb.w)) and (my < (y+(y2*i) + y2))
                dropOption.state = DDB_BOX_STATE_HOVER
                
                If md then
                    ddb.gotUpdated = TRUE
                    ddb.txt = dropOption.name
                    ddb.isDown = FALSE
                    ddb.toRender = TRUE
                    ddb.state = DDB_BOX_STATE_NORMAL
                Endif
            Endif 
        Endif

        If dropOption.state <> dropOption.lastState then
            dropOption.lastState = dropOption.state
            ddb.toRenderBox = TRUE
        Endif
        
        Inc(i)
    EndLoop
End

Procedure HagUpdateScrollBars(frm:^forms,msprite:Element,md1:Boolean,mh2:Boolean)
{
    The mechanics and behaviour of scrollbar gui elements
}
Var
    mx, my, mw, i, y, y1, y2, y3, y4, y5: Integer
Begin
    mx = MouseX
    my = MouseY
    mw = MouseWheel
    
    Loop scrollBar through frm.frmScrollBarList
        If scrollBar.visible and scrollBar.enabled then
            
            { Scroll }
            If ((scrollBar.state <> SBR_STATE_DISABLED) and ((msprite = scrollBar.e) or ((scrollBar.scrollTarget <> NULL) and (msprite = scrollBar.scrollTarget)))) and ((Millisecs - mtick) > OBSCURE_MTICK_DELAY_MS) then
            
                { Wheel scroll }
                If scrollBar.mWheel <> mw then
                
                    scrollBar.sbrOffset = scrollBar.sbrOffset + (scrollBar.mWheel - mw)
                    scrollBar.mWheel = mw
                    scrollBar.toRender = TRUE
                    
                    If scrollBar.sbrOffset <  0 then scrollBar.sbrOffset = 0
                    If scrollBar.sbrOffset > scrollBar.sbrLength - scrollBar.h then scrollBar.sbrOffset = scrollBar.sbrLength - scrollBar.h
                     
                Endif
            
            Else
                scrollBar.mwheel = mw            
            Endif
            
            
            
            { Mouse }            
            If (scrollBar.state <> SBR_STATE_DISABLED) and (msprite = scrollBar.e) and ((Millisecs - mtick) > OBSCURE_MTICK_DELAY_MS) then 
                
                If md1 then

                    { Slider }
                    y1 = ImageHeight(gte_scrollBar[SBR_PART_UP, scrollBar.stateUp])
                    y2 = scrollBar.h - ImageHeight(gte_scrollBar[SBR_PART_DOWN, scrollBar.stateUp]) - ImageHeight(gte_scrollBar[SBR_PART_SLIDER, scrollBar.stateSlider])
                    y3 = y2 - y1

                    If (scrollBar.sbrLength > 0) then
                        y4 = Floor(   (ToReal(scrollBar.sbrOffset) / ToReal(scrollBar.sbrLength - scrollBar.h)) * ToReal(y3) )
                        
                        If (mx > scrollBar.x) and (mx < (scrollBar.x + scrollBar.w)) then
                            If (my > scrollBar.y + y1 + y4) and (my < (scrollBar.y + y1 + y4 + ImageHeight(gte_scrollbar[SBR_PART_SLIDER, scrollBar.stateSlider]))) then
                            
                                scrollBar.stateSlider = SBR_STATE_ACTIVE
                                scrollBar.toRender = TRUE
                                
                            Endif
                        Endif
                    Endif

                    { Arrows }                
                    If (mx > scrollBar.x) and (mx < (scrollBar.x + scrollBar.w)) then
                            If (my > scrollBar.y) and (my < (scrollBar.y + ImageHeight(gte_scrollbar[SBR_PART_UP, scrollBar.stateUp]))) then
                                
                                scrollBar.toRender = TRUE
                                scrollBar.stateUp = SBR_STATE_ACTIVE
                                scrollBar.sbrOffset = scrollBar.sbrOffset - scrollBar.scrollSpeed
                                If scrollBar.sbrOffset < 0 then scrollBar.sbrOffset = 0
                                 
                            Endif
                    Endif
                    
                    If (mx > scrollBar.x) and (mx < (scrollBar.x + scrollBar.w)) then
                        If (my > (scrollBar.y + scrollBar.h - ImageHeight(gte_scrollbar[SBR_PART_DOWN, scrollBar.stateDown]))) and (my < (scrollBar.y + scrollBar.h)) then
                        
                                scrollBar.toRender = TRUE
                                scrollBar.stateDown = SBR_STATE_ACTIVE
                                scrollBar.sbrOffset = scrollBar.sbrOffset + scrollBar.scrollSpeed
                                If scrollBar.sbrOffset > scrollBar.sbrLength - scrollBar.h then scrollBar.sbrOffset = scrollBar.sbrLength - scrollBar.h

                        Endif
                    Endif
                
                Else
                
                    { Slider }
                    y1 = ImageHeight(gte_scrollBar[SBR_PART_UP, scrollBar.stateUp])
                    y2 = scrollBar.h - ImageHeight(gte_scrollBar[SBR_PART_DOWN, scrollBar.stateUp]) - ImageHeight(gte_scrollBar[SBR_PART_SLIDER, scrollBar.stateSlider])
                    y3 = y2 - y1

                    If (scrollBar.sbrLength > 0) then
                    
                        y4 = Floor(   (ToReal(scrollBar.sbrOffset) / ToReal(scrollBar.sbrLength - scrollBar.h)) * ToReal(y3) )
                        If (mx > scrollBar.x) and (mx < (scrollBar.x + scrollBar.w)) then
                            If (my > scrollBar.y + y1 + y4) and (my < (scrollBar.y + y1 + y4 + ImageHeight(gte_scrollbar[SBR_PART_SLIDER, scrollBar.stateSlider]))) then                                                       
                                If scrollBar.stateSlider <> SBR_STATE_ACTIVE then
                                    scrollBar.stateSlider = SBR_STATE_ACTIVE
                                    scrollBar.toRender = TRUE
                                Endif
                            Else
                                If scrollBar.stateSlider <> SBR_STATE_NORMAL then
                                    scrollBar.stateSlider = SBR_STATE_NORMAL
                                    scrollBar.toRender = TRUE
                                Endif
                            Endif
                        Else
                            If scrollBar.stateSlider <> SBR_STATE_NORMAL then
                                scrollBar.stateSlider = SBR_STATE_NORMAL
                                scrollBar.toRender = TRUE
                            Endif
                        Endif
                    Endif
                
                    { Arrows }
                    If scrollBar.stateUp = SBR_STATE_ACTIVE then
                        scrollBar.stateUp = SBR_STATE_NORMAL
                        scrollBar.toRender = TRUE
                    Endif
                    
                    If scrollBar.stateDown = SBR_STATE_ACTIVE then
                        scrollBar.stateDown = SBR_STATE_NORMAL
                        scrollBar.toRender = TRUE
                    Endif
                
            
                    If (mx > scrollBar.x) and (mx < (scrollBar.x + scrollBar.w)) then
                        If (my > scrollBar.y) and (my < (scrollBar.y + ImageHeight(gte_scrollbar[SBR_PART_UP, scrollBar.stateUp]))) then
                            If scrollBar.stateUp = SBR_STATE_NORMAL then
                                scrollBar.stateUp = SBR_STATE_HOVER
                                scrollBar.toRender = TRUE
                            Endif
                        Else
                            If scrollBar.stateUp = SBR_STATE_HOVER then
                                scrollBar.stateUp = SBR_STATE_NORMAL
                                scrollBar.toRender = TRUE
                            Endif
                        Endif
                    Else
                        If scrollBar.stateUp = SBR_STATE_HOVER then
                            scrollBar.stateUp = SBR_STATE_NORMAL
                            scrollBar.toRender = TRUE
                        Endif
                    Endif

                    If (mx > scrollBar.x) and (mx < (scrollBar.x + scrollBar.w)) then
                        If (my > (scrollBar.y + scrollBar.h - ImageHeight(gte_scrollbar[SBR_PART_DOWN, scrollBar.stateDown]))) and (my < (scrollBar.y + scrollBar.h)) then
                            If scrollBar.stateDown = SBR_STATE_NORMAL then
                                scrollBar.stateDown = SBR_STATE_HOVER
                                scrollBar.toRender = TRUE
                            Endif
                        Else
                            If scrollBar.stateDown = SBR_STATE_HOVER then
                                scrollBar.stateDown = SBR_STATE_NORMAL
                                scrollBar.toRender = TRUE
                            Endif
                        Endif
                    Else
                        If scrollBar.stateDown = SBR_STATE_HOVER then
                            scrollBar.stateDown = SBR_STATE_NORMAL
                            scrollBar.toRender = TRUE
                        Endif
                    Endif
                
                Endif                
            
            Else
            
                If scrollBar.stateSlider <> SBR_STATE_NORMAL then
                    If Not md1 then
                        scrollBar.stateSlider = SBR_STATE_NORMAL
                        scrollBar.toRender = TRUE
                    Endif
                Endif
            
                If scrollBar.stateUp = SBR_STATE_HOVER then
                    scrollBar.stateUp = SBR_STATE_NORMAL
                    scrollBar.toRender = TRUE
                Endif

                If scrollBar.stateDown = SBR_STATE_HOVER then
                    scrollBar.stateDown = SBR_STATE_NORMAL
                    scrollBar.toRender = TRUE
                Endif
                
            Endif
            
            If scrollBar.state = SBR_STATE_DISABLED then
                If scrollBar.stateUp <> SBR_STATE_DISABLED then
                    scrollBar.stateUp = SBR_STATE_DISABLED
                    scrollBar.stateDown = SBR_STATE_DISABLED
                    scrollBar.toRender = TRUE
                Endif
            Else
                If scrollBar.stateUp = SBR_STATE_DISABLED then
                    scrollBar.stateUp = SBR_STATE_NORMAL
                    scrollBar.stateDown = SBR_STATE_NORMAL
                    scrollBar.toRender = TRUE
                Endif
            Endif
            
            If (scrollBar.state <> SBR_STATE_DISABLED) and (md1) then
                If (scrollBar.stateSlider = SBR_STATE_ACTIVE) or ((msprite = scrollBar.e) and (my > (scrollBar.y + ImageHeight(gte_scrollBar[SBR_PART_DOWN, scrollBar.stateUp]))) and (my < (scrollBar.y + scrollBar.h - ImageHeight(gte_scrollBar[SBR_PART_DOWN, scrollBar.stateDown]))) ) then
                
                    y1 = ImageHeight(gte_scrollBar[SBR_PART_UP, scrollBar.stateUp])
                    y2 = scrollBar.h - ImageHeight(gte_scrollBar[SBR_PART_DOWN, scrollBar.stateUp]) - ImageHeight(gte_scrollBar[SBR_PART_SLIDER, scrollBar.stateSlider])
                    y3 = y2 - y1
                    y5 = (ToReal(my - scrollBar.y - y1) / ToReal(y3)) * ToReal(scrollBar.sbrLength - scrollBar.h)
                    
                    scrollBar.sbrOffset = y5
                    If scrollBar.sbrOffset < 0 then scrollBar.sbrOffset = 0
                    If scrollBar.sbrOffset > scrollBar.sbrLength - scrollBar.h then scrollBar.sbrOffset = scrollBar.sbrLength - scrollBar.h
                    scrollBar.toRender = TRUE
                Endif                
            Endif
            
        Else
            If scrollBar.state <> SBR_STATE_DISABLED then
                scrollBar.state = SBR_STATE_DISABLED
                scrollBar.toRender = TRUE
            Endif
        Endif
        
    EndLoop    
   
End

Procedure HagUpdateListBoxes(frm:^forms,msprite:Element,md1:Boolean,mh2:Boolean)
{
    The mechanics and behaviour of list box gui elements
}
Var
    mx, my, i, y, y2, y3: Integer
Begin
    mx = MouseX
    my = MouseY
    
    Loop listBox through frm.frmListBoxList
        If listBox.sbr.toRender then listBox.toRender = TRUE
    
        If listBox.visible and listBox.enabled then
        
            y = ImageHeight(gte_listbox[LBX_PART_TOP_MID, listBox.state])
            y2 = ImageHeight(gte_listbox[LBX_PART_MID_MID, listBox.state])
            y3 = y + (y2*CountList(listBox.lbxOptionList))
            
            If y3 < listBox.h then                
                If listBox.sbr.state <> SBR_STATE_DISABLED then
                    listBox.sbr.state = SBR_STATE_DISABLED
                    listBox.sbr.toRender = TRUE
                Endif
            Else
                If listBox.sbr.state <> SBR_STATE_NORMAL then 
                    listBox.sbr.state = SBR_STATE_NORMAL
                    listBox.sbr.toRender = TRUE
                Endif
                
                If y3 <> listBox.sbr.sbrLength then
                    listBox.sbr.sbrLength = y3
                    listBox.sbr.toRender = TRUE
                Endif
            Endif
        
                
            { Mouse }            
            If (msprite = listBox.e) and ((Millisecs - mtick) > OBSCURE_MTICK_DELAY_MS) then
                hag_tooltip = listBox.tooltip
                
                If (mx > listBox.x) and (mx < (listBox.x + listBox.w)) and (my > listBox.y) and (my < (listBox.y + listBox.h)) then
                
                    i = 0   
                    Loop listOption through listBox.lbxOptionList 
                        y3 = y + (y2*i)

            
                        If (listOption.state <> LBX_ITEM_STATE_DISABLED) then
                             If (my > (listBox.y + y3 - listBox.sbr.sbrOffset)) and (my < (listBox.y + y3 + y2 - listBox.sbr.sbrOffset)) then
                             
                                If md1 then
                                    listOption.state = LBX_ITEM_STATE_ACTIVE
                                    listBox.optionSelected = listOption
                                    listBox.toRender = TRUE
                                Endif
                            
                                If listOption.state = LBX_ITEM_STATE_NORMAL then
                                    listOption.state = LBX_ITEM_STATE_HOVER
                                    listBox.toRender = TRUE
                                Endif
                                
                             Else
                                If listOption.state = LBX_ITEM_STATE_HOVER then
                                    listOption.state = LBX_ITEM_STATE_NORMAL
                                    listBox.toRender = TRUE
                                Endif
                             Endif
                        Endif

                        Inc(i)
                    EndLoop
                
                Else
                    Loop listOption through listBox.lbxOptionList 
                        If listOption.state = LBX_ITEM_STATE_HOVER then
                            listOption.state = LBX_ITEM_STATE_NORMAL
                            listBox.toRender = TRUE
                        Endif
                    EndLoop
                Endif
            Else
                Loop listOption through listBox.lbxOptionList 
                    If listOption.state = LBX_ITEM_STATE_HOVER then
                        listOption.state = LBX_ITEM_STATE_NORMAL
                        listBox.toRender = TRUE
                    Endif
                EndLoop
            Endif
                
        Else
            //If listBox.enabled = FALSE then listBox.state = LBX_STATE_DISABLED
            
            If listBox.enabled = FALSE then
                If listBox.state <> LBX_STATE_DISABLED
                    listBox.state = LBX_STATE_DISABLED
                    listBox.toRender = TRUE
                Endif
            
                If listBox.sbr.state <> SBR_STATE_DISABLED then
                    listBox.sbr.state = SBR_STATE_DISABLED
                    listBox.sbr.toRender = TRUE
                Endif
            Endif
        Endif
        
        If listBox.toRender then
            Loop listOption through listBox.lbxOptionList
                If listBox.optionSelected <> listOption then
                    If listOption.state = LBX_ITEM_STATE_ACTIVE then listOption.state = LBX_ITEM_STATE_NORMAL
                Endif
            EndLoop
        Endif
        
        If listBox.visible then
        
            { Update }
            If listBox.state <> listBox.lastState then            
                listBox.lastState = listBox.state
                listBox.toRender = TRUE
            Endif
            
        Endif
        
    EndLoop    
   
End

Procedure HagUpdateTimers(frm:^forms)
{
    The mechanics and behaviour of timer elements
}
Begin

    Loop timer through frm.frmTimerList
        If timer.enabled then
        
            If timer.toSync then
                Case timer.method of
                    (TMR_METHOD_MILLISECS):
                        timer.startTime = Millisecs
                    (TMR_METHOD_FRAMES):
                        timer.startTime = 0
                    Default:
                        HagLog(LOG_ERROR,"WARNING: HagUpdateTimers: method '"+timer.method+"' unknown")
                EndCase
                
                timer.toSync = FALSE
                timer.gotActivated = FALSE
                
            Else
            
                Case timer.method of
                    (TMR_METHOD_MILLISECS):
                        If (Millisecs - timer.startTime) >= timer.freq then
                            timer.gotActivated = TRUE
                            timer.startTime = Millisecs 
                        Endif
                    
                    (TMR_METHOD_FRAMES):
                        Inc(timer.startTime)
                        If timer.startTime >= timer.freq then
                            timer.gotActivated = TRUE
                            timer.startTime = 0
                        Endif                    
                    
                    Default:
                        HagLog(LOG_ERROR,"WARNING: HagUpdateTimers: method '"+timer.method+"' unknown")
                EndCase
            
            
            Endif           
        
        Endif        
    EndLoop
    
End

Procedure HagUpdateTabs(frm:^forms,msprite:Element,md1:Boolean,mh2:Boolean)
{
    The mechanics and behaviour of tab gui elements
}
Var
    do_unselect : Boolean = FALSE
    dont_unselect :^tabs
Begin

    Loop tabGroup through frm.frmtabGroupList
        If tabGroup.visible and tabGroup.enabled then
            do_unselect = FALSE
    
            Loop tab through tabGroup.grpTabList
                If tab.visible and tab.enabled then
                    
                    { Mouse }
                    If msprite = tab.e then
                        hag_tooltip = tab.tooltip
            
                        If tab.state = TAB_STATE_INACTIVE then tab.state = TAB_STATE_HOVER

                        If md1 and ((Millisecs - mtick) > OBSCURE_MTICK_DELAY_MS) then
                            tab.isMouseTarget = TRUE
                        Else
                            If tab.isMouseTarget = TRUE then
                                tab.isMouseTarget = FALSE
                                tab.gotLeftClicked = TRUE
                                tab.state = TAB_STATE_ACTIVE
                                tab.selected = TRUE
                                tab.toRender = TRUE
                                do_unselect = TRUE
                                dont_unselect = tab 
                            Endif
                        Endif

                        If mh2 then
                            tab.gotRightClicked = TRUE
                        Endif
            
                    Else
                        If tab.state = TAB_STATE_HOVER then tab.state = TAB_STATE_INACTIVE                
                    Endif
                
                Endif
        
                If tab.visible then
        
                    { Update }
                    If tab.state <> tab.lastState then            
                        tab.lastState = tab.state
                        tab.toRender = TRUE
                    Endif
            
                Endif

            EndLoop

            { Clean Up : Prevent multiple selections }
            If do_unselect then
                Loop tab through tabGroup.grpTabList
                    If dont_unselect <> tab then
                        If tab.selected then
                            tab.state = TAB_STATE_INACTIVE
                            tab.selected = FALSE
                            tab.toRender = TRUE
                        Endif
                    Endif
                EndLoop
            Endif
        
        Endif
    EndLoop        
   
End

Procedure HagRender(frm:^forms, force:Boolean=FALSE) ; Export
{
    If any elements have toRender flags set, then they are redrawn.
    
    TODO: [?] If the forms has a toOrder flag set, then the element zorders are updated.
    
    It is best to call this once before you start your main loop to prevent
    any lag in the loop which may strain your framelimiting timers.
}
Begin

    Loop button through frm.frmButtonList
        If button.toRender or force then RenderButton(button)
    EndLoop
    
    Loop progressBar through frm.frmProgressBarList
        If progressBar.toRender or force then RenderProgressBar(progressbar)
    EndLoop

    Loop slider through frm.frmSliderList
        If slider.toRender or force then RenderSlider(slider)
    EndLoop
    
    Loop radioGroup through frm.frmRadioGroupList
        Loop radioButton through radioGroup.grpRadioButtonList
            If radioButton.toRender or force then RenderRadioButton(radioButton)
        EndLoop
    EndLoop
    
    Loop checkBox through frm.frmCheckBoxList
        If checkBox.toRender or force then RenderCheckBox(checkBox)
    EndLoop

    Loop textBox through frm.frmTextBoxList
        If textBox.toRender or force then RenderTextBox(textBox)
    EndLoop

    Loop hText through frm.frmTextList
        If hText.toRender or force then RenderText(hText)
    EndLoop
    
    Loop dropDown through frm.frmDropDownList
        If dropDown.toRender or force then RenderDropDown(dropDown)
        If dropDown.toRenderBox or force then RenderDropDownBox(dropDown)
    EndLoop
    
    Loop listBox through frm.frmListBoxList
        If listbox.toRender or force then RenderListBox(listBox)
    EndLoop
    
    Loop scrollBar through frm.frmScrollBarList
        If scrollBar.toRender or force then RenderScrollbar(scrollBar)
    EndLoop
    
    Loop tabGroup through frm.frmTabGroupList
        Loop tab through tabGroup.grpTabList
            If tab.toRender or force then RenderTab(tab)
        EndLoop
    EndLoop
    
    Loop frame through frm.frmFrameList
        If frame.toRender or force then RenderFrame(frame)
    EndLoop
    
End

Procedure HagRenderAll(force:Boolean=FALSE) ; Export
Begin

    If hag_hasGuiTheme = FALSE then
        HagLog(LOG_ERROR,"Warning: HagRenderAll() was called with no theme loaded!")
        exit
    Endif

    Loop form through formList
        If form.visible or force then HagRender(form,force)
    EndLoop

End

Procedure HagBaseDir(baseDir: String) ; Export
{
    A nice interface to set the base directory for all hag files.
    This must be called before HagInit()
}
Begin
    hag_baseDir = baseDir
End

Procedure HagPrefEnable(id:Integer, val:Boolean=TRUE) ; Export
{
    A pretty interface to enable or disable boolean preferences
}
Begin
    hag_prefEnable[id] = val
    
    HagLog(LOG_DEBUG,"HagPrefEnable: hag_prefEnable["+ToString(id)+"] = "+ToString(val))
End

Procedure HagLoadGuiTheme(theme: String) ; Export
{
    Loads a GUI theme.
    
    Call HagFreeGuiTheme() before calling this function if a theme already exists.
}
Var
    fs: Element
    themeFile: String
    i: Integer
    hasinfo: Integer

    { Compiled Theme Properties }    
    time: Integer
    tname,tauthor,tdesc,tver: String
    tcompat: Integer
    tinfo: Array[MAX_GETS] of Boolean
    
Begin
    If hag_hasGuiTheme then HagLog(LOG_ERROR,"Warning: HagLoadGuiTheme() was called when a theme already existed")
    
    hag_hasGuiTheme = TRUE    
    HagLog(LOG_DEBUG,"HagLoadGuiTheme: "+theme)
    Inc(log_indent)

        { Images }

            { Buttons }    
            gte_button[BTN_PART_LEFT,   BTN_STATE_NORMAL]   = HagLoadThemeImage(theme,"button\normal_left.png",     THEME_TYPE_GUI)
            gte_button[BTN_PART_MID,    BTN_STATE_NORMAL]   = HagLoadThemeImage(theme,"button\normal_mid.png",      THEME_TYPE_GUI)
            gte_button[BTN_PART_RIGHT,  BTN_STATE_NORMAL]   = HagLoadThemeImage(theme,"button\normal_right.png",    THEME_TYPE_GUI)
            gte_button[BTN_PART_LEFT,   BTN_STATE_HOVER]    = HagLoadThemeImage(theme,"button\hover_left.png",      THEME_TYPE_GUI)
            gte_button[BTN_PART_MID,    BTN_STATE_HOVER]    = HagLoadThemeImage(theme,"button\hover_mid.png",       THEME_TYPE_GUI)
            gte_button[BTN_PART_RIGHT,  BTN_STATE_HOVER]    = HagLoadThemeImage(theme,"button\hover_right.png",     THEME_TYPE_GUI)
            gte_button[BTN_PART_LEFT,   BTN_STATE_FOCUSED]  = HagLoadThemeImage(theme,"button\focused_left.png",    THEME_TYPE_GUI)
            gte_button[BTN_PART_MID,    BTN_STATE_FOCUSED]  = HagLoadThemeImage(theme,"button\focused_mid.png",     THEME_TYPE_GUI)
            gte_button[BTN_PART_RIGHT,  BTN_STATE_FOCUSED]  = HagLoadThemeImage(theme,"button\focused_right.png",   THEME_TYPE_GUI)
            gte_button[BTN_PART_LEFT,   BTN_STATE_ACTIVE]   = HagLoadThemeImage(theme,"button\active_left.png",     THEME_TYPE_GUI)
            gte_button[BTN_PART_MID,    BTN_STATE_ACTIVE]   = HagLoadThemeImage(theme,"button\active_mid.png",      THEME_TYPE_GUI)
            gte_button[BTN_PART_RIGHT,  BTN_STATE_ACTIVE]   = HagLoadThemeImage(theme,"button\active_right.png",    THEME_TYPE_GUI)
            gte_button[BTN_PART_LEFT,   BTN_STATE_DISABLED]   = HagLoadThemeImage(theme,"button\disabled_left.png", THEME_TYPE_GUI)
            gte_button[BTN_PART_MID,    BTN_STATE_DISABLED]   = HagLoadThemeImage(theme,"button\disabled_mid.png",  THEME_TYPE_GUI)
            gte_button[BTN_PART_RIGHT,  BTN_STATE_DISABLED]   = HagLoadThemeImage(theme,"button\disabled_right.png",THEME_TYPE_GUI)
            
            { Progress Bars }
            gte_progressBar[PROG_PART_LEFT,     PROG_STATE_HORIZ]   = HagLoadThemeImage(theme,"progressbar\horizontal_left.png",    THEME_TYPE_GUI)
            gte_progressBar[PROG_PART_MID,      PROG_STATE_HORIZ]   = HagLoadThemeImage(theme,"progressbar\horizontal_mid.png",     THEME_TYPE_GUI)
            gte_progressBar[PROG_PART_RIGHT,    PROG_STATE_HORIZ]   = HagLoadThemeImage(theme,"progressbar\horizontal_right.png",   THEME_TYPE_GUI)
            gte_progressBar[PROG_PART_ITEM,     PROG_STATE_HORIZ]   = HagLoadThemeImage(theme,"progressbar\horizontal_item.png",    THEME_TYPE_GUI)
            gte_progressBar[PROG_PART_LEFT,     PROG_STATE_VERT]    = HagLoadThemeImage(theme,"progressbar\vertical_left.png",      THEME_TYPE_GUI)
            gte_progressBar[PROG_PART_MID,      PROG_STATE_VERT]    = HagLoadThemeImage(theme,"progressbar\vertical_mid.png",       THEME_TYPE_GUI)
            gte_progressBar[PROG_PART_RIGHT,    PROG_STATE_VERT]    = HagLoadThemeImage(theme,"progressbar\vertical_right.png",     THEME_TYPE_GUI)
            gte_progressBar[PROG_PART_ITEM,     PROG_STATE_VERT]    = HagLoadThemeImage(theme,"progressbar\vertical_item.png",      THEME_TYPE_GUI)

            { Sliders }
            gte_slider[SLI_PART_LEFT,           SLI_STATE_HORIZ]         = HagLoadThemeImage(theme,"slider\horizontal_top.png",             THEME_TYPE_GUI)
            gte_slider[SLI_PART_MID,            SLI_STATE_HORIZ]         = HagLoadThemeImage(theme,"slider\horizontal_mid.png",             THEME_TYPE_GUI)
            gte_slider[SLI_PART_RIGHT,          SLI_STATE_HORIZ]         = HagLoadThemeImage(theme,"slider\horizontal_bottom.png",          THEME_TYPE_GUI)
            gte_slider[SLI_PART_MARKING,        SLI_STATE_HORIZ]         = HagLoadThemeImage(theme,"slider\horizontal_marking.png",         THEME_TYPE_GUI)
            gte_slider[SLI_PART_LEFT,           SLI_STATE_VERT]          = HagLoadThemeImage(theme,"slider\vertical_top.png",               THEME_TYPE_GUI)
            gte_slider[SLI_PART_MID,            SLI_STATE_VERT]          = HagLoadThemeImage(theme,"slider\vertical_mid.png",               THEME_TYPE_GUI)
            gte_slider[SLI_PART_RIGHT,          SLI_STATE_VERT]          = HagLoadThemeImage(theme,"slider\vertical_bottom.png",            THEME_TYPE_GUI)
            gte_slider[SLI_PART_MARKING,        SLI_STATE_VERT]          = HagLoadThemeImage(theme,"slider\vertical_marking.png",           THEME_TYPE_GUI)
            gte_slider[SLI_PART_SLIDER, SLI_SLIDER_STATE_HORIZ_NORMAL]   = HagLoadThemeImage(theme,"slider\horizontal_normal_slider.png",   THEME_TYPE_GUI)
            gte_slider[SLI_PART_SLIDER, SLI_SLIDER_STATE_HORIZ_HOVER]    = HagLoadThemeImage(theme,"slider\horizontal_hover_slider.png",    THEME_TYPE_GUI)
            gte_slider[SLI_PART_SLIDER, SLI_SLIDER_STATE_HORIZ_DISABLED] = HagLoadThemeImage(theme,"slider\horizontal_disabled_slider.png", THEME_TYPE_GUI)
            gte_slider[SLI_PART_SLIDER, SLI_SLIDER_STATE_VERT_NORMAL]    = HagLoadThemeImage(theme,"slider\vertical_normal_slider.png",     THEME_TYPE_GUI)
            gte_slider[SLI_PART_SLIDER, SLI_SLIDER_STATE_VERT_HOVER]     = HagLoadThemeImage(theme,"slider\vertical_hover_slider.png",      THEME_TYPE_GUI)
            gte_slider[SLI_PART_SLIDER, SLI_SLIDER_STATE_VERT_DISABLED]  = HagLoadThemeImage(theme,"slider\vertical_disabled_slider.png",   THEME_TYPE_GUI)
            
            { Radio Buttons }
            gte_radioButton[RDO_STATE_NORMAL_UNSELECTED]    = HagLoadThemeImage(theme,"radiobutton\normal_unselected.png",  THEME_TYPE_GUI)
            gte_radioButton[RDO_STATE_HOVER_UNSELECTED]     = HagLoadThemeImage(theme,"radiobutton\hover_unselected.png",   THEME_TYPE_GUI)
            gte_radioButton[RDO_STATE_ACTIVE_UNSELECTED]    = HagLoadThemeImage(theme,"radiobutton\active_unselected.png",  THEME_TYPE_GUI)
            gte_radioButton[RDO_STATE_DISABLED_UNSELECTED]  = HagLoadThemeImage(theme,"radiobutton\disabled_unselected.png",THEME_TYPE_GUI)
            gte_radioButton[RDO_STATE_NORMAL_SELECTED]      = HagLoadThemeImage(theme,"radiobutton\normal_selected.png",    THEME_TYPE_GUI)
            gte_radioButton[RDO_STATE_HOVER_SELECTED]       = HagLoadThemeImage(theme,"radiobutton\hover_selected.png",     THEME_TYPE_GUI)
            gte_radioButton[RDO_STATE_ACTIVE_SELECTED]      = HagLoadThemeImage(theme,"radiobutton\active_selected.png",    THEME_TYPE_GUI)
            gte_radioButton[RDO_STATE_DISABLED_SELECTED]    = HagLoadThemeImage(theme,"radiobutton\disabled_selected.png",  THEME_TYPE_GUI)
            
            { Check Boxes }
            gte_checkBox[CBX_STATE_NORMAL_UNSELECTED]       = HagLoadThemeImage(theme,"checkbox\normal_unselected.png",     THEME_TYPE_GUI)
            gte_checkBox[CBX_STATE_HOVER_UNSELECTED]        = HagLoadThemeImage(theme,"checkbox\hover_unselected.png",      THEME_TYPE_GUI)
            gte_checkBox[CBX_STATE_ACTIVE_UNSELECTED]       = HagLoadThemeImage(theme,"checkbox\active_unselected.png",     THEME_TYPE_GUI)
            gte_checkBox[CBX_STATE_DISABLED_UNSELECTED]     = HagLoadThemeImage(theme,"checkbox\disabled_unselected.png",   THEME_TYPE_GUI)
            gte_checkBox[CBX_STATE_NORMAL_SELECTED]         = HagLoadThemeImage(theme,"checkbox\normal_selected.png",       THEME_TYPE_GUI)
            gte_checkBox[CBX_STATE_HOVER_SELECTED]          = HagLoadThemeImage(theme,"checkbox\hover_selected.png",        THEME_TYPE_GUI)
            gte_checkBox[CBX_STATE_ACTIVE_SELECTED]         = HagLoadThemeImage(theme,"checkbox\active_selected.png",       THEME_TYPE_GUI)
            gte_checkBox[CBX_STATE_DISABLED_SELECTED]       = HagLoadThemeImage(theme,"checkbox\disabled_selected.png",     THEME_TYPE_GUI)
            
            { Text Boxes }
            gte_textBox[TBX_PART_LEFT,  TBX_STATE_NORMAL]   = HagLoadThemeImage(theme,"textbox\normal_left.png",    THEME_TYPE_GUI)
            gte_textBox[TBX_PART_MID,   TBX_STATE_NORMAL]   = HagLoadThemeImage(theme,"textbox\normal_mid.png",     THEME_TYPE_GUI)
            gte_textBox[TBX_PART_RIGHT, TBX_STATE_NORMAL]   = HagLoadThemeImage(theme,"textbox\normal_right.png",   THEME_TYPE_GUI)
            gte_textBox[TBX_PART_LEFT,  TBX_STATE_HOVER]    = HagLoadThemeImage(theme,"textbox\hover_left.png",     THEME_TYPE_GUI)
            gte_textBox[TBX_PART_MID,   TBX_STATE_HOVER]    = HagLoadThemeImage(theme,"textbox\hover_mid.png",      THEME_TYPE_GUI)
            gte_textBox[TBX_PART_RIGHT, TBX_STATE_HOVER]    = HagLoadThemeImage(theme,"textbox\hover_right.png",    THEME_TYPE_GUI)
            gte_textBox[TBX_PART_LEFT,  TBX_STATE_FOCUSED]  = HagLoadThemeImage(theme,"textbox\focused_left.png",   THEME_TYPE_GUI)
            gte_textBox[TBX_PART_MID,   TBX_STATE_FOCUSED]  = HagLoadThemeImage(theme,"textbox\focused_mid.png",    THEME_TYPE_GUI)
            gte_textBox[TBX_PART_RIGHT, TBX_STATE_FOCUSED]  = HagLoadThemeImage(theme,"textbox\focused_right.png",  THEME_TYPE_GUI)
            gte_textBox[TBX_PART_LEFT,  TBX_STATE_DISABLED] = HagLoadThemeImage(theme,"textbox\disabled_left.png",  THEME_TYPE_GUI)
            gte_textBox[TBX_PART_MID,   TBX_STATE_DISABLED] = HagLoadThemeImage(theme,"textbox\disabled_mid.png",   THEME_TYPE_GUI)
            gte_textBox[TBX_PART_RIGHT, TBX_STATE_DISABLED] = HagLoadThemeImage(theme,"textbox\disabled_right.png", THEME_TYPE_GUI)

            { Drop Down Boxes }            
            gte_dropDown[DDB_PART_LEFT,     DDB_STATE_NORMAL]   = HagLoadThemeImage(theme,"dropdown\normal_left.png",   THEME_TYPE_GUI)
            gte_dropDown[DDB_PART_MID,      DDB_STATE_NORMAL]   = HagLoadThemeImage(theme,"dropdown\normal_mid.png",    THEME_TYPE_GUI)
            gte_dropDown[DDB_PART_RIGHT,    DDB_STATE_NORMAL]   = HagLoadThemeImage(theme,"dropdown\normal_right.png",  THEME_TYPE_GUI)
            gte_dropDown[DDB_PART_LEFT,     DDB_STATE_HOVER]    = HagLoadThemeImage(theme,"dropdown\hover_left.png",    THEME_TYPE_GUI)
            gte_dropDown[DDB_PART_MID,      DDB_STATE_HOVER]    = HagLoadThemeImage(theme,"dropdown\hover_mid.png",     THEME_TYPE_GUI)
            gte_dropDown[DDB_PART_RIGHT,    DDB_STATE_HOVER]    = HagLoadThemeImage(theme,"dropdown\hover_right.png",   THEME_TYPE_GUI)
            gte_dropDown[DDB_PART_LEFT,     DDB_STATE_ACTIVE]   = HagLoadThemeImage(theme,"dropdown\active_left.png",   THEME_TYPE_GUI)
            gte_dropDown[DDB_PART_MID,      DDB_STATE_ACTIVE]   = HagLoadThemeImage(theme,"dropdown\active_mid.png",    THEME_TYPE_GUI)
            gte_dropDown[DDB_PART_RIGHT,    DDB_STATE_ACTIVE]   = HagLoadThemeImage(theme,"dropdown\active_right.png",  THEME_TYPE_GUI)
            gte_dropDown[DDB_PART_LEFT,     DDB_STATE_DISABLED] = HagLoadThemeImage(theme,"dropdown\disabled_left.png", THEME_TYPE_GUI)
            gte_dropDown[DDB_PART_MID,      DDB_STATE_DISABLED] = HagLoadThemeImage(theme,"dropdown\disabled_mid.png",  THEME_TYPE_GUI)
            gte_dropDown[DDB_PART_RIGHT,    DDB_STATE_DISABLED] = HagLoadThemeImage(theme,"dropdown\disabled_right.png",THEME_TYPE_GUI)
            
            { Drop Down Boxes : Box }
            gte_dropDownBox[DDB_PART_BOX_TOP_LEFT]      = HagLoadThemeImage(theme,"dropdown\box\top_left.png",      THEME_TYPE_GUI)
            gte_dropDownBox[DDB_PART_BOX_TOP_MID]       = HagLoadThemeImage(theme,"dropdown\box\top_mid.png",       THEME_TYPE_GUI)
            gte_dropDownBox[DDB_PART_BOX_TOP_RIGHT]     = HagLoadThemeImage(theme,"dropdown\box\top_right.png",     THEME_TYPE_GUI)
            gte_dropDownBox[DDB_PART_BOX_MID_LEFT]      = HagLoadThemeImage(theme,"dropdown\box\mid_left.png",      THEME_TYPE_GUI)
            gte_dropDownBox[DDB_PART_BOX_MID_MID]       = HagLoadThemeImage(theme,"dropdown\box\mid_mid.png",       THEME_TYPE_GUI)
            gte_dropDownBox[DDB_PART_BOX_MID_RIGHT]     = HagLoadThemeImage(theme,"dropdown\box\mid_right.png",     THEME_TYPE_GUI)
            gte_dropDownBox[DDB_PART_BOX_BOTTOM_LEFT]   = HagLoadThemeImage(theme,"dropdown\box\bottom_left.png",   THEME_TYPE_GUI)
            gte_dropDownBox[DDB_PART_BOX_BOTTOM_MID]    = HagLoadThemeImage(theme,"dropdown\box\bottom_mid.png",    THEME_TYPE_GUI)
            gte_dropDownBox[DDB_PART_BOX_BOTTOM_RIGHT]  = HagLoadThemeImage(theme,"dropdown\box\bottom_right.png",  THEME_TYPE_GUI)
            
            
            { ListBoxes }
            gte_listBox[LBX_PART_TOP_LEFT, LBX_STATE_NORMAL]      = HagLoadThemeImage(theme,"listbox\normal_top_left.png",      THEME_TYPE_GUI)
            gte_listBox[LBX_PART_TOP_MID, LBX_STATE_NORMAL]       = HagLoadThemeImage(theme,"listbox\normal_top_mid.png",       THEME_TYPE_GUI)
            gte_listBox[LBX_PART_TOP_RIGHT, LBX_STATE_NORMAL]     = HagLoadThemeImage(theme,"listbox\normal_top_right.png",     THEME_TYPE_GUI)
            gte_listBox[LBX_PART_MID_LEFT, LBX_STATE_NORMAL]      = HagLoadThemeImage(theme,"listbox\normal_mid_left.png",      THEME_TYPE_GUI)
            gte_listBox[LBX_PART_MID_MID, LBX_STATE_NORMAL]       = HagLoadThemeImage(theme,"listbox\normal_mid_mid.png",       THEME_TYPE_GUI)
            gte_listBox[LBX_PART_MID_RIGHT, LBX_STATE_NORMAL]     = HagLoadThemeImage(theme,"listbox\normal_mid_right.png",     THEME_TYPE_GUI)
            gte_listBox[LBX_PART_BOTTOM_LEFT, LBX_STATE_NORMAL]   = HagLoadThemeImage(theme,"listbox\normal_bottom_left.png",   THEME_TYPE_GUI)
            gte_listBox[LBX_PART_BOTTOM_MID, LBX_STATE_NORMAL]    = HagLoadThemeImage(theme,"listbox\normal_bottom_mid.png",    THEME_TYPE_GUI)
            gte_listBox[LBX_PART_BOTTOM_RIGHT, LBX_STATE_NORMAL]  = HagLoadThemeImage(theme,"listbox\normal_bottom_right.png",  THEME_TYPE_GUI)
            
            gte_listBox[LBX_PART_TOP_LEFT, LBX_STATE_DISABLED]      = HagLoadThemeImage(theme,"listbox\disabled_top_left.png",      THEME_TYPE_GUI)
            gte_listBox[LBX_PART_TOP_MID, LBX_STATE_DISABLED]       = HagLoadThemeImage(theme,"listbox\disabled_top_mid.png",       THEME_TYPE_GUI)
            gte_listBox[LBX_PART_TOP_RIGHT, LBX_STATE_DISABLED]     = HagLoadThemeImage(theme,"listbox\disabled_top_right.png",     THEME_TYPE_GUI)
            gte_listBox[LBX_PART_MID_LEFT, LBX_STATE_DISABLED]      = HagLoadThemeImage(theme,"listbox\disabled_mid_left.png",      THEME_TYPE_GUI)
            gte_listBox[LBX_PART_MID_MID, LBX_STATE_DISABLED]       = HagLoadThemeImage(theme,"listbox\disabled_mid_mid.png",       THEME_TYPE_GUI)
            gte_listBox[LBX_PART_MID_RIGHT, LBX_STATE_DISABLED]     = HagLoadThemeImage(theme,"listbox\disabled_mid_right.png",     THEME_TYPE_GUI)
            gte_listBox[LBX_PART_BOTTOM_LEFT, LBX_STATE_DISABLED]   = HagLoadThemeImage(theme,"listbox\disabled_bottom_left.png",   THEME_TYPE_GUI)
            gte_listBox[LBX_PART_BOTTOM_MID, LBX_STATE_DISABLED]    = HagLoadThemeImage(theme,"listbox\disabled_bottom_mid.png",    THEME_TYPE_GUI)
            gte_listBox[LBX_PART_BOTTOM_RIGHT, LBX_STATE_DISABLED]  = HagLoadThemeImage(theme,"listbox\disabled_bottom_right.png",  THEME_TYPE_GUI)
            
            { Tabs }
            gte_tab[TAB_PART_LEFT,  TAB_STATE_INACTIVE] = HagLoadThemeImage(theme,"tab\inactive_left.png",  THEME_TYPE_GUI)
            gte_tab[TAB_PART_MID,   TAB_STATE_INACTIVE] = HagLoadThemeImage(theme,"tab\inactive_mid.png",   THEME_TYPE_GUI)
            gte_tab[TAB_PART_RIGHT, TAB_STATE_INACTIVE] = HagLoadThemeImage(theme,"tab\inactive_right.png", THEME_TYPE_GUI)
            gte_tab[TAB_PART_LEFT,  TAB_STATE_HOVER]    = HagLoadThemeImage(theme,"tab\hover_left.png",     THEME_TYPE_GUI)
            gte_tab[TAB_PART_MID,   TAB_STATE_HOVER]    = HagLoadThemeImage(theme,"tab\hover_mid.png",      THEME_TYPE_GUI)
            gte_tab[TAB_PART_RIGHT, TAB_STATE_HOVER]    = HagLoadThemeImage(theme,"tab\hover_right.png",    THEME_TYPE_GUI)
            gte_tab[TAB_PART_LEFT,  TAB_STATE_ACTIVE]   = HagLoadThemeImage(theme,"tab\active_left.png",    THEME_TYPE_GUI)
            gte_tab[TAB_PART_MID,   TAB_STATE_ACTIVE]   = HagLoadThemeImage(theme,"tab\active_mid.png",     THEME_TYPE_GUI)
            gte_tab[TAB_PART_RIGHT, TAB_STATE_ACTIVE]   = HagLoadThemeImage(theme,"tab\active_right.png",   THEME_TYPE_GUI)
            
            { Frames : Tab }
            gte_frame[FRA_PART_TOP_LEFT,    FRAME_STYLE_TAB]    = HagLoadThemeImage(theme,"frames\tab\top_left.png",        THEME_TYPE_GUI)
            gte_frame[FRA_PART_TOP_MID,     FRAME_STYLE_TAB]    = HagLoadThemeImage(theme,"frames\tab\top_mid.png",         THEME_TYPE_GUI)
            gte_frame[FRA_PART_TOP_RIGHT,   FRAME_STYLE_TAB]    = HagLoadThemeImage(theme,"frames\tab\top_right.png",       THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_LEFT,    FRAME_STYLE_TAB]    = HagLoadThemeImage(theme,"frames\tab\mid_left.png",        THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_MID,     FRAME_STYLE_TAB]    = HagLoadThemeImage(theme,"frames\tab\mid_mid.png",         THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_RIGHT,   FRAME_STYLE_TAB]    = HagLoadThemeImage(theme,"frames\tab\mid_right.png",       THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_LEFT, FRAME_STYLE_TAB]    = HagLoadThemeImage(theme,"frames\tab\bottom_left.png",     THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_MID,  FRAME_STYLE_TAB]    = HagLoadThemeImage(theme,"frames\tab\bottom_mid.png",      THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_RIGHT,FRAME_STYLE_TAB]    = HagLoadThemeImage(theme,"frames\tab\bottom_right.png",    THEME_TYPE_GUI)
            
            { Frames : Round Border }
            gte_frame[FRA_PART_TOP_LEFT,    FRAME_STYLE_ROUNDBORDER]    = HagLoadThemeImage(theme,"frames\roundborder\top_left.png",       THEME_TYPE_GUI)
            gte_frame[FRA_PART_TOP_MID,     FRAME_STYLE_ROUNDBORDER]    = HagLoadThemeImage(theme,"frames\roundborder\top_mid.png",        THEME_TYPE_GUI)
            gte_frame[FRA_PART_TOP_RIGHT,   FRAME_STYLE_ROUNDBORDER]    = HagLoadThemeImage(theme,"frames\roundborder\top_right.png",      THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_LEFT,    FRAME_STYLE_ROUNDBORDER]    = HagLoadThemeImage(theme,"frames\roundborder\mid_left.png",       THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_MID,     FRAME_STYLE_ROUNDBORDER]    = HagLoadThemeImage(theme,"frames\roundborder\mid_mid.png",        THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_RIGHT,   FRAME_STYLE_ROUNDBORDER]    = HagLoadThemeImage(theme,"frames\roundborder\mid_right.png",      THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_LEFT, FRAME_STYLE_ROUNDBORDER]    = HagLoadThemeImage(theme,"frames\roundborder\bottom_left.png",    THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_MID,  FRAME_STYLE_ROUNDBORDER]    = HagLoadThemeImage(theme,"frames\roundborder\bottom_mid.png",     THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_RIGHT,FRAME_STYLE_ROUNDBORDER]    = HagLoadThemeImage(theme,"frames\roundborder\bottom_right.png",   THEME_TYPE_GUI)

            { Frames : Round Solid }
            gte_frame[FRA_PART_TOP_LEFT,    FRAME_STYLE_ROUNDSOLID]    = HagLoadThemeImage(theme,"frames\roundsolid\top_left.png",       THEME_TYPE_GUI)
            gte_frame[FRA_PART_TOP_MID,     FRAME_STYLE_ROUNDSOLID]    = HagLoadThemeImage(theme,"frames\roundsolid\top_mid.png",        THEME_TYPE_GUI)
            gte_frame[FRA_PART_TOP_RIGHT,   FRAME_STYLE_ROUNDSOLID]    = HagLoadThemeImage(theme,"frames\roundsolid\top_right.png",      THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_LEFT,    FRAME_STYLE_ROUNDSOLID]    = HagLoadThemeImage(theme,"frames\roundsolid\mid_left.png",       THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_MID,     FRAME_STYLE_ROUNDSOLID]    = HagLoadThemeImage(theme,"frames\roundsolid\mid_mid.png",        THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_RIGHT,   FRAME_STYLE_ROUNDSOLID]    = HagLoadThemeImage(theme,"frames\roundsolid\mid_right.png",      THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_LEFT, FRAME_STYLE_ROUNDSOLID]    = HagLoadThemeImage(theme,"frames\roundsolid\bottom_left.png",    THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_MID,  FRAME_STYLE_ROUNDSOLID]    = HagLoadThemeImage(theme,"frames\roundsolid\bottom_mid.png",     THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_RIGHT,FRAME_STYLE_ROUNDSOLID]    = HagLoadThemeImage(theme,"frames\roundsolid\bottom_right.png",   THEME_TYPE_GUI)

            { Frames : Square Border }
            gte_frame[FRA_PART_TOP_LEFT,    FRAME_STYLE_SQUAREBORDER]    = HagLoadThemeImage(theme,"frames\squareborder\top_left.png",       THEME_TYPE_GUI)
            gte_frame[FRA_PART_TOP_MID,     FRAME_STYLE_SQUAREBORDER]    = HagLoadThemeImage(theme,"frames\squareborder\top_mid.png",        THEME_TYPE_GUI)
            gte_frame[FRA_PART_TOP_RIGHT,   FRAME_STYLE_SQUAREBORDER]    = HagLoadThemeImage(theme,"frames\squareborder\top_right.png",      THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_LEFT,    FRAME_STYLE_SQUAREBORDER]    = HagLoadThemeImage(theme,"frames\squareborder\mid_left.png",       THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_MID,     FRAME_STYLE_SQUAREBORDER]    = HagLoadThemeImage(theme,"frames\squareborder\mid_mid.png",        THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_RIGHT,   FRAME_STYLE_SQUAREBORDER]    = HagLoadThemeImage(theme,"frames\squareborder\mid_right.png",      THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_LEFT, FRAME_STYLE_SQUAREBORDER]    = HagLoadThemeImage(theme,"frames\squareborder\bottom_left.png",    THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_MID,  FRAME_STYLE_SQUAREBORDER]    = HagLoadThemeImage(theme,"frames\squareborder\bottom_mid.png",     THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_RIGHT,FRAME_STYLE_SQUAREBORDER]    = HagLoadThemeImage(theme,"frames\squareborder\bottom_right.png",   THEME_TYPE_GUI)

            { Frames : Square Solid }
            gte_frame[FRA_PART_TOP_LEFT,    FRAME_STYLE_SQUARESOLID]    = HagLoadThemeImage(theme,"frames\squaresolid\top_left.png",       THEME_TYPE_GUI)
            gte_frame[FRA_PART_TOP_MID,     FRAME_STYLE_SQUARESOLID]    = HagLoadThemeImage(theme,"frames\squaresolid\top_mid.png",        THEME_TYPE_GUI)
            gte_frame[FRA_PART_TOP_RIGHT,   FRAME_STYLE_SQUARESOLID]    = HagLoadThemeImage(theme,"frames\squaresolid\top_right.png",      THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_LEFT,    FRAME_STYLE_SQUARESOLID]    = HagLoadThemeImage(theme,"frames\squaresolid\mid_left.png",       THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_MID,     FRAME_STYLE_SQUARESOLID]    = HagLoadThemeImage(theme,"frames\squaresolid\mid_mid.png",        THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_RIGHT,   FRAME_STYLE_SQUARESOLID]    = HagLoadThemeImage(theme,"frames\squaresolid\mid_right.png",      THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_LEFT, FRAME_STYLE_SQUARESOLID]    = HagLoadThemeImage(theme,"frames\squaresolid\bottom_left.png",    THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_MID,  FRAME_STYLE_SQUARESOLID]    = HagLoadThemeImage(theme,"frames\squaresolid\bottom_mid.png",     THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_RIGHT,FRAME_STYLE_SQUARESOLID]    = HagLoadThemeImage(theme,"frames\squaresolid\bottom_right.png",   THEME_TYPE_GUI)
            
            { Frames : Mock Window }
            gte_frame[FRA_PART_TOP_LEFT,    FRAME_STYLE_MOCKWINDOW]    = HagLoadThemeImage(theme,"frames\mockwindow\top_left.png",       THEME_TYPE_GUI)
            gte_frame[FRA_PART_TOP_MID,     FRAME_STYLE_MOCKWINDOW]    = HagLoadThemeImage(theme,"frames\mockwindow\top_mid.png",        THEME_TYPE_GUI)
            gte_frame[FRA_PART_TOP_RIGHT,   FRAME_STYLE_MOCKWINDOW]    = HagLoadThemeImage(theme,"frames\mockwindow\top_right.png",      THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_LEFT,    FRAME_STYLE_MOCKWINDOW]    = HagLoadThemeImage(theme,"frames\mockwindow\mid_left.png",       THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_MID,     FRAME_STYLE_MOCKWINDOW]    = HagLoadThemeImage(theme,"frames\mockwindow\mid_mid.png",        THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_RIGHT,   FRAME_STYLE_MOCKWINDOW]    = HagLoadThemeImage(theme,"frames\mockwindow\mid_right.png",      THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_LEFT, FRAME_STYLE_MOCKWINDOW]    = HagLoadThemeImage(theme,"frames\mockwindow\bottom_left.png",    THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_MID,  FRAME_STYLE_MOCKWINDOW]    = HagLoadThemeImage(theme,"frames\mockwindow\bottom_mid.png",     THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_RIGHT,FRAME_STYLE_MOCKWINDOW]    = HagLoadThemeImage(theme,"frames\mockwindow\bottom_right.png",   THEME_TYPE_GUI)            

            { Frames : Header }
            gte_frame[FRA_PART_TOP_LEFT,    FRAME_STYLE_HEADER]    = HagLoadThemeImage(theme,"frames\header\top_left.png",       THEME_TYPE_GUI)
            gte_frame[FRA_PART_TOP_MID,     FRAME_STYLE_HEADER]    = HagLoadThemeImage(theme,"frames\header\top_mid.png",        THEME_TYPE_GUI)
            gte_frame[FRA_PART_TOP_RIGHT,   FRAME_STYLE_HEADER]    = HagLoadThemeImage(theme,"frames\header\top_right.png",      THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_LEFT,    FRAME_STYLE_HEADER]    = HagLoadThemeImage(theme,"frames\header\mid_left.png",       THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_MID,     FRAME_STYLE_HEADER]    = HagLoadThemeImage(theme,"frames\header\mid_mid.png",        THEME_TYPE_GUI)
            gte_frame[FRA_PART_MID_RIGHT,   FRAME_STYLE_HEADER]    = HagLoadThemeImage(theme,"frames\header\mid_right.png",      THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_LEFT, FRAME_STYLE_HEADER]    = HagLoadThemeImage(theme,"frames\header\bottom_left.png",    THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_MID,  FRAME_STYLE_HEADER]    = HagLoadThemeImage(theme,"frames\header\bottom_mid.png",     THEME_TYPE_GUI)
            gte_frame[FRA_PART_BOTTOM_RIGHT,FRAME_STYLE_HEADER]    = HagLoadThemeImage(theme,"frames\header\bottom_right.png",   THEME_TYPE_GUI)
            
            { Scrollbar }
            gte_scrollBar[SBR_PART_UP,      SBR_STATE_NORMAL]   = HagLoadThemeImage(theme,"scrollbar\normal_up.png",        THEME_TYPE_GUI)
            gte_scrollBar[SBR_PART_DOWN,    SBR_STATE_NORMAL]   = HagLoadThemeImage(theme,"scrollbar\normal_down.png",      THEME_TYPE_GUI)
            gte_scrollBar[SBR_PART_SLIDER,  SBR_STATE_NORMAL]   = HagLoadThemeImage(theme,"scrollbar\normal_slider.png",    THEME_TYPE_GUI)
            gte_scrollBar[SBR_PART_BAR,     SBR_STATE_NORMAL]   = HagLoadThemeImage(theme,"scrollbar\normal_bar.png",       THEME_TYPE_GUI)
            gte_scrollBar[SBR_PART_UP,      SBR_STATE_HOVER]    = HagLoadThemeImage(theme,"scrollbar\hover_up.png",         THEME_TYPE_GUI)
            gte_scrollBar[SBR_PART_DOWN,    SBR_STATE_HOVER]    = HagLoadThemeImage(theme,"scrollbar\hover_down.png",       THEME_TYPE_GUI)
            gte_scrollBar[SBR_PART_SLIDER,  SBR_STATE_HOVER]    = HagLoadThemeImage(theme,"scrollbar\hover_slider.png",     THEME_TYPE_GUI)
            gte_scrollBar[SBR_PART_UP,      SBR_STATE_ACTIVE]   = HagLoadThemeImage(theme,"scrollbar\active_up.png",        THEME_TYPE_GUI)
            gte_scrollBar[SBR_PART_DOWN,    SBR_STATE_ACTIVE]   = HagLoadThemeImage(theme,"scrollbar\active_down.png",      THEME_TYPE_GUI)
            gte_scrollBar[SBR_PART_SLIDER,  SBR_STATE_ACTIVE]   = HagLoadThemeImage(theme,"scrollbar\active_slider.png",    THEME_TYPE_GUI)
            gte_scrollBar[SBR_PART_UP,      SBR_STATE_DISABLED] = HagLoadThemeImage(theme,"scrollbar\disabled_up.png",      THEME_TYPE_GUI)
            gte_scrollBar[SBR_PART_DOWN,    SBR_STATE_DISABLED] = HagLoadThemeImage(theme,"scrollbar\disabled_down.png",    THEME_TYPE_GUI)
            gte_scrollBar[SBR_PART_BAR,     SBR_STATE_DISABLED] = HagLoadThemeImage(theme,"scrollbar\disabled_bar.png",     THEME_TYPE_GUI)
        
        { Compiled Theme Data }
        
        themeFile = hag_baseDir+"themes\gui\"+theme+"\"+theme+".bin"
        If FileExists(themeFile) then
        
            fs = CreateMemFile()
            LoadToMemFile(fs,themeFile)
            time = ReadInt(fs)
                HagLog(LOG_DEBUG,"HagLoadGuiTheme: Theme '"+themeFile+"', compiled "+DateTimeToString(time,'%yyyy%mm%dd / %hh:%nn:%ss'))
                Inc(log_indent)
      
                    tname   = ReadStr(fs)
                    tauthor = ReadStr(fs)
                    tdesc   = ReadStr(fs)
                    tver    = ReadStr(fs)
                    tcompat = ReadWord(fs)
                    
                     HagLog(LOG_DEBUG,"HagLoadGuiTheme: Name: '"+tname+"', Author: '"+tauthor+"', Version: '"+tver+"'")
                     HagLog(LOG_DEBUG,"HagLoadGuiTheme: Desc: '"+tdesc+"'")
                    If tcompat = THEME_COMPATIBLE then
                        HagLog(LOG_DEBUG,"HagLoadGuiTheme: Compatible: "+ToString(tcompat)+", required: "+ToString(THEME_COMPATIBLE))
                    Else
                        HagLog(LOG_ERROR,"WARNING: HagLoadGuiTheme: Compatible: "+ToString(tcompat)+", needed: "+ToString(THEME_COMPATIBLE))
                    Endif
                    
                    Repeat
                        hasinfo = ReadByte(fs)
                        
                        Case hasinfo of
                            (GET_BUTTON):       tinfo[GET_BUTTON]       = TRUE
                            (GET_RADIOBUTTON):  tinfo[GET_RADIOBUTTON]  = TRUE
                            (GET_CHECKBOX):     tinfo[GET_CHECKBOX]     = TRUE
                            (GET_TEXTBOX):      tinfo[GET_TEXTBOX]      = TRUE
                            (GET_TEXT):         tinfo[GET_TEXT]         = TRUE
                            (GET_DROPDOWN):     tinfo[GET_DROPDOWN]     = TRUE
                            (GET_TAB):          tinfo[GET_TAB]          = TRUE
                            (GET_FRAME):        tinfo[GET_FRAME]        = TRUE
                            (GET_LISTBOX):      tinfo[GET_LISTBOX]      = TRUE
                            255:
                                HagLog(LOG_DEBUG,"HagLoadGuiTheme: Found hasinfo end marker (255) OK.")
                                Inc(log_indent)
                                    For i = 0 to MAX_GETS
                                        If tinfo[i] then HagLog(LOG_DEBUG,"hasinfo: "+ToString(i))
                                    Next
                                Dec(log_indent)
                            Default:
                                HagLog(LOG_ERROR,"WARNING: HagLoadGuiTheme: Unknown header info identifier byte: '"+ToString(hasinfo)+"'")
                        EndCase
                        
                    Until hasinfo = 255                    
    
        
                    { Properties }

                    If tinfo[GET_BUTTON] = TRUE then 
                        HagLog(LOG_DEBUG, "Reading Compiled Button Data...")
                    
                        For i = 0 to (MAX_BTN_STATES-1)                    
                            fontName[GET_BUTTON,i] = ReadStr(fs)
                            fontSize[GET_BUTTON,i] = ReadByte(fs)
                            fontStyle[GET_BUTTON,i] = ReadByte(fs)
                            fontColor[GET_BUTTON,i] = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs))
                            textAlignment[GET_BUTTON,i] = ReadByte(fs)
                            textAAliasing[GET_BUTTON,i] = ReadBool(fs)
                        Next
                    Endif
                    
                    If tinfo[GET_RADIOBUTTON] = TRUE then
                        HagLog(LOG_DEBUG, "Reading Compiled Radio Button Data...")
                        
                        For i = 0 to (MAX_RDO_STATES-1)                    
                            fontName[GET_RADIOBUTTON,i] = ReadStr(fs)
                            fontSize[GET_RADIOBUTTON,i] = ReadByte(fs)
                            fontStyle[GET_RADIOBUTTON,i] = ReadByte(fs)
                            fontColor[GET_RADIOBUTTON,i] = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs))
                            textAlignment[GET_RADIOBUTTON,i] = ReadByte(fs)
                            textAAliasing[GET_RADIOBUTTON,i] = ReadBool(fs)
                        Next
                    Endif

                    If tinfo[GET_CHECKBOX] = TRUE then
                        HagLog(LOG_DEBUG, "Reading Compiled Checkbox Data...")
                        
                        For i = 0 to (MAX_CBX_STATES-1)                    
                            fontName[GET_CHECKBOX,i] = ReadStr(fs)
                            fontSize[GET_CHECKBOX,i] = ReadByte(fs)
                            fontStyle[GET_CHECKBOX,i] = ReadByte(fs)
                            fontColor[GET_CHECKBOX,i] = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs))
                            textAlignment[GET_CHECKBOX,i] = ReadByte(fs)
                            textAAliasing[GET_CHECKBOX,i] = ReadBool(fs)
                        Next
                    Endif

                    If tinfo[GET_TEXTBOX] = TRUE then
                        HagLog(LOG_DEBUG, "Reading Compiled Textbox Data...")
                                    
                        fontName[GET_TEXTBOX,0] = ReadStr(fs)
                        fontSize[GET_TEXTBOX,0] = ReadByte(fs)
                        fontStyle[GET_TEXTBOX,0] = 0
                        fontColor[GET_TEXTBOX,0] = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs))
                        textAlignment[GET_TEXTBOX,0] = 0
                        textAAliasing[GET_TEXTBOX,0] = FALSE

                        tbxDisabled_fontColor = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs))                         
                        tbxSelection_fontColor = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs)) 
                        tbxSelection_backColor = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs))
                        tbx_cursorColor = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs))
                        tbx_cursorWidth = ReadByte(fs)
                        tbx_cursorHeight = ReadByte(fs)
                        tbx_pointerWidth = ReadByte(fs)
                    Endif

                    If tinfo[GET_TEXT] = TRUE then
                        HagLog(LOG_DEBUG, "Reading Compiled Text Data...")
                    
                        For i = 0 to (MAX_TXT_TYPES-1)                    
                            fontName[GET_TEXT,i] = ReadStr(fs)
                            fontSize[GET_TEXT,i] = ReadByte(fs)
                            fontStyle[GET_TEXT,i] = ReadByte(fs)
                            fontColor[GET_TEXT,i] = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs))
                            textAlignment[GET_TEXT,i] = ReadByte(fs)
                            textAAliasing[GET_TEXT,i] = ReadBool(fs)
                        Next
                    Endif

                    If tinfo[GET_DROPDOWN] = TRUE then
                        HagLog(LOG_DEBUG, "Reading Compiled DropDown Data...")
                    
                        For i = 0 to (MAX_DDB_STATES-1)                    
                            fontName[GET_DROPDOWN,i] = ReadStr(fs)
                            fontSize[GET_DROPDOWN,i] = ReadByte(fs)
                            fontStyle[GET_DROPDOWN,i] = ReadByte(fs)
                            fontColor[GET_DROPDOWN,i] = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs))
                            textAlignment[GET_DROPDOWN,i] = ReadByte(fs)
                            textAAliasing[GET_DROPDOWN,i] = ReadBool(fs)
                        Next
                        
                        dropDown_above_yoffset = ReadByte(fs) - 128
                        dropDown_below_yoffset = ReadByte(fs) - 128
                        
                        For i = (MAX_DDB_STATES) to (MAX_DDB_BOX_STATES-1)                    
                            fontName[GET_DROPDOWN,i] = ReadStr(fs)
                            fontSize[GET_DROPDOWN,i] = ReadByte(fs)
                            fontStyle[GET_DROPDOWN,i] = ReadByte(fs)
                            fontColor[GET_DROPDOWN,i] = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs))
                            If i = DDB_BOX_STATE_HOVER then backColor[GET_DROPDOWN,i] = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs))
                            textAlignment[GET_DROPDOWN,i] = ReadByte(fs)
                            textAAliasing[GET_DROPDOWN,i] = ReadBool(fs)
                        Next
                    Endif

                    If tinfo[GET_TAB] = TRUE then
                        HagLog(LOG_DEBUG, "Reading Compiled Tab Data...")
                    
                        For i = 0 to (MAX_TAB_STATES-1)                    
                            fontName[GET_TAB,i] = ReadStr(fs)
                            fontSize[GET_TAB,i] = ReadByte(fs)
                            fontStyle[GET_TAB,i] = ReadByte(fs)
                            fontColor[GET_TAB,i] = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs))
                            textAlignment[GET_TAB,i] = ReadByte(fs)
                            textAAliasing[GET_TAB,i] = ReadBool(fs)
                        Next
                    Endif

                    If tinfo[GET_FRAME] = TRUE then
                        HagLog(LOG_DEBUG, "Reading Compiled Frame Data...")
                    
                        For i = 0 to (MAX_FRA_STYLES-1)                    
                            fontName[GET_FRAME,i] = ReadStr(fs)
                            fontSize[GET_FRAME,i] = ReadByte(fs)
                            fontStyle[GET_FRAME,i] = ReadByte(fs)
                            fontColor[GET_FRAME,i] = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs))
                            textAlignment[GET_FRAME,i] = ReadByte(fs)
                            textAAliasing[GET_FRAME,i] = ReadBool(fs)
                        Next
                    Endif
                    
                    If tinfo[GET_LISTBOX] = TRUE then
                        HagLog(LOG_DEBUG, "Reading Compiled Listbox Data...")
                    
                        For i = (MAX_LBX_STATES) to (MAX_LBX_ITEM_STATES-1)
                            fontName[GET_LISTBOX,i] = ReadStr(fs)
                            fontSize[GET_LISTBOX,i] = ReadByte(fs)
                            fontStyle[GET_LISTBOX,i] = ReadByte(fs)
                            fontColor[GET_LISTBOX,i] = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs))
                            backColor[GET_LISTBOX,i] = ToRGBA(ReadByte(fs),ReadByte(fs),ReadByte(fs),ReadByte(fs))
                            textAlignment[GET_LISTBOX,i] = ReadByte(fs)
                            textAAliasing[GET_LISTBOX,i] = ReadByte(fs)
                        Next
                    Endif
                
                Dec(log_indent)
        
            Closefile(fs)
        
        Else
            HagLog(LOG_ERROR,"Warning: HagLoadGuiTheme: Compiled theme file not found at "+themeFile)        
        Endif
    
    Dec(log_indent)
    HagLog(LOG_DEBUG,"HagLoadGuiTheme: End")

End

Function HagLoadThemeImage(theme, imgName: String, ttype:Integer=THEME_TYPE_GUI, chkptr:Boolean=TRUE) : Element
{
    Returns a handle to a theme image, performing some checks.
}
Var
    imgPath: String
    newImgName: String
    canvas: Element
Begin
    If (ttype = THEME_TYPE_GUI) then imgPath = (hag_baseDir+"themes\gui\"+theme+"\"+imgName)
    
    If FileExists(imgPath) then

        HagLog(LOG_DEBUG,"LoadThemeImage: "+imgName+" (FOUND)")
        result = LoadImage(imgPath)

        Inc(log_indent)        
        If result = NULL then HagLog(LOG_ERROR,"FATAL: LoadThemeImage: NULL handle returned.")
        Dec(log_indent)
    
    Else
    
        If chkptr and FileExists(imgPath+".ptr") then
            HagLog(LOG_DEBUG,"LoadThemeImage: "+imgName+" (REDIRECT)")
            Inc(log_indent)
            result = HagLoadThemeImage(theme,FileGetContents(imgPath+".ptr"),ttype,FALSE)
            Dec(log_indent)
        Else
    
            HagLog(LOG_ERROR,"Warning: LoadThemeImage: Image not found at "+imgPath)
            canvas = CreateImage(32,32)
            CLS(ToRGBA(255,0,0,100),canvas)
            result = canvas
        
        Endif
        
    Endif
    
End

Procedure HagFreeAll() ; Export
Var
    finram : Integer
    tcachecount : Integer
Begin
    finram = MemorySize(OSM_AVAILPHYS)
    tcachecount = CountList(tileCacheList)
    
    HagFreeGuiTheme()
    HagFreeTileCache()
    HagFreeForms()
    
     
    HagLog(LOG_PERF,"Session lasted: "+(Millisecs-hag_start)+" Millisecs ("+((Millisecs-hag_start)/1000)+" Seconds)")
    HagLog(LOG_PERF,"MB RAM Available: Start="+ToString(hag_ram/(1024*1024))+" End="+ToString(finram/(1024*1024))+" Finish="+ToString(MemorySize(OSM_AVAILPHYS)/(1024*1024)))
    HagLog(LOG_PERF,"In this session, "+ToString(hag_elements)+" hag elements were created.")
    HagLog(LOG_PERF,"At session end, there were "+tcachecount+" tiled images cached.")
    HagLog(LOG_PERF,"Average time between updates (milliseconds): "+hag_atpu)
    If (hag_atpu > 0) then
        HagLog(LOG_PERF,"Average updates per second: "+(1000.0/hag_atpu))
        HagLog(LOG_PERF,"Estimated total updates: "+ToInt((Millisecs-hag_start)/hag_atpu))
    Endif
        
    If hag_errors > 0 then MessageBox("Notice: Warnings/errors were logged by hag.","hag - Half A GUI")
End

Procedure HagFreeGuiTheme() ; Export
Begin
    If hag_hasGuiTheme = FALSE then
        HagLog(LOG_ERROR,"Warning: HagFreeGuiTheme() was called when a theme did not exist")
    Else
        HagLog(LOG_DEBUG,"HagFreeGuiTheme: Start")
        Inc(log_indent)
        
            hag_hasGuiTheme = FALSE

            { Buttons }            
            FreeImage(gte_button[BTN_PART_LEFT,   BTN_STATE_NORMAL])
            FreeImage(gte_button[BTN_PART_MID,    BTN_STATE_NORMAL])
            FreeImage(gte_button[BTN_PART_RIGHT,  BTN_STATE_NORMAL])
            FreeImage(gte_button[BTN_PART_LEFT,   BTN_STATE_HOVER])
            FreeImage(gte_button[BTN_PART_MID,    BTN_STATE_HOVER])
            FreeImage(gte_button[BTN_PART_RIGHT,  BTN_STATE_HOVER])
            FreeImage(gte_button[BTN_PART_LEFT,   BTN_STATE_FOCUSED])
            FreeImage(gte_button[BTN_PART_MID,    BTN_STATE_FOCUSED])
            FreeImage(gte_button[BTN_PART_RIGHT,  BTN_STATE_FOCUSED])
            FreeImage(gte_button[BTN_PART_LEFT,   BTN_STATE_ACTIVE])
            FreeImage(gte_button[BTN_PART_MID,    BTN_STATE_ACTIVE])
            FreeImage(gte_button[BTN_PART_RIGHT,  BTN_STATE_ACTIVE])
            FreeImage(gte_button[BTN_PART_LEFT,   BTN_STATE_DISABLED])
            FreeImage(gte_button[BTN_PART_MID,    BTN_STATE_DISABLED])
            FreeImage(gte_button[BTN_PART_RIGHT,  BTN_STATE_DISABLED])
            
            { Progress Bars }
            FreeImage(gte_progressBar[PROG_PART_LEFT,     PROG_STATE_HORIZ])
            FreeImage(gte_progressBar[PROG_PART_MID,      PROG_STATE_HORIZ])
            FreeImage(gte_progressBar[PROG_PART_RIGHT,    PROG_STATE_HORIZ])
            FreeImage(gte_progressBar[PROG_PART_ITEM,     PROG_STATE_HORIZ])
            FreeImage(gte_progressBar[PROG_PART_LEFT,     PROG_STATE_VERT])
            FreeImage(gte_progressBar[PROG_PART_MID,      PROG_STATE_VERT])
            FreeImage(gte_progressBar[PROG_PART_RIGHT,    PROG_STATE_VERT])
            FreeImage(gte_progressBar[PROG_PART_ITEM,     PROG_STATE_VERT])
            
            { Sliders }
            FreeImage(gte_slider[SLI_PART_LEFT,           SLI_STATE_HORIZ])
            FreeImage(gte_slider[SLI_PART_MID,            SLI_STATE_HORIZ])
            FreeImage(gte_slider[SLI_PART_RIGHT,          SLI_STATE_HORIZ])
            FreeImage(gte_slider[SLI_PART_MARKING,        SLI_STATE_HORIZ])  
            FreeImage(gte_slider[SLI_PART_LEFT,           SLI_STATE_VERT])
            FreeImage(gte_slider[SLI_PART_MID,            SLI_STATE_VERT])
            FreeImage(gte_slider[SLI_PART_RIGHT,          SLI_STATE_VERT])
            FreeImage(gte_slider[SLI_PART_MARKING,        SLI_STATE_VERT])
            FreeImage(gte_slider[SLI_PART_SLIDER, SLI_SLIDER_STATE_HORIZ_NORMAL])
            FreeImage(gte_slider[SLI_PART_SLIDER, SLI_SLIDER_STATE_HORIZ_HOVER])
            FreeImage(gte_slider[SLI_PART_SLIDER, SLI_SLIDER_STATE_HORIZ_DISABLED])
            FreeImage(gte_slider[SLI_PART_SLIDER, SLI_SLIDER_STATE_VERT_NORMAL])
            FreeImage(gte_slider[SLI_PART_SLIDER, SLI_SLIDER_STATE_VERT_HOVER])
            FreeImage(gte_slider[SLI_PART_SLIDER, SLI_SLIDER_STATE_VERT_DISABLED])

            { Radio Buttons }
            FreeImage(gte_radioButton[RDO_STATE_NORMAL_UNSELECTED])
            FreeImage(gte_radioButton[RDO_STATE_HOVER_UNSELECTED])
            FreeImage(gte_radioButton[RDO_STATE_ACTIVE_UNSELECTED])
            FreeImage(gte_radioButton[RDO_STATE_DISABLED_UNSELECTED])
            FreeImage(gte_radioButton[RDO_STATE_NORMAL_SELECTED])
            FreeImage(gte_radioButton[RDO_STATE_HOVER_SELECTED])
            FreeImage(gte_radioButton[RDO_STATE_ACTIVE_SELECTED])
            FreeImage(gte_radioButton[RDO_STATE_DISABLED_SELECTED])

            { Check Boxes }
            FreeImage(gte_checkBox[CBX_STATE_NORMAL_UNSELECTED])
            FreeImage(gte_checkBox[CBX_STATE_HOVER_UNSELECTED])
            FreeImage(gte_checkBox[CBX_STATE_ACTIVE_UNSELECTED])
            FreeImage(gte_checkBox[CBX_STATE_DISABLED_UNSELECTED])
            FreeImage(gte_checkBox[CBX_STATE_NORMAL_SELECTED])
            FreeImage(gte_checkBox[CBX_STATE_HOVER_SELECTED])
            FreeImage(gte_checkBox[CBX_STATE_ACTIVE_SELECTED])
            FreeImage(gte_checkBox[CBX_STATE_DISABLED_SELECTED])

            { Text Boxes }
            FreeImage(gte_textBox[TBX_PART_LEFT,  TBX_STATE_NORMAL])
            FreeImage(gte_textBox[TBX_PART_MID,   TBX_STATE_NORMAL])
            FreeImage(gte_textBox[TBX_PART_RIGHT, TBX_STATE_NORMAL])
            FreeImage(gte_textBox[TBX_PART_LEFT,  TBX_STATE_HOVER])
            FreeImage(gte_textBox[TBX_PART_MID,   TBX_STATE_HOVER])
            FreeImage(gte_textBox[TBX_PART_RIGHT, TBX_STATE_HOVER])
            FreeImage(gte_textBox[TBX_PART_LEFT,  TBX_STATE_FOCUSED])
            FreeImage(gte_textBox[TBX_PART_MID,   TBX_STATE_FOCUSED])
            FreeImage(gte_textBox[TBX_PART_RIGHT, TBX_STATE_FOCUSED])
            FreeImage(gte_textBox[TBX_PART_LEFT,  TBX_STATE_DISABLED])
            FreeImage(gte_textBox[TBX_PART_MID,   TBX_STATE_DISABLED])
            FreeImage(gte_textBox[TBX_PART_RIGHT, TBX_STATE_DISABLED])
            
            { Drop Down Boxes }
            FreeImage(gte_dropDown[DDB_PART_LEFT,     DDB_STATE_NORMAL])
            FreeImage(gte_dropDown[DDB_PART_MID,      DDB_STATE_NORMAL])
            FreeImage(gte_dropDown[DDB_PART_RIGHT,    DDB_STATE_NORMAL])
            FreeImage(gte_dropDown[DDB_PART_LEFT,     DDB_STATE_HOVER])
            FreeImage(gte_dropDown[DDB_PART_MID,      DDB_STATE_HOVER])
            FreeImage(gte_dropDown[DDB_PART_RIGHT,    DDB_STATE_HOVER])
            FreeImage(gte_dropDown[DDB_PART_LEFT,     DDB_STATE_ACTIVE])
            FreeImage(gte_dropDown[DDB_PART_MID,      DDB_STATE_ACTIVE])
            FreeImage(gte_dropDown[DDB_PART_RIGHT,    DDB_STATE_ACTIVE])
            FreeImage(gte_dropDown[DDB_PART_LEFT,     DDB_STATE_DISABLED])
            FreeImage(gte_dropDown[DDB_PART_MID,      DDB_STATE_DISABLED])
            FreeImage(gte_dropDown[DDB_PART_RIGHT,    DDB_STATE_DISABLED])
            
            { Drop Down Boxes : Box }
            FreeImage(gte_dropDownBox[DDB_PART_BOX_TOP_LEFT])
            FreeImage(gte_dropDownBox[DDB_PART_BOX_TOP_MID])
            FreeImage(gte_dropDownBox[DDB_PART_BOX_TOP_RIGHT])
            FreeImage(gte_dropDownBox[DDB_PART_BOX_MID_LEFT])
            FreeImage(gte_dropDownBox[DDB_PART_BOX_MID_MID])
            FreeImage(gte_dropDownBox[DDB_PART_BOX_MID_RIGHT])
            FreeImage(gte_dropDownBox[DDB_PART_BOX_BOTTOM_LEFT])
            FreeImage(gte_dropDownBox[DDB_PART_BOX_BOTTOM_MID])
            FreeImage(gte_dropDownBox[DDB_PART_BOX_BOTTOM_RIGHT])
            
            { Tabs }
            FreeImage(gte_tab[TAB_PART_LEFT,  TAB_STATE_INACTIVE])
            FreeImage(gte_tab[TAB_PART_MID,   TAB_STATE_INACTIVE])
            FreeImage(gte_tab[TAB_PART_RIGHT, TAB_STATE_INACTIVE])
            FreeImage(gte_tab[TAB_PART_LEFT,  TAB_STATE_HOVER])
            FreeImage(gte_tab[TAB_PART_MID,   TAB_STATE_HOVER])
            FreeImage(gte_tab[TAB_PART_RIGHT, TAB_STATE_HOVER])
            FreeImage(gte_tab[TAB_PART_LEFT,  TAB_STATE_ACTIVE])
            FreeImage(gte_tab[TAB_PART_MID,   TAB_STATE_ACTIVE])
            FreeImage(gte_tab[TAB_PART_RIGHT, TAB_STATE_ACTIVE])
            
            { Frames : Tab }
            FreeImage(gte_frame[FRA_PART_TOP_LEFT,    FRAME_STYLE_TAB])
            FreeImage(gte_frame[FRA_PART_TOP_MID,     FRAME_STYLE_TAB])
            FreeImage(gte_frame[FRA_PART_TOP_RIGHT,   FRAME_STYLE_TAB])
            FreeImage(gte_frame[FRA_PART_MID_LEFT,    FRAME_STYLE_TAB])
            FreeImage(gte_frame[FRA_PART_MID_MID,     FRAME_STYLE_TAB])
            FreeImage(gte_frame[FRA_PART_MID_RIGHT,   FRAME_STYLE_TAB])
            FreeImage(gte_frame[FRA_PART_BOTTOM_LEFT, FRAME_STYLE_TAB])
            FreeImage(gte_frame[FRA_PART_BOTTOM_MID,  FRAME_STYLE_TAB])
            FreeImage(gte_frame[FRA_PART_BOTTOM_RIGHT,FRAME_STYLE_TAB])
            
            { Frames : Round Border }
            FreeImage(gte_frame[FRA_PART_TOP_LEFT,    FRAME_STYLE_ROUNDBORDER])
            FreeImage(gte_frame[FRA_PART_TOP_MID,     FRAME_STYLE_ROUNDBORDER])
            FreeImage(gte_frame[FRA_PART_TOP_RIGHT,   FRAME_STYLE_ROUNDBORDER])
            FreeImage(gte_frame[FRA_PART_MID_LEFT,    FRAME_STYLE_ROUNDBORDER])
            FreeImage(gte_frame[FRA_PART_MID_MID,     FRAME_STYLE_ROUNDBORDER])
            FreeImage(gte_frame[FRA_PART_MID_RIGHT,   FRAME_STYLE_ROUNDBORDER])
            FreeImage(gte_frame[FRA_PART_BOTTOM_LEFT, FRAME_STYLE_ROUNDBORDER])
            FreeImage(gte_frame[FRA_PART_BOTTOM_MID,  FRAME_STYLE_ROUNDBORDER])
            FreeImage(gte_frame[FRA_PART_BOTTOM_RIGHT,FRAME_STYLE_ROUNDBORDER])

            { Frames : Round Solid }
            FreeImage(gte_frame[FRA_PART_TOP_LEFT,    FRAME_STYLE_ROUNDSOLID])
            FreeImage(gte_frame[FRA_PART_TOP_MID,     FRAME_STYLE_ROUNDSOLID])
            FreeImage(gte_frame[FRA_PART_TOP_RIGHT,   FRAME_STYLE_ROUNDSOLID])
            FreeImage(gte_frame[FRA_PART_MID_LEFT,    FRAME_STYLE_ROUNDSOLID])
            FreeImage(gte_frame[FRA_PART_MID_MID,     FRAME_STYLE_ROUNDSOLID])
            FreeImage(gte_frame[FRA_PART_MID_RIGHT,   FRAME_STYLE_ROUNDSOLID])
            FreeImage(gte_frame[FRA_PART_BOTTOM_LEFT, FRAME_STYLE_ROUNDSOLID])
            FreeImage(gte_frame[FRA_PART_BOTTOM_MID,  FRAME_STYLE_ROUNDSOLID])
            FreeImage(gte_frame[FRA_PART_BOTTOM_RIGHT,FRAME_STYLE_ROUNDSOLID])

            { Frames : Square Border }
            FreeImage(gte_frame[FRA_PART_TOP_LEFT,    FRAME_STYLE_SQUAREBORDER])
            FreeImage(gte_frame[FRA_PART_TOP_MID,     FRAME_STYLE_SQUAREBORDER])
            FreeImage(gte_frame[FRA_PART_TOP_RIGHT,   FRAME_STYLE_SQUAREBORDER])
            FreeImage(gte_frame[FRA_PART_MID_LEFT,    FRAME_STYLE_SQUAREBORDER])
            FreeImage(gte_frame[FRA_PART_MID_MID,     FRAME_STYLE_SQUAREBORDER])
            FreeImage(gte_frame[FRA_PART_MID_RIGHT,   FRAME_STYLE_SQUAREBORDER])
            FreeImage(gte_frame[FRA_PART_BOTTOM_LEFT, FRAME_STYLE_SQUAREBORDER])
            FreeImage(gte_frame[FRA_PART_BOTTOM_MID,  FRAME_STYLE_SQUAREBORDER])
            FreeImage(gte_frame[FRA_PART_BOTTOM_RIGHT,FRAME_STYLE_SQUAREBORDER])

            { Frames : Square Solid }
            FreeImage(gte_frame[FRA_PART_TOP_LEFT,    FRAME_STYLE_SQUARESOLID])
            FreeImage(gte_frame[FRA_PART_TOP_MID,     FRAME_STYLE_SQUARESOLID])
            FreeImage(gte_frame[FRA_PART_TOP_RIGHT,   FRAME_STYLE_SQUARESOLID])
            FreeImage(gte_frame[FRA_PART_MID_LEFT,    FRAME_STYLE_SQUARESOLID])
            FreeImage(gte_frame[FRA_PART_MID_MID,     FRAME_STYLE_SQUARESOLID])
            FreeImage(gte_frame[FRA_PART_MID_RIGHT,   FRAME_STYLE_SQUARESOLID])
            FreeImage(gte_frame[FRA_PART_BOTTOM_LEFT, FRAME_STYLE_SQUARESOLID])
            FreeImage(gte_frame[FRA_PART_BOTTOM_MID,  FRAME_STYLE_SQUARESOLID])
            FreeImage(gte_frame[FRA_PART_BOTTOM_RIGHT,FRAME_STYLE_SQUARESOLID])

            { Frames : Mockwindow }
            FreeImage(gte_frame[FRA_PART_TOP_LEFT,    FRAME_STYLE_MOCKWINDOW])
            FreeImage(gte_frame[FRA_PART_TOP_MID,     FRAME_STYLE_MOCKWINDOW])
            FreeImage(gte_frame[FRA_PART_TOP_RIGHT,   FRAME_STYLE_MOCKWINDOW])
            FreeImage(gte_frame[FRA_PART_MID_LEFT,    FRAME_STYLE_MOCKWINDOW])
            FreeImage(gte_frame[FRA_PART_MID_MID,     FRAME_STYLE_MOCKWINDOW])
            FreeImage(gte_frame[FRA_PART_MID_RIGHT,   FRAME_STYLE_MOCKWINDOW])
            FreeImage(gte_frame[FRA_PART_BOTTOM_LEFT, FRAME_STYLE_MOCKWINDOW])
            FreeImage(gte_frame[FRA_PART_BOTTOM_MID,  FRAME_STYLE_MOCKWINDOW])
            FreeImage(gte_frame[FRA_PART_BOTTOM_RIGHT,FRAME_STYLE_MOCKWINDOW])
            
            { Frames : Header }
            FreeImage(gte_frame[FRA_PART_TOP_LEFT,    FRAME_STYLE_HEADER])
            FreeImage(gte_frame[FRA_PART_TOP_MID,     FRAME_STYLE_HEADER])
            FreeImage(gte_frame[FRA_PART_TOP_RIGHT,   FRAME_STYLE_HEADER])
            FreeImage(gte_frame[FRA_PART_MID_LEFT,    FRAME_STYLE_HEADER])
            FreeImage(gte_frame[FRA_PART_MID_MID,     FRAME_STYLE_HEADER])
            FreeImage(gte_frame[FRA_PART_MID_RIGHT,   FRAME_STYLE_HEADER])
            FreeImage(gte_frame[FRA_PART_BOTTOM_LEFT, FRAME_STYLE_HEADER])
            FreeImage(gte_frame[FRA_PART_BOTTOM_MID,  FRAME_STYLE_HEADER])
            FreeImage(gte_frame[FRA_PART_BOTTOM_RIGHT,FRAME_STYLE_HEADER])
            
            { Listboxes }
            FreeImage(gte_listBox[LBX_PART_TOP_LEFT, LBX_STATE_NORMAL])
            FreeImage(gte_listBox[LBX_PART_TOP_MID, LBX_STATE_NORMAL])
            FreeImage(gte_listBox[LBX_PART_TOP_RIGHT, LBX_STATE_NORMAL])
            FreeImage(gte_listBox[LBX_PART_MID_LEFT, LBX_STATE_NORMAL])
            FreeImage(gte_listBox[LBX_PART_MID_MID, LBX_STATE_NORMAL])
            FreeImage(gte_listBox[LBX_PART_MID_RIGHT, LBX_STATE_NORMAL])
            FreeImage(gte_listBox[LBX_PART_BOTTOM_LEFT, LBX_STATE_NORMAL])
            FreeImage(gte_listBox[LBX_PART_BOTTOM_MID, LBX_STATE_NORMAL])
            FreeImage(gte_listBox[LBX_PART_BOTTOM_RIGHT, LBX_STATE_NORMAL])
            FreeImage(gte_listBox[LBX_PART_TOP_LEFT, LBX_STATE_DISABLED])
            FreeImage(gte_listBox[LBX_PART_TOP_MID, LBX_STATE_DISABLED])
            FreeImage(gte_listBox[LBX_PART_TOP_RIGHT, LBX_STATE_DISABLED])
            FreeImage(gte_listBox[LBX_PART_MID_LEFT, LBX_STATE_DISABLED])
            FreeImage(gte_listBox[LBX_PART_MID_MID, LBX_STATE_DISABLED])
            FreeImage(gte_listBox[LBX_PART_MID_RIGHT, LBX_STATE_DISABLED])
            FreeImage(gte_listBox[LBX_PART_BOTTOM_LEFT, LBX_STATE_DISABLED])
            FreeImage(gte_listBox[LBX_PART_BOTTOM_MID, LBX_STATE_DISABLED])
            FreeImage(gte_listBox[LBX_PART_BOTTOM_RIGHT, LBX_STATE_DISABLED])
            
            { Scrollbars }
            FreeImage(gte_scrollBar[SBR_PART_UP,      SBR_STATE_NORMAL])
            FreeImage(gte_scrollBar[SBR_PART_DOWN,    SBR_STATE_NORMAL])
            FreeImage(gte_scrollBar[SBR_PART_SLIDER,  SBR_STATE_NORMAL])
            FreeImage(gte_scrollBar[SBR_PART_BAR,     SBR_STATE_NORMAL])
            FreeImage(gte_scrollBar[SBR_PART_UP,      SBR_STATE_HOVER])
            FreeImage(gte_scrollBar[SBR_PART_DOWN,    SBR_STATE_HOVER])
            FreeImage(gte_scrollBar[SBR_PART_SLIDER,  SBR_STATE_HOVER])
            FreeImage(gte_scrollBar[SBR_PART_UP,      SBR_STATE_ACTIVE])
            FreeImage(gte_scrollBar[SBR_PART_DOWN,    SBR_STATE_ACTIVE])
            FreeImage(gte_scrollBar[SBR_PART_SLIDER,  SBR_STATE_ACTIVE])
            FreeImage(gte_scrollBar[SBR_PART_UP,      SBR_STATE_DISABLED])
            FreeImage(gte_scrollBar[SBR_PART_DOWN,    SBR_STATE_DISABLED])
            FreeImage(gte_scrollBar[SBR_PART_BAR,     SBR_STATE_DISABLED])

        Dec(log_indent)
        HagLog(LOG_DEBUG,"HagFreeGuiTheme: End")
        
    Endif
End

Procedure HagFreeTileCache() ; Export
Begin
    HagLog(LOG_DEBUG,"HagFreeTileCache: Start")
    Inc(log_indent)
    
        Loop tileCache through tileCacheList
            HagLog(LOG_DEBUG,"HagFreeTileCache: ID("+ToString(tileCache.eGet)+","+ToString(tileCache.ePart)+","+ToString(tileCache.eState)+"), "+ToString(tileCache.w)+" by "+ToString(tileCache.h))
        
            FreeImage(tileCache.e)
            Free(tileCache)
        EndLoop
    
    Dec(log_indent)
    HagLog(LOG_DEBUG,"HagFreeTileCache: End")
End

Procedure HagFreeForms() ; Export
Begin
    HagLog(LOG_DEBUG,"HagFreeForms: Start")
    Inc(log_indent)

        Loop form through formList
            FreeForm(form)
        EndLoop

    Dec(log_indent)
    HagLog(LOG_DEBUG,"HagFreeForms: End")
End

Procedure HagLog(logFile: String, msg: String)
{
    Writes an entry to the specified debug file, if debugging is enabled.
    logFile should be either LOG_DEBUG or LOG_ERROR
}
Var
    logPath : String
    logSize : Integer = 0
    fstream : Element
Begin
    If (logfile <> LOG_DEBUG) and (logfile <> LOG_ERROR) and (logfile <> LOG_PERF) then
        HagLog(LOG_ERROR,"FATAL: HagLog: Invalid log context!")
    Else
        If ((logFile = LOG_DEBUG) and (hag_prefEnable[HAG_PREF_ENABLE_DEBUG_LOG] = TRUE)) or ((logFile = LOG_ERROR) and (hag_prefEnable[HAG_PREF_ENABLE_ERROR_LOG] = TRUE)) or ((logFile = LOG_PERF) and (hag_prefEnable[HAG_PREF_ENABLE_PERF_LOG] = TRUE)) then
        
            If (logFile = LOG_ERROR) and (Left(msg,1) <> "(") then Inc(hag_errors)
           
            logPath = hag_baseDir+"Log\"+logfile
    
            If FileExists(logPath) then    
                fstream = ReadFile(logPath)
                logSize = FileSize(fstream)
                Closefile(fstream)
            Endif
    
            fstream = WriteFile(logPath)
            FileSeek(fstream,logSize)
            WriteLn(fstream,""+RPad(ToString((Millisecs-hag_start)),8,"")+RepStr(" ",(log_indent*4))+msg)    
            Closefile(fstream)

            If logFile = LOG_ERROR then HagLog(LOG_DEBUG,msg)
    
        Endif
    Endif
End







(* -------------------------------------------------------------------------- *)
(* HAG SYSTEM / OPTIONS *)
(* -------------------------------------------------------------------------- *)


Procedure HagEnableDebugLog(enable:Boolean=TRUE) ; Export
{
    Proivdes the easiest to remember interface to enable (or disable) the
    debug log
}
Begin
    HagPrefEnable(HAG_PREF_ENABLE_DEBUG_LOG,enable)
End

Procedure HagDisableDebugLog() ; Export
Begin
    HagEnableDebugLog(FALSE)
End

Procedure HagEnableErrorLog(enable:Boolean=TRUE) ; Export
{
    Proivdes the easiest to remember interface to enable (or disable) the
    error log
}
Begin
    HagPrefEnable(HAG_PREF_ENABLE_ERROR_LOG,enable)
End

Procedure HagDisableErrorLog() ; Export
Begin
    HagEnableErrorLog(FALSE)
End

Procedure HagEnablePerfLog(enable:Boolean=TRUE) ; Export
{
    Proivdes the easiest to remember interface to enable (or disable) the
    performance log
}
Begin
    HagPrefEnable(HAG_PREF_ENABLE_PERF_LOG,enable)
End

Procedure HagDisablePerfLog() ; Export
Begin
    HagEnablePerfLog(FALSE)
End

Procedure HagEnableTileCache(enable:Boolean=TRUE) ; Export
{
    Proivdes the easiest to remember interface to enable (or disable) the
    tile cache
}
Begin
    HagPrefEnable(HAG_PREF_ENABLE_TILE_CACHE,enable)
End

Procedure HagDisableTileCache() ; Export
Begin
    HagEnableTileCache(FALSE)
End

Procedure HagEnableAAliasing(enable:Boolean=TRUE) ; Export
{
    Proivdes the easiest to remember interface to enable (or disable) theme
    font antialiaising, if the theme has been compiled with antialiaisng turned
    on.    
}
Begin
    HagPrefEnable(HAG_PREF_ENABLE_AADRAW,enable)
End

Procedure HagDisableAAliasing() ; Export
Begin
    HagEnableAAliasing(FALSE)
End



Begin
End
