# Architecture Overview

This document explains the high-level architecture of MultiTerminalCodeViz, how components interact, and the data flow throughout the application.

## 🏗️ System Architecture

MultiTerminalCodeViz follows a modern React architecture with these key principles:

- **Component-Based**: UI built from reusable, composable components
- **Context-Driven State**: Global state managed through React Context
- **Hook-Based Logic**: Custom hooks for complex behaviors
- **TypeScript First**: Full type safety throughout the application

## 📊 High-Level Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                        App.tsx                              │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐ │
│  │  ThemeProvider  │  │   AppProvider   │  │   Router    │ │
│  └─────────────────┘  └─────────────────┘  └─────────────┘ │
└─────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────┐
│                     AppContent                              │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐ │
│  │ ControlsPanel   │  │ TerminalWindow  │  │ BouncyCat   │ │
│  │                 │  │    (Multiple)   │  │ (Multiple)  │ │
│  └─────────────────┘  └─────────────────┘  └─────────────┘ │
└─────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────┐
│                    Custom Hooks                            │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐ │
│  │  useTypewriter  │  │    useTheme     │  │  useAppContext│ │
│  └─────────────────┘  └─────────────────┘  └─────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## 🧩 Core Components

### App.tsx - Application Root
**Purpose**: Main application container and routing setup

**Key Responsibilities**:
- Provides global context providers (Theme, App state)
- Sets up React Router for navigation
- Renders the main application content

<augment_code_snippet path="src/App.tsx" mode="EXCERPT">
````typescript
function App() {
  return (
    <ThemeProvider>
      <AppProvider>
        <Router>
          <Routes>
            <Route path="/" element={<AppContent />} />
            <Route path="/typer" element={<AsciiTyper />} />
          </Routes>
          <Analytics />
        </Router>
      </AppProvider>
    </ThemeProvider>
  );
}
````
</augment_code_snippet>

### AppContent - Main Application Logic
**Purpose**: Manages terminal state and layout

**Key Responsibilities**:
- Terminal creation, positioning, and removal
- Z-index management for window layering
- Bouncy cat spawning logic
- Event handling for terminal interactions

### TerminalWindow - Individual Terminal Component
**Purpose**: Renders a single draggable, resizable terminal

**Key Features**:
- Mac-style terminal appearance with traffic lights
- Draggable and resizable functionality
- Typewriter animation integration
- Theme-aware styling

<augment_code_snippet path="src/components/TerminalWindow/TerminalWindow.tsx" mode="EXCERPT">
````typescript
export function TerminalWindow({
  id,
  initialPosition = { x: 0, y: 0 },
  title = 'Terminal',
  onClose,
  onPositionChange,
  zIndex = 10,
  onFocus,
  totalTerminalCount = 1
}: TerminalWindowProps) {
````
</augment_code_snippet>

### ControlsPanel - User Interface Controls
**Purpose**: Provides user controls for customizing the experience

**Features**:
- Terminal count adjustment (+/- buttons)
- Theme selection dropdown
- Speed control slider
- Layout mode toggle
- YouTube audio player integration

## 🔄 State Management

### Context Architecture

The application uses React Context for global state management:

#### AppContext
**Purpose**: Manages application-wide settings

**State Properties**:
- `numWindows`: Number of terminal windows (1-100)
- `layout`: Layout mode ('uniform' | 'scattered')
- `speed`: Animation speed (1-20 chunks/second)
- `theme`: Color theme selection
- `controlsVisible`: Controls panel visibility

<augment_code_snippet path="src/contexts/AppContext.tsx" mode="EXCERPT">
````typescript
interface AppState {
  numWindows: number;
  layout: LayoutMode;
  speed: number; // 1-20 chunks/s
  theme: ThemeMode;
  controlsVisible: boolean;
}
````
</augment_code_snippet>

#### ThemeContext
**Purpose**: Manages color themes and styling

**Features**:
- Multiple predefined themes (Matrix, Cyberpunk, Retro, etc.)
- Dynamic color role mapping
- Theme switching functionality

## 🎣 Custom Hooks

### useTypewriter Hook
**Purpose**: Handles animated typing effects

**Key Features**:
- Token-based animation (3-6 characters at a time)
- Variable speed control
- Loop functionality with delays
- Cleanup on component unmount

<augment_code_snippet path="src/hooks/useTypewriter.ts" mode="EXCERPT">
````typescript
export function useTypewriter({ 
  lines, 
  speed = 20,
  enabled = true, 
  loop = false,
  loopDelay = 2000 
}: UseTypewriterProps) {
````
</augment_code_snippet>

**Animation Logic**:
1. Processes text in "tokens" (chunks of 3-6 characters)
2. Each terminal has randomized speed (±15% variation)
3. Supports delays between lines
4. Loops content when enabled

### useTheme Hook
**Purpose**: Provides theme context access

**Returns**:
- Current theme object
- Theme switching functions
- Color role utilities

## 📊 Data Flow

### Terminal Creation Flow
```
User clicks '+' button
       ↓
ControlsPanel calls onTerminalCountChange
       ↓
AppContent updates terminal count
       ↓
New Terminal components rendered
       ↓
Each terminal starts typewriter animation
```

### Theme Change Flow
```
User selects new theme
       ↓
ControlsPanel calls setTheme
       ↓
ThemeContext updates current theme
       ↓
All components re-render with new colors
```

### Animation Flow
```
TerminalWindow mounts
       ↓
useTypewriter hook initializes
       ↓
Timer starts with randomized speed
       ↓
Text appears in token chunks
       ↓
Loop restarts after completion
```

## 🎨 Styling Architecture

### Tailwind CSS Integration
- **Utility-First**: Classes applied directly to components
- **Theme Integration**: Custom colors defined in theme context
- **Responsive Design**: Mobile-friendly breakpoints

### CSS Modules
- **Component-Specific**: Each component has its own CSS file
- **Scoped Styles**: Prevents style conflicts
- **Animation Definitions**: Custom animations for terminals

## 🧪 Testing Strategy

### Component Testing
- **React Testing Library**: User-centric testing approach
- **Vitest**: Fast test runner with ES modules support
- **Mock Strategies**: Context providers and external dependencies

### Test Structure
```
src/
├── components/
│   └── __tests__/
├── contexts/
│   └── __tests__/
├── hooks/
│   └── __tests__/
└── utils/
    └── __tests__/
```

## 🚀 Build & Deployment

### Development Build
- **Vite Dev Server**: Hot module replacement
- **TypeScript Compilation**: Real-time type checking
- **ESLint Integration**: Code quality enforcement

### Production Build
- **Vite Build**: Optimized bundle creation
- **Code Splitting**: Automatic chunk optimization
- **Asset Optimization**: Image and CSS minification

### Deployment Targets
- **Vercel**: Primary deployment platform
- **Docker**: Containerized deployment option
- **Static Hosting**: Any static file server

## 🔧 Configuration Files

### Key Configuration Files
- `vite.config.ts`: Build tool configuration
- `tsconfig.json`: TypeScript compiler options
- `tailwind.config.js`: CSS framework configuration
- `eslint.config.js`: Code linting rules

## 📈 Performance Considerations

### Optimization Strategies
- **Virtual Scrolling**: For large numbers of terminals
- **Component Memoization**: Prevents unnecessary re-renders
- **Lazy Loading**: Code splitting for better initial load
- **Animation Throttling**: Prevents performance degradation

### Memory Management
- **Cleanup Timers**: useTypewriter properly cleans up intervals
- **Component Unmounting**: Proper cleanup in useEffect hooks
- **State Optimization**: Minimal state updates

---

**Next Steps**: Now that you understand the architecture, explore the [API Reference](api-reference.md) for detailed component documentation!
