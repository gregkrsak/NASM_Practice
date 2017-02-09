;
; helloworld.asm
;
; A sample assembly language file.
;
; Written by Greg M. Krsak <greg.krsak@gmail.com>, Feb. 2017
;
; Processor: 64-bit, Intel or AMD
; Operating System: Windows, XP (Server 2003) or later
; Assembler: NASM
;
; Tested with:
; nasm -f win64 "helloworld.asm"
; golink /console /entry WinMain "helloworld.obj" kernel32.dll user32.dll
;
; For more information about 64-bit Windows programming in general, try these references:
; https://msdn.microsoft.com/en-us/library/windows/desktop/ms632595.aspx
; https://msdn.microsoft.com/en-us/library/7kcdt6fy.aspx
;


;
; DEFINES
;
MB_OK               equ 0                                   ; Represents the "OK" button of a message box
HWND_DESKTOP        equ 0                                   ; Represents a window handle to the Windows desktop
NULL                equ 0                                   ; Defines the value NULL


;
; THE NAME OF THE PROGRAM ENTRY POINT
;
global WinMain


;
; REQUIRED OPERATING SYSTEM LIBRARIES:
; 
; (kernel32.dll)
extern ExitProcess                                          ; API Reference: https://msdn.microsoft.com/en-us/library/windows/desktop/ms682658.aspx
; (user32.dll)
extern MessageBoxA                                          ; API Reference: https://msdn.microsoft.com/en-us/library/windows/desktop/ms645505.aspx


;
; DATA
;
section .data

; Used to display the message box
UserGreeting.title:                 db "A message for you", NULL
UserGreeting.message:               db "Hello World!", NULL                   


;
; CODE
;
section .text

; --- Program execution starts here ---
WinMain:
    push    rbp                                             ; Prolog
    mov     rbp, rsp                                        ; 
    
    ; Greet the user
    mov     rcx, HWND_DESKTOP                               ; Get a window handle to the Windows desktop
    lea     rdx, [UserGreeting.message]                     ; Get the memory address of the message box text
    lea     r8, [UserGreeting.title]                        ; Get the memory address of the message box title
    mov     r9d, MB_OK                                      ; Configure the message box to only feature an OK button
    call    MessageBoxA                                     ; Use the Windows API to display a message box
    
    mov     rsp, rbp                                        ; Epilog
    pop     rbp                                             ; 

    ; Exit the program
    mov     ecx, eax                                        ; Program exit code should equal the result of the MessageBoxA function
    call    ExitProcess                                     ; Use the Windows API to exit the program 
; --- Program execution ends here ---


; End of helloworld.asm
