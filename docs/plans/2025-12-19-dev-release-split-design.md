# Dev/Release File Split Design

## Overview

Split the single-file TaskTimer.html into separate source files for development, with a build script that generates the single-file release version.

## File Structure

```
TaskTimer/
├── src/
│   ├── index.html          # Dev version with placeholders
│   ├── css/
│   │   └── style.css       # All CSS (~450 lines)
│   └── js/
│       ├── clock-logic.js  # ClockLogic object - pure functions (~550 lines)
│       └── app.js          # State, UI, events (~1350 lines)
├── TaskTimer.html          # Generated release file (do not edit)
├── scripts/
│   └── build.js            # Node script to assemble release
├── package.json            # Add build script
├── tests/
│   └── clock.test.js       # Update to load from src/
└── AGENTS.md               # Update documentation
```

## Template Placeholders

`src/index.html` structure:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- ... meta tags ... -->
  <link rel="stylesheet" href="css/style.css">
  <!-- BUILD:CSS -->
  <title>TaskTimer</title>
</head>
<body>
  <!-- ... HTML content ... -->

  <script src="js/clock-logic.js"></script>
  <script src="js/app.js"></script>
  <!-- BUILD:JS -->
</body>
</html>
```

- Dev: Browser loads external files, ignores BUILD comments
- Build: Removes external refs, injects content at BUILD markers

## Build Script

`scripts/build.js`:
- Read src/index.html, css/style.css, js/clock-logic.js, js/app.js
- Remove `<link>` and `<script>` tags for external files
- Replace `<!-- BUILD:CSS -->` with `<style>` containing CSS
- Replace `<!-- BUILD:JS -->` with `<script>` containing both JS files
- Write to TaskTimer.html

## Commands

```bash
npm test      # Run tests against src/index.html
npm run build # Generate TaskTimer.html
```

## Migration Steps

1. Create `src/` directory structure
2. Extract CSS to `src/css/style.css`
3. Extract ClockLogic to `src/js/clock-logic.js`
4. Extract app code to `src/js/app.js`
5. Create `src/index.html` with external refs and BUILD markers
6. Create `scripts/build.js`
7. Update `package.json` with build script
8. Update `tests/clock.test.js` path
9. Update `AGENTS.md`
10. Run build, verify TaskTimer.html matches original
11. Run tests, verify all pass
