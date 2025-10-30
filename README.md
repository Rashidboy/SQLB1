# SQLB1
SQL so'rovlar 
## 🎯 Maqsad
Ushbu loyiha yordamida siz **SQL so‘rovlarini yaratish**, **subquerylardan foydalanish**, **ma’lumotlarni saralash**, va **sana bo‘yicha filtrlash**ni o‘rganasiz.  
Natijada siz ma’lumotlarni tahlil qilish, hisobotlar yaratish va dasturlarda ma’lumotlar bazalari bilan ishlashni oson o‘zlashtirasiz.

---

## 🧠 Nimalarni o‘rganasiz?
- SELECT, WHERE, BETWEEN, ORDER BY, va CASE shartlari bilan ishlash  
- Ichki so‘rovlar (`subquery`) yordamida ma’lumot olish  
- Sana bo‘yicha filtrlash (`date range filtering`)  
- Ma’lumotlarni tartiblash va birlashtirish  
- PostgreSQL asosiy amaliyotlari  

---

## 📂 Loyihaning tarkibi
SQLB1/
├── src/ # Asosiy SQL fayllar
├── materials/ # Model va rasm fayllar
├── misc/images/ # Diagrammalar va vizual ko‘rinishlar
└── README.md

yaml
Копировать код

---

## 🧩 Ma’lumotlar modeli (Database Schema)
Quyidagi rasmda loyiha ma’lumotlar bazasining tuzilmasi ko‘rsatilgan:

![Database Schema](misc/images/schema.png)

**Asosiy jadvallar:**

| Jadval nomi | Tavsif |
|--------------|--------|
| 🧍‍♂️ `person` | Shaxslar haqidagi ma’lumotlar (ism, yosh, manzil, jins) |
| 🍕 `pizzeria` | Pitsariya ma’lumotlari (nomi va reytingi) |
| 📋 `menu` | Har bir pitsariyadagi menyu va narxlar |
| 🕓 `person_visits` | Shaxslarning pitsariyalarga tashrifi haqidagi ma’lumotlar |
| 🛒 `person_order` | Buyurtmalar tarixi (kim, qachon va nima buyurtma bergan) |

---

## 🧱 Jadval yaratish kodi (Model SQL)

### 👤 `person` jadvali
```sql
create table person (
  id bigint primary key,
  name varchar not null,
  age integer not null default 10,
  gender varchar not null default 'female',
  address varchar
);

alter table person add constraint ch_gender
check (gender in ('female', 'male'));
🍕 pizzeria jadvali
sql
Копировать код
create table pizzeria (
  id bigint primary key,
  name varchar not null,
  rating numeric not null default 0
);

alter table pizzeria add constraint ch_rating
check (rating between 0 and 5);
🕓 person_visits jadvali
sql
Копировать код
create table person_visits (
  id bigint primary key,
  person_id bigint not null,
  pizzeria_id bigint not null,
  visit_date date not null default current_date,
  constraint uk_person_visits unique (person_id, pizzeria_id, visit_date),
  constraint fk_person_visits_person_id foreign key (person_id) references person(id),
  constraint fk_person_visits_pizzeria_id foreign key (pizzeria_id) references pizzeria(id)
);
📋 menu jadvali
sql
Копировать код
create table menu (
  id bigint primary key,
  pizzeria_id bigint not null,
  pizza_name varchar not null,
  price numeric not null default 1,
  constraint fk_menu_pizzeria_id foreign key (pizzeria_id) references pizzeria(id)
);
🛒 person_order jadvali
sql
Копировать код
create table person_order (
  id bigint primary key,
  person_id bigint not null,
  menu_id bigint not null,
  order_date date not null default current_date,
  constraint fk_order_person_id foreign key (person_id) references person(id),
  constraint fk_order_menu_id foreign key (menu_id) references menu(id)
);
🍽️ Ma’lumotlarni kiritish (INSERT)
Quyidagi namunaviy ma’lumotlar bazaga kiritiladi:

sql
Копировать код
insert into person values (1, 'Anna', 16, 'female', 'Moscow');
insert into pizzeria values (1, 'Pizza Hut', 4.6);
insert into person_visits values (1, 1, 1, '2022-01-01');
insert into menu values (1, 1, 'cheese pizza', 900);
insert into person_order values (1, 1, 1, '2022-01-01');
⚙️ Qanday ishlatish kerak
1️⃣ Bazani yaratish
PostgreSQL da yangi ma’lumotlar bazasini oching:

bash
Копировать код
createdb pizza_db
2️⃣ Modellarni import qilish
materials/model.sql faylini bazaga yuklang:

bash
Копировать код
psql -d pizza_db -f materials/model.sql
3️⃣ SQL mashqlarni bajarish
src/ ichidagi .sql fayllarni ketma-ket ishga tushiring:

bash
Копировать код
psql -d pizza_db -f src/day00_ex00.sql
4️⃣ Natijani tekshirish
Har bir mashq so‘rovini psql yoki pgAdmin orqali sinab ko‘ring.

🧪 Namuna: SELECT so‘rovi
sql
Копировать код
-- Kazan shahridagi barcha shaxslarning ismi va yoshi
SELECT name, age
FROM person
WHERE address = 'Kazan';
Natija:

name	age
Kate	33
Denis	13
Elvira	45

🧭 Foydali rasm va ko‘rsatmalar
Entity Relationship Diagram


Jadval munosabatlari


💬 Fikr-mulohaza
💡 Bu yerda anonim fikr qoldirishingiz mumkin.
Sizning fikringiz loyiha sifatini oshirishda yordam beradi!

👨‍💻 Muallif
Rashid Mirtazoqulov
📧 rashidmirtazoqulov0804@gmail.com
🌐 GitHub: Rashidboy
