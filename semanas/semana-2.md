## Solución de Control de Versiones con Git

### ¿Para qué me sirve aprender a instalar, configurar y usar los comandos básicos de Git?
Aprender Git me permite controlar el historial de cambios de mis proyectos, trabajar de forma segura, colaborar con otras personas y recuperar versiones anteriores en caso de errores.

### Instalación
Descargar e instalar Git desde el sitio oficial.  
Una vez instalado, verifica que funcione correctamente:

- `git --version` → Muestra la versión de Git instalada en tu computadora para confirmar que se instaló correctamente.

### Configuración inicial
Antes de empezar a usar Git, es necesario configurar tu identidad (nombre y correo). Estos datos aparecerán en todos tus commits.

- `git config --global user.name "Tu Nombre"` → Configura el nombre de usuario que se usará en los commits.
- `git config --global user.email "tu@email.com"` → Configura el correo electrónico asociado a tus commits.

### Flujo básico de trabajo

#### Crear o clonar un repositorio
- `mkdir mi-proyecto && cd mi-proyecto` → Crea una carpeta para el proyecto y entra en ella.
- `git init` → Inicializa un nuevo repositorio Git vacío en la carpeta actual.
- `git clone https://github.com/usuario/repo.git` → Descarga una copia completa de un repositorio remoto a tu computadora.
- `cd repo` → Entra en la carpeta del repositorio clonado.

#### Ver estado y cambios
- `git status` → Muestra el estado actual del repositorio (qué archivos están modificados, en stage o sin seguimiento).
- `git diff` → Muestra los cambios realizados en los archivos que aún no han sido agregados al stage.
- `git diff --staged` → Muestra los cambios que ya están preparados (en stage) y que se incluirán en el próximo commit.

#### Preparar (stage) y confirmar (commit)
- `git add archivo.txt` → Agrega un archivo específico al área de preparación (staging area) para ser confirmado.
- `git commit -m "Mensaje breve y descriptivo"` → Guarda los cambios preparados en el historial del repositorio con un mensaje descriptivo.

#### Subir (push) y bajar (pull) cambios
- `git push origin main` → Sube los commits locales al repositorio remoto (generalmente en la rama main).
- `git pull` → Descarga los cambios más recientes del repositorio remoto y los fusiona con tu versión local.

### Comandos básicos de solución de problemas

#### Ver historial
- `git log --oneline --graph --decorate` → Muestra un historial resumido de los commits con un gráfico de ramas y decoraciones.
- `git show <hash>` → Muestra los detalles completos de un commit específico (cambios, autor, mensaje, etc.).

#### Deshacer cambios sin perder trabajo
- `git restore archivo.txt` → Restaura un archivo modificado a su estado anterior (versión del último commit).
- `git restore --staged archivo.txt` → Quita un archivo del área de stage sin eliminar los cambios realizados.
- `git reset --soft HEAD~1` → Deshace el último commit, pero mantiene los cambios en el área de stage para poder modificarlos.

#### Ramificación y fusión (Básico)
- `git branch` → Lista todas las ramas del repositorio y muestra en cuál estás trabajando actualmente.
- `git branch feature-x` → Crea una nueva rama llamada "feature-x".
- `git switch feature-x` → Cambia a la rama "feature-x".
- `git switch -c feature-y` → Crea y cambia a una nueva rama llamada "feature-y" en un solo comando.
- `git merge feature-x` → Fusiona los cambios de la rama "feature-x" en la rama actual.