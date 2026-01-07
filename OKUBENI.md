# Anti-Zombie Remover v1.0.0

> **SENTRA Research Project**  
> 🔗 Discord: `ed.husserl`  
> 📄 Lisans: MIT

> ⚠️ **Uyarı:** Bu resmi olmayan bir mod aracıdır. The Indie Stone ile bağlantısı yoktur.

> [🇬🇧 For English click here](README.md)

---

## 📋 Bu Nedir?

Bu araç, Project Zomboid 42.13.1'deki **otomatik zombi silme** mekanizmasını devre dışı bırakır veya değiştirir.

### Sorun
Varsayılan olarak, Project Zomboid performans optimizasyonu için zombi sayısı **500'ü** geçtiğinde otomatik olarak zombileri siler.

### Çözüm
Bu sorunu çözmek için **iki versiyon** sunuyoruz:

---

## 🔧 Hangi Versiyonu Kullanmalıyım?

| Versiyon | Açıklama | En İyi Kullanım |
|----------|----------|-----------------|
| **[Standard](Anti-Zombie-Remover/)** | Zombi silmeyi tamamen devre dışı bırakır | Maksimum zombi kaosu, hordlar |
| **[Limit](Anti-Zombie-Remover-Limit/)** | Kendi limitinizi belirleyin | Performans ve zombi dengesi |

### Hızlı Karşılaştırma

| Özellik | Standard | Limit |
|---------|----------|-------|
| Zombiler siliniyor mu? | ❌ Asla | ✅ Limitten sonra |
| Özel limit? | Hayır (Sınırsız) | Evet (Siz seçersiniz) |
| Performans etkisi | Yüksek (daha fazla zombi) | Kontrol edilebilir |
| Önerilen kullanım | Hord sunucuları, test | Üretim sunucuları |

---

## 📁 Klasör Yapısı

```
Anti-Zombie-Remover/
├── Anti-Zombie-Remover/           # Standard versiyon (Sınırsız)
│   ├── src/
│   ├── compile.bat / compile.sh
│   ├── README.md
│   └── KURULUM.md
├── Anti-Zombie-Remover-Limit/     # Limit versiyon (Özelleştirilebilir)
│   ├── src/
│   ├── compile.bat / compile.sh
│   ├── README.md
│   └── KURULUM.md
├── LICENSE
├── README.md                      # İngilizce
└── OKUBENI.md                     # Bu dosya (Türkçe)
```

---

## 🚀 Hızlı Başlangıç

1. **Versiyonunuzu seçin** (Standard veya Limit)
2. **Klasörü açın** ve `compile.bat` (Windows) veya `compile.sh` (Linux) çalıştırın
3. **Talimatları takip edin** ve derleyin
4. **Derlenen `.class` dosyalarını** `projectzomboid.jar` içine kopyalayın
5. **Sunucu/oyunu başlatın** ve keyfini çıkarın!

Detaylı talimatlar için her versiyonun klasöründeki README/KURULUM dosyalarına bakın.

---

## ⚠️ Önemli Uyarılar

- Herhangi bir yama uygulamadan önce **dosyalarınızı yedekleyin**
- **Kim Kurmalı?**
  - **Tek Oyunculu (Solo):** Siz kurmalısınız.
  - **Co-op (Host):** Sadece Host (Oyunu Kuran) kurmalıdır.
  - **Dedicated Sunucu:** Sadece Sunucuya kurulmalıdır. (Oyuncuların/Clientların çok oyunculu için bir şey kurmasına gerek **YOKTUR**).
- **Oyun güncellemeleri** yamayı yeniden uygulamanızı gerektirebilir
- **Performans** - Çok fazla zombi kasılmaya neden olabilir

---

## 📄 Lisans

Bu proje **MIT Lisansı** altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

Project Zomboid, The Indie Stone'ın mülkiyetindedir.

---

**Geliştirici:** SENTRA Anti-Cheat Research Project  
**Discord:** ed.husserl  
**Tarih:** Ocak 2026  
**Sürüm:** v1.0.0
