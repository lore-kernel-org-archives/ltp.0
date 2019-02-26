From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Feb 2019 14:34:59 +0530
Subject: [LTP] [PATCH] [COMMITTED] syscalls/syncfs: Fix compilation
In-Reply-To: <20190225154921.13527-1-chrubis@suse.cz>
References: <20190225154921.13527-1-chrubis@suse.cz>
Message-ID: <CAFA6WYOUbq0_jyqnRV8vgT1WNjx6U2U84r5zKoX0uvNTgchR+w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 25 Feb 2019 at 21:19, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> The lapi/syncfs.h calls tst_syscall() which in turn uses tst_brk and
> TCONF, which is undefined until we include tst_test.h.
>
> This commit just swaps the tst_test.h and lapi/syncfs.h includes so that
> tst_test.h is included first, which fixed compilation on older
> distributions. This is a quick fix, cleaner solution may be done later
> on as a part of https://github.com/linux-test-project/ltp/issues/506.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/syscalls/syncfs/syncfs01.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for this fix.

-Sumit

>
> diff --git a/testcases/kernel/syscalls/syncfs/syncfs01.c b/testcases/kernel/syscalls/syncfs/syncfs01.c
> index 2210da617..051a19ea6 100644
> --- a/testcases/kernel/syscalls/syncfs/syncfs01.c
> +++ b/testcases/kernel/syscalls/syncfs/syncfs01.c
> @@ -16,8 +16,8 @@
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <sys/types.h>
> -#include "lapi/syncfs.h"
>  #include "tst_test.h"
> +#include "lapi/syncfs.h"
>  #include "check_syncfs.h"
>
>  #define MNTPOINT       "mnt_point"
> --
> 2.19.2
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
