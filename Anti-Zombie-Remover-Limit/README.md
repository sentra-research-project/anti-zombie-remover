# Anti-Zombie Remover (Limit Edition) v1.0.0

> **SENTRA Anti-Cheat Research Project**  
> 🔗 Discord: `ed.husserl`  
> 📄 License: MIT

> ⚠️ **Disclaimer:** This is an unofficial modification tool. Not affiliated with The Indie Stone.

> [🇹🇷 Türkçe Kurulum ve Açıklama için Tıklayın.](KURULUM.md)

## 📋 Overview

This enhanced patch allows you to **set a custom limit** for the zombie culling mechanism on Project Zomboid 42.13.1 dedicated servers, instead of completely disabling it or using the default limit.

### The Problem
By default, PZ automatically deletes excess zombies when the count exceeds **500** for performance optimization.

### The Solution
This tool lets you decide the limit!
- Set to **0** (or empty): Sets limit to **999,999** (Effectively Unlimited).
  > **Tip:** If you want **completely unlimited** zombies, we recommend using the standard [Anti-Zombie-Remover](../Anti-Zombie-Remover) tool for the absolute best performance (no calculation overhead).
- Set to **500**: Standard vanilla behavior.
- Set to **2000**: Recommended maximum for high performance.
- Set to any number you want based on your server performance.

---

## ⚠️ Important Warnings

| Warning | Description |
|---------|-------------|
| **Server Only** | This patch applies ONLY to the server |
| **Performance** | Setting a very high limit (e.g. 5000+) may cause lag |
| **PZ Version** | Tested for Project Zomboid 42.13.1 |

---

## 🛠️ Installation Steps

### Step 1: Requirements

1. **Java JDK 17** (or newer)
   - Download: https://adoptium.net/
   - `javac --version` command must work after installation

2. **7-Zip** or similar archive tool

### Step 2: Locate Server JAR File

Go to your Project Zomboid Dedicated Server installation folder:
```
Windows: C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid Dedicated Server\
Linux: ~/.steam/steam/steamapps/common/Project Zomboid Dedicated Server/
```
Look for `projectzomboid.jar` (or `zombie.jar`).

### Step 3: Backup Original Class Files
**IMPORTANT:** Backup original files before making any changes!

### Step 4: Compile Java Files (Easy Method)

This tool includes scripts that will ask for your desired zombie limit and compile the code for you.

**Windows:**
1. Open the `Anti-Zombie-Remover-Limit` folder.
2. Double-click or run `compile.bat`.
3. Select your language (English/Turkish).
4. **Enter Zombie Limit:** 
   - Type `0` or keep empty for **Unlimited**.
   - Type `500` for **Vanilla** (Default).
   - Type `2000` for **Recommended Max**.
   - Or enter any custom number.
5. It will ask for your Project Zomboid Dedicated Server folder path; enter it and press Enter.
   > **Note:** For local testing, use your game folder (e.g. `C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid`).

**Linux:**
```bash
cd Anti-Zombie-Remover-Limit
chmod +x compile.sh
./compile.sh
```
Follow the on-screen prompts to set the limit and server path.

### Step 5: Inject into JAR File

1. Extract `projectzomboid.jar` (using 7-Zip or `jar -xf`).
2. Copy the compiled `.class` files from the `compiled/` folder to the extracted folders:
   - `compiled/zombie/popman/ZombieCountOptimiser.class` -> `zombie/popman/`
   - `compiled/zombie/network/packets/character/ZombieDeletePacket.class` -> `zombie/network/packets/character/`
3. Re-package the JAR file (`jar -cf projectzomboid.jar .`).
   
*(Detailed instructions for Step 5 are the same as the standard version).*

---

## 🔄 Uninstalling Patch

Restore your backup `projectzomboid.jar` file.

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
