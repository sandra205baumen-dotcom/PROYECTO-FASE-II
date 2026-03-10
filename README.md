# PROYECTO-FASE-II
Filtrado  en el dominio del espacio para mejora de las imágenes.

# Proyecto Fase II : Procesamiento Digital de Imágenes

Proyecto académico enfocado en la aplicación de técnicas de **mejoramiento de imágenes** para resaltar características visuales asociadas a incendios, como fuego y humo, utilizando diferentes métodos de procesamiento digital de imágenes.

Este trabajo forma parte de la asignatura de Procesamiento Digital de Imágenes y utiliza un conjunto de imágenes de incendios para analizar el efecto de distintas técnicas de mejora.

---

# 📌 Objetivo del proyecto

Implementar y evaluar diferentes técnicas de mejoramiento de imágenes con el fin de mejorar la visibilidad de características relacionadas con incendios en un conjunto de imágenes clasificadas previamente.

---

# 🗂 Dataset

Se utilizó el dataset:

**forestFireDataset (ObjectDetection)**

Este conjunto de datos contiene imágenes relacionadas con incendios en diferentes escenarios, incluyendo:

- presencia de fuego
- presencia de humo
- diferentes entornos
- distintas condiciones de iluminación

Las imágenes presentan diversos niveles de complejidad visual que permiten evaluar el comportamiento de las técnicas de mejoramiento.

---

# 🏷 Clasificación de las imágenes

Antes de aplicar las técnicas de procesamiento, las imágenes fueron **clasificadas manualmente** con el objetivo de organizar los diferentes escenarios presentes en el dataset.

Se utilizaron los siguientes criterios de clasificación:

### 1️⃣ Tipo de fuego
- Fuego incipiente  
- Fuego de superficie  
- Fuego de copas  
- Fuego estructural  
- Resplandor (Glow)

### 2️⃣ Características del humo

**Color**
- Blanco
- Gris / Marrón
- Negro

**Densidad**
- Difuso
- Denso

**Dinámica**
- Columna vertical
- Humo de arrastre

### 3️⃣ Entorno y contexto
- Forestal
- Interfaz urbano-forestal
- Urbano / industrial

### 4️⃣ Condiciones de iluminación
- Diurno (sol directo)
- Diurno (nublado)
- Crepuscular
- Nocturno

### 5️⃣ Falsos positivos
- Atardecer / amanecer
- Polvo o neblina

Esta clasificación permite evaluar las técnicas bajo diferentes condiciones visuales.

---

# ⚙️ Técnicas de mejoramiento implementadas

En este proyecto se implementaron las siguientes técnicas de procesamiento digital de imágenes:

### 1️⃣ Ecualización del histograma
Mejora el contraste redistribuyendo los niveles de intensidad de la imagen.

### 2️⃣ CLAHE (Contrast Limited Adaptive Histogram Equalization)
Versión adaptativa de la ecualización del histograma que limita la amplificación del contraste para evitar la amplificación del ruido.

### 3️⃣ Highboost Filtering
Técnica utilizada para resaltar detalles y bordes manteniendo la información original de la imagen.

### 4️⃣ Gradiente-Laplaciano
Operador utilizado para resaltar bordes mediante derivadas espaciales de la imagen.

### 5️⃣ Filtrado Adaptativo Local
Filtro que ajusta su comportamiento según las características estadísticas locales de la imagen.

### 6️⃣ Adaptive Median Filter
Filtro diseñado para eliminar ruido impulsivo preservando bordes y detalles importantes.

---

# 🔬 Metodología

El flujo general del trabajo se describe a continuación:

Dataset de imágenes  
↓  
Clasificación de imágenes  
↓  
Selección de casos de prueba  
↓  
Aplicación de técnicas de mejoramiento  
↓  
Análisis y comparación de resultados  

Cada técnica se aplicó a diferentes imágenes con distintos niveles de complejidad para analizar su efecto en la visibilidad del fuego y del humo.
