# Contributing to MultiTerminalCodeViz

Thank you for your interest in contributing to MultiTerminalCodeViz! This document provides guidelines and information for contributors.

## 🎯 How to Contribute

We welcome contributions of all kinds:

- 🐛 **Bug Reports**: Help us identify and fix issues
- 💡 **Feature Requests**: Suggest new features or improvements
- 📝 **Documentation**: Improve or add documentation
- 🔧 **Code Contributions**: Fix bugs or implement new features
- 🎨 **Design**: Improve UI/UX or create new themes
- 🧪 **Testing**: Add or improve test coverage

## 🚀 Getting Started

### 1. Fork and Clone

```bash
# Fork the repository on GitHub, then clone your fork
git clone https://github.com/YOUR_USERNAME/MultiTerminalCodeViz.git
cd MultiTerminalCodeViz

# Add the original repository as upstream
git remote add upstream https://github.com/Esther-Zhu023/MultiTerminalCodeViz.git
```

### 2. Set Up Development Environment

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Run tests
npm run test

# Check code quality
npm run lint
npm run format
```

### 3. Create a Branch

```bash
# Create and switch to a new branch
git checkout -b feature/your-feature-name

# Or for bug fixes
git checkout -b fix/issue-description
```

## 📋 Development Guidelines

### Code Style

We use ESLint and Prettier to maintain consistent code style:

```bash
# Check linting
npm run lint

# Auto-fix linting issues
npm run lint -- --fix

# Format code
npm run format
```

### TypeScript Standards

- **Always use TypeScript**: No plain JavaScript files
- **Explicit types**: Define interfaces for props and complex objects
- **Strict mode**: Follow strict TypeScript configuration
- **No `any`**: Use proper types or `unknown` if necessary

```typescript
// ✅ Good
interface ComponentProps {
  title: string;
  count?: number;
  onUpdate: (value: number) => void;
}

// ❌ Avoid
function Component(props: any) {
  // ...
}
```

### React Best Practices

- **Functional Components**: Use function components with hooks
- **Custom Hooks**: Extract reusable logic into custom hooks
- **Memoization**: Use `React.memo`, `useMemo`, and `useCallback` appropriately
- **Error Boundaries**: Handle errors gracefully

### Testing Requirements

All contributions should include appropriate tests:

```bash
# Run tests
npm run test

# Run tests with coverage
npm run test -- --coverage

# Run tests in watch mode
npm run test -- --watch
```

**Test Coverage Requirements**:
- New features: 80%+ test coverage
- Bug fixes: Include regression tests
- Components: Test user interactions and edge cases

### Commit Message Format

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
type(scope): description

[optional body]

[optional footer]
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples**:
```
feat(terminal): add drag and drop functionality
fix(typewriter): resolve animation timing issue
docs(api): update component documentation
test(hooks): add useTypewriter test coverage
```

## 🐛 Bug Reports

When reporting bugs, please include:

### Bug Report Template

```markdown
## Bug Description
A clear description of what the bug is.

## Steps to Reproduce
1. Go to '...'
2. Click on '...'
3. Scroll down to '...'
4. See error

## Expected Behavior
What you expected to happen.

## Actual Behavior
What actually happened.

## Environment
- OS: [e.g., macOS 12.0]
- Browser: [e.g., Chrome 95.0]
- Node.js: [e.g., 18.0.0]
- npm: [e.g., 8.0.0]

## Additional Context
- Error messages (with full stack trace)
- Screenshots or videos
- Any relevant console output
```

## 💡 Feature Requests

For feature requests, please provide:

### Feature Request Template

```markdown
## Feature Description
A clear description of the feature you'd like to see.

## Problem Statement
What problem does this feature solve?

## Proposed Solution
How do you envision this feature working?

## Alternatives Considered
What other solutions have you considered?

## Additional Context
- Mockups or sketches
- Examples from other applications
- Use cases and user stories
```

## 🔧 Code Contributions

### Pull Request Process

1. **Create an Issue**: For significant changes, create an issue first to discuss the approach
2. **Fork and Branch**: Create a feature branch from `main`
3. **Develop**: Write code following our guidelines
4. **Test**: Ensure all tests pass and add new tests
5. **Document**: Update documentation if needed
6. **Submit PR**: Create a pull request with a clear description

### Pull Request Template

```markdown
## Description
Brief description of changes made.

## Type of Change
- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

## Testing
- [ ] Tests pass locally
- [ ] New tests added for new functionality
- [ ] Manual testing completed

## Screenshots/Videos
If applicable, add screenshots or videos demonstrating the changes.

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Code is commented where necessary
- [ ] Documentation updated
- [ ] No new warnings or errors introduced
```

### Review Process

1. **Automated Checks**: CI/CD pipeline runs tests and linting
2. **Code Review**: Maintainers review code for quality and consistency
3. **Feedback**: Address any requested changes
4. **Approval**: Once approved, the PR will be merged

## 🎨 Design Contributions

### UI/UX Improvements

- Follow existing design patterns
- Ensure accessibility (WCAG 2.1 AA compliance)
- Test on multiple screen sizes
- Consider dark/light theme compatibility

### New Themes

When adding new color themes:

```typescript
// src/data/colorThemes.ts
export const newTheme = {
  name: 'Theme Name',
  background: 'bg-color-class',
  colors: {
    primary: 'text-color-class',
    secondary: 'text-color-class',
    accent: 'text-color-class',
    muted: 'text-color-class',
    success: 'text-green-400',
    warning: 'text-yellow-400',
    error: 'text-red-400',
    command: 'text-color-class'
  }
};
```

## 📚 Documentation Contributions

### Documentation Standards

- **Clear and Concise**: Write for beginners
- **Examples**: Include code examples
- **Up-to-date**: Ensure accuracy with current codebase
- **Accessible**: Use proper headings and structure

### Documentation Types

- **API Documentation**: Component props, hook parameters
- **Tutorials**: Step-by-step guides
- **Examples**: Real-world usage patterns
- **Troubleshooting**: Common issues and solutions

## 🧪 Testing Contributions

### Test Types

- **Unit Tests**: Individual functions and components
- **Integration Tests**: Component interactions
- **E2E Tests**: Full user workflows (future)

### Writing Good Tests

```typescript
// Good test example
describe('TerminalWindow', () => {
  it('should render with correct title', () => {
    render(<TerminalWindow id="test" title="My Terminal" />);
    expect(screen.getByText('My Terminal')).toBeInTheDocument();
  });

  it('should call onClose when close button is clicked', () => {
    const onClose = vi.fn();
    render(<TerminalWindow id="test" onClose={onClose} />);
    
    fireEvent.click(screen.getByTitle('Close terminal'));
    expect(onClose).toHaveBeenCalledTimes(1);
  });
});
```

## 🏷️ Release Process

### Versioning

We follow [Semantic Versioning](https://semver.org/):

- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

### Release Checklist

- [ ] All tests passing
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Version bumped in package.json
- [ ] Git tag created
- [ ] Release notes written

## 🤝 Community Guidelines

### Code of Conduct

- **Be Respectful**: Treat everyone with respect and kindness
- **Be Inclusive**: Welcome contributors of all backgrounds and skill levels
- **Be Constructive**: Provide helpful feedback and suggestions
- **Be Patient**: Remember that everyone is learning

### Communication

- **GitHub Issues**: For bug reports and feature requests
- **GitHub Discussions**: For questions and general discussion
- **Pull Request Comments**: For code-specific discussions

## 🆘 Getting Help

### For Contributors

- **Documentation**: Check the [docs/](docs/) directory
- **Examples**: Look at existing code for patterns
- **Issues**: Search existing issues for similar problems
- **Discussions**: Ask questions in GitHub Discussions

### For Maintainers

- **Review Guidelines**: Be constructive and helpful
- **Response Time**: Aim to respond within 48 hours
- **Mentoring**: Help new contributors learn and improve

## 🎉 Recognition

Contributors are recognized in:

- **README.md**: Contributors section
- **Release Notes**: Major contributions highlighted
- **GitHub**: Contributor graphs and statistics

---

**Thank you for contributing to MultiTerminalCodeViz!** 🚀

Your contributions help make this project better for everyone. Whether you're fixing a typo or adding a major feature, every contribution is valued and appreciated.
