From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Oct 2020 17:11:08 -0700
Subject: [LTP] mmstress[1309]: segfault at 7f3d71a36ee8 ip
 00007f3d77132bdf sp 00007f3d71a36ee8 error 4 in
 libc-2.27.so[7f3d77058000+1aa000]
In-Reply-To: <CAHk-=who8WmkWuuOJeGKa-7QCtZHqp3PsOSJY0hadyywucPMcQ@mail.gmail.com>
References: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
 <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
 <CA+G9fYv=DUanNfL2yza=y9kM7Y9bFpVv22Wd4L9NP28i0y7OzA@mail.gmail.com>
 <CA+G9fYudry0cXOuSfRTqHKkFKW-sMrA6Z9BdQFmtXsnzqaOgPg@mail.gmail.com>
 <CAHk-=who8WmkWuuOJeGKa-7QCtZHqp3PsOSJY0hadyywucPMcQ@mail.gmail.com>
Message-ID: <CAHk-=wi=sf4WtmZXgGh=nAp4iQKftCKbdQqn56gjifxWNpnkxw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 22, 2020 at 4:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Thanks. Very funky, but thanks. I've been running that commit on my
> machine for over half a year, and it still looks "trivially correct"
> to me, but let me go look at it one more time. Can't argue with a
> reliable bisect and revert..

Hmm. The fact that it only happens with KASAN makes me suspect it's
some bad interaction with the inline asm syntax change (and explains
why I've run with this for half a year without issues).

In particular, I wonder if it's that KASAN causes some reload pattern,
and the whole

     register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX);
..
     asm volatile(.. "r" (__val_pu) ..)

thing causes problems. That's an ugly pattern, but it's written that
way to get gcc to handle the 64-bit case properly (with the value in
%rax:%rdx).

It turns out that the decode of the user-mode SIGSEGV code is a
variation of system calls, ie

   0: b8 18 00 00 00        mov    $0x18,%eax
   5: 0f 05                syscall
   7: 48 3d 01 f0 ff ff    cmp    $0xfffffffffffff001,%rax
   d: 73 01                jae    0x10
   f:* c3                    retq    <-- trapping instruction

or

   0: 41 52                push   %r10
   2: 52                    push   %rdx
   3: 4d 31 d2              xor    %r10,%r10
   6: ba 02 00 00 00        mov    $0x2,%edx
   b: be 80 00 00 00        mov    $0x80,%esi
  10: 39 d0                cmp    %edx,%eax
  12: 75 07                jne    0x1b
  14: b8 ca 00 00 00        mov    $0xca,%eax
  19: 0f 05                syscall
  1b: 89 d0                mov    %edx,%eax
  1d: 87 07                xchg   %eax,(%rdi)
  1f: 85 c0                test   %eax,%eax
  21: 75 f1                jne    0x14
  23:* 5a                    pop    %rdx <-- trapping instruction
  24: 41 5a                pop    %r10
  26: c3                    retq

so in both cases it looks like 'syscall' returned with a bad stack pointer.

Which is certainly a sign of some code generation issue.

Very annoying, because it probably means that it's compiler-specific
too. And that "syscall 018" looks very odd. I think that's
sched_yield() on x86-64, which doesn't have any __put_user() cases at
all..

Would you mind sending me the problematic vmlinux file in private (or,
likely better - a pointer to some place I can download it, it's going
to be huge).

                      Linus
