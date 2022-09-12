
;
;   Searches & removes all messages of the 
;   given person without having to ban them.
;


#Include ..\Libraries\Gdip.ahk
#Include ..\Libraries\Gdip_ImageSearch.ahk
#Include ..\Libraries\ImageSearch.ahk


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
        Send , { Enter }
        
        ;Sleep, 200
        
        Loop {
            
            loopTimer := loopTimer + 1
            
            if(loopTimer > 50)
                continue outer

            onScreen := isImageOnScreenA("C:\searching.bmp")
            
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
        Send , { Down }
        Sleep , 100
        Send , { Down }
        Sleep , 100
        Send , { Down }
        Sleep , 100
        Send , { Down }
        Sleep , 100
        Send , { Enter }
        Sleep , 100
        
        Loop {
            
            loopTimer := loopTimer + 1
            
            if(loopTimer > 50)
                continue outer
            
            onScreen := isImageOnScreenB("C:\deletebutton.bmp")
            
            if(onScreen != 1)
                onScreen := isImageOnScreenB("C:\deletebutton2.bmp")
            
            Sleep, 100
        
            if(onScreen)
                break
        }
        
        ;   Tab to delete
        
        Send , { Tab }
        Sleep , 100
        Send , { Tab }
        Sleep , 100
        
        ;   Delete
        
        Send , { Enter }
    }


    return


;   Escape key will exit the process

Esc::ExitApp


isImageOnScreenA( image ){
    return isImageOnScreen( image 
            , [ 1460 , 66  ] 
            , [ 1674 , 140 ] )
}

isImageOnScreenB( image ){
    return isImageOnScreen( image 
            , [ 1500 , 400 ] 
            , [ 1700 , 950 ] )
}

isImageOnScreen( image , from , to ){
    
    options := { image : image 
               , from  : from 
               , to    : to }

    imageSearchc( x1 , y1 , options )

    return x1 != null
}
