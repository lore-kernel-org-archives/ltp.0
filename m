Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VP8qr-0007Bs-OE
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 10:31:17 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VP8qn-0002cp-SP
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 10:31:17 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 26 Sep 2013 14:30:33 +0400
Message-Id: <1380191440-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] cpuset controller fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com, miaox@cn.fujitsu.com

Hi!

I have very limited access to real hardware with 4 NUMA nodes. So most
of these fixes were checked with numa=fake=4 kernel cmdline.

It would be great if somebody verified it on real hardware.

And:
1. What do you think about idea of assigning to each cpuset controller test
a separate testcase name in runtest/controllers? Instead of using a single
run_cpuset_test.sh. 
This will greatly simplify output results analysis.

For example rename current cpuset01 testcase to cpuset12 and 
assign names cpuset01 cpuset11 cpuset_*.sh tests.

2. How do you think about adding a separate tst_kvercmp2 binary
(using tst_kvercmp2() function). 
It would help in cpuset_base_ops_testset.sh because several distribution
kernels have these fixes. Because on we also need to make testing based on
distribution kernel version.

Like this:
tst_kvercmp2 X Y Z "RHEL5:234 SLES10:0.91"

Thank you.


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
