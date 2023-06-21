This is dummy isolated example for reproduce problem with probably wrong relocation table, but 🤷🏻‍♂️

### Build

To build & reproduce you need:
- rust toolchain
- Playdate SDK 2.0
- env var `PLAYDATE_SDK_PATH` pointing to Playdate SDK dir.

```bash
./build.sh
```

Then have a look at produced artifact `./foo.pdx/pdex.bin`. 🤷🏻‍♂️



### Some notes

Elf before pdc have correct entry-point with correct relocation section. Correct - as I suppose, but...
After pdc the new elf `foo.pdx/pdex.bin` does not contain anything.
