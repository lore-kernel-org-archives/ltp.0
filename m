From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Nov 2019 11:24:47 +0800
Subject: [LTP] [PATCH v2] tst_fill_fs: enhance the filesystem filling
 routine
In-Reply-To: <20191125130155.GA8703@rei.lan>
References: <20191120072311.32333-1-liwang@redhat.com>
 <20191125130155.GA8703@rei.lan>
Message-ID: <CAEemH2cxS1KR1eYeBregDPU7qFMPH-4UggvprPhv3rO+UineEA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Nov 25, 2019 at 9:13 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
> > index 4003dce97..3015c066e 100644
> > --- a/lib/tst_fill_fs.c
> > +++ b/lib/tst_fill_fs.c
> > @@ -6,6 +6,7 @@
> >  #include <errno.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > +#include <sys/statvfs.h>
> >
> >  #define TST_NO_DEFAULT_MAIN
> >  #include "tst_test.h"
> > @@ -19,6 +20,8 @@ void tst_fill_fs(const char *path, int verbose)
> >       size_t len;
> >       ssize_t ret;
> >       int fd;
> > +     struct statvfs fi;
> > +     statvfs(path, &fi);
> >
> >       for (;;) {
> >               len = random() % (1024 * 102400);
> > @@ -37,17 +40,20 @@ void tst_fill_fs(const char *path, int verbose)
> >                       return;
> >               }
> >
> > -             while (len) {
> > +             while (len >= fi.f_bsize/2) {
> >                       ret = write(fd, buf, MIN(len, sizeof(buf)));
> >
> >                       if (ret < 0) {
> > +                             if (errno == ENOSPC) {
> > +                                     SAFE_FSYNC(fd);
> > +                                     len /= 2;
> > +                                     continue;
> > +                             }
> > +
> >                               SAFE_CLOSE(fd);
> >
> >                               if (errno != ENOSPC)
> >                                       tst_brk(TBROK | TERRNO, "write()");
> > -
> > -                             tst_res(TINFO | TERRNO, "write()");
> > -                             return;
> >                       }
> >
> >                       len -= ret;
>
> Wouldn't this cause second SAFE_CLOSE() here because we no longer do a
> return from from the while loop on ENOSPC?
>

No, it wouldn't cause that. The while's condition judgment will help to
go-out the loop when len < fi.f_bsize/2, and it only do SAFE_CLOSE() once
in any situation I think.


> Why not just:
>
> diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
> index 4003dce97..2226171d8 100644
> --- a/lib/tst_fill_fs.c
> +++ b/lib/tst_fill_fs.c
> @@ -41,6 +41,13 @@ void tst_fill_fs(const char *path, int verbose)
>                         ret = write(fd, buf, MIN(len, sizeof(buf)));
>
>                         if (ret < 0) {
> +                               /* retry on ENOSPC to make sure filesystem
> is really full */
> +                               if (errno == ENOSPC && len >=
> fi.f_bsize/2) {
> +                                       SAFE_FSYNC(fd);
> +                                       len /= 2;
> +                                       continue;
>

It does the same thing as my patch, but your code looks a little better
because it reserves the print&reutrn part in below.

I will send patch V3 on your suggestion.


> +                               }
> +
>                                 SAFE_CLOSE(fd);
>
>                                 if (errno != ENOSPC)
>
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191126/7afc91dc/attachment.htm>
