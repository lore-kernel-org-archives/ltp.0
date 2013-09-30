Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VQd8X-0007Yy-1D
	for ltp-list@lists.sourceforge.net; Mon, 30 Sep 2013 13:03:41 +0000
Date: Mon, 30 Sep 2013 15:04:03 +0200
From: chrubis@suse.cz
Message-ID: <20130930130403.GA3917@rei.suse.cz>
References: <1380191440-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1380191440-18171-7-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130926120601.GE14003@rei.suse.cz> <52442EAB.6070805@oracle.com>
	<20130926135731.GA15992@rei.suse.cz>
	<20130926140639.GB15992@rei.suse.cz> <52493A44.8060409@oracle.com>
	<52496FD1.6010604@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52496FD1.6010604@oracle.com>
Subject: Re: [LTP] [PATCH 6/7] cpuset_memory_spread_test: number of nodes
 and sleep timeout
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, miaox@cn.fujitsu.com

Hi!
> > Hmmm, Mems_allowed* content of /proc/$test_pid/status before sending
> > SIGUSR1 to $test_pid is:
> >
> > Mems_allowed:    00000000,00000001
> > Mems_allowed_list:    0
> > cpuset11    1  TFAIL  :  hog the memory on the unexpected
> > node(FilePages_For_Nodes(KB): _0: 112
> > _1: 0
> > _2: 0
> > _3: 0, Expect Nodes: 0).
> >
> > i.e. It is a failure on:
> >      base_test "0" "0" "0" "0"
> >
> > So, may be, It's a testcase issue. I'm Looking more deeply.
> >
> >
> 
> It seems that just
>    /bin/echo 3 > /proc/sys/vm/drop_caches
> is not sufficient to free memory.

Right, that drops only caches that are synced to disks and could be
freed without waiting for writeback.

> In accordance to Documentation/sysctl/vm.txt we need to invoke 'sync' 
> before that.
> 
> I removed all the 'sleep's from the testcases and add a single sync 
> before sending SIGUSR1 to mem_hog.
> 
> After that this testcase started to work reliable.

Sounds good.

So the problem (given the symptoms) may be that the test process wasn't
moved to the desired cpuset right away because kernel needed to shuffle
the process caches and since the transition wasn't complete the memory
allocated meanwhile was stil at the wrong node?

If that is so, we may also add a check that the process is moved to the
cpuset allready before starting the test. But let's proceed with the
fixes and cleanups we allready have first.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
