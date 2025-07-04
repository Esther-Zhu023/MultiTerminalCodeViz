# Getting Started Guide

This guide will help you set up MultiTerminalCodeViz on your local machine, whether you're a beginner or experienced developer.

## 📋 Prerequisites

### Required Knowledge
- **Basic JavaScript/TypeScript**: Understanding of variables, functions, and objects
- **React Fundamentals**: Components, props, state, and hooks
- **Command Line Basics**: Running commands in terminal/command prompt
- **Git Basics**: Cloning repositories and basic version control

### System Requirements
- **Node.js**: Version 18.0 or higher
- **npm**: Version 8.0 or higher (comes with Node.js)
- **Git**: For cloning the repository
- **Modern Web Browser**: Chrome, Firefox, Safari, or Edge

### Recommended Tools
- **VS Code**: With React and TypeScript extensions
- **React Developer Tools**: Browser extension for debugging
- **Git GUI**: GitHub Desktop, SourceTree, or similar (optional)

## 🔧 Installation

### Step 1: Verify Prerequisites

First, check that you have the required tools installed:

```bash
# Check Node.js version (should be 18+)
node --version

# Check npm version (should be 8+)
npm --version

# Check Git version
git --version
```

If any of these commands fail, install the missing tools:
- **Node.js**: Download from [nodejs.org](https://nodejs.org/)
- **Git**: Download from [git-scm.com](https://git-scm.com/)

### Step 2: Clone the Repository

```bash
# Clone the repository
git clone https://github.com/Esther-Zhu023/MultiTerminalCodeViz.git

# Navigate to the project directory
cd MultiTerminalCodeViz

# Verify you're in the right directory
ls -la
```

You should see files like `package.json`, `src/`, `docs/`, etc.

### Step 3: Install Dependencies

```bash
# Install all project dependencies
npm install

# This will create node_modules/ and package-lock.json
```

**What's happening?** npm reads `package.json` and installs all required packages including React, TypeScript, Vite, and testing tools.

### Step 4: Start Development Server

```bash
# Start the development server
npm run dev
```

You should see output like:
```
  VITE v5.2.0  ready in 1234 ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: use --host to expose
```

### Step 5: Open in Browser

1. Open your web browser
2. Navigate to `http://localhost:5173`
3. You should see the MultiTerminalCodeViz application!

## 🎮 First Steps

### Understanding the Interface

When you first open the app, you'll see:

1. **Background**: A macOS Sonoma-style wallpaper
2. **Terminal Window**: One draggable terminal with animated typing
3. **Controls Panel**: Top-left panel with various options
4. **ASCII Art**: "I VIBE MORE THAN YOU" header in each terminal

### Basic Controls

**Terminal Count**:
- Use `+` and `-` buttons to add/remove terminals
- Range: 1 to 10,000+ terminals (be careful with high numbers!)

**Themes**:
- Dropdown menu with different color schemes
- Try "Matrix", "Cyberpunk", or "Retro" themes

**Layout**:
- **Uniform**: Terminals arrange in a grid
- **Scattered**: Random positions

**Speed Control**:
- Slider to adjust typing animation speed
- Range: 1 (slow) to 20 (fast) chunks per second

### Try These Experiments

1. **Add More Terminals**: Click `+` several times and watch the grid adjust
2. **Change Themes**: Switch between different color schemes
3. **Adjust Speed**: Move the speed slider and observe the typing changes
4. **Drag Terminals**: Click and drag terminal windows around
5. **Resize Terminals**: Drag the bottom-right corner of any terminal
6. **Hide Controls**: Click the hide button for clean screenshots

## 🧪 Development Commands

```bash
# Start development server with hot reload
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Run tests
npm run test

# Run tests with UI
npm run test:ui

# Lint code
npm run lint

# Format code
npm run format
```

## 🐛 Common Issues

### Port Already in Use
If you see "Port 5173 is already in use":
```bash
# Kill the process using the port
npx kill-port 5173

# Or use a different port
npm run dev -- --port 3000
```

### Node Version Issues
If you get Node.js version errors:
```bash
# Check your Node version
node --version

# Update Node.js if needed (use nvm if available)
nvm install 18
nvm use 18
```

### Dependencies Not Installing
If `npm install` fails:
```bash
# Clear npm cache
npm cache clean --force

# Delete node_modules and try again
rm -rf node_modules package-lock.json
npm install
```

### TypeScript Errors
If you see TypeScript compilation errors:
```bash
# Check TypeScript configuration
npx tsc --noEmit

# Restart your IDE/editor
# VS Code: Ctrl+Shift+P -> "TypeScript: Restart TS Server"
```

## 🎯 Next Steps

Now that you have the project running:

1. **Explore the Code**: Look at `src/App.tsx` to understand the main component
2. **Read the Architecture Guide**: Learn how components work together
3. **Try Making Changes**: Modify colors, text, or animations
4. **Run Tests**: Ensure everything works with `npm run test`
5. **Check Examples**: See real-world usage patterns

## 🆘 Getting Help

If you're stuck:

1. **Check the Console**: Open browser dev tools (F12) for error messages
2. **Read Error Messages**: They often contain helpful information
3. **Search Issues**: Check GitHub issues for similar problems
4. **Ask Questions**: Create a new issue or discussion

**Congratulations!** 🎉 You now have MultiTerminalCodeViz running locally. Ready to explore the codebase? Check out the [Architecture Guide](architecture.md) next!
