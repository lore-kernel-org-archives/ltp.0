From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Apr 2019 17:21:34 +0800
Subject: [LTP] [PATCH] syscalls/swapon02: Do not fail on overlayfs
In-Reply-To: <20190430090846.s2ctvbipxgs6nprr@XZHOUW.usersys.redhat.com>
References: <20190430071446.13716-1-xzhou@redhat.com>
 <CAEemH2c0FYg+WoCJfzWmaUiANE3pcpdXT2fHVGXsL_qnRJUn+A@mail.gmail.com>
 <20190430083056.b6q2p6yzqbp2q6fm@XZHOUW.usersys.redhat.com>
 <CAEemH2d-xLCFayr8uCycdYZCtwg1YRHJcpXjdzRCi6zJ6_rMPw@mail.gmail.com>
 <20190430090846.s2ctvbipxgs6nprr@XZHOUW.usersys.redhat.com>
Message-ID: <CAEemH2dvDqWq7XMS_dNkuKkE31FejY59H+cvX37R8xCeo0uD3Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 30, 2019 at 5:08 PM Murphy Zhou <xzhou@redhat.com> wrote:

> ...
> > > > > +       if (fs_type == TST_OVERLAYFS_MAGIC && errno == EINVAL) {
> > > > > +               tst_resm(TCONF, "Swapfile on overlayfs not
> > > implemeted");
> > > > > +                       return;
> > > > > +       }
> > > > >
> > > >
> > > > The code looks correct.
> > > >
> > > > But it already has a test skipping for BTRFS, is there any
> possibility to
> > > > combine these filesystems check together?
> > >
> > > Good idea~  Sending V2.
> > >
> >
> > One more comment.
> >
> > I just noticed that it also has an FS skipping list in setup(), do u
> think
> > can we move BTRFS and OVERLAYFS to there?
>
> Great! That makes perfect sense. Also I'm thinking a few other tweaks
> needed:
>
>   NFS now actually support swapfiles. Let's remove it from skip list;
>

But AFAIK someone still run LTP on old distro/kernel, so we can't guarantee
the test works fine in that situation. So, my opinion is to reserve the
NFS, or do you have a better way to make test more flexible?


>   Skip all swapon/swapoff tests on TMPFS BTRFS OVERLAYFS;
>   Add CIFS_MAGIC, then skip on it too;
>   Remove existing BTRFS return value tweaks.
>

Agree.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190430/1dbfc940/attachment.html>
