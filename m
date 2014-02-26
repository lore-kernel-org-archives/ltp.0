Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WIg6c-0000rX-Bd
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 15:09:06 +0000
Date: Wed, 26 Feb 2014 16:08:50 +0100
From: chrubis@suse.cz
Message-ID: <20140226150850.GB27609@rei>
References: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20140211151034.GA15043@rei.Home> <530C7004.3060102@oracle.com>
	<20140226134703.GA27609@rei> <530DF8C6.50600@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <530DF8C6.50600@oracle.com>
Subject: Re: [LTP] rpc-tirpc-full-test-suite
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > You can skip the whole subdirectory in rpc/Makefile if tirpc is not
> > found with:
> >
> > ifeq ($(RPC_LIBS),)
> > FILTER_OUT_DIRS+=rpc-tirpc-full-test-suite
> > endif
> >
> > Assuming that the RPC_LIBS behaves the same way as NUMA_LIBS for
> > example.
> >
> > And please shorten the directory names when you are at it,
> > rpc-tirpc-full-test-suite is far to long and tirpc or similar would do
> > the same job.
> 
> Sorry, did you mean to rename rpc-tirpc-full-test-suite to tirpc or 
> similar?

Yes, I'm not a friend of overly descriptive names. So either tirpc or
tirpc-test-suite or anything short enough and descriptive.

> >> Make corresponding changes in current execution/building infrastructure
> >> under rpc-tirpc-full-test-suite. Maybe someone will need it. And I don't
> >> feel that I have a right to remove all these shell scripts and etc.
> >
> > I would personaly remove the current execution/building infrastructure
> > and focus on the LTP integration. Managing two parallel systems is much
> > more work and unless somebody will use the current system it will get
> > broken sooner or later.
> 
> Ok. But maybe move this stuff into a subdirectory under 
> rpc-tirpc-full-test-suite? Just in case...

I would not bother, it's contained in about 10 released LTP tarballs
that are all archived in sf.net download area and it's in a git history
as well and the original tarball is stil reachable at:
http://nfsv4.bullopensource.org/doc/rpc_testsuite.php

Let's concentrate on making it run flawlessly in default LTP run.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
