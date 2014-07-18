Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<jbeckenbach=ltp-list=lists.sourceforge.net=jmtqtyzj@lancope.com>)
	id 1X8FoW-0005JV-V0
	for ltp-list@lists.sourceforge.net; Fri, 18 Jul 2014 21:35:36 +0000
Received: from smtp-out3.electric.net ([72.35.12.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X8FoV-0006VB-MR
	for ltp-list@lists.sourceforge.net; Fri, 18 Jul 2014 21:35:36 +0000
Received: from 1X8FoP-0006TB-TU by out3b.electric.net with emc1-ok (Exim
	4.80.1) (envelope-from <jbeckenbach@lancope.com>) id 1X8FoP-0006VQ-Uh
	for ltp-list@lists.sourceforge.net; Fri, 18 Jul 2014 14:35:29 -0700
Received: from [209.182.184.2] (helo=LCHQEX03.lancope.local)
	by out3b.electric.net with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.80.1) (envelope-from <jbeckenbach@lancope.com>)
	id 1X8FoP-0006TB-TU
	for ltp-list@lists.sourceforge.net; Fri, 18 Jul 2014 14:35:29 -0700
From: Joseph Beckenbach <jbeckenbach@lancope.com>
Date: Fri, 18 Jul 2014 21:35:27 +0000
Message-ID: <4506ACC2AE90484D87F9A883BA36C21C2ADF02C2@LCHQEX03.lancope.local>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] More observations on HEAD
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi, all!

Feel free to ignore this -- it's an experience report of a cluster of runs I've just done against 3.12.24 kernels.

The default test set runs move_pages* twice.

setfsuid04_16 and setregid{02,04,05,07}_16 TFAIL rather than TCONF on no-16-bit-syscalls systems.

run_cgroup_test_fj.sh hangs on heavy-load systems with $LTPROOT/output/ not present.

Some test under container_test.sh (sourcing childns.sh) attempts to create veth pairs without verifying veth functionality supported.
Other tests under container_test.sh fail to source files (childns.sh cannot source cmdlib.sh;  child_1.sh and childipv6.sh cannot source initialize.sh).

Many tests under cgroup_regression_test.sh blindly log to hard-coded $LTPROOT/output/ directory without making sure it's there.
Also, subtest #7 "fails to mount hugetlb" because it seemingly did not first check whether the functionality was enabled.

Under cgroup_fj also seems to have some tests which do latency tests and other tests, outputting "TINFO" and "FAIL" and "PASS" not in standard format.
I will see if I can bisect it down and work out which tests those are.

dma_thread_diotest invocations all claim to be "dma_thread_diotest07" in the runltp outputfile.

Thanks!

Joseph
Joseph Beckenbach, senior QA engineer : Automation
x97166
M 678-602-3192


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
