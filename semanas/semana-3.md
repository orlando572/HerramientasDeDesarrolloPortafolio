## Solución de Control de Versiones con Git - Semana 3

### ¿Para qué te servirá en tu vida académica o profesional saber usar Git y manejar ramas?
Dominar Git y el manejo de ramas te permite trabajar de forma organizada en proyectos grandes, colaborar eficientemente con otras personas, experimentar nuevas funcionalidades sin riesgo y mantener un historial de cambios claro y profesional. Es una habilidad muy valorada en entornos académicos y en la industria del desarrollo de software.

### Repositorio

#### Crear un nuevo repositorio local
- `mkdir proyecto && cd proyecto` → Crea una carpeta para el proyecto y entra en ella.
- `git init` → Inicializa un nuevo repositorio Git vacío en la carpeta actual.
- `git remote add origin https://github.com/tu-usuario/proyecto.git` → Conecta tu repositorio local con un repositorio remoto (GitHub) para poder subir y descargar cambios.

#### Clonar un repositorio existente
- `git clone https://github.com/tu-usuario/proyecto.git` → Descarga una copia completa del repositorio remoto a tu computadora.
- `cd proyecto` → Entra en la carpeta del repositorio que acabas de clonar.

### Trabajo diario: add → commit → push
Este es el flujo básico que usarás casi todos los días:

- `git status` → Muestra el estado actual del repositorio (archivos modificados, agregados o sin seguimiento).
- `git add .` → Agrega todos los archivos modificados y nuevos al área de preparación (staging area).
- `git commit -m "feat: agrega formulario de login"` → Guarda los cambios en el historial con un mensaje claro y descriptivo (usando buenas convenciones como "feat:").
- `git push origin main` → Sube los commits locales a la rama `main` del repositorio remoto.

### Ramas (Branching)

#### Crear y cambiar a una rama nueva
- `git switch -c feature/login` → Crea una nueva rama llamada `feature/login` y cambia a ella inmediatamente (forma recomendada actualmente).
- `git checkout -b feature/login` → Forma antigua pero todavía válida de crear y cambiar a una nueva rama.

#### Ver ramas
- `git branch -a` → Muestra todas las ramas locales y remotas del repositorio.

#### Subir la rama por primera vez
- `git push -u origin feature/login` → Sube la rama actual al repositorio remoto y la configura para hacer push/pull automáticamente en el futuro (`-u` = upstream).

#### Fusionar (Merge)
- `git switch main` → Cambia a la rama principal (`main`) antes de fusionar.
- `git pull --ff-only` → Actualiza la rama main con los últimos cambios remotos, pero solo permite fast-forward (evita merges innecesarios).
- `git merge --no-ff feature/login` → Fusiona la rama `feature/login` en la rama actual creando un commit de merge (mantiene la historia clara).
- `git push` → Sube la fusión realizada a la rama main del repositorio remoto.

#### Rebase interactivo para mantener un historial limpio
- `git switch feature/login` → Cambia a la rama que quieres reorganizar.
- `git rebase -i main` → Reorganiza interactivamente los commits de tu rama sobre la rama `main`, permitiendo limpiar, combinar o reescribir mensajes de commits para un historial más ordenado.
