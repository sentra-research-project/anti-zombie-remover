# Anti-Zombie Remover (Limit Edition) v1.0.0

> **SENTRA Anti-Cheat Research Project**  
> 🔗 Discord: `ed.husserl`  
> 📄 Lisans: MIT

> ⚠️ **Uyarı:** Bu resmi olmayan bir mod aracıdır. The Indie Stone ile bağlantısı yoktur.

## 📋 Genel Bakış

Bu geliştirilmiş patch, Project Zomboid 42.13.1 sunucularındaki zombie silme mekanizması için **özel bir limit belirlemenize** olanak tanır.

### Sorun
Varsayılan olarak PZ, performans optimizasyonu için **500 zombie** sınırına ulaşıldığında fazla zombileri otomatik olarak siler.

### Çözüm
Bu araç ile limiti siz belirlersiniz!
- **0** (veya boş) yaparsanız: Limiti **999.999** yapar (Pratikte Sınırsız).
  > **İpucu:** Eğer **tamamen sınırsız** zombi istiyorsanız, en iyi performans için standart [Anti-Zombie-Remover](../Anti-Zombie-Remover) aracını kullanmanız önerilir (hesaplama yükü olmaz).
- **500** yaparsanız: Standart oyun ayarı (Vanilla).
- **2000** yaparsanız: Yüksek performans için önerilen maksimum değer.
- Sunucu performansınıza göre istediğiniz sayıyı verebilirsiniz.

---

## ⚠️ Önemli Uyarılar

| Uyarı | Açıklama |
|-------|----------|
| **Sadece Sunucu** | Bu patch SADECE sunucuya uygulanır |
| **Performans** | Çok yüksek limitler (örn. 5000+) lag yapabilir |
| **PZ Sürümü** | Project Zomboid 42.13.1 için test edilmiştir |

---

## 🛠️ Kurulum Adımları

### Adım 1: Gerekli Araçlar

1. **Java JDK 17** (veya üzeri)
   - İndirme: https://adoptium.net/
   - Kurulumdan sonra `javac --version` komutu çalışmalı

2. **7-Zip** veya benzeri arşiv aracı

### Adım 2: Sunucu JAR Dosyasını Bulma

Project Zomboid Dedicated Server kurulum klasörünüze gidin:
```
Windows: C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid Dedicated Server\
Linux: ~/.steam/steam/steamapps/common/Project Zomboid Dedicated Server/
```
Genellikle `projectzomboid.jar` (veya `zombie.jar`) dosyasını bulun.

### Adım 3: Orijinal Class Dosyalarını Yedekleme
**ÖNEMLİ:** Değişiklik yapmadan önce orijinal dosyaları yedekleyin!

### Adım 4: Java Dosyalarını Compile Etme (Kolay Yöntem)

Bu araç, sizden bir limit isteyecek ve kodu ona göre derleyecektir.

**Windows:**
1. `Anti-Zombie-Remover-Limit` klasörüne girin.
2. `compile.bat` dosyasına çift tıklayın veya çalıştırın.
3. Dil seçimi yapın (İngilizce/Türkçe).
4. **Zombie Limiti Girin:**
   - **Sınırsız** için `0` yazın veya boş bırakın.
   - **Vanilla** (Varsayılan) için `500` yazın.
   - **Önerilen Maksimum** için `2000` yazın.
   - Veya istediğiniz bir sayı girin.
5. Sizden Project Zomboid Dedicated Server klasör yolunu isteyecektir, girin ve Enter'a basın.
   > **Not:** Yerel test için oyun klasörünü kullanın (örn. `C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid`).

**Linux:**
```bash
cd Anti-Zombie-Remover-Limit
chmod +x compile.sh
./compile.sh
```
Ekrandaki talimatları izleyerek limiti ve sunucu yolunu girin.

### Adım 5: JAR Dosyasına Ekleme

1. `projectzomboid.jar` dosyasını çıkartın (7-Zip veya komut ile).
2. Oluşturulan `.class` dosyalarını (`compiled/` klasöründekiler) çıkartılan klasörlere kopyalayın:
   - `compiled/zombie/popman/ZombieCountOptimiser.class` -> `zombie/popman/`
   - `compiled/zombie/network/packets/character/ZombieDeletePacket.class` -> `zombie/network/packets/character/`
3. JAR dosyasını tekrar paketleyin (`jar -cf projectzomboid.jar .`).

*(Adım 5 detayları standart sürümle aynıdır).*

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
