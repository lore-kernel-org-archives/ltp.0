Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VQdUx-0001L3-BF
	for ltp-list@lists.sourceforge.net; Mon, 30 Sep 2013 13:26:51 +0000
Date: Mon, 30 Sep 2013 15:27:15 +0200
From: chrubis@suse.cz
Message-ID: <20130930132714.GA4034@rei.suse.cz>
References: <1380191440-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1380191440-18171-7-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130926120601.GE14003@rei.suse.cz> <52442EAB.6070805@oracle.com>
	<20130926135731.GA15992@rei.suse.cz>
	<20130926140639.GB15992@rei.suse.cz> <52493A44.8060409@oracle.com>
	<52496FD1.6010604@oracle.com> <20130930130403.GA3917@rei.suse.cz>
	<52497984.7090909@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52497984.7090909@oracle.com>
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
> I suppose the problem is of different nature. The problem is that
> the caches are not dropped after performing 'dd'. And since dd is executed
> in root cpuset (at the beginning of the testcase where no other cpusets 
> are defined),
> these caches are spread among all memory nodes.
> 
> The test process is placed in desired cpuset. It reads DATAFILE (which is
> already in memory, since the caches are in memory), but this reading 
> doesn't increase
> memory consumption.
> 
> And delta (memory consumption after mem_hog's reading - memory 
> consumption before mem_hog's
> reading taken on each node) is equal to zero (approximately). So the 
> testcase fails.

Ah, that explains it. Thanks for the detailed description (and don't
forget to add this information into the corresponding git commit
message).

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
