elm-kernel-debug
====

Compile kernel code and test it.

## Usage

Download a couple packages and put them in the `hax` folder so you can hack them locally.

    ./build.sh elm/virtual-dom elm/browser

Then you can edit those as you choose, and re-build them.

    ./build.sh

Use `elm reactor` and navigate to [localhost:8000/index.html](localhost:8000/index.html) to investigate the compiled result.

## Note

After running `build.sh`, check the `0.19.0/package` folder for your module. If you see multiple versions of it in there, your changes may not be built into `index.html`! In that case, adjust the version of your module in its `elm.json` to match the one the Elm compiler brings in.
