From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 17 Aug 2020 19:14:04 +0530
Subject: [LTP] [PATCH 02/23] fs: refactor ksys_umount
In-Reply-To: <CA+G9fYuYxGBKR5aQqCQwA=SjLRDbyQKwQYJvbJRaKT7qwy7voQ@mail.gmail.com>
References: <20200728163416.556521-1-hch@lst.de>
 <20200728163416.556521-3-hch@lst.de>
 <CA+G9fYuYxGBKR5aQqCQwA=SjLRDbyQKwQYJvbJRaKT7qwy7voQ@mail.gmail.com>
Message-ID: <CA+G9fYs4w46bZtgaKTzTLgaqNDcw3vdRaKWuGJ4wN4SSKJqUKA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 6 Aug 2020 at 20:14, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 28 Jul 2020 at 22:04, Christoph Hellwig <hch@lst.de> wrote:
> >
> > Factor out a path_umount helper that takes a struct path * instead of the
> > actual file name.  This will allow to convert the init and devtmpfs code
> > to properly mount based on a kernel pointer instead of relying on the
> > implicit set_fs(KERNEL_DS) during early init.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/namespace.c | 40 ++++++++++++++++++----------------------
> >  1 file changed, 18 insertions(+), 22 deletions(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 6f8234f74bed90..43834b59eff6c3 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c

<trim>

>
> Regressions on linux next 20200803 tag kernel.
> LTP syscalls test umount03 mount a path for testing and
> umount failed and retired for 50 times and test exit with warning
> and following test cases using that mount path failed.
>
> LTP syscalls tests failed list,
>     * umount03
>     * umount2_01
>     * umount2_02
>     * umount2_03
>     * utime06
>     * copy_file_range01

The reported issue has been fixed in linux next 20200817 tag by
below patch.

fs: fix a struct path leak in path_umount
Make sure we also put the dentry and vfsmnt in the illegal flags and
!may_umount cases.
Fixes: 41525f56e256 ("fs: refactor ksys_umount")

- Naresh
