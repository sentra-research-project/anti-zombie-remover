@echo off
REM ============================================
REM  Anti-Zombie Remover v1.0.0
REM  SENTRA Anti-Cheat Research Project
REM  Discord: ed.husserl
REM  License: MIT
REM ============================================

:LANG_SELECT
cls
echo ============================================
echo   SENTRA Anti-Cheat Research Project
echo   Anti-Zombie Remover v1.0.0
echo ============================================
echo.
echo Please select your language / Lutfen dil secin:
echo.
echo [1] English
echo [2] Turkce
echo.
set /p LCHOICE="Choice / Secim (1-2): "

if "%LCHOICE%"=="1" goto EN
if "%LCHOICE%"=="2" goto TR
goto LANG_SELECT

:EN
set MSG_TITLE=Anti-Zombie Remover - Compile Script (English)
set MSG_JAVA_ERR=[ERROR] javac not found!
set MSG_JAVA_HINT=Java JDK 17 or newer must be installed and added to PATH.
set MSG_JAVA_FOUND=[INFO] Java JDK found.
set MSG_SERVER_NOTE=Note: For local testing, use your game folder (e.g. C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid)
set MSG_ASK_SERVER=Enter PZ Dedicated Server folder path: 
set MSG_ERR_FOLDER=[ERROR] Folder not found: 
set MSG_INFO_SERVER=[INFO] Server folder: 
set MSG_ASK_OUTPUT=Where to create output files (leave empty for 'compiled'): 
set MSG_INFO_OUTPUT=[INFO] Files will be saved to: 
set MSG_PREP_CP=[INFO] Preparing Classpath...
set MSG_WARN_NOJAR=[WARNING] No .jar files found in the specified directory!
set MSG_WARN_CHECK=Please make sure you selected the main game/server directory.
set MSG_CP_READY=[INFO] Classpath ready.
set MSG_COMPILING=[INFO] Compiling files...
set MSG_COMP_FAIL=[ERROR] Compilation failed!
set MSG_SUCCESS=[OK] All files compiled successfully.
set MSG_DONE_TITLE=PROCESS COMPLETED
set MSG_DONE_FILES=Files are in: 
goto START

:TR
set MSG_TITLE=Anti-Zombie Remover - Derleme Araci (Turkce)
set MSG_JAVA_ERR=[HATA] javac bulunamadi!
set MSG_JAVA_HINT=Java JDK 17 veya uzeri kurulu olmali. ve PATH'e eklenmelidir.
set MSG_JAVA_FOUND=[BILGI] Java JDK bulundu.
set MSG_SERVER_NOTE=Not: Yerel test icin oyun klasorunu kullanin (orn. C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid)
set MSG_ASK_SERVER=PZ Dedicated Server klasor yolunu girin: 
set MSG_ERR_FOLDER=[HATA] Klasor bulunamadi: 
set MSG_INFO_SERVER=[BILGI] Sunucu klasoru: 
set MSG_PREP_CP=[BILGI] Classpath Hazirlaniyor...
set MSG_ASK_OUTPUT=Cikti klasoru neresi olsun (varsayilan 'compiled' icin bos birakin):
set MSG_WARN_NOJAR=[UYARI] Belirtilen klasorde hic .jar dosyasi bulunamadi!
set MSG_WARN_CHECK=Lutfen ana oyun/sunucu klasorunu sectiginizden emin olun.
set MSG_CP_READY=[BILGI] Classpath hazir.
set MSG_COMPILING=[BILGI] Dosyalar derleniyor...
set MSG_COMP_FAIL=[HATA] Derleme basarisiz!
set MSG_SUCCESS=[TAMAM] Tum dosyalar basariyla derlendi.
set MSG_DONE_TITLE=ISLEM TAMAMLANDI
set MSG_DONE_FILES=Dosyalar surada: 
goto START

:START
cls
echo ============================================
echo   %MSG_TITLE%
echo   Project Zomboid 42.13.1
echo ============================================
echo.

REM Check Java
where javac >nul 2>&1
if errorlevel 1 (
    echo %MSG_JAVA_ERR%
    echo %MSG_JAVA_HINT%
    echo Download: https://adoptium.net/
    pause
    exit /b 1
)

echo %MSG_JAVA_FOUND%
javac -version
echo.

REM Ask for server folder
echo %MSG_SERVER_NOTE%
echo.
set /p SERVER_PATH="%MSG_ASK_SERVER%"

REM Remove quotes
set SERVER_PATH=%SERVER_PATH:"=%

if not exist "%SERVER_PATH%" (
    echo %MSG_ERR_FOLDER%%SERVER_PATH%
    pause
    exit /b 1
)

echo %MSG_INFO_SERVER%%SERVER_PATH%
echo.

REM Ask for output folder
set /p OUTPUT_PATH="%MSG_ASK_OUTPUT%"
if "%OUTPUT_PATH%"=="" set OUTPUT_PATH=compiled

if not exist "%OUTPUT_PATH%" mkdir "%OUTPUT_PATH%"
echo %MSG_INFO_OUTPUT%%OUTPUT_PATH%
echo.

REM Create Classpath
echo %MSG_PREP_CP%
setlocal EnableDelayedExpansion
set "CP="
for /f "delims=" %%f in ('dir /s /b "%SERVER_PATH%\*.jar" 2^>nul') do (
    set "CP=!CP!%%f;"
)
endlocal & set "CP=%CP%"

echo [DEBUG] Classpath: %CP%
echo.
if "%CP%"=="" (
    echo %MSG_WARN_NOJAR%
    echo %MSG_WARN_CHECK%
    pause
    exit /b 1
)

echo %MSG_CP_READY%
echo.

REM Compile
echo %MSG_COMPILING%
javac --release 17 -cp "%CP%" -d "%OUTPUT_PATH%" src\zombie\popman\ZombieCountOptimiser.java src\zombie\network\packets\character\ZombieDeletePacket.java
if errorlevel 1 (
    echo %MSG_COMP_FAIL%
    pause
    exit /b 1
)
echo %MSG_SUCCESS%

echo.
echo ============================================
echo   %MSG_DONE_TITLE%
echo   %MSG_DONE_FILES%%OUTPUT_PATH%
echo ============================================
pause
