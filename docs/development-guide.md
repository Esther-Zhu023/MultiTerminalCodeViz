# Development Guide

This guide covers coding standards, best practices, and contribution guidelines for MultiTerminalCodeViz.

## 🏗️ Project Structure

```
MultiTerminalCodeViz/
├── docs/                    # Documentation
├── public/                  # Static assets
├── src/
│   ├── components/          # React components
│   │   ├── BouncyCat/
│   │   ├── ControlsPanel/
│   │   ├── TerminalWindow/
│   │   └── YouTubeAudioPlayer/
│   ├── contexts/            # React contexts
│   │   ├── AppContext.tsx
│   │   ├── ThemeContext.tsx
│   │   └── __tests__/
│   ├── data/                # Static data and configurations
│   │   ├── colorThemes.ts
│   │   └── terminalOutputs.ts
│   ├── hooks/               # Custom React hooks
│   │   └── useTypewriter.ts
│   ├── pages/               # Page components
│   ├── utils/               # Utility functions
│   └── main.tsx            # Application entry point
├── package.json
├── vite.config.ts
├── tsconfig.json
└── tailwind.config.js
```

## 📝 Coding Standards

### TypeScript Guidelines

#### Type Definitions
Always define explicit types for props, state, and function parameters:

```typescript
// ✅ Good
interface TerminalWindowProps {
  id: string;
  initialPosition?: { x: number; y: number };
  onClose?: () => void;
}

// ❌ Avoid
function TerminalWindow(props: any) {
  // ...
}
```

#### Interface vs Type
- Use `interface` for object shapes that might be extended
- Use `type` for unions, primitives, and computed types

```typescript
// ✅ Interface for extensible objects
interface TerminalWindowProps {
  id: string;
  title?: string;
}

// ✅ Type for unions and computed types
type LayoutMode = 'uniform' | 'scattered';
type ThemeColors = keyof TerminalTheme['colors'];
```

#### Strict Type Checking
- Enable strict mode in TypeScript configuration
- Avoid `any` type - use `unknown` if necessary
- Use type assertions sparingly and with type guards

### React Best Practices

#### Component Structure
Follow this order for component elements:

```typescript
// 1. Imports
import { useState, useEffect } from 'react';
import { useTheme } from '../contexts/ThemeContext';

// 2. Types/Interfaces
interface ComponentProps {
  // ...
}

// 3. Component
export function Component({ prop1, prop2 }: ComponentProps) {
  // 4. Hooks (in order of dependency)
  const { currentTheme } = useTheme();
  const [state, setState] = useState(initialValue);
  
  // 5. Event handlers
  const handleClick = () => {
    // ...
  };
  
  // 6. Effects
  useEffect(() => {
    // ...
  }, [dependencies]);
  
  // 7. Render
  return (
    <div>
      {/* JSX */}
    </div>
  );
}
```

#### Hook Guidelines
- Custom hooks should start with `use`
- Keep hooks focused on a single responsibility
- Always clean up side effects

```typescript
// ✅ Good custom hook
export function useTypewriter({ lines, speed }: UseTypewriterProps) {
  const [displayedLines, setDisplayedLines] = useState<TerminalLine[]>([]);
  const timeoutRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  
  useEffect(() => {
    // Animation logic
    
    return () => {
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current);
      }
    };
  }, [lines, speed]);
  
  return { displayedLines };
}
```

#### State Management
- Use Context for global state
- Keep local state close to where it's used
- Prefer `useReducer` for complex state logic

### CSS and Styling

#### Tailwind CSS Usage
- Use utility classes for most styling
- Create custom CSS only when necessary
- Follow mobile-first responsive design

```typescript
// ✅ Good Tailwind usage
<div className="bg-gray-800 border border-gray-600 rounded-lg shadow-lg p-4">
  <h3 className="text-white font-medium text-sm mb-3">Title</h3>
</div>
```

#### CSS Modules
For component-specific styles that can't be achieved with Tailwind:

```css
/* TerminalWindow.css */
.terminal-window {
  @apply relative bg-black border border-gray-600 rounded-lg overflow-hidden;
}

.terminal-cursor {
  animation: blink 1s infinite;
}

@keyframes blink {
  0%, 50% { opacity: 1; }
  51%, 100% { opacity: 0; }
}
```

## 🧪 Testing Standards

### Test Structure
Organize tests alongside source code:

```
src/
├── components/
│   ├── TerminalWindow/
│   │   ├── TerminalWindow.tsx
│   │   ├── TerminalWindow.css
│   │   └── __tests__/
│   │       └── TerminalWindow.test.tsx
```

### Testing Patterns

#### Component Testing
```typescript
import { render, screen, fireEvent } from '@testing-library/react';
import { TerminalWindow } from '../TerminalWindow';
import { renderWithProviders } from '../../../test-utils';

describe('TerminalWindow', () => {
  it('renders with correct title', () => {
    renderWithProviders(
      <TerminalWindow id="test" title="Test Terminal" />
    );
    
    expect(screen.getByText('Test Terminal')).toBeInTheDocument();
  });
  
  it('calls onClose when close button clicked', () => {
    const onClose = vi.fn();
    renderWithProviders(
      <TerminalWindow id="test" onClose={onClose} />
    );
    
    fireEvent.click(screen.getByTitle('Close terminal'));
    expect(onClose).toHaveBeenCalled();
  });
});
```

#### Hook Testing
```typescript
import { renderHook, act } from '@testing-library/react';
import { useTypewriter } from '../useTypewriter';

describe('useTypewriter', () => {
  it('displays lines progressively', async () => {
    const lines = [
      { text: 'Hello' },
      { text: 'World' }
    ];
    
    const { result } = renderHook(() => 
      useTypewriter({ lines, speed: 10 })
    );
    
    expect(result.current.displayedLines).toHaveLength(0);
    
    // Wait for animation
    await act(async () => {
      await new Promise(resolve => setTimeout(resolve, 50));
    });
    
    expect(result.current.displayedLines.length).toBeGreaterThan(0);
  });
});
```

### Test Coverage
- Aim for 80%+ test coverage
- Focus on critical user interactions
- Test error conditions and edge cases

## 🔧 Development Workflow

### Setting Up Development Environment

1. **Clone and Install**:
```bash
git clone https://github.com/Esther-Zhu023/MultiTerminalCodeViz.git
cd MultiTerminalCodeViz
npm install
```

2. **Start Development Server**:
```bash
npm run dev
```

3. **Run Tests**:
```bash
npm run test        # Run tests once
npm run test:ui     # Run tests with UI
npm run test:watch  # Run tests in watch mode
```

### Code Quality Tools

#### ESLint Configuration
The project uses ESLint with TypeScript and React rules:

```javascript
// eslint.config.js
export default tseslint.config(
  { ignores: ['dist'] },
  {
    extends: [js.configs.recommended, ...tseslint.configs.recommended],
    files: ['**/*.{ts,tsx}'],
    plugins: {
      'react-hooks': reactHooks,
      'react-refresh': reactRefresh,
    },
    rules: {
      ...reactHooks.configs.recommended.rules,
      'react-refresh/only-export-components': ['warn', { allowConstantExport: true }],
    },
  },
)
```

#### Prettier Configuration
Code formatting is handled by Prettier:

```bash
npm run format  # Format all files
```

### Git Workflow

#### Branch Naming
- `feature/description` - New features
- `fix/description` - Bug fixes
- `docs/description` - Documentation updates
- `refactor/description` - Code refactoring

#### Commit Messages
Follow conventional commit format:

```
type(scope): description

feat(terminal): add drag and drop functionality
fix(typewriter): resolve animation timing issue
docs(api): update component documentation
test(hooks): add useTypewriter test coverage
```

#### Pull Request Process
1. Create feature branch from `main`
2. Make changes with tests
3. Run linting and tests locally
4. Create pull request with description
5. Address review feedback
6. Merge after approval

## 🚀 Performance Guidelines

### React Performance
- Use `React.memo` for expensive components
- Implement `useMemo` and `useCallback` judiciously
- Avoid creating objects in render functions

```typescript
// ✅ Good - memoized expensive calculation
const expensiveValue = useMemo(() => {
  return computeExpensiveValue(data);
}, [data]);

// ✅ Good - stable callback reference
const handleClick = useCallback(() => {
  onItemClick(item.id);
}, [item.id, onItemClick]);
```

### Animation Performance
- Use CSS transforms for animations
- Prefer `requestAnimationFrame` for complex animations
- Clean up timers and intervals

### Bundle Size
- Use dynamic imports for code splitting
- Analyze bundle with `npm run build && npx vite-bundle-analyzer`
- Remove unused dependencies

## 🐛 Debugging Guidelines

### Development Tools
- **React DevTools**: Component inspection and profiling
- **Browser DevTools**: Network, Performance, Console tabs
- **VS Code Extensions**: ES7+ React/Redux/React-Native snippets

### Common Debugging Patterns
```typescript
// Debug hook dependencies
useEffect(() => {
  console.log('Effect triggered', { lines, speed, enabled });
  // ...
}, [lines, speed, enabled]);

// Debug render cycles
console.log('Component rendering', { props, state });
```

### Error Boundaries
Implement error boundaries for graceful error handling:

```typescript
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true };
  }

  componentDidCatch(error, errorInfo) {
    console.error('Error caught by boundary:', error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return <h1>Something went wrong.</h1>;
    }

    return this.props.children;
  }
}
```

## 📦 Build and Deployment

### Build Process
```bash
npm run build     # Production build
npm run preview   # Preview production build locally
```

### Environment Variables
Create `.env.local` for local development:

```
VITE_API_URL=http://localhost:3000
VITE_ANALYTICS_ID=your-analytics-id
```

### Deployment Checklist
- [ ] All tests passing
- [ ] No TypeScript errors
- [ ] No ESLint warnings
- [ ] Build succeeds
- [ ] Performance audit passed
- [ ] Accessibility audit passed

---

**Ready to contribute?** Check out our [Contributing Guidelines](../CONTRIBUTING.md) and start building awesome features!
