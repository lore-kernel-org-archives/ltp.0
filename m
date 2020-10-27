From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Oct 2020 20:38:22 +0800
Subject: [LTP] [PATCH] madvise06: Increase reliability and diagnostic
 info
In-Reply-To: <20201026121605.20100-1-rpalethorpe@suse.com>
References: <20201026121605.20100-1-rpalethorpe@suse.com>
Message-ID: <CAEemH2d8+5qLLKWsuf5WJeLHdv2VfPZiyM9-oW=WyH4m==h=8g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Oct 26, 2020 at 8:16 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> When memcg.limit_in_bytes is set to PASS_THRESHOLD it's unlikely
> swapcached will increase by more than PASS_THRESHOLD unless processes
> in other memcgs are also increasing it. Additionally MADV_WILLNEED
> must remove pages from memory as it adds more so that the first page
> may not be in memory by the time the last page is faulted if the
> amount exceeds the memory limit (which it does because CHUNK_SZ >
> PASS_THRESSHOLD). Worse if pages are faulted in a non-linear way, or
> the process must access some other pages, then there is no guarantee
> which parts of the range will be resident in memory. This results in
> spurious test failures.
>
> To solve this we can set PASS_THRESHOLD to 1/4 of CHUNK_SZ and
> memcg.limit_in_bytes to 1/2 of CHUNK_SZ (MEM_LIMIT), then mark
> MEM_LIMIT bytes as needed. That way the amount in the SwapCache will
> easily be more than the threshold. Secondly we can run madvise again
> on PASS_THRESHOLD bytes and check that dirtying all of these does not
> result in too many page faults. We also run the second test on every
> occasion to ensure the test code itself is still valid. If the
> original bug is present then both tests fail.
>
> Finally this prints more diagnostic information to help with debugging
> the test.
>
> While debugging the test a kernel bug was found in 5.9 which effects
> CGroupV1 when use_hierarchy=0. This is unlikely to effect many users,
> but a fix is pending and will be referenced in the test when
> available. It is recommended that you set use_hierarchy=1.
>

Great, we could add the commit info as well after patch merging in the
mainline kernel.


> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>
Reviewed-by: Li Wang <liwang@redhat.com>

This improvement makes sense to me apart from a tiny syntax error below.

One additional comment, I found this test now only run with CGroupV1,
and maybe we could make use of the LTP-cgroup new library after we
updating that(tst_cgroup.c) to make it works well with CGroupV2.

---
>  testcases/kernel/syscalls/madvise/madvise06.c | 107 ++++++++++++++----
>  1 file changed, 84 insertions(+), 23 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/madvise/madvise06.c
> b/testcases/kernel/syscalls/madvise/madvise06.c
> index f76f3f6aa..3e70da37e 100644
> --- a/testcases/kernel/syscalls/madvise/madvise06.c
> +++ b/testcases/kernel/syscalls/madvise/madvise06.c
> @@ -19,6 +19,23 @@
>   *   Date:   Thu May 22 11:54:17 2014 -0700
>   *
>   *       mm: madvise: fix MADV_WILLNEED on shmem swapouts
> + *
> + *   Two checks are performed, the first looks at how SwapCache
> + *   changes during madvise. When the pages are dirtied, about half
> + *   will be accounted for under Cached and the other half will be
> + *   moved into Swap. When madvise is run it will cause the pages
> + *   under Cached to also be moved to Swap while rotating the pages
> + *   already in Swap into SwapCached. So we expect that SwapCached has
> + *   roughly MEM_LIMIT bytes added to it, but for reliability the
> + *   PASS_THRESHOLD is much lower than that.
> + *
> + *   Secondly we run madvise again, but only on the first
> + *   PASS_THRESHOLD bytes to ensure these are entirely in RAM. Then we
> + *   dirty these pages and check there were (almost) no page
> + *   faults. Two faults are allowed incase some tasklet or something
> + *   else unexpected, but irrelevant procedure, registers a fault to
> + *   our process.
> + *
>   */
>
>  #include <errno.h>
> @@ -28,8 +45,10 @@
>  #include "tst_test.h"
>
>  #define CHUNK_SZ (400*1024*1024L)
> -#define CHUNK_PAGES (CHUNK_SZ / pg_sz)
> +#define MEM_LIMIT (CHUNK_SZ / 2)
> +#define MEMSW_LIMIT (2 * CHUNK_SZ)
>  #define PASS_THRESHOLD (CHUNK_SZ / 4)
> +#define PASS_THRESHOLD_KB (PASS_THRESHOLD / 1024)
>
>  #define MNT_NAME "memory"
>  #define GROUP_NAME "madvise06"
> @@ -37,12 +56,39 @@
>  static const char drop_caches_fname[] = "/proc/sys/vm/drop_caches";
>  static int pg_sz;
>
> +static long init_swap, init_swap_cached, init_cached;
> +
>  static void check_path(const char *path)
>  {
>         if (access(path, R_OK | W_OK))
>                 tst_brk(TCONF, "file needed: %s\n", path);
>  }
>
> +#define READ_CGMEM(item)                                               \
> +       ({long tst_rval;                                                \
> +         SAFE_FILE_LINES_SCANF(MNT_NAME"/"GROUP_NAME"/memory."item,    \
> +                               "%ld",                                  \
> +                               &tst_rval);                             \
> +         tst_rval;})
> +
> +static void meminfo_diag(const char *point)
> +{
> +       FILE_PRINTF("/proc/sys/vm/stat_refresh", "1");
> +       tst_res(TINFO, point);
>

Here is a syntax error, to fix it as:
    tst_res(TINFO, "%s", point);

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201027/0b40d304/attachment.htm>
