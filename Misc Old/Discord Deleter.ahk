;Do a search for whoever on Discord, this goes through and deletes every message
;Handy for purging messages without banning the OP

#Include .\Gdip.ahk
#Include .\Gdip_ImageSearch.ahk
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen

Sleep, 1000
outer:
Loop{
loopTimer := 0
    Sleep, 1000
    ;Click search bar
    Click, 1751, 46 Left, Down
    Sleep, 78
    Click, 1751, 46 Left, Down
    Sleep, 200
    Send, {Enter}
    ;Sleep, 200
    Loop{
        loopTimer := loopTimer+1
        if(loopTimer>50)
        {
        continue outer
        }
        onScreen := checkIfImageIsOnScreen("C:\searching.bmp")
        Sleep, 100
    if(!onScreen)
        break
    }
    loopTimer := 0
    Sleep, 300
    ;Click post
    Click, 1553, 199 Right, Down
    Sleep, 47
    Click, 1553, 199 Right, Up
    Sleep, 100
    ;Click, 1616, 290 Left, Down
    ;Sleep, 100
    ;Click, 1616, 290 Left, Up
    ;Use keys instead, fuck it
    Sleep, 200
    Send, {Down}
    Sleep, 100
    Send, {Down}
    Sleep, 100
    Send, {Down}
    Sleep, 100
    Send, {Down}
    Sleep, 100
    Send, {Enter}
    Sleep, 100
    Loop{
        loopTimer := loopTimer+1
        if(loopTimer>50)
        {
        continue outer
        }
        onScreen := checkIfImageIsOnScreen2("C:\deletebutton.bmp")
        if(onScreen != 1)
            onScreen := checkIfImageIsOnScreen2("C:\deletebutton2.bmp")
        Sleep, 100
    if(onScreen)
        break
    }
    ;Tab to delete
    Send, {Tab}
    Sleep, 100
    Send, {Tab}
    Sleep, 100
    ;Delete
    Send, {Enter}

}


return

Esc::ExitApp  ;Escape key will exit... place this at the bottom of the script

checkIfImageIsOnScreen(topLeftImageLocation){
    imageSearchc(x1,y1,1460,66,1674,140,topLeftImageLocation)
    if(x1 == null)
        return false
    return true
}
checkIfImageIsOnScreen2(topLeftImageLocation){
    imageSearchc(x1,y1,1500,400,1700,950,topLeftImageLocation)
    if(x1 == null)
        return false
    return true
}
imageSearchc(byRef out1,byRef out2,x1,y1,x2,y2,image,vari=0,trans="",direction=5,debug=0){
     ptok:=gdip_startup()
    imageB:=gdip_createBitmapFromFile(image)
    scrn:=gdip_bitmapfromscreen(x1 . "|" . y1 . "|" . x2 - x1 . "|" . y2 - y1)
    if(debug)
        gdip_saveBitmapToFile(scrn,a_now . ".png")
    errorlev:=gdip_imageSearch(scrn,imageB,tempxy,0,0,0,0,vari,trans,direction)
    gdip_disposeImage(scrn)
    gdip_disposeImage(imageB)
Gdip_Shutdown(ptok)
    if(errorlev){
        out:=strSplit(tempxy,"`,")
        out1:=out[1] + x1
        out2:=out[2] + y1
        return % errorlev
    }
    return 0
}
