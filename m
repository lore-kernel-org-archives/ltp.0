From: Murphy Zhou <xzhou@redhat.com>
Date: Wed, 5 Jun 2019 12:44:57 +0800
Subject: [LTP] [PATCH v6 1/4] lib/tst_ioctl.c: add helper tst_fibmap
In-Reply-To: <20190528141214.18752-1-xzhou@redhat.com>
References: <CAOQ4uxihom9Uw66c0BwuiWHOejZXDJHUe3rHBVRfk0=C-AYnAw@mail.gmail.com>
 <20190528141214.18752-1-xzhou@redhat.com>
Message-ID: <20190605044457.egj3nnp574otnso6@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Ping on this one.

Thanks~

On Tue, May 28, 2019 at 10:12:11PM +0800, Murphy Zhou wrote:
> To check if FIBMAP ioctl is supported on the filesystem we are
> testing on. It also can check the support status of specific
> files, but that may not needed for now.
> 
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
> v6:
>   Modify make_swapfile() to check mkswap support status safely
>   Remove whitelist
>   Remove BTRFS EINVAL check
>   Check mkswap status before testing swapon in helper
>   If swapon pass, following swapoff failure will fail the whole test and break
>   Also modify swapoff02 to remove whitelist completely
> v5:
>   Split to 4 patches
>   Only take one filename parameter in tst_fibmap
>   Add helper is_swap_supported to check swap operation support status
>   Test fibmap/swapon and swapoff operation in the helper
>   Keep NFS/TMPFS whitelist
>   Keep BTRFS EINVAL handling logic, except above 2 situation:
>     if swapon fails and fibmap is not supported, tst_brk with TCONF
>     if swapon fails and fibmap is supported, tst_brk with TFAIL
>   If swapon test pass in the helper, test swapoff similarly
>   Put is_swap_supported helper in libswapon, link swapoff binaries to it
>   Mute a sprintf filaname wanrning by the way
> v4:
>   Fail softly if FIBMAP nit supported, instead of skip entire testcase
> v3:
>   Fix fs_type undeclared in swapoff01.c
> v2:
>   Test FIBMAP instead of fstype whitelist
> 
>  include/tst_fs.h |  5 +++++
>  lib/tst_ioctl.c  | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>  create mode 100644 lib/tst_ioctl.c
> 
> diff --git a/include/tst_fs.h b/include/tst_fs.h
> index ebca065c6..6d03371ec 100644
> --- a/include/tst_fs.h
> +++ b/include/tst_fs.h
> @@ -178,6 +178,11 @@ const char **tst_get_supported_fs_types(void);
>   */
>  void tst_fill_fs(const char *path, int verbose);
>  
> +/*
> + * test if FIBMAP ioctl is supported
> + */
> +int tst_fibmap(const char *filename);
> +
>  #ifdef TST_TEST_H__
>  static inline long tst_fs_type(const char *path)
>  {
> diff --git a/lib/tst_ioctl.c b/lib/tst_ioctl.c
> new file mode 100644
> index 000000000..38aa937db
> --- /dev/null
> +++ b/lib/tst_ioctl.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/ioctl.h>
> +#include <linux/fs.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +
> +#include "tst_test.h"
> +
> +int tst_fibmap(const char *filename)
> +{
> +	/* test if FIBMAP ioctl is supported */
> +	int fd, block = 0;
> +
> +	fd = open(filename, O_RDWR | O_CREAT, 0666);
> +	if (fd < 0) {
> +		tst_res(TWARN | TERRNO,
> +			 "open(%s, O_RDWR | O_CREAT, 0666) failed", filename);
> +		return 1;
> +	}
> +
> +	if (ioctl(fd, FIBMAP, &block)) {
> +		tst_res(TINFO, "FIBMAP ioctl is NOT supported");
> +		close(fd);
> +		return 1;
> +	}
> +	tst_res(TINFO, "FIBMAP ioctl is supported");
> +
> +	if (close(fd)) {
> +		tst_res(TWARN | TERRNO, "close(fd) failed");
> +		return 1;
> +	}
> +	return 0;
> +}
> -- 
> 2.21.0
> 
