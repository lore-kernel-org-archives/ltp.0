From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Jul 2018 16:52:24 +0200
Subject: [LTP] [PATCH 2/3] syscalls/alarm03: Rewrite to new library
In-Reply-To: <20180725142030.GC23890@rei>
References: <1532431855-18452-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1532431855-18452-2-git-send-email-huangjh.jy@cn.fujitsu.com>
 <20180725142030.GC23890@rei>
Message-ID: <20180725145224.GD21960@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > -	tst_sig(FORK, DEF_HANDLER, cleanup);
> > -
> > -	signal(SIGALRM, trapper);
> > -
> > -	TEST_PAUSE;
> > +	SAFE_SIGNAL(SIGALRM, sighandler);
> 
> I do wonder why do we call the SAFE_SIGNAL() here?
> 
> It does not make much sense.

Actually why we are even installing the signal handler, we do not wait
for the alarm to fire anyways.

-- 
Cyril Hrubis
chrubis@suse.cz
