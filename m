From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed, 4 Nov 2020 15:01:07 +0800
Subject: [LTP] [PATCH] syscalls/quotactl04: add mkfs.ext4 package
 version check
In-Reply-To: <5FA2321D.30907@cn.fujitsu.com>
References: <20201104041544.17048-1-po-hsu.lin@canonical.com>
 <5FA2321D.30907@cn.fujitsu.com>
Message-ID: <CAMy_GT8uVNzP=Q9aXS0nxXnMiZJhKQuB3RiRuqDNuYgwOrUKxQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 4, 2020 at 12:46 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:
>
> Hi Po-hsu
>
> > The project quota feature was added in e2fsprogs 1.43 [1]:
> >    E2fsprogs 1.43 (May 17, 2016)
> >      Add support for the ext4 metadata checksum, checksum seed, inline
> >      data, encryption, project quota, and read-only features.
> >
> > The test should be skipped when running with older package, otherwise
> > it will fail with:
> >    Invalid filesystem option set: quota,project
> >
> > Use popen and fscanf to get mkfs.ext4 -V output for version
> > comparison. This version checking by adding digits together does not
> > work with alphabets in the number like rc1, but in that case the test
> > will still be tested.
> >
> > It will now be skipped with (Tested with Ubuntu Xenial + 4.15 kernel):
> >    quotactl04.c:118: TCONF: Test needs mkfs.ext4>= 1.43 for encrypt
> >    option, test skipped
> >
> > [1] http://e2fsprogs.sourceforge.net/e2fsprogs-release.html#1.42.13
> >
> > Signed-off-by: Po-Hsu Lin<po-hsu.lin@canonical.com>
> > ---
> >   testcases/kernel/syscalls/quotactl/quotactl04.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
> > index 73980d7e9..1cef8fcf3 100644
> > --- a/testcases/kernel/syscalls/quotactl/quotactl04.c
> > +++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
> > @@ -19,6 +19,8 @@
> >    * 7) quotactl(2) succeeds to get disk quota limit greater than or equal to
> >    *    ID with Q_GETNEXTQUOTA flag for project.
> >    * 8) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for project.
> > + *
> > + * Minimum e2fsprogs version required is 1.43.
> >    */
> >
> >   #include<errno.h>
> > @@ -28,6 +30,7 @@
> >   #include<sys/stat.h>
> >   #include "config.h"
> >   #include "lapi/quotactl.h"
> > +#include "tst_safe_stdio.h"
> >   #include "tst_test.h"
> >
> >   #ifndef QFMT_VFS_V1
> > @@ -102,9 +105,18 @@ static struct tcase {
> >
> >   static void setup(void)
> >   {
> > +     FILE *f;
> >       const char *const fs_opts[] = {"-I 256", "-O quota,project", NULL};
> > +     int rc, major, minor, patch;
> >
> >       test_id = geteuid();
> > +     f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
> > +     rc = fscanf(f, "mke2fs %d.%d.%d",&major,&minor,&patch);
> > +     if (rc != 3)
> > +             tst_res(TWARN, "Unable parse version number");
> > +     else if (major * 10000 + minor * 100 + patch<  14300)
> > +             tst_brk(TCONF, "Test needs mkfs.ext4>= 1.43 for encrypt option, test skipped");
>
> Test needs quota,project instead of encrypt option,
> other than this, it looks good to me
Ah sorry, it's a copy from another patch, I will resend this one.
Thanks!

>
> Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>
> > +     pclose(f);
> >       SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
> >       SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "quota");
> >       mount_flag = 1;
>
>
>
