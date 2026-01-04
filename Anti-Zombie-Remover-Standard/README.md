# Anti-Zombie Remover v1.0.0

> **SENTRA Anti-Cheat Research Project**  
> 🔗 Discord: `ed.husserl`  
> 📄 License: MIT

> ⚠️ **Disclaimer:** This is an unofficial modification tool. Not affiliated with The Indie Stone.

> [🇹🇷 Türkçe Kurulum ve Açıklama için Tıklayın.](KURULUM.md)
 
 ## 📋 Overview
 
 This patch disables the **automatic zombie deletion** mechanism on Project Zomboid 42.13.1 (Solo, Co-op, or Dedicated).
 
 ### The Problem
 By default, PZ automatically deletes excess zombies when the count exceeds **500** for performance optimization.
 
 ### The Solution
 This patch rejects zombie deletion requests on the server side. **No changes are required for players.**
 
 ---
 
 ## ⚠️ Important Warnings
 
 | Warning | Description |
 |---------|-------------|
| **Install Target** | Solo, Co-op Host, or Server. (Clients/Players do NOT need to install on Dedicated Servers). |
 | **Performance** | Too many zombies may cause performance issues |
 | **PZ Version** | Tested for Project Zomboid 42.13.1 |
 | **Update** | You may need to re-apply the patch when the game updates |
 
 ---
 
 ## 📁 File Structure
 
 ```
 Anti-Zombie-Remover/
 ├── src/
 │   └── zombie/
 │       ├── popman/
 │       │   └── ZombieCountOptimiser.java    # Zombie counting - disabled
 │       └── network/
 │           └── packets/
 │               └── character/
 │                   └── ZombieDeletePacket.java  # Deletion request - reject
 ├── KURULUM.md                                   # Turkish installation guide
 └── README.md                                    # This file
 ```
 
 ---
 
 ## 🛠️ Installation Steps (Dedicated Server)
 
 ### Step 1: Requirements
 
 1. **Java JDK 17** (or newer)
    - Download: https://adoptium.net/
    - `javac --version` command must work after installation
 
 2. **7-Zip** or similar archive tool
    - To edit JAR files
 
 ### Step 2: Locate Server JAR File
 
 Go to your Project Zomboid Dedicated Server or Game installation folder:
 
 ```
Windows (Dedicated): C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid Dedicated Server\
Windows (Game):      C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid\

Linux (Dedicated):   ~/.steam/steam/steamapps/common/Project Zomboid Dedicated Server/
Linux (Game):        ~/.steam/steam/steamapps/common/Project Zomboid/
 ```
 
 Look for the main JAR file, usually named `projectzomboid.jar`.
 
 ### Step 3: Backup Original Class Files
 
 **IMPORTANT:** Backup original files before making any changes!
 
 ```bash
 # Windows PowerShell
 Copy-Item "projectzomboid.jar" "projectzomboid.jar.backup"
 
 # Linux
 cp projectzomboid.jar projectzomboid.jar.backup
 ```
 
 ### Step 4: Compile Java Files
 
 #### 4.1 Easy Method (Using Scripts)
 
 Pre-made scripts are available in the `Anti-Zombie-Remover` folder:
 
 **Windows:**
 1. Open the `Anti-Zombie-Remover` folder.
 2. Double-click or run `compile.bat`.
 3. Select your language (English/Turkish).
 4. It will ask for your Project Zomboid Dedicated Server folder path; enter it and press Enter.
    > **Note:** For local testing, use your game folder (e.g. `C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid`).
 
 **Linux:**
 ```bash
 cd Anti-Zombie-Remover
 chmod +x compile.sh
 ./compile.sh
 ```
 
 #### 4.2 Manual Method (Command Line)
 
 If you prefer not to use scripts, you can compile manually:
 
 **Prepare Classpath:**
  
  You need to use all JAR files in the server or game folder as classpath:
  
  ```bash
  # Windows PowerShell (run in server or game folder)
  $CP = (Get-ChildItem *.jar | ForEach-Object { $_.FullName }) -join ";"
  
  # Linux
  CP=$(find . -name "*.jar" | tr '\n' ':')
  ```
  
  **Compile:**
  
  ```bash
  # Go to Anti-Zombie-Remover/src folder
  cd Anti-Zombie-Remover/src
  
  # Windows
  javac -cp "$CP" -d ../compiled zombie/popman/ZombieCountOptimiser.java
  javac -cp "$CP" -d ../compiled zombie/network/packets/character/ZombieDeletePacket.java
  
  # Linux
  javac -cp "$CP" -d ../compiled zombie/popman/ZombieCountOptimiser.java
  javac -cp "$CP" -d ../compiled zombie/network/packets/character/ZombieDeletePacket.java
  ```
  
  These commands will create `.class` files in `Anti-Zombie-Remover/compiled/` folder:
  - `compiled/zombie/popman/ZombieCountOptimiser.class`
  - `compiled/zombie/network/packets/character/ZombieDeletePacket.class`
  
  ### Step 5: Inject into JAR File (RECOMMENDED)
  
  **⚠️ IMPORTANT:** Extracting and re-packing the JAR can sometimes cause issues. We highly recommend editing the JAR _directly_ using **7-Zip** or **NanaZip**.
  
  #### 5.1 Drag & Drop (Windows/GUI)
  1. Open `projectzomboid.jar` with **7-Zip** (Right click -> 7-Zip -> Open Archive).
  2. Navigate to `zombie/popman/` inside the archive.
  3. Drag and drop your compiled `ZombieCountOptimiser.class` into it.
  4. Navigate to `zombie/network/packets/character/` inside the archive.
  5. Drag and drop your compiled `ZombieDeletePacket.class` into it.
  6. Close 7-Zip. Changes are saved automatically.
  
  #### 5.2 Command Line (Linux/Advanced)
  If you can't use a GUI like 7-Zip, you can update the jar using the `jar` command:
  
  ```bash
  # Update classes inside the jar
  jar uf projectzomboid.jar -C ../compiled .
  ```
  
  ---
  
  ## 🔧 Alternative: Extract and Re-pack (Risky)
  
  If you cannot use the direct edit method:
  
  ```bash
  # 1. Extract
  mkdir temp_jar
  cd temp_jar
  jar -xf ../projectzomboid.jar
  
  # 2. Copy files
  cp ../compiled/zombie/popman/ZombieCountOptimiser.class zombie/popman/
  cp ../compiled/zombie/network/packets/character/ZombieDeletePacket.class zombie/network/packets/character/
  
  # 3. Re-pack
  jar -cf ../projectzomboid_patched.jar .
  cd ..
  mv projectzomboid.jar projectzomboid.jar.original
  mv projectzomboid_patched.jar projectzomboid.jar
  ```
 
 ---
 
 ## ✅ Testing (Dedicated Server)
 
 1. Start the server
 2. Connect with a player
 3. Spawn a large number of zombies via cheat menu or admin commands
 4. Verify zombies are **NOT deleted** when count exceeds 500
 
 ---
 
 ## 🎮 Testing in Local Game (Singleplayer/Host)
 
 If you want to test this patch on your own computer, the process is almost identical to Dedicated Server, only the **file paths** are different.
 
 ### 1. Locate Game Folder
 Steam Library -> Project Zomboid -> Right Click -> Properties -> Installed Files -> Browse.
 Typically: `C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid`
 
 ### 2. Locate JAR File
 Find `projectzomboid.jar` (or similar, e.g., `projectzomboid-core.jar`) in the main game folder.
 
 ### 3. Backup
 Make a copy of `projectzomboid.jar` and rename it to `projectzomboid.jar.backup`.
 
 ### 4. Apply Patch
 1. Open `projectzomboid.jar` with **7-Zip** or **WinRAR**.
 2. Navigate to `zombie/popman/` inside the archive and drop your `ZombieCountOptimiser.class` file there.
 3. Navigate to `zombie/network/packets/character/` inside the archive and drop your `ZombieDeletePacket.class` file there.
 4. Close the archive.
 
 ### 5. Start Game
 Launch the game normally and start in **Solo** or **Host** mode. Test if zombies are deleted.
 **Note:** Steam may repair files sometimes, you might need to re-apply the patch if it gets deleted.
 
 ---
 
 ## 🔄 Uninstalling Patch
 
 To revert to original state:
 
 ```bash
 # Restore backup file
 mv zombie.jar.backup zombie.jar
 ```
 
 ---
 
 ## ❓ Troubleshooting
 
 ### Error: "javac not found"
 - Java JDK is not installed or not in PATH
 - Solution: Install JDK and set `JAVA_HOME` environment variable
 
 ### Error: "class not found" during compilation
 - Classpath is set incorrectly
 - Solution: Make sure all JAR files are in classpath
 
 ### Server not starting
 - Class files compiled incorrectly or placed in wrong location
 - Solution: Restore from backup and repeat steps
 
 ### Zombies still being deleted
 - Wrong JAR file edited
 - Solution: Check which JAR file the server is using
 
 ---
 
 ## 📝 Technical Details
 
 ### Modified Functions
 
 1. **`ZombieCountOptimiser.startCount()`**
    - Original: Calculates number of zombies to delete
    - Modified: Always returns 0
 
 2. **`ZombieCountOptimiser.incrementZombie()`**
    - Original: Adds zombie to deletion list
    - Modified: Does nothing
 
 3. **`ZombieDeletePacket.parse()`**
    - Original: Processes deletion request from client
    - Modified: Reads request but ignores (rejects) it
 
 ### Why Server Only?

The zombie deletion mechanism works on the server side.

- **Singleplayer:** You are both the server and the client. You **must install** it.
- **Co-op (Host):** The person hosting the game is the server. Only the **Host** needs to install it. Friends joining do not need to install anything.
- **Dedicated Server:** Install only on the **Server**. Players joining the server do **NOT** need to install anything.

Zombie deletion flow:
 ```
 CLIENT → "Delete this zombie" request → SERVER
 SERVER → (With Patch) Rejects request
 SERVER → Does NOT send "deleted" notification to other clients
 Result → Zombie remains for everyone
 ```
 
 ---

 ## 📌 Version Compatibility

| PZ Version | Compatibility | Notes |
|------------|---------------|-------|
| 41.x       | ❓ Unknown     | May need re-check          |
| 42.x       | ❓ Unknown     | May need re-check          |
| 42.13.1    | ✅ Compatible  | Tested                     |
| 42.13.x    | ⚠️ Likely      | Class structure may change |
| 42.14+     | ❓ Unknown     | May need re-check          |

---

## 📄 License

This project is licensed under the **MIT License**. See [LICENSE](LICENSE) file for details.

Project Zomboid is property of The Indie Stone.

---

**Developer:** SENTRA Anti-Cheat Research Project  
**Discord:** ed.husserl  
**Date:** January 2026  
**Version:** v1.0.0
```
