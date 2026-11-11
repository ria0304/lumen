BITS 32

global enter_user_mode

%define USER_CODE_SELECTOR 0x1B
%define USER_DATA_SELECTOR 0x23

%define USER_CODE_ADDRESS  0x00C00000
%define USER_STACK_TOP     0x00C02000

enter_user_mode:

    cli

    ; CPU will use these five values as the
    ; privilege-level transition frame:
    ;
    ;     SS
    ;     ESP
    ;     EFLAGS
    ;     CS
    ;     EIP

    push dword USER_DATA_SELECTOR
    push dword USER_STACK_TOP

    pushfd
    pop eax

    ; Enable interrupts after entering Ring 3.
    or eax, 0x00000200

    push eax
    push dword USER_CODE_SELECTOR
    push dword USER_CODE_ADDRESS

    iret
