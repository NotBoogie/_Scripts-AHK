
;
﻿;  Searches & removes all messages of the 
;  given person without having to ban them.
;


#Include .\Gdip.ahk
#Include .\Gdip_ImageSearch.ahk

CoordMode , Mouse , Screen
CoordMode , Pixel , Screen

Sleep , 1000


outer:

    Loop {
        
        loopTimer := 0
        
        Sleep , 1000
        
        ;Click search bar
        
        Click , 1751 , 46 Left , Down
        Sleep , 78
        Click , 1751 , 46 Left , Down
        Sleep , 200
        Send , {Enter}
        
        ;Sleep, 200
        
        Loop {
            
            loopTimer := loopTimer + 1
            
            if(loopTimer > 50)
                continue outer

            onScreen := checkIfImageIsOnScreen("C:\searching.bmp")
            
            Sleep , 100
        
            if(!onScreen)
                break
        }
        
        loopTimer := 0
        
        Sleep, 300
        
        ;Click post
        
        Click , 1553 , 199 Right , Down
        Sleep , 47
        Click , 1553 , 199 Right , Up
        Sleep , 100
        
        ;Click, 1616, 290 Left, Down
        ;Sleep, 100
        ;Click, 1616, 290 Left, Up
        
        ;   Use keys instead, fuck it
        
        Sleep , 200
        Send , {Down}
        Sleep , 100
        Send , {Down}
        Sleep , 100
        Send , {Down}
        Sleep , 100
        Send , {Down}
        Sleep , 100
        Send , {Enter}
        Sleep , 100
        
        Loop {
            
            loopTimer := loopTimer + 1
            
            if(loopTimer>50)
                continue outer
            
            onScreen := checkIfImageIsOnScreen2("C:\deletebutton.bmp")
            
            if(onScreen != 1)
                onScreen := checkIfImageIsOnScreen2("C:\deletebutton2.bmp")
            
            Sleep, 100
        
            if(onScreen)
                break
        }
        
        ;   Tab to delete
        
        Send , {Tab}
        Sleep , 100
        Send , {Tab}
        Sleep , 100
        
        ;   Delete
        
        Send , {Enter}
    }


    return


;   Escape key will exit the process

Esc::ExitApp


checkIfImageIsOnScreen( topLeftImageLocation ){
    
    imageSearchc(
        x1 , y1 , 
        1460 , 66 , 
        1674 , 140 ,
        topLeftImageLocation
    )
    
    return x1 != null
}

checkIfImageIsOnScreen2( topLeftImageLocation ){

    imageSearchc(
        x1 , y1 ,
        1500 , 400 ,
        1700 , 950 ,
        topLeftImageLocation
    )

    return x1 != null
}


imageSearchc(
    byRef out1 , byRef out2 , 
    Ax , Ay , Bx , By , 
    image , 
    vari = 0 , 
    trans = "" , 
    direction = 5 , 
    debug = 0
){
    
    ptok := gdip_startup()
    fileMap := gdip_createBitmapFromFile(image)
    screenMap := gdip_bitmapfromscreen(Ax . "|" . Ay . "|" . Bx - Ax . "|" . By - Ay)
    
    if(debug)
        gdip_saveBitmapToFile(screenMap,a_now . ".png")
    
    error := gdip_imageSearch(screenMap,fileMap,tempxy,0,0,0,0,vari,trans,direction)
    
    gdip_disposeImage(screenMap)
    gdip_disposeImage(fileMap)
    Gdip_Shutdown(ptok)
    
    if(error){
        out := strSplit(tempxy,"`,")
        out1 := out[1] + Ax
        out2 := out[2] + Ay
        return % error
    }
    
    return 0
}
