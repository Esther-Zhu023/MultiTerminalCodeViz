# Troubleshooting Guide

This guide helps you resolve common issues when working with MultiTerminalCodeViz.

## 🚨 Installation Issues

### Node.js Version Problems

**Problem**: Getting errors about Node.js version compatibility
```
error: This version of Node.js is not supported
```

**Solutions**:
```bash
# Check your Node.js version
node --version

# If version is below 18.0, update Node.js
# Option 1: Download from nodejs.org
# Option 2: Use Node Version Manager (recommended)

# Install nvm (macOS/Linux)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Install nvm (Windows)
# Download from: https://github.com/coreybutler/nvm-windows

# Install and use Node 18
nvm install 18
nvm use 18
```

### npm Install Failures

**Problem**: Dependencies fail to install
```
npm ERR! peer dep missing
npm ERR! network timeout
```

**Solutions**:
```bash
# Clear npm cache
npm cache clean --force

# Delete node_modules and package-lock.json
rm -rf node_modules package-lock.json

# Try installing again
npm install

# If still failing, try with legacy peer deps
npm install --legacy-peer-deps

# Alternative: Use yarn instead
npm install -g yarn
yarn install
```

### Port Already in Use

**Problem**: Development server won't start
```
Error: Port 5173 is already in use
```

**Solutions**:
```bash
# Option 1: Kill the process using the port
npx kill-port 5173

# Option 2: Use a different port
npm run dev -- --port 3000

# Option 3: Find and kill the process manually
# macOS/Linux:
lsof -ti:5173 | xargs kill -9

# Windows:
netstat -ano | findstr :5173
taskkill /PID <PID> /F
```

## 🔧 Development Issues

### TypeScript Compilation Errors

**Problem**: TypeScript errors preventing compilation
```
error TS2345: Argument of type 'string' is not assignable to parameter of type 'number'
```

**Solutions**:
```bash
# Check TypeScript configuration
npx tsc --noEmit

# Restart TypeScript server in VS Code
# Ctrl+Shift+P -> "TypeScript: Restart TS Server"

# Update TypeScript if needed
npm update typescript

# Check for type definition issues
npm install --save-dev @types/react @types/react-dom
```

### React Hook Errors

**Problem**: Hook-related errors
```
Error: Invalid hook call. Hooks can only be called inside the body of a function component
```

**Common Causes & Solutions**:

1. **Calling hooks conditionally**:
```typescript
// ❌ Wrong
if (condition) {
  const [state, setState] = useState(false);
}

// ✅ Correct
const [state, setState] = useState(false);
if (condition) {
  // Use state here
}
```

2. **Calling hooks in regular functions**:
```typescript
// ❌ Wrong
function regularFunction() {
  const [state, setState] = useState(false);
}

// ✅ Correct
function useCustomHook() {
  const [state, setState] = useState(false);
  return { state, setState };
}
```

3. **Multiple React versions**:
```bash
# Check for duplicate React versions
npm ls react

# If duplicates found, dedupe
npm dedupe
```

### CSS/Styling Issues

**Problem**: Tailwind classes not applying
```
Class 'bg-gray-800' not found
```

**Solutions**:
```bash
# Ensure Tailwind is properly configured
# Check tailwind.config.js content paths
content: [
  "./index.html",
  "./src/**/*.{js,ts,jsx,tsx}",
]

# Rebuild CSS
npm run dev

# Clear browser cache
# Chrome: Ctrl+Shift+R (hard refresh)

# Check if PostCSS is configured
# Verify postcss.config.js exists
```

**Problem**: Custom CSS not loading
```
Module not found: Can't resolve './Component.css'
```

**Solutions**:
```typescript
// Ensure CSS file exists and is imported correctly
import './TerminalWindow.css';

// Check file path and extension
// Verify CSS file is in the same directory
```

## 🎮 Runtime Issues

### Terminal Animation Problems

**Problem**: Typewriter animation not working
```
Terminals appear but text doesn't animate
```

**Debugging Steps**:
```typescript
// 1. Check if useTypewriter hook is receiving data
const { displayedLines, isTyping } = useTypewriter({
  lines: terminalOutputs[outputType] || [],
  speed: terminalSpeed,
  enabled: shouldAnimate,
  loop: shouldAnimate,
});

console.log('Typewriter debug:', {
  lines: terminalOutputs[outputType],
  speed: terminalSpeed,
  enabled: shouldAnimate,
  displayedLines: displayedLines.length,
  isTyping
});

// 2. Verify terminal outputs data
console.log('Available outputs:', Object.keys(terminalOutputs));

// 3. Check if component is unmounting too quickly
useEffect(() => {
  console.log('TerminalWindow mounted');
  return () => console.log('TerminalWindow unmounted');
}, []);
```

### Performance Issues

**Problem**: App becomes slow with many terminals
```
Browser becomes unresponsive with 100+ terminals
```

**Solutions**:
```typescript
// 1. Implement virtual scrolling for large numbers
const maxRenderedTerminals = actualTerminalCount > 1000 ? 40 : 80;

// 2. Optimize re-renders with React.memo
export const TerminalWindow = React.memo(function TerminalWindow(props) {
  // Component logic
});

// 3. Debounce expensive operations
const debouncedUpdate = useMemo(
  () => debounce(updateFunction, 100),
  [updateFunction]
);

// 4. Use useCallback for event handlers
const handlePositionChange = useCallback((id, position) => {
  // Handler logic
}, []);
```

### Context Provider Issues

**Problem**: Context values are undefined
```
TypeError: Cannot read properties of undefined (reading 'currentTheme')
```

**Solutions**:
```typescript
// 1. Ensure component is wrapped in provider
function App() {
  return (
    <ThemeProvider>
      <AppProvider>
        <YourComponent />
      </AppProvider>
    </ThemeProvider>
  );
}

// 2. Add error boundary for context
export function useTheme() {
  const context = useContext(ThemeContext);
  if (context === undefined) {
    throw new Error('useTheme must be used within a ThemeProvider');
  }
  return context;
}

// 3. Check provider order (ThemeProvider should wrap AppProvider)
```

## 🧪 Testing Issues

### Test Environment Setup

**Problem**: Tests failing with module resolution errors
```
Cannot resolve module '@testing-library/react'
```

**Solutions**:
```bash
# Install missing test dependencies
npm install --save-dev @testing-library/react @testing-library/jest-dom @testing-library/user-event

# Verify vitest configuration in vite.config.ts
test: {
  globals: true,
  environment: 'jsdom',
  setupFiles: './src/setupTests.ts',
}

# Check setupTests.ts exists and imports jest-dom
import '@testing-library/jest-dom';
```

### Mock Issues

**Problem**: Tests failing due to unmocked dependencies
```
ReferenceError: ResizeObserver is not defined
```

**Solutions**:
```typescript
// Mock ResizeObserver in setupTests.ts
global.ResizeObserver = vi.fn().mockImplementation(() => ({
  observe: vi.fn(),
  unobserve: vi.fn(),
  disconnect: vi.fn(),
}));

// Mock react-draggable
vi.mock('react-draggable', () => ({
  default: ({ children }: { children: React.ReactNode }) => <div>{children}</div>
}));

// Mock react-resizable
vi.mock('react-resizable', () => ({
  ResizableBox: ({ children }: { children: React.ReactNode }) => <div>{children}</div>
}));
```

## 🌐 Browser Compatibility

### Safari Issues

**Problem**: Features not working in Safari
```
TypeError: Cannot read property 'requestAnimationFrame' of undefined
```

**Solutions**:
```typescript
// Add polyfills for older browsers
// Install core-js if needed
npm install core-js

// Use feature detection
if (typeof window !== 'undefined' && window.requestAnimationFrame) {
  // Use requestAnimationFrame
} else {
  // Fallback to setTimeout
}
```

### Mobile Issues

**Problem**: Touch interactions not working properly
```
Drag and drop doesn't work on mobile
```

**Solutions**:
```typescript
// Ensure touch events are handled
// react-draggable should handle this automatically
// But you can add touch-action CSS if needed
.draggable-element {
  touch-action: none;
}

// Test on actual devices, not just browser dev tools
```

## 🔍 Debugging Tools

### React DevTools

1. **Install Extension**: React Developer Tools for Chrome/Firefox
2. **Component Tree**: Inspect component hierarchy and props
3. **Profiler**: Identify performance bottlenecks

### Browser DevTools

```javascript
// Console debugging
console.log('Debug info:', { variable1, variable2 });

// Performance monitoring
console.time('expensive-operation');
// ... expensive code
console.timeEnd('expensive-operation');

// Network tab: Check for failed requests
// Performance tab: Analyze rendering performance
```

### VS Code Debugging

```json
// .vscode/launch.json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug React App",
      "type": "node",
      "request": "launch",
      "program": "${workspaceFolder}/node_modules/.bin/vite",
      "args": ["dev"],
      "console": "integratedTerminal"
    }
  ]
}
```

## 📞 Getting Help

### Before Asking for Help

1. **Check Console**: Look for error messages in browser console
2. **Reproduce**: Create minimal reproduction of the issue
3. **Search Issues**: Check GitHub issues for similar problems
4. **Update Dependencies**: Ensure you're using latest versions

### Creating Good Bug Reports

Include this information:
- **Environment**: OS, Node.js version, browser
- **Steps to Reproduce**: Exact steps that cause the issue
- **Expected Behavior**: What should happen
- **Actual Behavior**: What actually happens
- **Error Messages**: Full error text and stack traces
- **Code Samples**: Minimal reproduction code

### Community Resources

- **GitHub Issues**: [Project Issues](https://github.com/Esther-Zhu023/MultiTerminalCodeViz/issues)
- **GitHub Discussions**: [Project Discussions](https://github.com/Esther-Zhu023/MultiTerminalCodeViz/discussions)
- **React Documentation**: [reactjs.org](https://reactjs.org/)
- **TypeScript Handbook**: [typescriptlang.org](https://www.typescriptlang.org/)

---

**Still stuck?** Don't hesitate to create an issue on GitHub with detailed information about your problem. The community is here to help!
