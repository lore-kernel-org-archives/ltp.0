From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Feb 2021 11:11:55 +0800
Subject: [LTP] [PATCH] open_posix_testsuite: correct fork11-1 report log
In-Reply-To: <60331FCB.2020108@cn.fujitsu.com>
References: <20210220123724.16939-1-liwang@redhat.com>
 <60331FCB.2020108@cn.fujitsu.com>
Message-ID: <CAEemH2fO_kcboA0RYXZPGgua_Uv2aB8YDHEOViRy27=tNXS4cw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

Merged, thanks for your review!

On Mon, Feb 22, 2021 at 11:06 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> Hi Li
> Looks good to me,
> Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>
> ps: My pc (I use it to merge patch) is not with me, you can merge this
> yourself.
> > Signed-off-by: Li Wang<liwang@redhat.com>
> > ---
> >   .../open_posix_testsuite/conformance/interfaces/fork/11-1.c   | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git
> a/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
> > index 8a7796cfd..e31f3896f 100644
> > --- a/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
> > +++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
> > @@ -47,7 +47,7 @@ static int child(int fd)
> >
> >       if (fcntl(fd, F_SETLK,&fl) == -1) {
> >               if (errno == EACCES || errno == EAGAIN) {
> > -                     printf("PASSED: child did not inherit the lock\n");
> > +                     printf("PASSED: Child locked file already locked
> by parent\n");
> >                       return PTS_PASS;
> >               }
> >
> > @@ -56,7 +56,7 @@ static int child(int fd)
> >               return PTS_UNRESOLVED;
> >       }
> >
> > -     printf("Child locked file already locked by parent\n");
> > +     printf("Child did not inherit the lock\n");
> >       return PTS_FAIL;
> >   }
> >
>
>
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210222/0b765d04/attachment-0001.htm>
