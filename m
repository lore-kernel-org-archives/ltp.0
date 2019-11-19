From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Nov 2019 03:13:32 -0500 (EST)
Subject: [LTP] [PATCH] fallocate05: increase FALLOCATE_SIZE
In-Reply-To: <CAEemH2eu8HcQ90+BxUL0Hu+No6P5je4xC3oqVSU_ZnwMXEG=7Q@mail.gmail.com>
References: <d8ad4bab26557fdf70e7ebc3f771bbb37ae889d7.1574093242.git.jstancek@redhat.com>
 <CAEemH2eu8HcQ90+BxUL0Hu+No6P5je4xC3oqVSU_ZnwMXEG=7Q@mail.gmail.com>
Message-ID: <1824199572.12930798.1574151212869.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Another patch I was thinking is to enhance the tst_fill_fs routine, which
> as Eric suggested, makes more reliably to get to a full filesystem.
> Something like what xfstest does to cut the trial write size in half and
> try again until the size is less than the filesystem block size.
> 
> Comments?

fallocate05 seems to be the only test using it, but in general I think we
can do that too. Assuming this alone would be reliable, is there any
advantage of running test with small FALLOCATE_SIZE?

> 
> --- a/lib/tst_fill_fs.c
> +++ b/lib/tst_fill_fs.c
> @@ -6,6 +6,7 @@
>  #include <errno.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <sys/statvfs.h>
> 
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
> @@ -19,6 +20,8 @@ void tst_fill_fs(const char *path, int verbose)
>         size_t len;
>         ssize_t ret;
>         int fd;
> +       struct statvfs fi;
> +       statvfs(path, &fi);
> 
>         for (;;) {
>                 len = random() % (1024 * 102400);
> @@ -41,6 +44,12 @@ void tst_fill_fs(const char *path, int verbose)
>                         ret = write(fd, buf, MIN(len, sizeof(buf)));
> 
>                         if (ret < 0) {
> +                               if (errno == ENOSPC) {
> +                                       len /= 2;
> +                                       if (len >= fi.f_bsize)
> +                                               continue;
> +                               }
> +
>                                 SAFE_CLOSE(fd);
> 
>                                 if (errno != ENOSPC)
> 
> 
> 
> >
> > Increase FALLOCATE_SIZE to minimize chance of hitting sporadic
> > failures when that happens.
> >
> > Thanks to Carlos Maiolino and Eric Sandeen for their comments
> > and suggestions.
> >
> > Fixes #610
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> >
> Reviewed-by: Li Wang <liwang@redhat.com>

Thanks, I pushed this patch for now. 

