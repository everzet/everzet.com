# Website generator

Static site generator for the company website.

## Included

- [Eleventy](https://www.11ty.dev/)
- [TailwindCSS](https://tailwindcss.com/)
- Fast build with per env configs ([babel-env](https://babeljs.io/docs/en/babel-preset-env), [postcss-preset-env](https://github.com/csstools/postcss-preset-env), [webpack](https://webpack.js.org/configuration/#use-different-configuration-file)...)
- `.js` (ES6, Babel and its polyfills)
- `.css` (PostCSS, Autoprefixer, PurgeCSS)

## Usage

First install the dependencies:

```sh
npm install
```

Then you can:

| Command               | Description                                  |
| --------------------- | -------------------------------------------- |
| **`npm run start`**   | Run your website on http://localhost:8080    |
| **`npm run build`**   | Build your production website inside `/dist` |

That's it.

## eli5 (explain like i'm 5)

Webpack is used when:

1. Any changes to `assets/scripts` or `assets/styles` is watched and rebuilt by Webpack.
2. The new files are appended to the ignored file `_includes/webpack.njk` thanks to [html-webpack-plugin](https://github.com/jantimon/html-webpack-plugin).
3. Eleventy sees the new `_includes/webpack.njk` and rebuild.

Any other changes is picked up normally by Eleventy (see [.eleventy.js](.eleventy.js))

## Thanks

The codebase is derived heavily from [eleventy-webpack](https://github.com/clenemt/eleventy-webpack).
