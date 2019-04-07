elm-kernel-debug
====

Compile kernel code and test it... for good, not evil.

## Install

```bash
yarn
```

## Usage

```bash
# Download a couple packages and put them in the `hax` folder so you can hack them locally.
./build.sh elm/virtual-dom elm/browser
```

Then you can edit those as you choose, and re-build them.

```bash
./build.sh
```

Use `elm reactor` and navigate to [localhost:8000/index.html](http://localhost:8000/index.html) to investigate the compiled result.

It builds the file in `app/src/Increment.elm` using the resources placed in the `0.19.0` folder by the build script.

## Watch for changes

    yarn install
    yarn watch

...to rebuild every time you change a `.elm` or `.js` file in the `hax` folder.

### Note

After running `build.sh`, check the `0.19.0/package` folder for your module. If you see multiple versions of it in there, your changes might not have been built into `index.html`. In that case, adjust the version of your module in its `elm.json` to match the one the Elm compiler brings in.

## Caveat

### For Good!

This is intended *only* for contributing to Elm by providing bug fixes and the like.

### For Evil.

It is _not_ advisable to use this as any sort of ersatz build system that sidesteps the protections granted by the compiler in limiting which modules may contain kernel codez. Doing so would introduce more instability into a system that benefits most from reliability, predictability, and other -ilities.

I'm also aware that some organizations are willing to fork the Elm compiler just so they can continue to use their own Kernel code past version 0.19, so I don't think this will be the sole reason Elm tumbles into a maelstrom of unreliable custom kernel-level modules.

## Credit

Thanks to [Yosuke Torii](https://github.com/jinjor) for [the original](https://github.com/jinjor/elm-kernel-debug). Yosuke was unwilling to document how this works for reasons mentioned in the caveat above, but I need to document it so that I remember how it works in the future. Hence my fork.
