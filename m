From: zhaogongyi <zhaogongyi@huawei.com>
Date: Tue, 13 Apr 2021 11:54:54 +0000
Subject: [LTP] [PATCH] lib/tst_test.c: Bugfix for heartbeat
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B49AE@dggeml531-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Thanks so much!

I have resubmit the patch according your review.

Best Regards,
Gongyi

> 
> Hi!
> > Thanks for your review!
> >
> > > > +       } else
> > > > +               kill(getppid(), SIGUSR1);
> > >
> > > No need for the else branch here now that we do exit() a the end of
> the if
> > > () block.
> > >
> >
> > Generally speaking, It seems that we also need the else branch since we
> need to send heart beat to the main process.
> 
> What I meant was that the code could be structured as:
> 
> 
> 	if (getppid() == 1) {
> 		...
> 		exit(TBROK);
> 	}
> 
> 	kill(getppid(), SIGUSR1);
> 
> Hence there is no need for the else branch.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
