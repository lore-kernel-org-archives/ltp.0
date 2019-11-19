From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Nov 2019 13:34:49 +0800
Subject: [LTP] [PATCH] fallocate05: increase FALLOCATE_SIZE
In-Reply-To: <d8ad4bab26557fdf70e7ebc3f771bbb37ae889d7.1574093242.git.jstancek@redhat.com>
References: <d8ad4bab26557fdf70e7ebc3f771bbb37ae889d7.1574093242.git.jstancek@redhat.com>
Message-ID: <CAEemH2eu8HcQ90+BxUL0Hu+No6P5je4xC3oqVSU_ZnwMXEG=7Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

On Tue, Nov 19, 2019 at 12:08 AM Jan Stancek <jstancek@redhat.com> wrote:

> write() returning ENOSPC doesn't guarantee that filesystem after
> some internal book-keeping, flushing, finishing transactions, etc.
> won't still find some extra space.
>

Thanks for the patch, I have drafted a similar one but you sent out first
:).

Another patch I was thinking is to enhance the tst_fill_fs routine, which
as Eric suggested, makes more reliably to get to a full filesystem.
Something like what xfstest does to cut the trial write size in half and
try again until the size is less than the filesystem block size.

Comments?

--- a/lib/tst_fill_fs.c
+++ b/lib/tst_fill_fs.c
@@ -6,6 +6,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/statvfs.h>

 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
@@ -19,6 +20,8 @@ void tst_fill_fs(const char *path, int verbose)
        size_t len;
        ssize_t ret;
        int fd;
+       struct statvfs fi;
+       statvfs(path, &fi);

        for (;;) {
                len = random() % (1024 * 102400);
@@ -41,6 +44,12 @@ void tst_fill_fs(const char *path, int verbose)
                        ret = write(fd, buf, MIN(len, sizeof(buf)));

                        if (ret < 0) {
+                               if (errno == ENOSPC) {
+                                       len /= 2;
+                                       if (len >= fi.f_bsize)
+                                               continue;
+                               }
+
                                SAFE_CLOSE(fd);

                                if (errno != ENOSPC)



>
> Increase FALLOCATE_SIZE to minimize chance of hitting sporadic
> failures when that happens.
>
> Thanks to Carlos Maiolino and Eric Sandeen for their comments
> and suggestions.
>
> Fixes #610
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>
Reviewed-by: Li Wang <liwang@redhat.com>


> ---
>  testcases/kernel/syscalls/fallocate/fallocate05.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c
> b/testcases/kernel/syscalls/fallocate/fallocate05.c
> index 50c610c448ba..17034e5b11e7 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate05.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
> @@ -17,7 +17,7 @@
>  #include "lapi/fallocate.h"
>
>  #define MNTPOINT "mntpoint"
> -#define FALLOCATE_SIZE 8192
> +#define FALLOCATE_SIZE (1024*1024)
>  #define TESTED_FLAGS "fallocate(FALLOC_FL_PUNCH_HOLE |
> FALLOC_FL_KEEP_SIZE)"
>
>  static int fd;
> --
> 1.8.3.1
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191119/9aa93bfa/attachment.htm>
