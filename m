From: Murphy Zhou <xzhou@redhat.com>
Date: Tue, 28 May 2019 17:56:22 +0800
Subject: [LTP] [PATCH v5 2/4] swapon/libswapon: add helper
	is_swap_supported
In-Reply-To: <CAOQ4uxj_0F3pWGCLA4Fxcq54TVViid_8G3fpJw89Un8UfCo87g@mail.gmail.com>
References: <20190523135518.GF30616@rei.lan>
 <20190528043929.19671-1-xzhou@redhat.com>
 <20190528043929.19671-2-xzhou@redhat.com>
 <CAOQ4uxj_0F3pWGCLA4Fxcq54TVViid_8G3fpJw89Un8UfCo87g@mail.gmail.com>
Message-ID: <20190528095622.gi5islpc7zlmpc2n@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 28, 2019 at 08:56:06AM +0300, Amir Goldstein wrote:
> On Tue, May 28, 2019 at 7:40 AM Murphy Zhou <xzhou@redhat.com> wrote:
> >
> > To check if the filesystem we are testing on supports swapon/swapoff
> > operations. Keep NFS and TMPFS on the white list. Don't report fail
> > if BTRFS fails with EINVAL.
> 
> Changes look very good, but I don't think you need the whitelist anymore...
> 
> >
> > Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> > ---
> >  testcases/kernel/syscalls/swapon/libswapon.c | 56 ++++++++++++++++++++
> >  testcases/kernel/syscalls/swapon/libswapon.h |  6 +++
> >  2 files changed, 62 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/swapon/libswapon.c b/testcases/kernel/syscalls/swapon/libswapon.c
> > index cf6a98891..e02fdd4ad 100644
> > --- a/testcases/kernel/syscalls/swapon/libswapon.c
> > +++ b/testcases/kernel/syscalls/swapon/libswapon.c
> > @@ -19,6 +19,8 @@
> >   *
> >   */
> >
> > +#include <errno.h>
> > +#include "lapi/syscalls.h"
> >  #include "test.h"
> >  #include "libswapon.h"
> >
> > @@ -47,3 +49,57 @@ void make_swapfile(void (cleanup)(void), const char *swapfile)
> >
> >         tst_run_cmd(cleanup, argv, "/dev/null", "/dev/null", 0);
> >  }
> > +
> > +/*
> > + * Check swapon/swapoff support status of filesystems or files
> > + * we are testing on.
> > + */
> > +void is_swap_supported(void (cleanup)(void), const char *ops,
> > +                               const char *filename)
> > +{
> > +       int fibmap = tst_fibmap(filename);
> > +       long fs_type = tst_fs_type(cleanup, filename);
> > +       const char *fstype = tst_fs_type_name(fs_type);
> > +
> > +       /* whitelist legacy fs */
> > +       switch (fs_type) {
> > +       case TST_NFS_MAGIC:
> > +       case TST_TMPFS_MAGIC:
> > +               tst_brkm(TCONF, cleanup,
> > +                        "Cannot do %s on a file on %s filesystem",
> > +                        ops, fstype);
> > +       break;
> > +       }
> 
> If you remove this whitelist, then NFS,tmpfs will reach the fiemap != 0 case
> and result in tst_brkm(TCONF anyway.
> 
> > +
> > +       make_swapfile(NULL, filename);
> > +
> > +       TEST(ltp_syscall(__NR_swapon, filename, 0));
> > +
> > +       if (TEST_RETURN == -1) {
> > +               if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
> 
> If you replace (fs_type == TST_BTRFS_MAGIC) with (fibmap != 0)
> then NFS swapfile support could be tested as well and you do not
> special case any filesystem.

There is a surprise that on old kernels, 2.6.32 based, this change
would TBROK whitelisted NFS TCONF while mkswap swapfiles.

TBROK on mkswap failure seems the right thing to do, but the whitelist
here intended to fix this false alarm.

I remember Li suggested that un-whitelist NFS would break old distros.
TMPFS is fine.

Maybe we should safely check if mkswap is doable before checking swapon?
mkswap fail, fibmap fail --> tst_brk TCONF
mkswap fail, fibmap pass --> tst_brk TFAIL

Thanks,
Murphy
> 
> 
> > +                       tst_brkm(TCONF, cleanup,
> > +                               "Swapfile on BTRFS not implemented");
> > +               } else {
> > +                       if (fibmap == 0) {
> 
> and then you don't need this extra test.
> 
> > +                               tst_brkm(TFAIL | TERRNO, cleanup,
> > +                                        "swapon on %s failed", fstype);
> > +                       } else {
> > +                               tst_brkm(TCONF, cleanup,
> > +                                        "swapon on %s is not supported",
> > +                                               fstype);
> > +                       }
> > +               }
> > +       }
> > +
> > +       TEST(ltp_syscall(__NR_swapoff, filename, 0));
> > +
> > +       if (TEST_RETURN == -1) {
> > +               if (fibmap == 0) {
> > +                       tst_brkm(TFAIL | TERRNO, cleanup,
> > +                               "swapoff on %s failed", fstype);
> > +               } else {
> > +                       tst_brkm(TCONF, cleanup,
> > +                                "swapoff on %s is not supported", fstype);
> > +               }
> 
> I don't think there should be any TCONF here.
> If we reached here then swapon is supported - in that case
> failure to swapoff is a real failure.
> 
> Thanks,
> Amir.
