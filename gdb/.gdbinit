set disassembly-flavor intel

define asm
  tbreak _start
  run
  layout asm
  layout regs
  focus cmd
end

document asm
Run the program, stop at _start, and open the assembly/register TUI.
end
