### Build

To build & reproduce you need rust toolchain.

```bash
./build.sh
```

Then have a look at produced artifact `./foo.pdx/pdex.bin`. 🤷🏻‍♂️



### Some notes

Elf before pdc have correct entry-point with correct relocation section. Correct - as I suppose, but...
After pdc the new elf `foo.pdx/pdex.bin` does not contain anything.
