# Anti-Zombie Remover (Limit Edition) v1.0.0

> **SENTRA Anti-Cheat Research Project**  
> 🔗 Discord: `ed.husserl`  
> 📄 Lisans: MIT

> ⚠️ **Uyarı:** Bu resmi olmayan bir mod aracıdır. The Indie Stone ile bağlantısı yoktur.

## 📋 Genel Bakış

Bu geliştirilmiş patch, Project Zomboid 42.13.1 (Solo, Co-op veya Dedicated) sunucularındaki zombie silme mekanizması için **özel bir limit belirlemenize** olanak tanır.

### Sorun
Varsayılan olarak PZ, performans optimizasyonu için **500 zombie** sınırına ulaşıldığında fazla zombileri otomatik olarak siler.

### Çözüm
Bu araç ile limiti siz belirlersiniz!
- **0** (veya boş) yaparsanız: Limiti **999.999** yapar (Pratikte Sınırsız).
  > **İpucu:** Eğer **tamamen sınırsız** zombi istiyorsanız, en iyi performans için standart [Anti-Zombie-Remover](../Anti-Zombie-Remover-Standard) aracını kullanmanız önerilir (hesaplama yükü olmaz).
- **500** yaparsanız: Standart oyun ayarı (Vanilla).
- **2000** yaparsanız: Yüksek performans için önerilen maksimum değer.
- Sunucu performansınıza göre istediğiniz sayıyı verebilirsiniz.

---

## ⚠️ Önemli Uyarılar

| Uyarı | Açıklama |
|-------|----------|
| **Kurulum Yeri** | Solo, Co-op Host veya Sunucu. (Dedicated Sunucularda oyuncuların kurmasına gerek yoktur). |
| **Performans** | Çok yüksek limitler (örn. 5000+) lag yapabilir |
| **PZ Sürümü** | Project Zomboid 42.13.1 için test edilmiştir |

---

## 🛠️ Kurulum Adımları (Dedicated Server)

### Adım 1: Gerekli Araçlar

1. **Java JDK 17** (veya üzeri)
   - İndirme: https://adoptium.net/
   - Kurulumdan sonra `javac --version` komutu çalışmalı

2. **7-Zip** veya benzeri arşiv aracı

### Adım 2: Sunucu JAR Dosyasını Bulma

Project Zomboid Dedicated Server veya Oyun kurulum klasörünüze gidin:
```
Windows (Dedicated): C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid Dedicated Server\
Windows (Oyun):      C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid\

Linux (Dedicated):   ~/.steam/steam/steamapps/common/Project Zomboid Dedicated Server/
Linux (Oyun):        ~/.steam/steam/steamapps/common/Project Zomboid/
```
Genellikle `projectzomboid.jar` dosyasını bulun.

### Adım 3: Orijinal Class Dosyalarını Yedekleme
**ÖNEMLİ:** Değişiklik yapmadan önce orijinal dosyaları yedekleyin!

### Adım 4: Java Dosyalarını Compile Etme (Kolay Yöntem)

Bu araç, sizden bir limit isteyecek ve kodu ona göre derleyecektir.

**Windows:**
1.  `Anti-Zombie-Remover-Limit` klasörüne girin.
2.  `compile.bat` dosyasına çift tıklayın veya çalıştırın.
3.  Dil seçimi yapın (İngilizce/Türkçe).
4.  **Zombie Limiti Girin:**
    -   **Sınırsız** için `0` yazın veya boş bırakın.
    -   **Vanilla** (Varsayılan) için `500` yazın.
    -   **Önerilen Maksimum** için `2000` yazın.
    -   Veya istediğiniz bir sayı girin.
5.  Sizden Project Zomboid Dedicated Server klasör yolunu isteyecektir, girin ve Enter'a basın.
    > **Not:** Yerel test için oyun klasörünü kullanın (örn. `C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid`).

**Linux:**
```bash
cd Anti-Zombie-Remover-Limit
chmod +x compile.sh
./compile.sh
```
Ekrandaki talimatları izleyerek limiti ve sunucu yolunu girin.

### Adım 5: JAR Dosyasına Ekleme (ÖNERİLEN)

**⚠️ ÖNEMLİ:** JAR dosyasını çıkartıp tekrar paketlemek bazen sorun çıkarabilir. Bu yüzden **7-Zip** veya **NanaZip** gibi bir programla _doğrudan_ düzenlemenizi şiddetle öneririz.

1.  `projectzomboid.jar` dosyasını **7-Zip**/NanaZip ile açın.
2.  Derlenen `.class` dosyalarını (`compiled/` klasöründekiler) arşivin içine ilgili yerlere sürükleyin:
    -   `compiled/zombie/popman/ZombieCountOptimiser.class` -> `zombie/popman/`
    -   `compiled/zombie/network/packets/character/ZombieDeletePacket.class` -> `zombie/network/packets/character/`
3.  Arşivi kapatın. Değişiklikler kaydedilecektir.

*(Eğer GUI kullanamıyorsanız `jar uf projectzomboid.jar -C ../compiled .` komutunu kullanabilirsiniz).*

---

### Neden Sadece Sunucu?

Zombie silme mekanizması sunucu taraflı çalışır.

- **Tek Oyunculu (Solo):** Kendi bilgisayarınızda oynadığınız için hem sunucu hem istemci sizsiniz. Yamayı **kurmalısınız**.
- **Co-op (Host):** Oyunu kuran kişi (Host) sunucudur. Sadece **Host kurmalıdır**. Diğer arkadaşlarınızın kurmasına gerek yoktur.
- **Dedicated Sunucu:** Kiralık veya harici sunucularda yamayı **sadece sunucuya** kurun. Sunucuya bağlanan oyuncuların hiçbir şey yüklemesine gerek yoktur.

---

## 🔄 Patch'i Kaldırma

Yedeklediğiniz orijinal `projectzomboid.jar` dosyasını geri yükleyin.

## 📄 Lisans

Bu proje **MIT Lisansı** altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

Project Zomboid, The Indie Stone'ın mülkiyetindedir.

---

**Geliştirici:** SENTRA Anti-Cheat Research Project  
**Discord:** ed.husserl  
**Tarih:** Ocak 2026  
**Sürüm:** v1.0.0
