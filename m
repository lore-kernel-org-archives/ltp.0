From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 28 May 2019 17:52:58 +0300
Subject: [LTP] [PATCH v6 2/4] swapon/libswapon: add helper
	is_swap_supported
In-Reply-To: <20190528141214.18752-2-xzhou@redhat.com>
References: <CAOQ4uxihom9Uw66c0BwuiWHOejZXDJHUe3rHBVRfk0=C-AYnAw@mail.gmail.com>
 <20190528141214.18752-1-xzhou@redhat.com>
 <20190528141214.18752-2-xzhou@redhat.com>
Message-ID: <CAOQ4uxj46qHPmufpCwhAr6z7MaKzvw7ei5R427CbD=3e9he59g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 28, 2019 at 5:12 PM Murphy Zhou <xzhou@redhat.com> wrote:
>
> To check if the filesystem we are testing on supports FIBMAP, mkswap,
> swapon and swapoff operations.
> Modify make_swapfile function to test mkswap support status safely.
>
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>

Looks ok to me

> ---
>  testcases/kernel/syscalls/swapon/libswapon.c | 45 +++++++++++++++++++-
>  testcases/kernel/syscalls/swapon/libswapon.h |  7 ++-
>  2 files changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/swapon/libswapon.c b/testcases/kernel/syscalls/swapon/libswapon.c
> index cf6a98891..f66d19548 100644
> --- a/testcases/kernel/syscalls/swapon/libswapon.c
> +++ b/testcases/kernel/syscalls/swapon/libswapon.c
> @@ -19,13 +19,15 @@
>   *
>   */
>
> +#include <errno.h>
> +#include "lapi/syscalls.h"
>  #include "test.h"
>  #include "libswapon.h"
>
>  /*
>   * Make a swap file
>   */
> -void make_swapfile(void (cleanup)(void), const char *swapfile)
> +int make_swapfile(void (cleanup)(void), const char *swapfile, int safe)
>  {
>         if (!tst_fs_has_free(NULL, ".", sysconf(_SC_PAGESIZE) * 10,
>             TST_BYTES)) {
> @@ -45,5 +47,44 @@ void make_swapfile(void (cleanup)(void), const char *swapfile)
>         argv[1] = swapfile;
>         argv[2] = NULL;
>
> -       tst_run_cmd(cleanup, argv, "/dev/null", "/dev/null", 0);
> +       return tst_run_cmd(cleanup, argv, "/dev/null", "/dev/null", safe);
> +}
> +
> +/*
> + * Check swapon/swapoff support status of filesystems or files
> + * we are testing on.
> + */
> +void is_swap_supported(void (cleanup)(void), const char *filename)
> +{
> +       int fibmap = tst_fibmap(filename);
> +       long fs_type = tst_fs_type(cleanup, filename);
> +       const char *fstype = tst_fs_type_name(fs_type);
> +
> +       int ret = make_swapfile(NULL, filename, 1);
> +       if (ret != 0) {
> +               if (fibmap != 0) {
> +                       tst_brkm(TCONF, cleanup,
> +                               "mkswap on %s not supported", fstype);
> +               } else {
> +                       tst_brkm(TFAIL, cleanup,
> +                               "mkswap on %s failed", fstype);
> +               }
> +       }
> +
> +       TEST(ltp_syscall(__NR_swapon, filename, 0));
> +       if (TEST_RETURN == -1) {
> +               if (fibmap != 0 && errno == EINVAL) {
> +                       tst_brkm(TCONF, cleanup,
> +                               "Swapfile on %s not implemented", fstype);
> +               } else {
> +                       tst_brkm(TFAIL | TERRNO, cleanup,
> +                                "swapon on %s failed", fstype);
> +               }
> +       }
> +
> +       TEST(ltp_syscall(__NR_swapoff, filename, 0));
> +       if (TEST_RETURN == -1) {
> +               tst_brkm(TFAIL | TERRNO, cleanup,
> +                       "swapoff on %s failed", fstype);
> +       }
>  }
> diff --git a/testcases/kernel/syscalls/swapon/libswapon.h b/testcases/kernel/syscalls/swapon/libswapon.h
> index 7f7211eb4..a51833ec1 100644
> --- a/testcases/kernel/syscalls/swapon/libswapon.h
> +++ b/testcases/kernel/syscalls/swapon/libswapon.h
> @@ -29,6 +29,11 @@
>  /*
>   * Make a swap file
>   */
> -void make_swapfile(void (cleanup)(void), const char *swapfile);
> +int make_swapfile(void (cleanup)(void), const char *swapfile, int safe);
>
> +/*
> + * Check swapon/swapoff support status of filesystems or files
> + * we are testing on.
> + */
> +void is_swap_supported(void (cleanup)(void), const char *filename);
>  #endif /* __LIBSWAPON_H__ */
> --
> 2.21.0
>
