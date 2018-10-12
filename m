From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Oct 2018 18:20:00 +0200
Subject: [LTP] [PATCH] open_posix_testsuite/mmap24-2: Relax condition a
 bit
In-Reply-To: <1539226733-18212-1-git-send-email-hongzhi.song@windriver.com>
References: <1539226733-18212-1-git-send-email-hongzhi.song@windriver.com>
Message-ID: <20181012162000.GB30991@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Hongzhi,

> Mips will return EINVAL instead of ENOMEM as expected
> if the range [addr + len) exceeds TASK_SIZE.

> Linux kernel code: arch/mips/mm/mmap.c
> if (flags & MAP_FIXED) {
>     /* Even MAP_FIXED mappings must reside within TASK_SIZE */
>     if (TASK_SIZE - len < addr)
>         return -EINVAL;

> Relax the condition and accept both ENOMEM and EINVAL
> as expected outcome.

> Signed-off-by: Hongzhi.Song <hongzhi.song@windriver.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for your patch, LGTM.


Kind regards,
Petr
