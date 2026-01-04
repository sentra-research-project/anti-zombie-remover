# Anti-Zombie Remover v1.0.0

> **SENTRA Anti-Cheat Research Project**  
> 🔗 Discord: `ed.husserl`  
> 📄 Lisans: MIT

> ⚠️ **Uyarı:** Bu resmi olmayan bir mod aracıdır. The Indie Stone ile bağlantısı yoktur.

## 📋 Genel Bakış

Bu patch, Project Zomboid 42.13.1 dedicated sunucularında **otomatik zombie silme** mekanizmasını devre dışı bırakır.

### Sorun
Varsayılan olarak PZ, performans optimizasyonu için **500 zombie** sınırına ulaşıldığında fazla zombileri otomatik olarak siler.

### Çözüm
Bu patch ile zombie silme istekleri sunucu tarafında reddedilir. **Oyuncuların hiçbir değişiklik yapmasına gerek yoktur.**

---

## ⚠️ Önemli Uyarılar

| Uyarı | Açıklama |
|-------|----------|
| **Sadece Sunucu** | Bu patch SADECE sunucuya uygulanır |
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

## 🛠️ Kurulum Adımları

### Adım 1: Gerekli Araçlar

1. **Java JDK 17** (veya üzeri)
   - İndirme: https://adoptium.net/
   - Kurulumdan sonra `javac --version` komutu çalışmalı

2. **7-Zip** veya benzeri arşiv aracı
   - JAR dosyalarını düzenlemek için

### Adım 2: Sunucu JAR Dosyasını Bulma

Project Zomboid Dedicated Server kurulum klasörünüze gidin:

```
Windows: C:\Program Files (x86)\Steam\steamapps\common\Project Zomboid Dedicated Server\
Linux: ~/.steam/steam/steamapps/common/Project Zomboid Dedicated Server/
```

64: İçinde genellikle `projectzomboid.jar` isimli dosya bulunur.
65: Eğer yoksa şunları kontrol edin:
66: - `projectzomboid-dedi.jar`
67: - `zombie.jar`
68: - `commons.jar` (veya `java/` klasörü içindeki jar dosyaları)

### Adım 3: Orijinal Class Dosyalarını Yedekleme

**ÖNEMLİ:** Değişiklik yapmadan önce orijinal dosyaları yedekleyin!

```bash
# Windows PowerShell
Copy-Item "zombie.jar" "zombie.jar.backup"

# Linux
cp zombie.jar zombie.jar.backup
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
Sunucu klasöründeki tüm JAR dosyalarını classpath olarak kullanmanız gerekiyor:

```bash
# Windows PowerShell (sunucu klasöründe çalıştırın)
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

### Adım 5: JAR Dosyasına Ekleme

#### 5.1 JAR'ı Çıkartma

```bash
# Geçici klasör oluştur
mkdir temp_jar
cd temp_jar

# JAR'ı çıkart (7-Zip veya jar komutu)
jar -xf ../zombie.jar
# veya
# unzip ../zombie.jar
```

#### 5.2 Class Dosyalarını Değiştirme

Compile edilmiş `.class` dosyalarını doğru konumlara kopyalayın:

```bash
# ZombieCountOptimiser.class
cp ../compiled/zombie/popman/ZombieCountOptimiser.class zombie/popman/

# ZombieDeletePacket.class
cp ../compiled/zombie/network/packets/character/ZombieDeletePacket.class zombie/network/packets/character/
```

#### 5.3 JAR'ı Yeniden Oluşturma

```bash
# Yeni JAR oluştur
jar -cf ../zombie_patched.jar .

# Eski JAR'ı değiştir
cd ..
mv zombie.jar zombie_original.jar
mv zombie_patched.jar zombie.jar
```

### Adım 6: Sunucuyu Başlatma

Sunucuyu normal şekilde başlatın. Artık zombie'ler otomatik olarak silinmeyecek!

---

## 🔧 Alternatif: Manuel JAR Düzenleme (7-Zip ile)

Eğer komut satırı kullanmak istemiyorsanız:

1. **7-Zip** ile `zombie.jar` dosyasını açın
2. `zombie/popman/` klasörüne gidin
3. `ZombieCountOptimiser.class` dosyasını compile edilmiş versiyonla değiştirin
4. `zombie/network/packets/character/` klasörüne gidin
5. `ZombieDeletePacket.class` dosyasını compile edilmiş versiyonla değiştirin
6. 7-Zip'i kapatın (değişiklikler otomatik kaydedilir)

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
Oyunu normal şekilde açın ve "Host" (Sunucu Kur) diyerek bir oyun başlatın. Zombilerin silinmediğini test edin.
**Not:** Steam bazen dosyaları onarabilir, patch silinirse tekrar uygulamanız gerekir.

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

Zombie silme akışı:
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
