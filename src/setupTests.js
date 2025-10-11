import { expect, afterEach } from 'vitest';
import { cleanup } from '@testing-library/react';
import * as matchers from '@testing-library/jest-dom/matchers';

// Расширяем Vitest'овские expect матчерами из jest-dom
expect.extend(matchers);

// Очищаем DOM после каждого теста
afterEach(() => {
  cleanup();
});