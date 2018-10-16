From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Oct 2018 15:02:09 +0200
Subject: [LTP] [PATCH] open_posix_testsuite/mmap24-2: Relax condition a
 bit
In-Reply-To: <1539226733-18212-1-git-send-email-hongzhi.song@windriver.com>
References: <1539226733-18212-1-git-send-email-hongzhi.song@windriver.com>
Message-ID: <20181016130209.GB6980@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Linux kernel code: arch/mips/mm/mmap.c
> if (flags & MAP_FIXED) {
>     /* Even MAP_FIXED mappings must reside within TASK_SIZE */
>     if (TASK_SIZE - len < addr)
>         return -EINVAL;
> 
> Relax the condition and accept both ENOMEM and EINVAL
> as expected outcome.

Hmm, it's always complicated with these POSIX tests, since we have to
follow the POSIX specification there.

And the POSIX clearly says that mmap() shall fail with ENOMEM if
MAP_FIXED was specified, and the range [addr,addr+len) exceeds that
allowed for the address space of a process. So I guess that the best
solution here would be limiting the address space with rlimit, so that
we actually happen to hit the ENOMEM instead of EINVAL.

At least we cannot say that we passed the test with EINVAL because the
assertion we tried to test wasn't triggered.

-- 
Cyril Hrubis
chrubis@suse.cz
