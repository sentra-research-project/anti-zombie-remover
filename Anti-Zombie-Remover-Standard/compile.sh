#!/bin/bash
# ============================================
#  Anti-Zombie Remover v1.0.0
#  SENTRA Anti-Cheat Research Project
#  Discord: ed.husserl
#  License: MIT
# ============================================

clear
echo "============================================"
echo "  SENTRA Anti-Cheat Research Project"
echo "  Anti-Zombie Remover v1.0.0"
echo "============================================"
echo ""
echo "Please select your language / Lutfen dil secin:"
echo ""
echo "[1] English"
echo "[2] Turkce"
echo ""
read -p "Choice / Secim (1-2): " LCHOICE

case $LCHOICE in
    2)
        MSG_TITLE="Anti-Zombie Remover - Derleme Araci (Turkce)"
        MSG_JAVA_ERR="[HATA] javac bulunamadi!"
        MSG_JAVA_HINT="Java JDK 17 (veya uzeri) kurulu olmali."
        MSG_JAVA_INSTALL="Ubuntu/Debian: sudo apt install openjdk-25-jdk"
        MSG_JAVA_FOUND="[BILGI] Java JDK bulundu."
        MSG_SERVER_NOTE="Not: Yerel test icin oyun klasorunu kullanin (orn. ~/.steam/steam/steamapps/common/Project Zomboid)"
        MSG_ASK_SERVER="PZ Dedicated Server klasor yolunu girin: "
        MSG_ERR_FOLDER="[HATA] Klasor bulunamadi: "
        MSG_INFO_SERVER="[BILGI] Sunucu klasoru: "
        MSG_ASK_OUTPUT="Cikti klasoru neresi olsun (varsayilan 'compiled' icin bos birakin): "
        MSG_INFO_OUTPUT="[BILGI] Dosyalar suraya kaydedilecek: "
        MSG_PREP_CP="[BILGI] Classpath Hazirlaniyor..."
        MSG_WARN_NOJAR="[UYARI] Belirtilen klasorde hic .jar dosyasi bulunamadi!"
        MSG_WARN_CHECK="Lutfen ana oyun/sunucu klasorunu sectiginizden emin olun."
        MSG_CP_READY="[BILGI] Classpath hazir."
        MSG_COMPILING="[BILGI] Dosyalar derleniyor..."
        MSG_COMP_FAIL="[HATA] Derleme basarisiz!"
        MSG_SUCCESS="[TAMAM] Tum dosyalar basariyla derlendi."
        MSG_DONE_TITLE="ISLEM TAMAMLANDI"
        MSG_DONE_FILES="Dosyalar surada: "
        ;;
    *)
        MSG_TITLE="Anti-Zombie Remover - Compile Script (English)"
        MSG_JAVA_ERR="[ERROR] javac not found!"
        MSG_JAVA_HINT="Java JDK 17 (or newer) must be installed."
        MSG_JAVA_INSTALL="Ubuntu/Debian: sudo apt install openjdk-25-jdk (or manual install)"
        MSG_JAVA_FOUND="[INFO] Java JDK found."
        MSG_SERVER_NOTE="Note: For local testing, use your game folder (e.g. ~/.steam/steam/steamapps/common/Project Zomboid)"
        MSG_ASK_SERVER="Enter PZ Dedicated Server folder path: "
        MSG_ERR_FOLDER="[ERROR] Folder not found: "
        MSG_INFO_SERVER="[INFO] Server folder: "
        MSG_ASK_OUTPUT="Where to create output files (leave empty for 'compiled'): "
        MSG_INFO_OUTPUT="[INFO] Files will be saved to: "
        MSG_PREP_CP="[INFO] Preparing Classpath..."
        MSG_WARN_NOJAR="[WARNING] No .jar files found in the specified directory!"
        MSG_WARN_CHECK="Please make sure you selected the main game/server directory."
        MSG_CP_READY="[INFO] Classpath ready."
        MSG_COMPILING="[INFO] Compiling files..."
        MSG_COMP_FAIL="[ERROR] Compilation failed!"
        MSG_SUCCESS="[OK] All files compiled successfully."
        MSG_DONE_TITLE="PROCESS COMPLETED"
        MSG_DONE_FILES="Files are in: "
        ;;
esac

clear
echo "============================================"
echo "  $MSG_TITLE"
echo "  Project Zomboid 42.13.1"
echo "============================================"
echo ""

# Java Check
if ! command -v javac &> /dev/null; then
    echo "$MSG_JAVA_ERR"
    echo "$MSG_JAVA_HINT"
    echo "$MSG_JAVA_INSTALL"
    exit 1
fi

echo "$MSG_JAVA_FOUND"
javac -version
echo ""

# Ask for server folder
echo "$MSG_SERVER_NOTE"
echo ""
read -p "$MSG_ASK_SERVER" SERVER_PATH

if [ ! -d "$SERVER_PATH" ]; then
    echo "$MSG_ERR_FOLDER$SERVER_PATH"
    exit 1
fi

echo "$MSG_INFO_SERVER$SERVER_PATH"
echo ""

# Ask for output folder
read -p "$MSG_ASK_OUTPUT" OUTPUT_PATH
if [ -z "$OUTPUT_PATH" ]; then
    OUTPUT_PATH="compiled"
fi

mkdir -p "$OUTPUT_PATH"
echo "$MSG_INFO_OUTPUT$OUTPUT_PATH"
echo ""

# Create Classpath
echo "$MSG_PREP_CP"
CP=$(find "$SERVER_PATH" -name "*.jar" | tr '\n' ':')

if [ -z "$CP" ]; then
    echo "$MSG_WARN_NOJAR"
    echo "$MSG_WARN_CHECK"
    exit 1
fi

echo "$MSG_CP_READY"
echo ""

# Compile
echo "$MSG_COMPILING"
javac --release 17 -cp "$CP" -d "$OUTPUT_PATH" src/zombie/popman/ZombieCountOptimiser.java src/zombie/network/packets/character/ZombieDeletePacket.java
if [ $? -ne 0 ]; then
    echo "$MSG_COMP_FAIL"
    exit 1
fi
echo "$MSG_SUCCESS"

echo ""
echo "============================================"
echo "  $MSG_DONE_TITLE"
echo "  $MSG_DONE_FILES$OUTPUT_PATH"
echo "============================================"
