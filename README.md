# Anti-Zombie Remover v1.0.0

> **SENTRA Research Project**  
> 🔗 Discord: `ed.husserl`  
> 📄 License: MIT

> ⚠️ **Disclaimer:** This is an unofficial modification tool. Not affiliated with The Indie Stone.

> [🇹🇷 Türkçe için tıklayın](OKUBENI.md)

---

## 📋 What is this?

This tool disables or modifies the **automatic zombie culling** mechanism in Project Zomboid 42.13.1.

### The Problem
By default, Project Zomboid automatically deletes zombies when the count exceeds **500** to optimize performance.

### The Solution
We provide **two versions** to solve this:

---

## 🔧 Which Version Should I Use?

| Version | Description | Best For |
|---------|-------------|----------|
| **[Standard](Anti-Zombie-Remover/)** | Completely disables zombie culling | Maximum zombie chaos, hordes |
| **[Limit](Anti-Zombie-Remover-Limit/)** | Set your own custom limit | Balance between performance and zombies |

### Quick Comparison

| Feature | Standard | Limit |
|---------|----------|-------|
| Zombies deleted? | ❌ Never | ✅ After your limit |
| Custom limit? | No (Unlimited) | Yes (You choose) |
| Performance impact | Higher (more zombies) | Controllable |
| Recommended for | Horde servers, testing | Production servers |

---

## 📁 Folder Structure

```
Anti-Zombie-Remover/
├── Anti-Zombie-Remover/           # Standard version (Unlimited)
│   ├── src/
│   ├── compile.bat / compile.sh
│   ├── README.md
│   └── KURULUM.md                 
├── Anti-Zombie-Remover-Limit/     # Limit version (Customizable)
│   ├── src/
│   ├── compile.bat / compile.sh
│   ├── README.md
│   └── KURULUM.md
├── LICENSE
├── README.md                      # This file (English)
└── OKUBENI.md                     # Turkish version
```

---

## 🚀 Quick Start

1. **Choose your version** (Standard or Limit)
2. **Open the folder** and run `compile.bat` (Windows) or `compile.sh` (Linux)
3. **Follow the prompts** to compile
4. **Copy the compiled `.class` files** into your `projectzomboid.jar`
5. **Start your server/game** and enjoy!

For detailed instructions, see the README/KURULUM files in each version's folder.

---

## ⚠️ Important Warnings

- **Backup your files** before applying any patch
- **Who needs to install?**
  - **Singleplayer:** You install it.
  - **Co-op (Host):** Only the Host installs it.
  - **Dedicated Server:** Only the Server installs it. (Clients/Players do **NOT** need to install anything for multiplayer).
- **Game updates** may require re-applying the patch
- **Performance** - Too many zombies can cause lag

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

**Developer:** SENTRA Research Project  
**Discord:** ed.husserl  
**Date:** January 2026  
**Version:** v1.0.0
