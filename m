From: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 08 Mar 2018 23:19:12 +1100
Subject: [LTP] [bug?] Access was denied by memory protection keys in
	execute-only address
In-Reply-To: <CAEemH2f0LDqyR5AmUYv17OuBc5-UycckDPWgk46XU_ghQo4diw@mail.gmail.com>
References: <CAEemH2f0LDqyR5AmUYv17OuBc5-UycckDPWgk46XU_ghQo4diw@mail.gmail.com>
Message-ID: <871sguep4v.fsf@concordia.ellerman.id.au>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Li Wang <liwang@redhat.com> writes:
> Hi,
>
> ltp/mprotect04[1] crashed by SEGV_PKUERR on ppc64(LPAR on P730, Power 8
> 8247-22L) with kernel-v4.16.0-rc4.
>
> 10000000-10020000 r-xp 00000000 fd:00 167223           mprotect04
> 10020000-10030000 r--p 00010000 fd:00 167223           mprotect04
> 10030000-10040000 rw-p 00020000 fd:00 167223           mprotect04
> 1001a380000-1001a3b0000 rw-p 00000000 00:00 0          [heap]
> 7fffa6c60000-7fffa6c80000 --xp 00000000 00:00 0 ​
>
> ​&exec_func = 0x10030170​
>
> ​&func = 0x7fffa6c60170​
>
> ​While perform ​
> "(*func)();" we get the
> ​segmentation fault.
> ​
>
> ​strace log:​
>
> -------------------
> ​mprotect(0x7fffaed00000, 131072, PROT_EXEC) = 0
> rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
> --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_PKUERR, si_addr=0x7fffaed00170}
> ---​

Looks like a bug to me.

Please Cc linuxppc-dev on powerpc bugs.

I also can't reproduce this failure on my machine.
Not sure what's going on?

cheers
