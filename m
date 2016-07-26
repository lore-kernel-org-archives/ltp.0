From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jul 2016 14:08:36 +0100
Subject: [LTP] Can we assume at least GCC 4.1 for building LTP tests?
	(__builtin___clear_cache())
Message-ID: <CAFEAcA-w1oQiWSHtm-fXUMStFJdwyXyJr+4E8=4ObtJ8jcZVkA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi; is there a minimum GCC version we can assume for LTP tests,
and is it GCC 4.1 or better?

I ask because the mprotect04.c test case currently does this:

#ifdef __powerpc__
    for (i = 0; i < copy_sz; i += 4)
        __asm__ __volatile__("dcbst 0,%0; sync; icbi 0,%0; sync; isync"
            :: "r"(mem_start + i));
#endif

to synchronize the icache and dcache following copying some code,
but this only works on PPC, not on other architectures which
require explicit cache maintenance (like ARM). The easy way to
do this portably is:

    __builtin___clear_cache(mem_start, mem_start + copy_sz);

which uses the GCC (and clang) builtin which should work on any
architecture (and do nothing on ones like x86 which don't need
special handling). However it doesn't exist prior to GCC 4.1
(which was released a decade ago), so if LTP still has to
support ancient compilers it gets a bit more awkward. (Perhaps
the easiest thing would be to TCONF the test on ancient gcc.)

thanks
-- PMM
