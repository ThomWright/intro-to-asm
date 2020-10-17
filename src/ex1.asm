global _start
_start:
  mov eax, 1  ; sys_exit system call identifier
  mov ebx, 42 ; exit status
  int 0x80    ; perform system call
