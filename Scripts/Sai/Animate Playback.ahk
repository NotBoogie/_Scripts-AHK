
Exit

#SingleInstance Force

global numberOfFrames := 4
global isPlaying := false

keyFrameUp := Numpad4 
keyFrameDown := Numpad5
keyFrameShowOnlyOneLater := Numpad6

global FPS = 8

;   Milliseconds to wait on each frame
global FPSsleepTime = 1 / FPS * 1000

global BreakLoop

;   Go up numberOfFrames pressing keyFrameShowOnlyOneLater 
;   each time per framerate, then spam down numberOfFrames

GetFrameNumber()

;pressButton(Numpad4)
;Loop{
    ;Loop, % numberOfFrames{
    ;    pressButton(keyFrameUp)
    ;    pressButton(keyFrameShowOnlyOneLater)
    ;}
    
;}


DoLoop( frames , delay ){

    ;MsgBox, %frames%
    
    Loop {
    
        if(BreakLoop = 1)
            break 
    
        Loop , % frames - 1 {
        
            if(BreakLoop = 1)
                break 
            
            moveUpFrame()
            
            Sleep delay
        }
        
        if(BreakLoop = 1)
            break 
        
        resetToBottom(frames - 1)
        
        Sleep delay
    }
}

return


;   Escape key will exit the process
;Esc::ExitApp


moveUpFrame(){
    
    Send , { Numpad4 Down }
    Send , { Numpad4 Up }
    
    ShowOnlyCurrentLayer()
}

ShowOnlyCurrentLayer(){
    Send , { Numpad6 Down }
    Send , { Numpad6 Up }
}

resetToBottom(numberOfFrames){
    
    Loop , % numberOfFrames {
        
        Send , { Numpad5 Down }
        
        Sleep 15
        
        ;Send, { Numpad5 Up }
    }
    
    Send , {Numpad5 Up}
    
    ShowOnlyCurrentLayer()
}

pressButton( button ){
    Send , { %button% Down }
    Sleep 50
    Send , { %button% Up }
}

traverseUpWithOnionSkin(){
    ;Set layer transparency to 30
    ;Make new layer
    ;Fill new layer with green
    ;Make new layer be masked by previous
    ;Move up layer selection
}

shiftDown(){
    Send , { Shift Down }
}

shiftUp(){
    Send , { Shift Up }
}

RandSleep( x , y ){
    Random , rand , %x% , %y%
    Sleep %rand%
}

GetFrameNumber(){
    InputBox , numberOfFrames, Number of Frames, Enter number of frames., , 150, 150
}

Esc::
    BreakLoop = 1
    isPlaying := !isPlaying
    return

1::
    GetFrameNumber()
    return

`::
    if(!isPlaying){
        BreakLoop := 0
        DoLoop(numberOfFrames,FPSsleepTime)
    } else {
        BreakLoop := 1
    }
    
    isPlaying := !isPlaying
    
    return
