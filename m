From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Nov 2018 14:51:50 +0100
Subject: [LTP] [PATCH] open_posix_testsuite/mmap24-2: Support mips
In-Reply-To: <1540348607-217391-1-git-send-email-hongzhi.song@windriver.com>
References: <1540348607-217391-1-git-send-email-hongzhi.song@windriver.com>
Message-ID: <20181127135149.GA26575@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
First of all sorry for the late reply.

> Mips will return EINVAL instead of ENOMEM as expected
> if MAP_FIXED is set and the range of [addr + len) exceeds
> TASK_SIZE.
> 
> Linux kernel code: arch/mips/mm/mmap.c
> if (flags & MAP_FIXED) {
>     /* Even MAP_FIXED mappings must reside within TASK_SIZE */
>     if (TASK_SIZE - len < addr)
>         return -EINVAL;
> 
> The POSIX specification says:
> "If MAP_FIXED is set, mmap() may return MAP_FAILED and set errno to
> [EINVAL]."
> [http://pubs.opengroup.org/onlinepubs/9699919799/functions/mmap.html]
> 
> So I think the mips kernel remains POSIX compliant.

There is a subtle difference between the ENOMEM and EINVAL error for
MAP_FIXED though.

If you look at POSIX specification terminology it says that 'shall'
defines mandatory features while 'may' describes optional features.

Which means that the MAP_FIXED returning ENOMEM for addresses above
TASK_SIZE is mandatory since it's defined in the shall fail list. And
that EINVAL is recomended to be used for other unsuitable address that
fit into the process address space but are not suitable for a different
reasons which could be mostly translated to hardware limits.

To sum it up, as far as I can tell mips is not POSIX confirmant here and
even if this is a very minor issue we shouldn't change the test here.

-- 
Cyril Hrubis
chrubis@suse.cz
