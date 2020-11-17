From: Li Wang <liwang@redhat.com>
Date: Tue, 17 Nov 2020 14:43:57 +0800
Subject: [LTP] [PATCH] madvise06: Allow for kmem and memsw counters
 being disabled
In-Reply-To: <20201116105209.20395-1-rpalethorpe@suse.com>
References: <20201116105209.20395-1-rpalethorpe@suse.com>
Message-ID: <CAEemH2cLAygaDZcohNwZ7Yx_tnjtywYXD7MmXs=J0upwgBdE-Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

This one looks good to me.

On Mon, Nov 16, 2020 at 6:52 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> These may be missing and we only access them for printing diagnostic
> info.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>
Reviewed-by: Li Wang <liwang@redhat.com>


> ---
>  testcases/kernel/syscalls/madvise/madvise06.c | 22 ++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/madvise/madvise06.c
> b/testcases/kernel/syscalls/madvise/madvise06.c
> index 2ba2bac6f..dc515d528 100644
> --- a/testcases/kernel/syscalls/madvise/madvise06.c
> +++ b/testcases/kernel/syscalls/madvise/madvise06.c
> @@ -64,14 +64,16 @@ static void check_path(const char *path)
>  }
>
>  #define READ_CGMEM(item)                                               \
> -       ({long tst_rval;                                                \
> -         SAFE_FILE_LINES_SCANF(MNT_NAME"/"GROUP_NAME"/memory."item,    \
> -                               "%ld",                                  \
> -                               &tst_rval);                             \
> +       ({long tst_rval = 0;                                            \
> +         const char *cgpath = MNT_NAME"/"GROUP_NAME"/memory."item;     \
> +         if (!access(cgpath, R_OK))                                    \
> +                 SAFE_FILE_LINES_SCANF(cgpath, "%ld", &tst_rval);      \
>           tst_rval;})
>
>  static void meminfo_diag(const char *point)
>  {
> +       long rval;
> +
>         FILE_PRINTF("/proc/sys/vm/stat_refresh", "1");
>         tst_res(TINFO, "%s", point);
>         tst_res(TINFO, "\tSwap: %ld Kb",
> @@ -82,10 +84,14 @@ static void meminfo_diag(const char *point)
>                 SAFE_READ_MEMINFO("Cached:") - init_cached);
>         tst_res(TINFO, "\tcgmem.usage_in_bytes: %ld Kb",
>                 READ_CGMEM("usage_in_bytes") / 1024);
> -       tst_res(TINFO, "\tcgmem.memsw.usage_in_bytes: %ld Kb",
> -               READ_CGMEM("memsw.usage_in_bytes") / 1024);
> -       tst_res(TINFO, "\tcgmem.kmem.usage_in_bytes: %ld Kb",
> -               READ_CGMEM("kmem.usage_in_bytes") / 1024);
> +
> +       rval = READ_CGMEM("memsw.usage_in_bytes") / 1024;
> +       if (rval)
> +               tst_res(TINFO, "\tcgmem.memsw.usage_in_bytes: %ld Kb",
> rval);
> +
> +       rval = READ_CGMEM("kmem.usage_in_bytes") / 1024;
> +       if (rval)
> +               tst_res(TINFO, "\tcgmem.kmem.usage_in_bytes: %ld Kb",
> rval);
>  }
>
>  static void setup(void)
> --
> 2.29.1
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201117/4729d55c/attachment.htm>
