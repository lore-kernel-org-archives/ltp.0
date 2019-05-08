From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 May 2019 13:22:15 +0300
Subject: [LTP] [PATCH v3] syscalls/swap{on,
	off}: skip if FIBMAP ioctl trial fails
In-Reply-To: <20190508034331.hc6rssg4mc66k5xc@XZHOUW.usersys.redhat.com>
References: <20190430152949.17723-1-xzhou@redhat.com>
 <20190430235915.19512-1-xzhou@redhat.com>
 <CAEemH2f3Dq9tpoD8Cq+vJ5SYoaOfVQdP3FQU-6op52U+1p=Yeg@mail.gmail.com>
 <20190508034331.hc6rssg4mc66k5xc@XZHOUW.usersys.redhat.com>
Message-ID: <CAOQ4uxjDyx7JFBSmkDe-rHNe=NriT710Ldsva=s+HasaDL0CTw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, May 8, 2019 at 6:43 AM Murphy Zhou <xzhou@redhat.com> wrote:
>
> Hi,
>
> Thanks for reviewing!
>
> On Tue, May 07, 2019 at 04:52:01PM +0800, Li Wang wrote:
> > Hi Murphy,
> >
> > On Wed, May 1, 2019 at 7:59 AM Murphy Zhou <xzhou@redhat.com> wrote:
> >
> > > That means swapfile in the test filesystem is not supported.
> > > Add a test helper to do a FIBMAP ioctl test. Remove old fs type whitelist
> > > code.
> > >
> > > Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> > > ---
> > > v2:
> > >    Test FIBMAP instead of fstype whitelist.
> > > v3:
> > >    Fix fs_type undeclared in swapoff01.c.
> > >
> > >  include/tst_fs.h                              |  5 +++
> > >  lib/tst_ioctl.c                               | 41 +++++++++++++++++++
> > >  testcases/kernel/syscalls/swapoff/swapoff01.c | 13 ++----
> > >  testcases/kernel/syscalls/swapoff/swapoff02.c | 11 +++--
> > >  testcases/kernel/syscalls/swapon/swapon01.c   | 13 ++----
> > >  testcases/kernel/syscalls/swapon/swapon02.c   | 16 ++------
> > >  testcases/kernel/syscalls/swapon/swapon03.c   | 20 ++-------
> > >  7 files changed, 65 insertions(+), 54 deletions(-)
> > >  create mode 100644 lib/tst_ioctl.c
> > >
> > > diff --git a/include/tst_fs.h b/include/tst_fs.h
> > > index b2b19ada6..cc38b3547 100644
> > > --- a/include/tst_fs.h
> > > +++ b/include/tst_fs.h
> > > @@ -172,6 +172,11 @@ const char **tst_get_supported_fs_types(void);
> > >   */
> > >  void tst_fill_fs(const char *path, int verbose);
> > >
> > > +/*
> > > + * test if FIBMAP ioctl is supported
> > > + */
> > > +int tst_fibmap(void);
> > > +
> > >  #ifdef TST_TEST_H__
> > >  static inline long tst_fs_type(const char *path)
> > >  {
> > > diff --git a/lib/tst_ioctl.c b/lib/tst_ioctl.c
> > > new file mode 100644
> > > index 000000000..d468d5898
> > > --- /dev/null
> > > +++ b/lib/tst_ioctl.c
> > > @@ -0,0 +1,41 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +
> > > +#include <errno.h>
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <sys/ioctl.h>
> > > +#include <linux/fs.h>
> > > +
> > > +#define TST_NO_DEFAULT_MAIN
> > > +
> > > +#include "tst_test.h"
> > > +
> > > +int tst_fibmap(void)
> > > +{
> > > +       /* test if FIBMAP ioctl is supported */
> > > +       int fd, block = 0;
> > > +       const char *tmpdir = getenv("TMPDIR");
> > > +       char buf[128];
> > > +
> > > +       tst_res(TINFO, "Testing if FIBMAP ioctl is supported in %s",
> > > tmpdir);
> > > +
> > > +       sprintf(buf, "%s/tst_fibmap", tmpdir);
> > > +
> > > +       fd = open(buf, O_RDWR | O_CREAT, 0666);
> > > +       if (fd < 0) {
> > > +               tst_res(TWARN | TERRNO,
> > > +                        "open(%s, O_RDWR | O_CREAT, 0666) failed", buf);
> > > +               return 1;
> > > +       }
> > > +
> > > +       if (ioctl(fd, FIBMAP, &block)) {
> > > +               close(fd);
> > > +               return 1;
> > > +       }
> > > +
> > > +       if (close(fd)) {
> > > +               tst_res(TWARN | TERRNO, "close(fd) failed");
> > > +               return 1;
> > > +       }
> > > +       return 0;
> > > +}
> > > diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c
> > > b/testcases/kernel/syscalls/swapoff/swapoff01.c
> > > index a63e661a5..a37cd9be1 100644
> > > --- a/testcases/kernel/syscalls/swapoff/swapoff01.c
> > > +++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
> > > @@ -55,11 +55,6 @@ int main(int ac, char **av)
> > >  static void verify_swapoff(void)
> > >  {
> > >         if (ltp_syscall(__NR_swapon, "./swapfile01", 0) != 0) {
> > > -               if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
> > > -                       tst_brkm(TCONF, cleanup,
> > > -                                "Swapfiles on BTRFS are not implemented");
> > > -               }
> > > -
> > >                 tst_resm(TBROK, "Failed to turn on the swap file"
> > >                          ", skipping test iteration");
> > >                 return;
> > > @@ -86,13 +81,11 @@ static void setup(void)
> > >
> > >         tst_tmpdir();
> > >
> > > -       switch ((fs_type = tst_fs_type(cleanup, "."))) {
> > > -       case TST_NFS_MAGIC:
> > > -       case TST_TMPFS_MAGIC:
> > > +       fs_type = tst_fs_type(cleanup, ".");
> > > +       if (tst_fibmap()) {
> > >                 tst_brkm(TCONF, cleanup,
> > > -                        "Cannot do swapoff on a file on %s filesystem",
> > > +                        "Cannot do FIBMAP ioctl on a file on %s
> > > filesystem",
> > >                          tst_fs_type_name(fs_type));
> > > -       break;
> > >         }
> > >
> > >         if (!tst_fs_has_free(NULL, ".", 64, TST_MB)) {
> > > diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c
> > > b/testcases/kernel/syscalls/swapoff/swapoff02.c
> > > index b5c6312a1..889f3c800 100644
> > > --- a/testcases/kernel/syscalls/swapoff/swapoff02.c
> > > +++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
> > > @@ -43,6 +43,7 @@ char *TCID = "swapoff02";
> > >  int TST_TOTAL = 3;
> > >
> > >  static uid_t nobody_uid;
> > > +static long fs_type;
> > >
> > >  static struct test_case_t {
> > >         char *err_desc;
> > > @@ -138,13 +139,11 @@ static void setup(void)
> > >
> > >         tst_tmpdir();
> > >
> > > -       switch ((type = tst_fs_type(cleanup, "."))) {
> > > -       case TST_NFS_MAGIC:
> > > -       case TST_TMPFS_MAGIC:
> > > +       fs_type = tst_fs_type(cleanup, ".");
> > > +       if (tst_fibmap()) {
> > >                 tst_brkm(TCONF, cleanup,
> > > -                        "Cannot do swapoff on a file on %s filesystem",
> > > -                        tst_fs_type_name(type));
> > > -       break;
> > > +                        "Cannot do FIBMAP ioctl on a file on %s
> > > filesystem",
> > > +                        tst_fs_type_name(fs_type));
> > >         }
> > >
> > >         if (!tst_fs_has_free(NULL, ".", 1, TST_KB)) {
> > > diff --git a/testcases/kernel/syscalls/swapon/swapon01.c
> > > b/testcases/kernel/syscalls/swapon/swapon01.c
> > > index 32538f82b..0a5a3de86 100644
> > > --- a/testcases/kernel/syscalls/swapon/swapon01.c
> > > +++ b/testcases/kernel/syscalls/swapon/swapon01.c
> > > @@ -39,11 +39,6 @@ static void verify_swapon(void)
> > >         TEST(ltp_syscall(__NR_swapon, "./swapfile01", 0));
> > >
> > >         if (TEST_RETURN == -1) {
> > > -               if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
> > > -                       tst_brkm(TCONF, cleanup,
> > > -                                "Swapfile on BTRFS not implemeted");
> > > -                       return;
> > > -               }
> > >                 tst_resm(TFAIL | TTERRNO, "Failed to turn on swapfile");
> > >         } else {
> > >                 tst_resm(TPASS, "Succeeded to turn on swapfile");
> > > @@ -84,13 +79,11 @@ static void setup(void)
> > >
> > >         tst_tmpdir();
> > >
> > > -       switch ((fs_type = tst_fs_type(cleanup, "."))) {
> > > -       case TST_NFS_MAGIC:
> > > -       case TST_TMPFS_MAGIC:
> > > +       fs_type = tst_fs_type(cleanup, ".");
> > > +       if (tst_fibmap()) {
> > >
> >
> > I'm not sure whether FIBMAP ioctl FAIL means that swapfile is unsupportted
> > on a filesystem.

Li is correct here. BTRFS and NFS on recent kernel support swapfile but not
support FIBMAP ioctl, so if you want to add test coverage for NFS and
BTRFS, I'm afraid they would have to be whitelisted after all, but not
is setup()
because depending on kernel, they may support swapfile and may not.
Worse even, BTRFS had FIBMAP support for a while and then removed, see:
ed46ff3d4237 Btrfs: support swap files
35054394c4b3 Btrfs: stop providing a bmap operation to avoid swapfile
corruptions

Sorry I missed this before.

> > If that's true, shouldn't we verify FIBMAP ioctl on the swapfile?  Here you
> > just test that in a tmp file, it probably not a correct way I guess.
>
> We don't need to test on a swapfile. If the filesystem we are testing
> supports FIBMAP iotcl, we can make a file in this filesystem a swapfile.
>

In theory, FIBMAP can work on certain files and fail on certain files
(e.g. reflinked xfs/ocfs2 file), but that is unlikely the case in this test
and not related to file being a swap file.

In conclusion
1. If filesystem supports FIBMAP its a very strong indication that
    filesystem supports swapfile, but in theory a future  filesystem
    could fail this test (don't see a reason for that to happen).
2. If filesystem does not support FIBMAP it can support swapfile
    btrfs and nfs are examples in current upstream, but in future could
    be other filesystems as well

Suggestion: test in setup FIBMAP. If not supported don't fail immediately
but do the try and fail softly with TCONF that is currently implemented
for TST_BTRFS_MAGIC.

Thanks,
Amir.
