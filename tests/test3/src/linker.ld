ENTRY (_loader)

SECTIONS
{
	. = 0x100000;

	.setup :
	{
		*(.setup)
	}

	. += 0xC0000000;

	.text : AT(ADDR(.text) - 0xC0000000)
	{
		*(.text)
	}

	.data ALIGN (4096) : AT(ADDR(.data) - 0xC0000000)
	{
		*(.data)
		*(.rodata*)
	}

	.bss ALIGN (4096) : AT(ADDR(.bss) - 0xC0000000)
	{
		*(COMMON*)
		*(.bss*)
	}
}
