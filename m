From: Murphy Zhou <xzhou@redhat.com>
Date: Mon, 10 Jun 2019 14:12:09 +0800
Subject: [LTP] [PATCH v6 2/4] swapon/libswapon: add helper
 is_swap_supported
In-Reply-To: <CAEemH2eezXfcn=cXPNDxTHf2wUn+auxh7jpJ3LuFnF-mm8yjig@mail.gmail.com>
References: <CAOQ4uxihom9Uw66c0BwuiWHOejZXDJHUe3rHBVRfk0=C-AYnAw@mail.gmail.com>
 <20190528141214.18752-1-xzhou@redhat.com>
 <20190528141214.18752-2-xzhou@redhat.com>
 <CAEemH2fcM18gLbM3bWRu7ddR+8QbmYCL+4U83Z5tiWgZ4suz_A@mail.gmail.com>
 <CAEemH2f275JA7f_mzyQwQeW8LJ2_YS5L42=KD1KWWGZKrmwitQ@mail.gmail.com>
 <20190605093005.qwpput3zxrd22z44@XZHOUW.usersys.redhat.com>
 <CAEemH2eezXfcn=cXPNDxTHf2wUn+auxh7jpJ3LuFnF-mm8yjig@mail.gmail.com>
Message-ID: <20190610061209.bsdrcld6ilh4vjk5@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 05, 2019 at 05:53:13PM +0800, Li Wang wrote:
> On Wed, Jun 5, 2019 at 5:30 PM Murphy Zhou <xzhou@redhat.com> wrote:
> 
> > On Wed, Jun 05, 2019 at 02:55:47PM +0800, Li Wang wrote:
> > > On Wed, Jun 5, 2019 at 1:51 PM Li Wang <liwang@redhat.com> wrote:
> > >
> > > >
> > > >
> > > > On Tue, May 28, 2019 at 10:13 PM Murphy Zhou <xzhou@redhat.com> wrote:
> > > >
> > > >> To check if the filesystem we are testing on supports FIBMAP, mkswap,
> > > >> swapon and swapoff operations.
> > > >> Modify make_swapfile function to test mkswap support status safely.
> > > >>
> > > >> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> > > >> ---
> > > >>  testcases/kernel/syscalls/swapon/libswapon.c | 45
> > +++++++++++++++++++-
> > > >>  testcases/kernel/syscalls/swapon/libswapon.h |  7 ++-
> > > >>  2 files changed, 49 insertions(+), 3 deletions(-)
> > > >>
> > > >> diff --git a/testcases/kernel/syscalls/swapon/libswapon.c
> > > >> b/testcases/kernel/syscalls/swapon/libswapon.c
> > > >> index cf6a98891..f66d19548 100644
> > > >> --- a/testcases/kernel/syscalls/swapon/libswapon.c
> > > >> +++ b/testcases/kernel/syscalls/swapon/libswapon.c
> > > >> @@ -19,13 +19,15 @@
> > > >>   *
> > > >>   */
> > > >>
> > > >> +#include <errno.h>
> > > >> +#include "lapi/syscalls.h"
> > > >>  #include "test.h"
> > > >>  #include "libswapon.h"
> > > >>
> > > >>  /*
> > > >>   * Make a swap file
> > > >>   */
> > > >> -void make_swapfile(void (cleanup)(void), const char *swapfile)
> > > >> +int make_swapfile(void (cleanup)(void), const char *swapfile, int
> > safe)
> > > >>  {
> > > >>         if (!tst_fs_has_free(NULL, ".", sysconf(_SC_PAGESIZE) * 10,
> > > >>             TST_BYTES)) {
> > > >> @@ -45,5 +47,44 @@ void make_swapfile(void (cleanup)(void), const char
> > > >> *swapfile)
> > > >>         argv[1] = swapfile;
> > > >>         argv[2] = NULL;
> > > >>
> > > >> -       tst_run_cmd(cleanup, argv, "/dev/null", "/dev/null", 0);
> > > >> +       return tst_run_cmd(cleanup, argv, "/dev/null", "/dev/null",
> > safe);
> > > >> +}
> > > >> +
> > > >> +/*
> > > >> + * Check swapon/swapoff support status of filesystems or files
> > > >> + * we are testing on.
> > > >> + */
> > > >> +void is_swap_supported(void (cleanup)(void), const char *filename)
> > > >> +{
> > > >> +       int fibmap = tst_fibmap(filename);
> > > >> +       long fs_type = tst_fs_type(cleanup, filename);
> > > >> +       const char *fstype = tst_fs_type_name(fs_type);
> > > >> +
> > > >> +       int ret = make_swapfile(NULL, filename, 1);
> > > >> +       if (ret != 0) {
> > > >> +               if (fibmap != 0) {
> > > >>
> > > >
> > > > As I replied in patch 1/4, how do we know that means FIBMAP not
> > support if
> > > > just verify fibmap != 0?
> > > > So I would suggest to make the return value of tst_fibmap() is more
> > > > precise and do if (fibmap == 1) check here.
> >
> > Very good catch. The return value should be more precise. Thanks!
> >
> > > >
> > >
> > > And also, imagine that if swapon01 test failed on BRTFS or NFS(support
> > > swapfile but not
> > > support FIBMAP ioctl), then here will report the new bug as a TCONF to
> > LTP.
> >
> > Here is testing mkswap for swapon test preparation. If mkswap fail, and
> > FIBMAP not supported, it's reasonable to me that we should not go on to
> > test swapon.
> >
> > But yes, if a regression causes mkswap fail without FIBMAP supported, we
> > could miss the bug here like you described. This situation should be
> > covered by tcase for mkswap IMO.
> >
> 
> I'm thinking maybe we cann't avoid adding a whilelist in the test, at least
> for known filesystem without FIBMAP supported.

No, I think we don't need a whilelist here. Amir and I discussed long way
to here, you can check that. We are not using fibmap test as a verdict for
swapfile is supported or not. Doing a mkswap/swapon/swapoff test before
real tests to detect the support situation. tst_fibmap result helps us
to decide how to report. If the underneath filesystem can survive these
test, it should be supporting swapfiles and swapon/swapoff tests should
run.

The whitelisted nfs and tmpfs are well covered by these pre-tests. More, 
NFS should not be skipped as if we turn on kernle configs for NFS_SWAP,
these tests can run on NFS.

Whitelist could skip more tests and bugs.

I tested some fibmap/mkswap/swapon/swapoff tests for your reference:

1 means positive, 0 means negative.

-------- On 5.3-rc3+ kernel, NFS_SWAP=y SUNRPC_SWAP=y -------
	fibamp	mkswap	swapon swapoff
xfs	1	1	1	1
ext4	1	1	1	1

btrfs	0	1	0	0
tmpfs	0	1	0	0

ovl	1	1	1	1

cifs
v3.11	0	1	0	0
v1	0	1	0	0
v2	0	1	0	0

nfs
v4.2	0	1	1*	1
v4.1	0	1	1	1
v4.0	0	1	1* 	1
v3	0	1	1	1

* hang sometimes

--------- On 3.10.0 based kernel ----------------
	fibamp	mkswap	swapon swapoff
xfs	1	1	1	1
ext4	1	1	1	1

btrfs	0	1	0	0
tmpfs	0	1	0	0

ovl	1	1	1	1

cifs
v3.0	0	1	0	0

nfs
v4.2	0	1	0	0


---------- On 2.6.32 based kernel ---------------
	fibamp	mkswap	swapon swapoff
tmpfs	0	1	0	0
xfs	1	1	1	1
ext4	1	1	1	1
cifs	0	0	0	0
nfs	0	0	0	0

> 
> FYI: what do you think if change the is_swap_supported(...) like this?
> 
> void is_swap_supported(void (cleanup)(void), const char *filename)
> {
>         int fibmap = tst_fibmap(filename);
> 
>         if (fibmap == 1) {

fibmap == 0 does not mean swapfile is supported. We need to make sure that
survivors of this function are supporting swapfiles.

Thanks,
Murphy

>                 int ret;
>                 long fs_type = tst_fs_type(cleanup, filename);
>                 const char *fstype = tst_fs_type_name(fs_type);
> 
>                 ret = make_swapfile(NULL, filename, 1);
>                 if (ret != 0) {
>                         if (fs_type == TST_NFS_MAGIC ||
>                                 fs_type == TST_TMPFS_MAGIC ||
>                                 fs_type == TST_BRTFS_MAGIC) {
>                                 tst_brkm(TFAIL, cleanup,
>                                         "mkswap on %s failed", fstype);
>                         } else {
>                                 tst_brkm(TCONF, cleanup,
>                                         "mkswap on %s not supported",
> fstype);
>                         }
>                 }
> 
>                 TEST(ltp_syscall(__NR_swapon, filename, 0));
>                 if (TEST_RETURN == -1) {
>                         if (errno == EINVAL) {
>                                 tst_brkm(TCONF, cleanup,
>                                          "Swapfile on %s not implemented",
> fstype);
>                         } else {
>                                 tst_brkm(TFAIL | TERRNO, cleanup,
>                                          "swapon on %s failed", fstype);
>                         }
>                 }
> 
>                 TEST(ltp_syscall(__NR_swapoff, filename, 0));
>                 if (TEST_RETURN == -1) {
>                         tst_brkm(TFAIL | TERRNO, cleanup,
>                                 "swapoff on %s failed", fstype);
>                 }
>         }
> }
> 
> >
> > I'm going to dig more on fibmap/mkswap/swapon/swapoff support status of
> > varies filesystems.
> >
> > >
> > >
> > > > +                       tst_brkm(TCONF, cleanup,
> > > >> +                               "mkswap on %s not supported", fstype);
> > > >> +               } else {
> > > >> +                       tst_brkm(TFAIL, cleanup,
> > > >> +                               "mkswap on %s failed", fstype);
> > > >> +               }
> > > >> +       }
> > > >> +
> > > >> +       TEST(ltp_syscall(__NR_swapon, filename, 0));
> > > >> +       if (TEST_RETURN == -1) {
> > > >> +               if (fibmap != 0 && errno == EINVAL) {
> > > >> +                       tst_brkm(TCONF, cleanup,
> > > >> +                               "Swapfile on %s not implemented",
> > fstype);
> > > >>
> > > >
> > > > Maybe there is unnecessary to check fibmap value again? Since if the
> > > > fibmap is 1, it has already broken in make_swapfile() error handler and
> > > > never coming here?
> >
> > If mkswap succeeds, we are coming here.
> >
> 
> Ah yes. I missed that situation.
> 
> >
> > Thanks for reviewing!
> > Murphy
> >
> > > >
> > > >
> > > >
> > > >> +               } else {
> > > >> +                       tst_brkm(TFAIL | TERRNO, cleanup,
> > > >> +                                "swapon on %s failed", fstype);
> > > >> +               }
> > > >> +       }
> > > >> +
> > > >> +       TEST(ltp_syscall(__NR_swapoff, filename, 0));
> > > >> +       if (TEST_RETURN == -1) {
> > > >> +               tst_brkm(TFAIL | TERRNO, cleanup,
> > > >> +                       "swapoff on %s failed", fstype);
> > > >> +       }
> > > >>  }
> > > >> diff --git a/testcases/kernel/syscalls/swapon/libswapon.h
> > > >> b/testcases/kernel/syscalls/swapon/libswapon.h
> > > >> index 7f7211eb4..a51833ec1 100644
> > > >> --- a/testcases/kernel/syscalls/swapon/libswapon.h
> > > >> +++ b/testcases/kernel/syscalls/swapon/libswapon.h
> > > >> @@ -29,6 +29,11 @@
> > > >>  /*
> > > >>   * Make a swap file
> > > >>   */
> > > >> -void make_swapfile(void (cleanup)(void), const char *swapfile);
> > > >> +int make_swapfile(void (cleanup)(void), const char *swapfile, int
> > safe);
> > > >>
> > > >> +/*
> > > >> + * Check swapon/swapoff support status of filesystems or files
> > > >> + * we are testing on.
> > > >> + */
> > > >> +void is_swap_supported(void (cleanup)(void), const char *filename);
> > > >>  #endif /* __LIBSWAPON_H__ */
> > > >> --
> > > >> 2.21.0
> > > >>
> > > >>
> > > >> --
> > > >> Mailing list info: https://lists.linux.it/listinfo/ltp
> > > >>
> > > >
> > > >
> > > > --
> > > > Regards,
> > > > Li Wang
> > > >
> > >
> > >
> > > --
> > > Regards,
> > > Li Wang
> >
> 
> 
> -- 
> Regards,
> Li Wang
