From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Apr 2021 13:32:52 +0200
Subject: [LTP] [PATCH] lib/tst_test.c: Bugfix for heartbeat
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B4974@dggeml531-mbx.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B4974@dggeml531-mbx.china.huawei.com>
Message-ID: <YHWBZLHgDx1q9kIb@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks for your review!
> 
> > > +       } else
> > > +               kill(getppid(), SIGUSR1);
> > 
> > No need for the else branch here now that we do exit() a the end of the if
> > () block.
> >
> 
> Generally speaking, It seems that we also need the else branch since we need to send heart beat to the main process.

What I meant was that the code could be structured as:


	if (getppid() == 1) {
		...
		exit(TBROK);
	}

	kill(getppid(), SIGUSR1);

Hence there is no need for the else branch.

-- 
Cyril Hrubis
chrubis@suse.cz
