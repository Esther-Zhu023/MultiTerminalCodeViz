import { render, screen } from '@testing-library/react';
import App from './App';

describe('<App />', () => {
  it('renders the Vite and React heading', () => {
    render(<App />);
    expect(screen.getByRole('heading', { name: /vite \+ react/i })).toBeInTheDocument();
  });
}); 