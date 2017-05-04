CC=xc32-gcc
CFLAGS=-Wall -Werror -O0
LDFLAGS=-mprocessor=32MX320F128H

TARGET=main
SRCS=$(TARGET).c
OBJS=$(SRCS:.c=.o)

AVRDUDE=avrdude
AVRDUDE_PORT=/dev/ttyUSB0
AVRDUDE_CONF=avrdude.conf
AVRDUDE_FLAGS=-C $(AVRDUDE_CONF) -p pic32-360 -c stk500 -P $(AVRDUDE_PORT)

$(TARGET).bin: $(OBJS)
	$(CC) -T ldscript.ld $(LDFLAGS)  -o $(TARGET).bin $(OBJS)

$(TARGET).hex: $(TARGET).bin
	xc32-objcopy -R ._debug_exception -O ihex $(TARGET).bin $(TARGET).hex

upload: $(TARGET).hex
	$(AVRDUDE) $(AVRDUDE_FLAGS) -U flash:w:$(TARGET).hex

SUFFIXES: .c .o

.c.o:
	$(CC) -c $(CFLAGS) -o $@ $<

PHONY: clean

clean:
	@rm -f $(OBJS) $(TARGET).bin $(TARGET).hex
