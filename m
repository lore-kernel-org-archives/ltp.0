From: Li Wang <liwang@redhat.com>
Date: Fri, 8 Jun 2018 17:14:47 +0800
Subject: [LTP] [PATCH 1/2] madvise: add MADV_WIPEONFORK/MADV_KEEPONFORK
 in madvise() test
In-Reply-To: <20180514092635.26100-1-liwang@redhat.com>
References: <20180514092635.26100-1-liwang@redhat.com>
Message-ID: <CAEemH2fFc8xs7jOTCzfvDi_r=d09r2p0+xcGzdXYMq3Q8ruGqw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ping

On Mon, May 14, 2018 at 5:26 PM, Li Wang <liwang@redhat.com> wrote:

> The kernel commit (d2cd9ed mm,fork: introduce MADV_WIPEONFORK)
> introduces two new advices for madvise() in kernel-v4.14. Here
> making LTP cover that test accordingly.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  include/lapi/mmap.h                           | 5 +++++
>  testcases/kernel/syscalls/madvise/madvise01.c | 3 +++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
> index 7a55800..18547c0 100644
> --- a/include/lapi/mmap.h
> +++ b/include/lapi/mmap.h
> @@ -71,6 +71,11 @@
>  # define MADV_FREE     8
>  #endif
>
> +#ifndef MADV_WIPEONFORK
> +# define MADV_WIPEONFORK 18
> +# define MADV_KEEPONFORK 19
> +#endif
> +
>  #ifdef HAVE_SYS_SHM_H
>  # include <sys/shm.h>
>  # define MMAP_GRANULARITY SHMLBA
> diff --git a/testcases/kernel/syscalls/madvise/madvise01.c
> b/testcases/kernel/syscalls/madvise/madvise01.c
> index 4b18a21..8d1d787 100644
> --- a/testcases/kernel/syscalls/madvise/madvise01.c
> +++ b/testcases/kernel/syscalls/madvise/madvise01.c
> @@ -62,6 +62,9 @@ static struct tcase {
>         {MADV_DONTDUMP,    "MADV_DONTDUMP",    &sfile}, /* since Linux 3.4
> */
>         {MADV_DODUMP,      "MADV_DODUMP",      &sfile}, /* since Linux 3.4
> */
>         {MADV_FREE,        "MADV_FREE",        &amem},  /* since Linux 4.5
> */
> +       {MADV_WIPEONFORK,  "MADV_WIPEONFORK",  &amem},  /* since Linux
> 4.14 */
> +       {MADV_KEEPONFORK,  "MADV_KEEPONFORK",  &amem},  /* since Linux
> 4.14 */
> +
>  };
>
>  static void setup(void)
> --
> 2.9.5
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>



-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180608/896f912e/attachment.html>
