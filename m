From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jan 2019 15:57:59 +0200
Subject: [LTP] [PATCH] [COMMITTED] syscalls/fadvise: Fix regression
In-Reply-To: <20190111132049.32121-1-chrubis@suse.cz>
References: <20190111132049.32121-1-chrubis@suse.cz>
Message-ID: <CAOQ4uxi9mdUP6szeTvb1dR2XTUHeE8ZcP-pM-g_mj-N7LJM_FQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jan 11, 2019 at 3:23 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> These test were disabled from execution without _FILE_OFFSET_BITS != 64
> since their conversion into the new library. The problem is that we
> didn't copied the original condition correctly. Originally the tests
> were disabled in case of:
>
> if ((_FILE_OFFSET_BITS != 64) && (__NR_fadvise64 == 0))
>
> While after the change they were disabled in case of:
>
> Now looking at the original condition the __NR_fadvise64 was never equal
> to 0, since the original tests included lapi/syscalls.h which defines
> fallback definitions with value -1. So either had the __NR_fadvise64
> correct value or was set to -1.
>
> All in all looking at the code it does not make sense to disable these
> tests anyway, so this commit just removes the ifdefs.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Amir Goldstein <amir73il@gmail.com>
> ---
>  testcases/kernel/syscalls/fadvise/posix_fadvise01.c | 11 -----------
>  testcases/kernel/syscalls/fadvise/posix_fadvise02.c | 11 -----------
>  testcases/kernel/syscalls/fadvise/posix_fadvise03.c | 11 -----------
>  testcases/kernel/syscalls/fadvise/posix_fadvise04.c | 10 ----------
>  4 files changed, 43 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> index e52692c06..2af040840 100644
> --- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> +++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> @@ -29,13 +29,7 @@
>  #include <string.h>
>
>  #include "tst_test.h"
> -
>  #include "lapi/syscalls.h"
> -#ifndef _FILE_OFFSET_BITS
> -#define _FILE_OFFSET_BITS 32
> -#endif
> -
> -#if (_FILE_OFFSET_BITS == 64)
>
>  char fname[] = "/bin/cat";     /* test executable to open */
>  int fd = -1;                   /* initialized in open */
> @@ -86,8 +80,3 @@ static struct tst_test test = {
>         .test = verify_fadvise,
>         .tcnt = ARRAY_SIZE(defined_advise),
>  };
> -
> -#else
> -       TST_TEST_TCONF("This test can only run on kernels that implements "
> -                       "fadvise64 which is used from posix_fadvise");
> -#endif

ACK. FWIW, I never understood the intention behind this build time check.

Not related to the cleanup nor to your regression fix, but his test does not
seem to cope well with kernel without CONFIG_ADVISE_SYSCALLS.

Thanks,
Amir.
