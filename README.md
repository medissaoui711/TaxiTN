# 🚗 TaxiTN — Full-Stack Frontend SPA

<div align="center">

![TaxiTN](https://img.shields.io/badge/version-1.0.0-22c55e?style=for-the-badge)
![HTML](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![CSS](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![RTL](https://img.shields.io/badge/Arabic_RTL-✓-green?style=for-the-badge)
![No Framework](https://img.shields.io/badge/No_Framework-Vanilla_JS-orange?style=for-the-badge)

**تطبيق TaxiTN للنقل والتوصيل — مبنية بـ Vanilla HTML/CSS/JS بدون أي إطار عمل**

[🔴 عرض مباشر](https://taxitn-app.pages.dev) • [📁 الملفات](#الملفات) • [✨ المميزات](#المميزات) • [🗺️ الخرائط](#خرائط)

</div>

---

## 📋 نظرة عامة

تطبيق **TaxiTN** للنقل والتوصيل — حل متكامل للمواصلات الذكية في تونس. يشمل المشروع واجهة مستخدم SPA كاملة مع 9 صفحات تفاعلية، ونظام خرائط مبني باستخدام Leaflet.js.

> **ملاحظة:** هذا المشروع لأغراض تعليمية وتقنية فقط. جميع العلامات التجارية ملك لأصحابها.

---

## 📁 الملفات

```
taxitn/
├── index.html             # الصفحة الرئيسية (SEO optimized)
├── taxitn_clone.html      # التطبيق الرئيسي — SPA كاملة (9 صفحات)
├── taxitn_maps.html       # نظام الخرائط والتتبع المباشر (Leaflet.js)
├── DEPLOYMENT_REPORT.md   # تقرير النشر الشامل
├── .github/workflows/     # CI/CD GitHub Actions
│   └── deploy.yml         # نشر تلقائي على Cloudflare Pages
├── README.md              # هذا الملف
└── .gitignore             # إعدادات Git
```

---

## ✨ المميزات

### 🏠 التطبيق الرئيسي (`taxitn_clone.html`)

#### الصفحات (9 صفحات)

| الصفحة | الوصف |
|--------|-------|
| **Home** | صفحة رئيسية مع Hero + تبويبات الخدمات + إحصائيات |
| **Ride** | حجز الرحلات مع اختيار نوع السيارة وتقدير السعر |
| **Food** | تصفح المطاعم + بحث + طلب طعام مباشر |
| **Grocery** | تسوق البقالة مع سلة مشتريات تفاعلية |
| **Pay** | محفظة TaxiTN Pay + إرسال أموال |
| **Plus** | خطط الاشتراك (شهري / سنوي / عائلي) |
| **Business** | حلول الشركات + نموذج تواصل |
| **About** | قصة الشركة + فريق القيادة |
| **Profile** | ملف شخصي + 5 تبويبات (رحلات / طلبات / محفظة / عناوين / إعدادات) |

#### المكونات التفاعلية

- **SPA Navigation** — انتقال سلس بين الصفحات بدون إعادة تحميل
- **Cart Sidebar** — سلة مشتريات منزلقة مع إدارة كاملة
- **Auth Flow** — تسجيل دخول / إنشاء حساب / تسجيل خروج
- **4 Modals** — تأكيد رحلة، دفع، اشتراك Plus، تسجيل الدخول
- **Toast Notifications** — إشعارات لجميع أحداث التطبيق
- **Dropdown Nav** — قائمة منسدلة للخدمات
- **Responsive** — متوافق مع الجوال (breakpoint 960px)
- **SEO Meta Tags** — Open Graph, Twitter Cards, Theme Color

---

### 🗺️ نظام الخرائط (`taxitn_maps.html`)

> مبني باستخدام **Leaflet.js** — مكتبة خرائط مفتوحة المصدر

#### ميزات الخريطة

- **خرائط تفاعلية** — Leaflet.js مع OpenStreetMap tiles
- **تحديد الموقع** — Geolocation API أو نقر على الخريطة
- **Reverse Geocoding** — تحويل النقرة لاسم منطقة (Nominatim API)
- **بحث بالعناوين** — Autocomplete من 12 موقع معروف
- **رسم المسار** — حساب وعرض المسار بين نقطتين (OSRM API)
- **تتبع السائق** — محاكاة حركة السيارة على المسار خطوة بخطوة
- **8 سائقين** — مع حركة تلقائية متجددة
- **Pan & Zoom** — سحب الخريطة + عجلة الماوس + أزرار التكبير
- **وضع ليلي** — Dark mode للخريطة
- **مشاركة الموقع** — نسخ رابط Google Maps للحافظة
- **Lazy Loading** — تحميل Leaflet بـ `defer` لتحسين الأداء

#### واجهة Sidebar

| التبويب | المحتوى |
|---------|---------|
| **احجز رحلة** | حقول الانطلاق/الوجهة + اختيار السيارة + تقدير السعر |
| **تتبع السائق** | ETA + بيانات السائق + أزرار (اتصال / مشاركة / ملاحظة / طوارئ) |
| **السائقون** | قائمة السائقين القريبين مع التقييمات والمسافة |

---

## 🛠️ التقنيات المستخدمة

```
Frontend Only — Zero Dependencies (except Leaflet)
```

| التقنية | الاستخدام |
|---------|-----------|
| `HTML5` | هيكل الصفحات، Semantic Elements, SEO Meta Tags |
| `CSS3` | Variables, Grid, Flexbox, Animations, RTL, Responsive |
| `Vanilla JS` | SPA Router, State Management, DOM Manipulation |
| `Leaflet.js` | خرائط تفاعلية (CDN) |
| `Geolocation API` | تحديد الموقع الحالي للمستخدم |
| `Clipboard API` | مشاركة رابط الموقع |
| `Google Fonts` | خط Tajawal للنص العربي |
| `GitHub Actions` | CI/CD نشر تلقائي |
| `Cloudflare Pages` | استضافة CDN عالمية |

---

## 🚀 النشر

### GitHub + Cloudflare Pages (الطريقة المُوصى بها)

الموقع مُستضاف على **Cloudflare Pages** مع نشر تلقائي عبر GitHub Actions:

| البيئة | الرابط |
|--------|--------|
| **Production** | [https://taxitn-app.pages.dev](https://taxitn-app.pages.dev) |
| **GitHub Repo** | [https://github.com/medissaoui711/TaxiTN](https://github.com/medissaoui711/TaxiTN) |

### تشغيل محلياً

```bash
# لا يوجد أي تثبيت مطلوب
# افتح الملف مباشرة في المتصفح

start index.html
# أو
start taxitn_clone.html
# أو
start taxitn_maps.html
```

### عبر Live Server (VS Code)

```bash
# 1. ثبّت إضافة Live Server في VS Code
# 2. انقر يمين على الملف
# 3. اختر "Open with Live Server"
```

### عبر Python HTTP Server

```bash
python -m http.server 8080
# ثم افتح: http://localhost:8080
```

---

## 📱 التوافق

| المتصفح | الدعم |
|---------|-------|
| Chrome 90+ | ✅ كامل |
| Firefox 88+ | ✅ كامل |
| Safari 14+ | ✅ كامل |
| Edge 90+ | ✅ كامل |
| Mobile (iOS/Android) | ✅ Responsive |

---

## 📊 الإحصائيات

| الملف | الحجم | الأسطر | الوصف |
|-------|-------|--------|-------|
| `index.html` | ~77 KB | ~2,300 | الصفحة الرئيسية (SEO optimized) |
| `taxitn_clone.html` | ~77 KB | ~900 | نسخة احتياطية |
| `taxitn_maps.html` | ~37 KB | ~750 | نظام الخرائط |
| **Total** | ~190 KB | ~4,000 | — |

---

## 🔮 خطوات التطوير المستقبلية

- [ ] **ربط الملفين** في SPA واحدة متكاملة
- [ ] **تحويل لـ React/Next.js** مع component-based architecture
- [ ] **Backend API** باستخدام FastAPI أو Node.js
- [ ] **قاعدة بيانات** PostgreSQL + Prisma ORM
- [ ] **خرائط حقيقية** — Google Maps API أو Mapbox
- [ ] **Real-time Tracking** عبر WebSockets
- [ ] **نظام المصادقة** — JWT + OAuth (Google/Apple)
- [ ] **دفع حقيقي** — Stripe أو PayTabs
- [ ] **PWA** — تحويل لتطبيق قابل للتثبيت
- [ ] **تطبيق موبايل** — React Native أو Flutter

---

## 📁 هيكل المشروع

```
taxitn/
├── .github/
│   └── workflows/
│       └── deploy.yml          # CI/CD Pipeline
├── index.html                  # Main SPA (SEO optimized)
├── taxitn_clone.html           # Backup copy
├── taxitn_maps.html            # Maps module
├── DEPLOYMENT_REPORT.md        # Deployment guide
├── README.md                   # Documentation
└── .gitignore                  # Git ignore rules
```

---

## 🎨 نظام التصميم

```css
:root {
  --green:       #3DC56A;   /* اللون الرئيسي */
  --green-dark:  #2aa855;   /* Hover States */
  --green-light: #e8f9ee;   /* Backgrounds */
  --black:       #0a0a0a;   /* نص رئيسي */
  --gray:        #6b7280;   /* نص ثانوي */
  --light:       #f8fafc;   /* خلفيات */
  --radius:      18px;      /* Border Radius */
  --shadow:      0 4px 24px rgba(0,0,0,.08);
}
```

**الخط:** [Tajawal](https://fonts.google.com/specimen/Tajawal) — Google Fonts  
**الاتجاه:** RTL كامل (`dir="rtl"`, `lang="ar"`)

---

## 🛡️ SEO & Performance

- ✅ **Meta Tags:** Description, Keywords, Author
- ✅ **Open Graph:** Title, Description, Image, URL, Locale
- ✅ **Twitter Cards:** Large image summary
- ✅ **Theme Color:** #3DC56A
- ✅ **Preconnect:** Google Fonts, unpkg CDN
- ✅ **Lazy Loading:** Leaflet CSS with `media="print"` trick
- ✅ **Defer:** JavaScript non-blocking
- ✅ **CI/CD:** Automated deployment on push

---

## 👨‍💻 المطوّر

**محمد** — AI Product Builder & Full-Stack Engineer  
🏢 **رواي الذكاء الاصطناعي** — منصة تعليم الذكاء الاصطناعي بالعربية

---

## 📄 الترخيص

```
MIT License — للاستخدام التعليمي والشخصي
العلامة التجارية "Careem" ملك لشركة Careem Networks FZ LLC
```

---

<div align="center">

**بُني بـ ❤️ و Vanilla JS — بدون frameworks، بدون dependencies**

</div>
