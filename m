From: Li Wang <liwang@redhat.com>
Date: Tue, 12 Jun 2018 21:05:22 +0800
Subject: [LTP] [PATCH] swapon: commit swapfile caches to disk
In-Reply-To: <20180612124822.GA18870@rei>
References: <1528806239-14297-1-git-send-email-liwang@redhat.com>
 <20180612124822.GA18870@rei>
Message-ID: <CAEemH2dofgvXn7fFyzA_mWA+aZTeNJH=nXNQ86nTiO0UzBd2CQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Tue, Jun 12, 2018 at 8:48 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Testcase include swapon(8) fails on mainline kernel-v4.17+ as:
> >   swapon01    1  TFAIL  :  swapon01.c:47: Failed to turn on swapfile:
> TEST_ERRNO=EINVAL(22): Invalid argument
> >   swapon02    4  TFAIL  :  swapon02.c:91: swapon(2) failed to produce
> expected error: 16, errno: EBUSY and got 22.
> >   swapon03    1  TFAIL  :  swapon03.c:243: Failed to setup swaps
> >   swapoff01   1  TBROK  :  swapoff01.c:64: Failed to turn on the swap
> file, skipping test iteration
>
> 4.17+ means that this is yet to be release kernel, right? In that
> situation we wait if the change will survive upon the official release
> before changing the LTP test.
>

​You are right, I'm OK to wait.
​


>
> > diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c
> b/testcases/kernel/syscalls/swapoff/swapoff01.c
> > index a63e661..b587b0d 100644
> > --- a/testcases/kernel/syscalls/swapoff/swapoff01.c
> > +++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
> > @@ -105,6 +105,8 @@ static void setup(void)
> >
> >       if (system("mkswap swapfile01 > tmpfile 2>&1") != 0)
> >               tst_brkm(TBROK, cleanup, "Failed to make swapfile");
> > +
> > +     sync();
>
> Can we rather use fsync() and/or fdatasync()? I would like the avoid the
> system wide sync() here since that may slow down the test unnecessarily.
>
>
​Actually I tried to add fsync() and syncfs() in tst_fill_file.c first, but
it does NOT works for me.  After tracking more, I found that we have to
sync up caches in front of the command `mkswap swapfile`.​



> --
> Cyril Hrubis
> chrubis@suse.cz
>



-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180612/4c553103/attachment.html>
