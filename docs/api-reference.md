# API Reference

This document provides detailed documentation for all components, hooks, and utilities in MultiTerminalCodeViz.

## 🧩 Components

### TerminalWindow

A draggable and resizable terminal window component that displays animated typing effects.

#### Props

```typescript
interface TerminalWindowProps {
  id: string;                    // Unique identifier for the terminal
  initialPosition?: { x: number; y: number }; // Starting position
  initialSize?: { width?: number; height?: number }; // Starting size
  title?: string;                // Window title (default: 'Terminal')
  onClose?: () => void;          // Callback when close button clicked
  onPositionChange?: (id: string, position: { x: number; y: number }) => void;
  zIndex?: number;               // Z-index for layering (default: 10)
  onFocus?: (id: string) => void; // Callback when terminal gains focus
  totalTerminalCount?: number;   // Total number of terminals (for speed calculation)
}
```

#### Usage Example

```typescript
<TerminalWindow
  id="terminal-1"
  initialPosition={{ x: 100, y: 100 }}
  title="My Terminal"
  onClose={() => handleClose('terminal-1')}
  onFocus={handleFocus}
  zIndex={15}
/>
```

#### Features

- **Draggable**: Click and drag the title bar to move
- **Resizable**: Drag bottom-right corner to resize
- **Mac-style UI**: Traffic light buttons (red/yellow/green)
- **Animated Typing**: Uses `useTypewriter` hook for text animation
- **Theme Support**: Automatically applies current theme colors

---

### ControlsPanel

The main control interface for adjusting application settings.

#### Props

```typescript
interface ControlsPanelProps {
  terminalCount: number;         // Current number of terminals
  onTerminalCountChange: (count: number) => void; // Terminal count change handler
  onArrangeTerminals?: () => void; // Optional terminal arrangement handler
  minTerminals?: number;         // Minimum terminals (default: 1)
  maxTerminals?: number;         // Maximum terminals (default: 10000)
  catCount?: number;             // Number of bouncy cats
  onRemoveAllCats?: () => void;  // Remove all cats handler
}
```

#### Usage Example

```typescript
<ControlsPanel
  terminalCount={5}
  onTerminalCountChange={setTerminalCount}
  onArrangeTerminals={handleArrange}
  catCount={cats.length}
  onRemoveAllCats={removeAllCats}
/>
```

#### Features

- **Terminal Count Controls**: +/- buttons with validation
- **Theme Selector**: Dropdown with all available themes
- **Speed Slider**: Adjusts typing animation speed
- **Layout Toggle**: Switch between uniform and scattered layouts
- **Hide/Show**: Collapsible panel for clean screenshots
- **YouTube Player**: Integrated audio player for background music

---

### BouncyCat

An animated cat component that bounces around the screen.

#### Props

```typescript
interface BouncyCatProps {
  id: string;           // Unique identifier
  totalCatCount: number; // Total number of cats (affects behavior)
}
```

#### Usage Example

```typescript
<BouncyCat id="cat-1" totalCatCount={3} />
```

#### Features

- **Physics Animation**: Bounces off screen edges
- **Random Movement**: Unpredictable bouncing patterns
- **Auto-cleanup**: Removes itself when appropriate

---

## 🎣 Custom Hooks

### useTypewriter

Handles animated typing effects with token-based animation.

#### Parameters

```typescript
interface UseTypewriterProps {
  lines: TerminalLine[];    // Array of lines to animate
  speed?: number;           // Milliseconds per token (default: 20)
  enabled?: boolean;        // Enable/disable animation (default: true)
  loop?: boolean;           // Loop animation (default: false)
  loopDelay?: number;       // Delay before restarting (default: 2000ms)
}
```

#### Returns

```typescript
interface UseTypewriterReturn {
  displayedLines: TerminalLine[]; // Currently displayed lines
  isTyping: boolean;              // Whether animation is active
  reset: () => void;              // Reset animation to beginning
}
```

#### Usage Example

```typescript
const { displayedLines, isTyping, reset } = useTypewriter({
  lines: terminalOutputs.development,
  speed: 50,
  enabled: true,
  loop: true,
  loopDelay: 3000
});
```

#### Animation Logic

1. **Token-Based**: Animates 3-6 characters at a time (not character-by-character)
2. **Variable Speed**: Each terminal gets ±15% speed variation
3. **Line Delays**: Supports custom delays between lines
4. **Loop Support**: Can restart animation after completion

---

### useTheme

Provides access to theme context and utilities.

#### Returns

```typescript
interface ThemeContextType {
  currentTheme: TerminalTheme;    // Current theme object
  themeName: string;              // Current theme name
  setTheme: (themeName: string) => void; // Theme setter
  getThemeNames: () => string[];  // Available theme names
  getColorForRole: (role: TerminalColorRole) => string; // Color utility
}
```

#### Usage Example

```typescript
const { currentTheme, themeName, setTheme, getColorForRole } = useTheme();

// Apply theme colors
const textColor = getColorForRole('primary');
const accentColor = getColorForRole('accent');

// Change theme
setTheme('matrix');
```

#### Available Color Roles

- `primary`: Main text color
- `secondary`: Secondary text color
- `accent`: Highlight color
- `muted`: Dimmed text color
- `success`: Success message color
- `warning`: Warning message color
- `error`: Error message color
- `command`: Command prompt color

---

### useAppContext

Provides access to global application state.

#### Returns

```typescript
interface AppContextProps {
  // State
  numWindows: number;
  layout: LayoutMode;
  speed: number;
  theme: ThemeMode;
  controlsVisible: boolean;
  
  // Setters
  setNumWindows: (num: number | ((prev: number) => number)) => void;
  setLayout: Dispatch<SetStateAction<LayoutMode>>;
  setSpeed: (speed: number | ((prev: number) => number)) => void;
  setTheme: Dispatch<SetStateAction<ThemeMode>>;
  setControlsVisible: Dispatch<SetStateAction<boolean>>;
  
  // Utilities
  toggleLayout: () => void;
  toggleTheme: () => void;
  toggleControlsVisible: () => void;
}
```

#### Usage Example

```typescript
const { 
  numWindows, 
  setNumWindows, 
  speed, 
  setSpeed,
  toggleLayout 
} = useAppContext();

// Update terminal count
setNumWindows(prev => prev + 1);

// Toggle layout mode
toggleLayout();
```

---

## 📊 Data Types

### TerminalLine

Represents a single line of terminal output.

```typescript
interface TerminalLine {
  text: string;                    // The text content
  colorRole?: TerminalColorRole;   // Color role for theming
  bold?: boolean;                  // Bold text flag
  delay?: number;                  // Delay before showing line (ms)
}
```

### TerminalTheme

Defines a complete color theme.

```typescript
interface TerminalTheme {
  name: string;                    // Theme display name
  background: string;              // Background CSS class
  colors: {
    primary: string;               // Primary text color
    secondary: string;             // Secondary text color
    accent: string;                // Accent color
    muted: string;                 // Muted text color
    success: string;               // Success color
    warning: string;               // Warning color
    error: string;                 // Error color
    command: string;               // Command color
  };
}
```

### Layout Types

```typescript
type LayoutMode = 'uniform' | 'scattered';
type ThemeMode = 'dark' | 'light';
```

---

## 🛠️ Utility Functions

### generateMultiLineAsciiArt

Generates ASCII art from text arrays.

```typescript
function generateMultiLineAsciiArt(lines: string[]): string[]
```

#### Usage Example

```typescript
const asciiArt = generateMultiLineAsciiArt(['HELLO', 'WORLD']);
// Returns array of ASCII art lines
```

### generateRandomPosition

Generates random position within viewport bounds.

```typescript
function generateRandomPosition(): { x: number; y: number }
```

---

## 🎨 CSS Classes

### Terminal Window Classes

- `.terminal-window`: Base terminal styling
- `.terminal-title-bar`: Title bar styling
- `.terminal-content`: Content area styling
- `.terminal-cursor`: Blinking cursor animation

### Animation Classes

- `.typewriter-cursor`: Cursor blink animation
- `.bounce-animation`: Bouncy cat animation
- `.fade-in`: Fade in transition

---

## 🧪 Testing Utilities

### Test Helpers

```typescript
// Mock context providers for testing
function renderWithProviders(component: ReactElement) {
  return render(
    <ThemeProvider>
      <AppProvider>
        {component}
      </AppProvider>
    </ThemeProvider>
  );
}
```

### Common Test Patterns

```typescript
// Test component rendering
test('renders terminal window', () => {
  renderWithProviders(<TerminalWindow id="test" />);
  expect(screen.getByRole('dialog')).toBeInTheDocument();
});

// Test context updates
test('updates terminal count', () => {
  const { result } = renderHook(() => useAppContext(), {
    wrapper: AppProvider
  });
  
  act(() => {
    result.current.setNumWindows(5);
  });
  
  expect(result.current.numWindows).toBe(5);
});
```

---

**Next Steps**: Ready to start developing? Check out the [Development Guide](development-guide.md) for coding standards and contribution guidelines!
