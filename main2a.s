TRISF=0xBF886140
LATF=0xBF886160
DELAY=10000000
RF0CLEAR=0x00000000 #et bit à bit pour mettre bit 0 à 0
RF0SETCLEAR=0x00000001 #ou bit à bit pour mettre bit 0 à 1

	.text
	.globl main
	.ent main
main:
	# configuration RG0 en sortie
	li 	$a2, TRISF
	lw 	$a0, 0($a2)
	li 	$a1, RF0CLEAR 
	and	$a0, $a0, $a1
	sw 	$a0, 0($a2)
	# chargement valeur LATF dans $a2
	li 	$a2, LATF
	lw 	$a0, 0($a2)
main_loop:
	# extinction LD5 (LATF0=0)
	li 	$a1, RF0CLEAR
	and 	$a0, $a0, $a1
	sw 	$a0, 0($a2)
	li 	$a3, DELAY
loop2:
	addi $a3, $a3,-1
	bgtz $a3, loop2
	# allumage LD5 (LATF0=1)
	li 	$a1, RF0SETCLEAR
	or 	$a0, $a0, $a1
	sw 	$a0, 0($a2)
	li 	$a3, DELAY
loop:
	addi $a3, $a3,-1
	bgtz $a3, loop
	b 	main_loop
	.end main
