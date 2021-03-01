From: zhaogongyi <zhaogongyi@huawei.com>
Date: Mon, 1 Mar 2021 02:30:19 +0000
Subject: [LTP] [PATCH] fanotify13.c/setxattr01.c: Remove requirement of
 needs_tmpdir
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB403883535@dggeml531-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> 
> Hi gongyi
> > The testcases aim to run on all_filesystems, so we need remove the
> > requirement of needs_tmpdir.
> >
> This commit message is confusing. See commit dae8427740f(" Remove
> duplicated ".needs_tmpdir=1" when using equivalent flags").
> 
> The needs_tmpdir flag is not needed to be set when use these flags:
> '.all_filesystems', '.format_device', '.mntpoint', '.mount_device'
> '.needs_checkpoints', '.needs_device', '.resource_file'.
>   These flags imply creating temporary directory.
> 
> Does have other case still have this duplicated flag?

	I have resubmit the patch which added 4 testcases that have this duplicated flag and midified the git log.


> 
> > Signed-off-by: Zhao Gongyi<zhaogongyi@huawei.com>
> > ---
> >   testcases/kernel/syscalls/fanotify/fanotify13.c | 1 -
> >   testcases/kernel/syscalls/setxattr/setxattr01.c | 1 -
> >   2 files changed, 2 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c
> > b/testcases/kernel/syscalls/fanotify/fanotify13.c
> > index 6d812cdd1..1fb12ae68 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify13.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
> > @@ -289,7 +289,6 @@ static struct tst_test test = {
> >   	.setup = do_setup,
> >   	.cleanup = do_cleanup,
> >   	.needs_root = 1,
> > -	.needs_tmpdir = 1,
> >   	.mount_device = 1,
> >   	.mntpoint = MOUNT_PATH,
> >   	.all_filesystems = 1,
> > diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c
> > b/testcases/kernel/syscalls/setxattr/setxattr01.c
> > index 8b84dfe0d..8cd2821d0 100644
> > --- a/testcases/kernel/syscalls/setxattr/setxattr01.c
> > +++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
> > @@ -210,7 +210,6 @@ static struct tst_test test = {
> >   	.mntpoint = MNTPOINT,
> >   	.mount_device = 1,
> >   	.all_filesystems = 1,
> > -	.needs_tmpdir = 1,
> >   	.needs_root = 1,
> >   };
> >
> > --
> > 2.17.1
> >
> >
> 
> 

