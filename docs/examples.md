# Examples and Use Cases

This guide provides practical examples and tutorials for using and extending MultiTerminalCodeViz.

## 🎯 Basic Usage Examples

### Creating Your First Terminal Setup

Here's how to create a basic setup with multiple terminals:

```typescript
import { useState } from 'react';
import { TerminalWindow } from './components/TerminalWindow/TerminalWindow';

function BasicExample() {
  const [terminals, setTerminals] = useState([
    { id: 'terminal-1', position: { x: 100, y: 100 } },
    { id: 'terminal-2', position: { x: 300, y: 200 } },
    { id: 'terminal-3', position: { x: 500, y: 300 } }
  ]);

  const handleClose = (id: string) => {
    setTerminals(prev => prev.filter(t => t.id !== id));
  };

  return (
    <div className="relative w-full h-screen bg-gray-900">
      {terminals.map(terminal => (
        <TerminalWindow
          key={terminal.id}
          id={terminal.id}
          initialPosition={terminal.position}
          title={`Terminal ${terminal.id.split('-')[1]}`}
          onClose={() => handleClose(terminal.id)}
        />
      ))}
    </div>
  );
}
```

### Custom Terminal Content

Create terminals with custom content and animations:

```typescript
import { terminalOutputs } from '../data/terminalOutputs';

// Custom terminal outputs
const customOutputs = {
  myCustomScript: [
    { text: "$ npm run custom-script", colorRole: "command" },
    { text: "Starting custom process...", colorRole: "accent", delay: 500 },
    { text: "✓ Process completed successfully", colorRole: "success", delay: 1000 },
  ]
};

function CustomTerminal() {
  return (
    <TerminalWindow
      id="custom-terminal"
      title="Custom Script"
      initialPosition={{ x: 200, y: 150 }}
      // The terminal will automatically cycle through available outputs
    />
  );
}
```

## 🎨 Theming Examples

### Creating Custom Themes

Add your own color themes to the application:

```typescript
// src/data/colorThemes.ts
export const customThemes = {
  neonGreen: {
    name: 'Neon Green',
    background: 'bg-black',
    colors: {
      primary: 'text-green-400',
      secondary: 'text-green-300',
      accent: 'text-green-200',
      muted: 'text-green-600',
      success: 'text-green-300',
      warning: 'text-yellow-400',
      error: 'text-red-400',
      command: 'text-green-100'
    }
  },
  oceanBlue: {
    name: 'Ocean Blue',
    background: 'bg-blue-900',
    colors: {
      primary: 'text-blue-100',
      secondary: 'text-blue-200',
      accent: 'text-cyan-300',
      muted: 'text-blue-400',
      success: 'text-green-400',
      warning: 'text-yellow-300',
      error: 'text-red-300',
      command: 'text-cyan-200'
    }
  }
};

// Merge with existing themes
export const allThemes = {
  ...terminalThemes,
  ...customThemes
};
```

### Using Themes in Components

```typescript
import { useTheme } from '../contexts/ThemeContext';

function ThemedComponent() {
  const { currentTheme, getColorForRole, setTheme } = useTheme();

  return (
    <div className={`${currentTheme.background} p-4 rounded`}>
      <h2 className={`${getColorForRole('primary')} text-xl font-bold`}>
        Themed Header
      </h2>
      <p className={`${getColorForRole('secondary')} mt-2`}>
        This text uses the secondary color from the current theme.
      </p>
      
      <button
        onClick={() => setTheme('neonGreen')}
        className={`${getColorForRole('accent')} border border-current px-4 py-2 mt-4 rounded hover:bg-current hover:text-black transition-colors`}
      >
        Switch to Neon Green
      </button>
    </div>
  );
}
```

## 🎬 Animation Examples

### Custom Typewriter Effects

Create your own typewriter animations with different behaviors:

```typescript
import { useTypewriter } from '../hooks/useTypewriter';

function CustomTypewriterExample() {
  // Fast typing for urgent messages
  const urgentMessages = [
    { text: "🚨 URGENT: System alert detected!", colorRole: "error", bold: true },
    { text: "Initiating emergency protocols...", colorRole: "warning", delay: 200 },
    { text: "✓ All systems secure", colorRole: "success", delay: 1000 }
  ];

  const { displayedLines: urgentLines } = useTypewriter({
    lines: urgentMessages,
    speed: 10, // Very fast
    enabled: true,
    loop: false
  });

  // Slow, dramatic typing
  const dramaticMessages = [
    { text: "In the beginning...", colorRole: "muted", delay: 1000 },
    { text: "There was code.", colorRole: "primary", delay: 2000 },
    { text: "And the code was good.", colorRole: "accent", delay: 2000 }
  ];

  const { displayedLines: dramaticLines } = useTypewriter({
    lines: dramaticMessages,
    speed: 100, // Very slow
    enabled: true,
    loop: true,
    loopDelay: 5000
  });

  return (
    <div className="grid grid-cols-2 gap-4 p-4">
      <div className="bg-red-900 p-4 rounded">
        <h3 className="text-red-100 font-bold mb-2">Urgent Terminal</h3>
        <div className="font-mono text-sm">
          {urgentLines.map((line, index) => (
            <div key={index} className={`${line.colorRole ? getColorForRole(line.colorRole) : 'text-white'} ${line.bold ? 'font-bold' : ''}`}>
              {line.text}
            </div>
          ))}
        </div>
      </div>

      <div className="bg-gray-800 p-4 rounded">
        <h3 className="text-gray-100 font-bold mb-2">Dramatic Terminal</h3>
        <div className="font-mono text-sm">
          {dramaticLines.map((line, index) => (
            <div key={index} className={`${line.colorRole ? getColorForRole(line.colorRole) : 'text-white'}`}>
              {line.text}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
```

### Synchronized Animations

Create multiple terminals that animate in sync:

```typescript
function SynchronizedTerminals() {
  const [startAnimation, setStartAnimation] = useState(false);
  
  const sharedLines = [
    { text: "$ git clone https://github.com/user/repo.git", colorRole: "command" },
    { text: "Cloning into 'repo'...", colorRole: "muted", delay: 500 },
    { text: "✓ Repository cloned successfully", colorRole: "success", delay: 1000 }
  ];

  const terminals = [
    { id: 'sync-1', position: { x: 100, y: 100 } },
    { id: 'sync-2', position: { x: 400, y: 100 } },
    { id: 'sync-3', position: { x: 700, y: 100 } }
  ];

  return (
    <div className="relative w-full h-screen bg-gray-900">
      <button
        onClick={() => setStartAnimation(!startAnimation)}
        className="absolute top-4 left-4 z-50 bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700"
      >
        {startAnimation ? 'Stop' : 'Start'} Sync Animation
      </button>

      {terminals.map(terminal => (
        <SyncTerminal
          key={terminal.id}
          id={terminal.id}
          position={terminal.position}
          lines={sharedLines}
          enabled={startAnimation}
        />
      ))}
    </div>
  );
}

function SyncTerminal({ id, position, lines, enabled }) {
  const { displayedLines } = useTypewriter({
    lines,
    speed: 30,
    enabled,
    loop: false
  });

  return (
    <div 
      className="absolute bg-black border border-gray-600 rounded p-4 w-80 h-60"
      style={{ left: position.x, top: position.y }}
    >
      <div className="text-green-400 font-mono text-sm">
        {displayedLines.map((line, index) => (
          <div key={index} className={getColorForRole(line.colorRole || 'primary')}>
            {line.text}
          </div>
        ))}
      </div>
    </div>
  );
}
```

## 🎮 Interactive Examples

### Terminal with User Input

Create an interactive terminal that responds to user input:

```typescript
function InteractiveTerminal() {
  const [history, setHistory] = useState<string[]>([
    'Welcome to Interactive Terminal',
    'Type "help" for available commands'
  ]);
  const [currentInput, setCurrentInput] = useState('');

  const commands = {
    help: () => [
      'Available commands:',
      '  help - Show this help message',
      '  clear - Clear the terminal',
      '  date - Show current date',
      '  echo <message> - Echo a message'
    ],
    clear: () => {
      setHistory([]);
      return [];
    },
    date: () => [new Date().toLocaleString()],
    echo: (args: string[]) => [args.join(' ')]
  };

  const handleCommand = (input: string) => {
    const [command, ...args] = input.trim().split(' ');
    const cmd = commands[command as keyof typeof commands];
    
    if (cmd) {
      const output = cmd(args);
      setHistory(prev => [...prev, `$ ${input}`, ...output]);
    } else {
      setHistory(prev => [...prev, `$ ${input}`, `Command not found: ${command}`]);
    }
    setCurrentInput('');
  };

  return (
    <div className="bg-black border border-gray-600 rounded p-4 w-96 h-80 font-mono text-sm">
      <div className="text-green-400 h-64 overflow-y-auto mb-2">
        {history.map((line, index) => (
          <div key={index}>{line}</div>
        ))}
      </div>
      
      <div className="flex items-center text-green-400">
        <span className="mr-2">$</span>
        <input
          type="text"
          value={currentInput}
          onChange={(e) => setCurrentInput(e.target.value)}
          onKeyPress={(e) => {
            if (e.key === 'Enter') {
              handleCommand(currentInput);
            }
          }}
          className="flex-1 bg-transparent outline-none text-green-400"
          placeholder="Enter command..."
        />
      </div>
    </div>
  );
}
```

### Terminal Grid Layout

Create a responsive grid of terminals:

```typescript
function TerminalGrid() {
  const [gridSize, setGridSize] = useState({ rows: 2, cols: 3 });
  const [terminals, setTerminals] = useState<Array<{id: string, content: string}>>([]);

  useEffect(() => {
    const newTerminals = [];
    for (let i = 0; i < gridSize.rows * gridSize.cols; i++) {
      newTerminals.push({
        id: `grid-terminal-${i}`,
        content: `Terminal ${i + 1}`
      });
    }
    setTerminals(newTerminals);
  }, [gridSize]);

  const calculatePosition = (index: number) => {
    const row = Math.floor(index / gridSize.cols);
    const col = index % gridSize.cols;
    const terminalWidth = 300;
    const terminalHeight = 200;
    const padding = 20;
    
    return {
      x: col * (terminalWidth + padding) + padding,
      y: row * (terminalHeight + padding) + padding + 60 // Account for controls
    };
  };

  return (
    <div className="relative w-full h-screen bg-gray-900">
      {/* Grid Controls */}
      <div className="absolute top-4 left-4 z-50 bg-gray-800 p-4 rounded border border-gray-600">
        <h3 className="text-white font-bold mb-2">Grid Layout</h3>
        <div className="flex items-center space-x-4">
          <label className="text-white text-sm">
            Rows:
            <input
              type="number"
              min="1"
              max="5"
              value={gridSize.rows}
              onChange={(e) => setGridSize(prev => ({ ...prev, rows: parseInt(e.target.value) }))}
              className="ml-2 w-16 px-2 py-1 bg-gray-700 text-white rounded"
            />
          </label>
          <label className="text-white text-sm">
            Cols:
            <input
              type="number"
              min="1"
              max="5"
              value={gridSize.cols}
              onChange={(e) => setGridSize(prev => ({ ...prev, cols: parseInt(e.target.value) }))}
              className="ml-2 w-16 px-2 py-1 bg-gray-700 text-white rounded"
            />
          </label>
        </div>
      </div>

      {/* Terminal Grid */}
      {terminals.map((terminal, index) => (
        <TerminalWindow
          key={terminal.id}
          id={terminal.id}
          title={terminal.content}
          initialPosition={calculatePosition(index)}
          initialSize={{ width: 300, height: 200 }}
        />
      ))}
    </div>
  );
}
```

## 🎪 Fun Examples

### Matrix Rain Effect

Create a Matrix-style digital rain effect:

```typescript
function MatrixRain() {
  const [drops, setDrops] = useState<Array<{id: number, x: number, chars: string[]}>>([]);

  useEffect(() => {
    const characters = 'アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン0123456789';
    
    const createDrop = (id: number) => ({
      id,
      x: Math.random() * window.innerWidth,
      chars: Array.from({ length: 20 }, () => 
        characters[Math.floor(Math.random() * characters.length)]
      )
    });

    // Initialize drops
    const initialDrops = Array.from({ length: 50 }, (_, i) => createDrop(i));
    setDrops(initialDrops);

    // Animate drops
    const interval = setInterval(() => {
      setDrops(prev => prev.map(drop => ({
        ...drop,
        chars: drop.chars.map(() => 
          characters[Math.floor(Math.random() * characters.length)]
        )
      })));
    }, 100);

    return () => clearInterval(interval);
  }, []);

  return (
    <div className="fixed inset-0 bg-black overflow-hidden">
      {drops.map(drop => (
        <div
          key={drop.id}
          className="absolute text-green-400 font-mono text-sm opacity-80"
          style={{
            left: drop.x,
            animation: `fall ${3 + Math.random() * 2}s linear infinite`,
            animationDelay: `${Math.random() * 2}s`
          }}
        >
          {drop.chars.map((char, index) => (
            <div
              key={index}
              style={{
                opacity: 1 - (index * 0.05),
                color: index === 0 ? '#ffffff' : '#00ff00'
              }}
            >
              {char}
            </div>
          ))}
        </div>
      ))}
      
      <style jsx>{`
        @keyframes fall {
          to {
            transform: translateY(100vh);
          }
        }
      `}</style>
    </div>
  );
}
```

### Terminal Screensaver

Create a screensaver mode with floating terminals:

```typescript
function TerminalScreensaver() {
  const [isActive, setIsActive] = useState(false);
  const [floatingTerminals, setFloatingTerminals] = useState<Array<{
    id: string;
    x: number;
    y: number;
    vx: number;
    vy: number;
  }>>([]);

  useEffect(() => {
    if (!isActive) return;

    // Create floating terminals
    const terminals = Array.from({ length: 5 }, (_, i) => ({
      id: `float-${i}`,
      x: Math.random() * (window.innerWidth - 300),
      y: Math.random() * (window.innerHeight - 200),
      vx: (Math.random() - 0.5) * 2,
      vy: (Math.random() - 0.5) * 2
    }));
    setFloatingTerminals(terminals);

    // Animate floating terminals
    const interval = setInterval(() => {
      setFloatingTerminals(prev => prev.map(terminal => {
        let { x, y, vx, vy } = terminal;
        
        x += vx;
        y += vy;
        
        // Bounce off edges
        if (x <= 0 || x >= window.innerWidth - 300) vx = -vx;
        if (y <= 0 || y >= window.innerHeight - 200) vy = -vy;
        
        return { ...terminal, x, y, vx, vy };
      }));
    }, 16); // 60fps

    return () => clearInterval(interval);
  }, [isActive]);

  return (
    <div className="relative w-full h-screen bg-black">
      <button
        onClick={() => setIsActive(!isActive)}
        className="absolute top-4 left-4 z-50 bg-purple-600 text-white px-4 py-2 rounded hover:bg-purple-700"
      >
        {isActive ? 'Stop' : 'Start'} Screensaver
      </button>

      {isActive && floatingTerminals.map(terminal => (
        <div
          key={terminal.id}
          className="absolute transition-none"
          style={{
            left: terminal.x,
            top: terminal.y,
            transform: 'translate3d(0, 0, 0)' // Hardware acceleration
          }}
        >
          <TerminalWindow
            id={terminal.id}
            title="Floating Terminal"
            initialSize={{ width: 300, height: 200 }}
          />
        </div>
      ))}
    </div>
  );
}
```

## 🚀 Advanced Use Cases

### Terminal Recording and Playback

Record terminal sessions and play them back:

```typescript
interface TerminalRecording {
  timestamp: number;
  action: 'type' | 'clear' | 'command';
  data: string;
}

function RecordableTerminal() {
  const [recording, setRecording] = useState<TerminalRecording[]>([]);
  const [isRecording, setIsRecording] = useState(false);
  const [isPlaying, setIsPlaying] = useState(false);

  const recordAction = (action: TerminalRecording['action'], data: string) => {
    if (isRecording) {
      setRecording(prev => [...prev, {
        timestamp: Date.now(),
        action,
        data
      }]);
    }
  };

  const playRecording = async () => {
    if (recording.length === 0) return;
    
    setIsPlaying(true);
    const startTime = recording[0].timestamp;
    
    for (const action of recording) {
      const delay = action.timestamp - startTime;
      await new Promise(resolve => setTimeout(resolve, delay));
      
      // Execute the recorded action
      switch (action.action) {
        case 'type':
          // Simulate typing
          break;
        case 'command':
          // Execute command
          break;
        case 'clear':
          // Clear terminal
          break;
      }
    }
    
    setIsPlaying(false);
  };

  return (
    <div className="p-4">
      <div className="mb-4 space-x-2">
        <button
          onClick={() => setIsRecording(!isRecording)}
          className={`px-4 py-2 rounded ${isRecording ? 'bg-red-600' : 'bg-green-600'} text-white`}
        >
          {isRecording ? 'Stop Recording' : 'Start Recording'}
        </button>
        
        <button
          onClick={playRecording}
          disabled={recording.length === 0 || isPlaying}
          className="px-4 py-2 rounded bg-blue-600 text-white disabled:opacity-50"
        >
          {isPlaying ? 'Playing...' : 'Play Recording'}
        </button>
        
        <button
          onClick={() => setRecording([])}
          className="px-4 py-2 rounded bg-gray-600 text-white"
        >
          Clear Recording
        </button>
      </div>

      <div className="text-sm text-gray-600 mb-4">
        Recording: {recording.length} actions
      </div>

      {/* Your terminal component here */}
    </div>
  );
}
```

---

**Ready to build something amazing?** These examples should give you a solid foundation for creating your own terminal experiences. Check out the [API Reference](api-reference.md) for more detailed information about available components and hooks!
