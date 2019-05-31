From: Li Wang <liwang@redhat.com>
Date: Fri, 31 May 2019 19:47:24 +0800
Subject: [LTP] [PATCH] syscalls/copy_file_range02.c: Compatible with new
 and old kernels
In-Reply-To: <20190531110122.GA8819@rei.lan>
References: <1559292243-2882-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <20190531110122.GA8819@rei.lan>
Message-ID: <CAEemH2eU+xcrDuW5UV=VCWhmHqrtOTE3HV=1Dr8cU8FWsBfLnw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 31, 2019 at 7:01 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > The patch as follows:
> > commit 11cbfb10775a ("vfs: deny copy_file_range() for non regular files")
> >
> > Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
> > ---
> >  .../syscalls/copy_file_range/copy_file_range02.c   | 33
> +++++++++++++++-------
> >  1 file changed, 23 insertions(+), 10 deletions(-)
> >
> > diff --git
> a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> > index 07c0207..9e6356c 100644
> > --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> > +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> > @@ -54,19 +54,32 @@ static void verify_copy_file_range(unsigned int n)
> >       TEST(sys_copy_file_range(fd_src, 0, *tc->copy_to_fd,
> >                               0, CONTSIZE, tc->flags));
> >
> > -     if (TST_RET == -1) {
> > -             if (tc->exp_err == TST_ERR) {
> > +     if (TST_RET != -1) {
> > +             tst_res(TFAIL,
> > +                     "copy_file_range returned wrong value: %ld",
> TST_RET);
> > +             return;
> > +     }
> > +
> > +     if (tc->exp_err == TST_ERR) {
> > +             tst_res(TPASS | TTERRNO,
> > +                     "copy_file_range failed as expected");
> > +     } else {
> > +             /* copy_file_range() returned EISDIR when copyed contents
> to
> > +              * directory on new kernels, but on old kernels, it
> returned
> > +              * EBADF.
> > +              *
> > +              * the patch as follws:
> > +              * commit 11cbfb10775a ("vfs: deny copy_file_range() for
> non regular files")
> > +              */
> > +             if (tc->exp_err == EISDIR && TST_ERR == EBADF) {
> >                       tst_res(TPASS | TTERRNO,
> > -                                     "copy_file_range failed as
> expected");
>
> If nothing else this should be guarded by kernel version check because
> if new kernel starts to return EBADFD again, that would be regression.
>
> So we should check the kernel version in test setup and set a flag that
> would be checked here as well.
>

This is a good suggestion. Another point I can come up is, if an LTS Linux
distribution backports that commit 11cbfb10775a to their old kernel as
regression fix, then this flag will make no sense.

So, to strict we maybe need to regards the EISDIR as the only one legal
errno(copying content to dir) when  kernel >= 4.10(includes commit
11cbfb10775a).


>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190531/61205c12/attachment-0001.html>
