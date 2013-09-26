Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VPCCy-000745-V0
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 14:06:20 +0000
Date: Thu, 26 Sep 2013 16:06:40 +0200
From: chrubis@suse.cz
Message-ID: <20130926140639.GB15992@rei.suse.cz>
References: <1380191440-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1380191440-18171-7-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130926120601.GE14003@rei.suse.cz> <52442EAB.6070805@oracle.com>
	<20130926135731.GA15992@rei.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130926135731.GA15992@rei.suse.cz>
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
> > If I remove this sleep and perform two sequential runs I get this error:
> > root@debian7-x64:/opt/ltp/testcases/bin# ./cpuset_memory_spread_testset.sh
> > 100+0 records in
> > 100+0 records out
> > 104857600 bytes (105 MB) copied, 0.0595533 s, 1.8 GB/s
> > cpuset11    1  TFAIL  :  hog the memory on the unexpected 
> > node(FilePages_For_Nodes(KB): _0: 0
> > _1: 336
> > _2: 0
> > _3: 0, Expect Nodes: 0).
> > 
> > But if I take a few seconds between two runs the error disappears.
> > 
> > I suppose this is an environment issue but don't know how to manage it.
> 
> Hmm, strange indeed, so it looks like the memory is allocated under
> wrong node.
> 
> I would guess that there is someting wrong with the cpuset that moves
> the test process into the new set. Maybe the system needs some time to
> move the process memory to the node we specified.

What about cating /proc/$test_pid/status before we allocate the memory
and checking that Mems_allowed_list matches the expected node?

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
