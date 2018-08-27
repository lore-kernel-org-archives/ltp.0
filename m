From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Aug 2018 00:48:47 +0200
Subject: [LTP] [PATCH] open_posix_testsuite/mmap_11-4: Skip this test on
 tmpfs
In-Reply-To: <1533102620-30244-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1533102620-30244-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180827224847.GA8057@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,
> According to mmap(2) manpage, when you write data to such partial
> page after the end of the object, the data stays in the page cache
> even after the file is closed and unmapped, subsequent mappings
> always see the modified content on tmpfs.  We just skip this test
> when running it on tmpfs.

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

> ---
>  .../conformance/interfaces/mmap/11-4.c                    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
> index 2b44815..a52b288 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
> @@ -40,8 +40,11 @@
>  #include <fcntl.h>
>  #include <string.h>
>  #include <errno.h>
> +#include <sys/vfs.h>
>  #include "posixtest.h"

> +#define TYPE_TMPFS_MAGIC	0x01021994

Thanks for your patch, pushed.

I don't like redefinition of TMPFS_MAGIC, but I didn't change it as openposix
subproject don't use include directory from root and therefore we can't use
TST_TMPFS_MAGIC from tst_fs.h. And I didn't add include of <linux/magic.h>
due the same inaccessibility of config.h.
Maybe it'd make sense to make access for some of the headers from include
directory.


Kind regards,
Petr
