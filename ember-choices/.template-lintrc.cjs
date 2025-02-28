'use strict';

module.exports = {
  extends: 'recommended',

  rules: {
    'no-forbidden-elements': [
      'error',
      { forbidden: ['meta', 'html', 'script'] },
    ],
    'no-whitespace-for-layout': false,
  },
};
