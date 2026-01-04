# Anti-Zombie Remover v1.0.0

> **SENTRA Anti-Cheat Research Project**  
> 🔗 Discord: `ed.husserl`  
> 📄 Lisans: MIT

> ⚠️ **Uyarı:** Bu resmi olmayan bir mod aracıdır. The Indie Stone ile bağlantısı yoktur.

## 📋 Genel Bakış

Bu patch, Project Zomboid 42.13.1 için (Solo, Co-op veya Dedicated) **otomatik zombie silme** mekanizmasını devre dışı bırakır.

### Sorun
Varsayılan olarak PZ, performans optimizasyonu için **500 zombie** sınırına ulaşıldığında fazla zombileri otomatik olarak siler.

### Çözüm
Bu patch ile zombie silme istekleri sunucu tarafında reddedilir. **Oyuncuların hiçbir değişiklik yapmasına gerek yoktur.**

---

## ⚠️ Önemli Uyarılar

| Uyarı | Açıklama |
|-------|----------|
| **Kurulum Yeri** | Solo, Co-op Host veya Sunucu. (Dedicated Sunucularda oyuncuların kurmasına gerek yoktur). |
| **Performans** | Çok fazla zombie performans sorunlarına neden olabilir |
| **PZ Sürümü** | Project Zomboid 42.13.1 için test edilmiştir |
| **Güncelleme** | Oyun güncellendiğinde patch'i yeniden uygulamanız gerekebilir |

---

## 📁 Dosya Yapısı

```
Anti-Zombie-Remover/
├── src/
│   └── zombie/
│       ├── popman/
│       │   └── ZombieCountOptimiser.java    # Zombie sayma - devre dışı
│       └── network/
│           └── packets/
│               └── character/
│                   └── ZombieDeletePacket.java  # Silme isteği - reddet
├── KURULUM.md                                   # Bu dosya
└── README.md                                    # İngilizce açıklama
```

---

## 🛠️ Kurulum Adımları (Dedicated Server)

### Adım 1: Gerekli Araçlar

1. **Java JDK 17** (veya üzeri)
   - İndirme: https://adoptium.net/
   - Kurulumdan sonra `javac --version` komutu çalışmalı

2. **7-Zip** veya benzeri arşiv aracı
   - JAR dosyalarını düzenlemek için

### Adım 2: Sunucu JAR Dosyasını Bulma

Project Zomboid Dedicated Server veya Oyun kurulum klasörünüze gidin:

```
Windows (Dedicated): C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid Dedicated Server\
Windows (Oyun):      C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid\

Linux (Dedicated):   ~/.steam/steam/steamapps/common/Project Zomboid Dedicated Server/
Linux (Oyun):        ~/.steam/steam/steamapps/common/Project Zomboid/
```

İçinde genellikle `projectzomboid.jar` bulunur.

### Adım 3: Orijinal Class Dosyalarını Yedekleme

**ÖNEMLİ:** Değişiklik yapmadan önce orijinal dosyaları yedekleyin!

```bash
# Windows PowerShell
Copy-Item "projectzomboid.jar" "projectzomboid.jar.backup"

# Linux
cp projectzomboid.jar projectzomboid.jar.backup
```

### Adım 4: Java Dosyalarını Compile Etme

#### 4.1 Kolay Yöntem (Script ile)
Anti-Zombie-Remover klasöründe hazır scriptler bulunmaktadır:

**Windows:**
1. `Anti-Zombie-Remover` klasörüne girin.
2. `compile.bat` dosyasına çift tıklayın veya çalıştırın.
3. Dil seçimi yapın (İngilizce/Türkçe).
4. Sizden Project Zomboid Dedicated Server klasör yolunu isteyecektir, girin ve Enter'a basın.
   > **Not:** Yerel test için oyun klasörünü kullanın (örn. `C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid`).

**Linux:**
```bash
cd Anti-Zombie-Remover
chmod +x compile.sh
./compile.sh
```

#### 4.2 Manuel Yöntem (Komut Satırı ile)
Eğer script kullanmak istemezseniz manuel olarak da derleyebilirsiniz:

**Classpath Hazırlığı:**
Sunucu veya oyun klasöründeki tüm JAR dosyalarını classpath olarak kullanmanız gerekiyor:

```bash
# Windows PowerShell (sunucu veya oyun klasöründe çalıştırın)
$CP = (Get-ChildItem *.jar | ForEach-Object { $_.FullName }) -join ";"

# Linux
CP=$(find . -name "*.jar" | tr '\n' ':')
```

**Compile Etme:**
```bash
# Anti-Zombie-Remover/src klasörüne gidin
cd Anti-Zombie-Remover/src

# Windows
javac -cp "$CP" -d ../compiled zombie/popman/ZombieCountOptimiser.java
javac -cp "$CP" -d ../compiled zombie/network/packets/character/ZombieDeletePacket.java

# Linux
javac -cp "$CP" -d ../compiled zombie/popman/ZombieCountOptimiser.java
javac -cp "$CP" -d ../compiled zombie/network/packets/character/ZombieDeletePacket.java
```

Bu komutlar `Anti-Zombie-Remover/compiled/` klasörüne `.class` dosyaları oluşturacaktır:
- `compiled/zombie/popman/ZombieCountOptimiser.class`
- `compiled/zombie/network/packets/character/ZombieDeletePacket.class`

### Adım 5: JAR Dosyasına Ekleme (ÖNERİLEN YÖNTEM)

**⚠️ ÖNEMLİ:** JAR dosyasını çıkartıp tekrar paketlemek bazen sorun çıkarabilir. Bu yüzden **7-Zip** veya **NanaZip** gibi bir programla _doğrudan_ düzenlemenizi şiddetle öneririz.

#### 5.1 Dosyaları Sürükle-Bırak (Windows/GUI)
1. `projectzomboid.jar` dosyasını **7-Zip** ile açın (Sağ tık -> 7-Zip -> Arşivi Aç).
2. Arşivin içinde `zombie/popman/` yoluna gidin.
3. Compile ettiğiniz `ZombieCountOptimiser.class` dosyasını buraya sürükleyip bırakın (veya kopyalayın).
4. Arşivin içinde `zombie/network/packets/character/` yoluna gidin.
5. Compile ettiğiniz `ZombieDeletePacket.class` dosyasını buraya sürükleyip bırakın (veya kopyalayın).
6. 7-Zip penceresini kapatın. Değişiklikler otomatik kaydedilecektir.

#### 5.2 Komut Satırı (Linux/Gelişmiş)
Eğer 7-Zip gibi bir GUI kullanamıyorsanız `jar` komutu ile güncelleme yapabilirsiniz:

```bash
# Class dosyalarını jar içine güncelle
jar uf projectzomboid.jar -C ../compiled .
```
*(Not: Bu komut `compiled` klasöründeki yapının `zombie/...` şeklinde jar içindekiyle eşleştiğini varsayar.)*

---

## 🔧 Alternatif: Çıkartıp Paketleme (Riskli)

Eğer yukarıdaki yöntemleri yapamazsanız manuel olarak çıkartıp tekrar paketleyebilirsiniz:

```bash
# 1. Klasör oluştur ve içine çıkart
mkdir temp_jar
cd temp_jar
jar -xf ../projectzomboid.jar

# 2. Dosyaları kopyala
cp ../compiled/zombie/popman/ZombieCountOptimiser.class zombie/popman/
cp ../compiled/zombie/network/packets/character/ZombieDeletePacket.class zombie/network/packets/character/

# 3. Tekrar paketle
jar -cf ../projectzomboid_patched.jar .
cd ..
mv projectzomboid.jar projectzomboid.jar.original
mv projectzomboid_patched.jar projectzomboid.jar
```

---

## ✅ Test Etme (Dedicated Sunucu)

1. Sunucuyu başlatın
2. Bir oyuncu ile bağlanın
3. Cheat menüsü veya admin komutları ile çok sayıda zombie spawn edin
4. 500'ü geçince zombilerin **silinmediğini** doğrulayın

---

## 🎮 Yerel Oyunda (Singleplayer/Host) Test Etme

Bu patch'i kendi bilgisayarınızda test etmek isterseniz süreç Dedicated Server ile neredeyse aynıdır, sadece **dosya yolları** farklıdır.

### 1. Oyun Klasörünü Bulun
Steam Kütüphanesi -> Project Zomboid -> Sağ Tık -> Özellikler -> Yüklü Dosyalar -> Gözat.
Genellikle: `C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid`

### 2. JAR Dosyasını Bulun
Oyunun ana klasöründe `projectzomboid.jar` (veya benzeri, örn: `projectzomboid-core.jar`) dosyasını bulun.

### 3. Yedek Alın
`projectzomboid.jar` dosyasının bir kopyasını alın ve adını `projectzomboid.jar.backup` yapın.

### 4. Patch'i Uygulayın
1. `projectzomboid.jar` dosyasını **7-Zip** veya **WinRAR** ile açın.
2. Arşivin içindeki `zombie/popman/` yoluna gidin ve `ZombieCountOptimiser.class` dosyasını sürükleyip bırakın.
3. Arşivin içindeki `zombie/network/packets/character/` yoluna gidin ve `ZombieDeletePacket.class` dosyasını sürükleyip bırakın.
4. Arşivi kapatın.

### 5. Oyunu Başlatın
Oyunu normal şekilde açın ve **Solo** (Tek Oyunculu) veya **COOP** (HOST) bölümünden oyununuzu başlatın. Zombilerin silinmediğini test edin.
**Not:** Steam bazen dosyaları onarabilir (verify integrity), eğer yama silinirse tekrar uygulamanız gerekebilir.

---

## 🔄 Patch'i Kaldırma

Orijinal duruma dönmek için:

```bash
# Yedeklenen dosyayı geri yükle
mv zombie.jar.backup zombie.jar
```

---

## ❓ Sorun Giderme

### Hata: "javac bulunamadı"
- Java JDK kurulu değil veya PATH'e eklenmemiş
- Çözüm: JDK kurun ve `JAVA_HOME` ortam değişkenini ayarlayın

### Hata: "class not found" compile sırasında
- Classpath yanlış ayarlanmış
- Çözüm: Tüm JAR dosyalarının classpath'de olduğundan emin olun

### Sunucu başlamıyor
- Class dosyaları yanlış derlendi veya yanlış konuma yerleştirildi
- Çözüm: Yedekten geri yükleyin ve adımları tekrarlayın

### Zombiler hala siliniyor
- Yanlış JAR dosyası düzenlendi
- Çözüm: Sunucunun hangi JAR'ı kullandığını kontrol edin

---

## 📝 Teknik Detaylar

### Değiştirilen Fonksiyonlar

1. **`ZombieCountOptimiser.startCount()`**
   - Orijinal: Silinecek zombie sayısını hesaplar
   - Değiştirilmiş: Her zaman 0 döndürür

2. **`ZombieCountOptimiser.incrementZombie()`**
   - Orijinal: Zombie'yi silme listesine ekler
   - Değiştirilmiş: Hiçbir şey yapmaz

3. **`ZombieDeletePacket.parse()`**
   - Orijinal: Client'tan gelen silme isteğini işler
   - Değiştirilmiş: İsteği okur ama işlemez (reddeder)

### Neden Sadece Sunucu?

Zombie silme mekanizması sunucu taraflı çalışır.

- **Tek Oyunculu (Solo):** Kendi bilgisayarınızda oynadığınız için hem sunucu hem istemci sizsiniz. Yamayı **kurmalısınız**.
- **Co-op (Host):** Oyunu kuran kişi (Host) sunucudur. Sadece **Host kurmalıdır**. Diğer arkadaşlarınızın kurmasına gerek yoktur.
- **Dedicated Sunucu:** Kiralık veya harici sunucularda yamayı **sadece sunucuya** kurun. Sunucuya bağlanan oyuncuların hiçbir şey yüklemesine gerek yoktur.

Zombi silme akışı:
```
CLIENT → "Bu zombiyi sil" isteği → SUNUCU
SUNUCU → (Patch ile) İsteği reddeder
SUNUCU → Diğer client'lara "silindi" bildirimi GÖNDERMEz
Sonuç → Zombie herkes için kalır
```

---

## 📌 Sürüm Uyumluluğu

| PZ Sürümü | Uyumluluk | Notlar |
|-----------|-----------|--------|
| 41.x      | ❓ Bilinmiyor | Yeniden kontrol gerekebilir |
| 42.x      | ❓ Bilinmiyor | Yeniden kontrol gerekebilir |
| 42.13.1   | ✅ Uyumlu     | Test edildi                 |
| 42.13.x   | ⚠️ Muhtemelen | Class yapısı değişebilir    |
| 42.14+    | ❓ Bilinmiyor | Yeniden kontrol gerekebilir |

---

## 📄 Lisans

Bu proje **MIT Lisansı** altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

Project Zomboid, The Indie Stone'ın mülkiyetindedir.

---

**Geliştirici:** SENTRA Anti-Cheat Research Project  
**Discord:** ed.husserl  
**Tarih:** Ocak 2026  
**Sürüm:** v1.0.0
```