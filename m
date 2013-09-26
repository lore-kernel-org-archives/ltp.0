Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VPA11-0002IT-Eb
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 11:45:51 +0000
Date: Thu, 26 Sep 2013 13:46:04 +0200
From: chrubis@suse.cz
Message-ID: <20130926114604.GD14003@rei.suse.cz>
References: <1380191440-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1380191440-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] cpuset controller fixes
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
> And:
> 1. What do you think about idea of assigning to each cpuset controller test
> a separate testcase name in runtest/controllers? Instead of using a single
> run_cpuset_test.sh. 
> This will greatly simplify output results analysis.
> 
> For example rename current cpuset01 testcase to cpuset12 and 
> assign names cpuset01 cpuset11 cpuset_*.sh tests.
> 
> 2. How do you think about adding a separate tst_kvercmp2 binary
> (using tst_kvercmp2() function). 
> It would help in cpuset_base_ops_testset.sh because several distribution
> kernels have these fixes. Because on we also need to make testing based on
> distribution kernel version.
> 
> Like this:
> tst_kvercmp2 X Y Z "RHEL5:234 SLES10:0.91"

Both sounds good to me.

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
