nop             # Values initialized using addi (positive only)
nop             # Author: Oliver Rodas
nop
nop             # Multdiv without Bypassing
nop 			# Multdiv Tests
addi $3, $0, 1	# r3 = 1
addi $1, $0, 3	# r1 = 3
sub $3, $0, $3	# r3 = -1
nop
nop
mul $21, $3, $1	# r21 = r3 * r1 = -3