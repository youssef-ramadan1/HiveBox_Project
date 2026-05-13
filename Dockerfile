# 1. هات نسخة بايثون جاهزة عشان نشغل عليها الكود
FROM python:3.9-slim

# 2. اعمل فولدر جوه الدوكر اسمه app عشان نرمي فيه الحاجة
WORKDIR /app

# 3. انقل ملف الطلبات لجوه
COPY requirements.txt .

# 4. خليه يسطب مكتبة Flask اللي إنت كتبتها في الملف
RUN pip install --no-cache-dir -r requirements.txt

# 5. انقل ملف app.py وكل حاجة تانية لجوه
COPY . .

# 6. افتح الباب (Port) رقم 5000 عشان نعرف نشوف الويب سايت
EXPOSE 5000

# 7. قوله أول ما تبدأ شغل الـ app.py
CMD ["python", "app.py"]
