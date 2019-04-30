From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Apr 2019 16:54:23 +0800
Subject: [LTP] [PATCH] syscalls/swapon02: Do not fail on overlayfs
In-Reply-To: <20190430083056.b6q2p6yzqbp2q6fm@XZHOUW.usersys.redhat.com>
References: <20190430071446.13716-1-xzhou@redhat.com>
 <CAEemH2c0FYg+WoCJfzWmaUiANE3pcpdXT2fHVGXsL_qnRJUn+A@mail.gmail.com>
 <20190430083056.b6q2p6yzqbp2q6fm@XZHOUW.usersys.redhat.com>
Message-ID: <CAEemH2d-xLCFayr8uCycdYZCtwg1YRHJcpXjdzRCi6zJ6_rMPw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 30, 2019 at 4:31 PM Murphy Zhou <xzhou@redhat.com> wrote:

> On Tue, Apr 30, 2019 at 04:14:23PM +0800, Li Wang wrote:
> > On Tue, Apr 30, 2019 at 3:21 PM Murphy Zhou <xzhou@redhat.com> wrote:
> >
> > > Currently swapfiles on Overlayfs are not supported.
> > >
> > > So if we are on overlayfs and we get EINVAL from swapon() we return
> TCONF.
> > >
> > > Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> > > ---
> > >  testcases/kernel/syscalls/swapon/swapon02.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/testcases/kernel/syscalls/swapon/swapon02.c
> > > b/testcases/kernel/syscalls/swapon/swapon02.c
> > > index 4af5105c6..211cdfc4e 100644
> > > --- a/testcases/kernel/syscalls/swapon/swapon02.c
> > > +++ b/testcases/kernel/syscalls/swapon/swapon02.c
> > > @@ -86,6 +86,11 @@ static void verify_swapon(struct test_case_t *test)
> > >                         return;
> > >         }
> > >
> > > +       if (fs_type == TST_OVERLAYFS_MAGIC && errno == EINVAL) {
> > > +               tst_resm(TCONF, "Swapfile on overlayfs not
> implemeted");
> > > +                       return;
> > > +       }
> > >
> >
> > The code looks correct.
> >
> > But it already has a test skipping for BTRFS, is there any possibility to
> > combine these filesystems check together?
>
> Good idea~  Sending V2.
>

One more comment.

I just noticed that it also has an FS skipping list in setup(), do u think
can we move BTRFS and OVERLAYFS to there?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190430/40504742/attachment.html>
