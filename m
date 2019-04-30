From: Murphy Zhou <xzhou@redhat.com>
Date: Tue, 30 Apr 2019 16:30:56 +0800
Subject: [LTP] [PATCH] syscalls/swapon02: Do not fail on overlayfs
In-Reply-To: <CAEemH2c0FYg+WoCJfzWmaUiANE3pcpdXT2fHVGXsL_qnRJUn+A@mail.gmail.com>
References: <20190430071446.13716-1-xzhou@redhat.com>
 <CAEemH2c0FYg+WoCJfzWmaUiANE3pcpdXT2fHVGXsL_qnRJUn+A@mail.gmail.com>
Message-ID: <20190430083056.b6q2p6yzqbp2q6fm@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 30, 2019 at 04:14:23PM +0800, Li Wang wrote:
> On Tue, Apr 30, 2019 at 3:21 PM Murphy Zhou <xzhou@redhat.com> wrote:
> 
> > Currently swapfiles on Overlayfs are not supported.
> >
> > So if we are on overlayfs and we get EINVAL from swapon() we return TCONF.
> >
> > Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> > ---
> >  testcases/kernel/syscalls/swapon/swapon02.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/swapon/swapon02.c
> > b/testcases/kernel/syscalls/swapon/swapon02.c
> > index 4af5105c6..211cdfc4e 100644
> > --- a/testcases/kernel/syscalls/swapon/swapon02.c
> > +++ b/testcases/kernel/syscalls/swapon/swapon02.c
> > @@ -86,6 +86,11 @@ static void verify_swapon(struct test_case_t *test)
> >                         return;
> >         }
> >
> > +       if (fs_type == TST_OVERLAYFS_MAGIC && errno == EINVAL) {
> > +               tst_resm(TCONF, "Swapfile on overlayfs not implemeted");
> > +                       return;
> > +       }
> >
> 
> The code looks correct.
> 
> But it already has a test skipping for BTRFS, is there any possibility to
> combine these filesystems check together?

Good idea~  Sending V2.

Thansk!
M

> 
> 
> > +
> >         tst_resm(TFAIL, "swapon(2) failed to produce expected error:"
> >                  " %d, errno: %s and got %d.", test->exp_errno,
> >                  test->exp_errval, TEST_ERRNO);
> > --
> > 2.21.0
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> >
> 
> 
> -- 
> Regards,
> Li Wang
