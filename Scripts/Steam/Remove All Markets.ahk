;Deletes all your market listings

#Include .\RunescapeToolkit.ahk

Loop{
    Loop{
        onScreen := checkIfImageIsOnScreen("..\..\Resources\SteamKey.bmp")
    if(onScreen == 1)
        break
        Sleep, 500
    }
    justClickLocation(1286, 374)

    Loop{
        onScreen := checkIfImageIsOnScreen("..\..\Resources\RemoveListing.bmp")
    if(onScreen == 1)
        break
        Sleep, 500
    }
    justClickLocation(1144, 561)
    Sleep, 3000
}


return

Esc::ExitApp  ;Escape key will exit... place this at the bottom of the script