
# Steps
1. `npx ember-cli@latest addon ember-choices -b @embroider/addon-blueprint --pnpm --typescript`
2. add glimmer, tracking, vscode glint config
3. create TooManyChoices component manually
4. in the addon dir used `pnpm pack` to generate a tarball
5. in ember app used `pnpm add path-to-tarball`
