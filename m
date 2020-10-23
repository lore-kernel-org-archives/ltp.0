From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Fri, 23 Oct 2020 09:14:21 +0200
Subject: [LTP] mmstress[1309]: segfault at 7f3d71a36ee8 ip
 00007f3d77132bdf sp 00007f3d71a36ee8 error 4 in
 libc-2.27.so[7f3d77058000+1aa000]
In-Reply-To: <20201023050214.GG23681@linux.intel.com>
References: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
 <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
 <CA+G9fYv=DUanNfL2yza=y9kM7Y9bFpVv22Wd4L9NP28i0y7OzA@mail.gmail.com>
 <CA+G9fYudry0cXOuSfRTqHKkFKW-sMrA6Z9BdQFmtXsnzqaOgPg@mail.gmail.com>
 <CAHk-=who8WmkWuuOJeGKa-7QCtZHqp3PsOSJY0hadyywucPMcQ@mail.gmail.com>
 <CAHk-=wi=sf4WtmZXgGh=nAp4iQKftCKbdQqn56gjifxWNpnkxw@mail.gmail.com>
 <CAEUSe78A4fhsyF6+jWKVjd4isaUeuFWLiWqnhic87BF6cecN3w@mail.gmail.com>
 <CAHk-=wgqAp5B46SWzgBt6UkheVGFPs2rrE6H4aqLExXE1TXRfQ@mail.gmail.com>
 <20201023050214.GG23681@linux.intel.com>
Message-ID: <356811ab-cb08-7685-ca01-fe58b5654953@rasmusvillemoes.dk>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 23/10/2020 07.02, Sean Christopherson wrote:
> On Thu, Oct 22, 2020 at 08:05:05PM -0700, Linus Torvalds wrote:
>> On Thu, Oct 22, 2020 at 6:36 PM Daniel D?az <daniel.diaz@linaro.org> wrote:
>>>
>>> The kernel Naresh originally referred to is here:
>>>   https://builds.tuxbuild.com/SCI7Xyjb7V2NbfQ2lbKBZw/
>>
>> Thanks.
>>
>> And when I started looking at it, I realized that my original idea
>> ("just look for __put_user_nocheck_X calls, there aren't so many of
>> those") was garbage, and that I was just being stupid.
>>
>> Yes, the commit that broke was about __put_user(), but in order to not
>> duplicate all the code, it re-used the regular put_user()
>> infrastructure, and so all the normal put_user() calls are potential
>> problem spots too if this is about the compiler interaction with KASAN
>> and the asm changes.
>>
>> So it's not just a couple of special cases to look at, it's all the
>> normal cases too.
>>
>> Ok, back to the drawing board, but I think reverting it is probably
>> the right thing to do if I can't think of something smart.
>>
>> That said, since you see this on x86-64, where the whole ugly trick with that
>>
>>    register asm("%"_ASM_AX)
>>
>> is unnecessary (because the 8-byte case is still just a single
>> register, no %eax:%edx games needed), it would be interesting to hear
>> if the attached patch fixes it. That would confirm that the problem
>> really is due to some register allocation issue interaction (or,
>> alternatively, it would tell me that there's something else going on).
> 
> I haven't reproduced the crash, but I did find a smoking gun that confirms the
> "register shenanigans are evil shenanigans" theory.  I ran into a similar thing
> recently where a seemingly innocuous line of code after loading a value into a
> register variable wreaked havoc because it clobbered the input register.
> 
> This put_user() in schedule_tail():
> 
>    if (current->set_child_tid)
>            put_user(task_pid_vnr(current), current->set_child_tid);
> 
> generates the following assembly with KASAN out-of-line:
> 
>    0xffffffff810dccc9 <+73>: xor    %edx,%edx
>    0xffffffff810dcccb <+75>: xor    %esi,%esi
>    0xffffffff810dcccd <+77>: mov    %rbp,%rdi
>    0xffffffff810dccd0 <+80>: callq  0xffffffff810bf5e0 <__task_pid_nr_ns>
>    0xffffffff810dccd5 <+85>: mov    %r12,%rdi
>    0xffffffff810dccd8 <+88>: callq  0xffffffff81388c60 <__asan_load8>
>    0xffffffff810dccdd <+93>: mov    0x590(%rbp),%rcx
>    0xffffffff810dcce4 <+100>: callq  0xffffffff817708a0 <__put_user_4>
>    0xffffffff810dcce9 <+105>: pop    %rbx
>    0xffffffff810dccea <+106>: pop    %rbp
>    0xffffffff810dcceb <+107>: pop    %r12
> 
> __task_pid_nr_ns() returns the pid in %rax, which gets clobbered by
> __asan_load8()'s check on current for the current->set_child_tid dereference.
> 

Yup, and you don't need KASAN to implicitly generate function calls for
you. With x86_64 defconfig, I get

extern u64 __user *get_destination(int x, int y);

void pu_test(void)
{
	u64 big = 0x1234abcd5678;

	if (put_user(big, get_destination(4, 5)))
		pr_warn("uh");
}

to generate

0000000000004d60 <pu_test>:
    4d60:       53                      push   %rbx
    4d61:       be 05 00 00 00          mov    $0x5,%esi
    4d66:       bf 04 00 00 00          mov    $0x4,%edi
    4d6b:       e8 00 00 00 00          callq  4d70 <pu_test+0x10>
                        4d6c: R_X86_64_PC32     get_destination-0x4
    4d70:       48 89 c1                mov    %rax,%rcx
    4d73:       e8 00 00 00 00          callq  4d78 <pu_test+0x18>
                        4d74: R_X86_64_PC32     __put_user_8-0x4
    4d78:       85 c9                   test   %ecx,%ecx
    4d7a:       75 02                   jne    4d7e <pu_test+0x1e>
    4d7c:       5b                      pop    %rbx
    4d7d:       c3                      retq
    4d7e:       5b                      pop    %rbx
    4d7f:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi
                        4d82: R_X86_64_32S      .rodata.str1.1+0xfa
    4d86:       e9 00 00 00 00          jmpq   4d8b <pu_test+0x2b>
                        4d87: R_X86_64_PC32     printk-0x4


That's certainly garbage. Now, I don't know if it's a sufficient fix (or
could break something else), but the obvious first step of rearranging
so that the ptr argument is evaluated before the assignment to __val_pu

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 477c503f2753..b5d3290fcd09 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -235,13 +235,13 @@ extern void __put_user_nocheck_8(void);
 #define do_put_user_call(fn,x,ptr)                                     \
 ({                                                                     \
        int __ret_pu;                                                   \
-       register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX);           \
+       __typeof__(ptr) __ptr = (ptr);                                  \
+       register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX) = (x);     \
        __chk_user_ptr(ptr);                                            \
-       __val_pu = (x);                                                 \
        asm volatile("call __" #fn "_%P[size]"                          \
                     : "=c" (__ret_pu),                                 \
                        ASM_CALL_CONSTRAINT                             \
-                    : "0" (ptr),                                       \
+                    : "0" (__ptr),                                     \
                       "r" (__val_pu),                                  \
                       [size] "i" (sizeof(*(ptr)))                      \
                     :"ebx");                                           \


at least gets us

0000000000004d60 <pu_test>:
    4d60:       53                      push   %rbx
    4d61:       be 05 00 00 00          mov    $0x5,%esi
    4d66:       bf 04 00 00 00          mov    $0x4,%edi
    4d6b:       e8 00 00 00 00          callq  4d70 <pu_test+0x10>
                        4d6c: R_X86_64_PC32     get_destination-0x4
    4d70:       48 89 c1                mov    %rax,%rcx
    4d73:       48 b8 78 56 cd ab 34    movabs $0x1234abcd5678,%rax
    4d7a:       12 00 00
    4d7d:       e8 00 00 00 00          callq  4d82 <pu_test+0x22>
                        4d7e: R_X86_64_PC32     __put_user_8-0x4


FWIW, https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html
does warn about function calls and other things that might clobber the
register variables between the assignment and the use as an input
(though the case of evaluating other input operands is not explicitly
mentioned).

Rasmus
