mkdir -p ./build
export ELF=./build/pdex.elf


cargo build --release --target=thumbv7em-none-eabihf --lib -vv \
	--config=.cargo/config-lib.toml


# setup.c
arm-none-eabi-gcc \
	-g3 -c -mthumb -mcpu=cortex-m7 -mfloat-abi=hard -mfpu=fpv5-sp-d16 -D__FPU_USED=1 -O2 -falign-functions=16 -fomit-frame-pointer -gdwarf-2 -Wall -Wno-unused -Wstrict-prototypes -Wno-unknown-pragmas -fverbose-asm -Wdouble-promotion -mword-relocations -fno-common -ffunction-sections -fdata-sections \
	-DTARGET_PLAYDATE=1 -DTARGET_EXTENSION=1  -MD -MP \
   -I $PLAYDATE_SDK_PATH/C_API \
	$PLAYDATE_SDK_PATH/C_API/buildsupport/setup.c \
   -o ./build/setup.o \


# bin <- lib+setup
arm-none-eabi-gcc \
	./build/setup.o \
   target/thumbv7em-none-eabihf/release/libfoo.a \
	-nostartfiles -mthumb -mcpu=cortex-m7 -mfloat-abi=hard -mfpu=fpv5-sp-d16 -D__FPU_USED=1 \
	-T$PLAYDATE_SDK_PATH/C_API/buildsupport/link_map.ld \
	-Wl,--cref,--gc-sections,--no-warn-mismatch,--emit-relocs \
	-MF target/thumbv7em-none-eabihf/release/libfoo.d \
	-I $PLAYDATE_SDK_PATH/C_API \
	-o $ELF \
	--entry eventHandlerShim


arm-none-eabi-readelf -h $ELF

# crate: elf-info v0.3.0 (cargo install elf-info)
which elf && ./analize.sh $ELF
# crate hexyl
which hexyl && hexyl ./foo.pdx/pdex.bin

$PLAYDATE_SDK_PATH/bin/pdc --verbose --skip-unknown ./build/ ./foo.pdx
