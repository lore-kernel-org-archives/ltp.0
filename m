From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 Apr 2017 17:31:31 +0200
Subject: [LTP] [PATCH] pan/ltp-pan.c: fix incorrect number of total tests
In-Reply-To: <58EC4F4B.7040003@cn.fujitsu.com>
References: <1491544700-6312-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170410135021.GC23301@rei.lan> <58EC4F4B.7040003@cn.fujitsu.com>
Message-ID: <20170412153131.GD25790@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Actually, the coll->cnt is number of tests loaded from the runtest file.
> However, starts is set to coll->cnt at first , and it reduces when 
> completing one test.
> Please see the following code:
> cpid =
> run_child(coll->ary[c], running + i, quiet_mode,
> &failcnt, fmt_print, logfile);
> if (cpid != -1)
> ++num_active;
> if ((cpid != -1 || sequential) && starts > 0)
> --starts;
> 
> I think that ltp-pan could indicate the number of tests which have been 
> run when receiving one signal.

Hmm, ok, so unless starts is set to -1, which means "execute the testrun
until interrupted" this would result in the number of executed tests, if
starts is -1 the result is incorrect anyway.

But to get it really correct we should rather add a counter and count
each started test child or something.

> I am not familiar with ltp-pan code???so do you have some suggestions 
> about it?

Well the ltp-pan code is messy and the tool is in a maintenance mode,
which means that we only do bugfixes. This looks like a bug so I'm not
against fixing it but at the same time I do not think that this is
important enough. So my suggestion would be to wait for the new LTP
test runner that I started to work on some time ago and keep up with
ltp-pan.c as it is until then.

-- 
Cyril Hrubis
chrubis@suse.cz
