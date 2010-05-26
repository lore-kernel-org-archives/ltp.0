Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1OH6Ax-0004TO-NZ
	for ltp-list@lists.sourceforge.net; Wed, 26 May 2010 02:16:55 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OH6Aw-00013e-7u
	for ltp-list@lists.sourceforge.net; Wed, 26 May 2010 02:16:55 +0000
Received: from relay04.sjc.mx.trendmicro.com (unknown [10.30.239.134])
	by out03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 10F9921132A
	for <ltp-list@lists.sourceforge.net>;
	Wed, 26 May 2010 02:16:48 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay04.sjc.mx.trendmicro.com (Postfix) with ESMTP id 582951D7844
	for <ltp-list@lists.sourceforge.net>;
	Wed, 26 May 2010 02:16:47 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Wed, 26 May 2010 11:16:45 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Wed, 26 May 2010 11:16:45 +0900
Message-ID: <000001cafc79$7d23c8e0$776b5aa0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] hugetlb tests failure occurred
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
To: ltp-list@lists.sourceforge.net

Hi,

I ran "hugeshmdt01" and "hugeshmctl01" tests.

At these tests, I set HugePages_Total:
------------</proc/meminfo>
[root@RHEL54-LTP-EM64T ltp]# cat /proc/meminfo
MemTotal:      2059632 kB
MemFree:       1392080 kB
Buffers:        204764 kB
Cached:         308092 kB
...
VmallocTotal: 34359738367 kB
VmallocUsed:      1012 kB
VmallocChunk: 34359736951 kB
HugePages_Total:     2
HugePages_Free:      2
HugePages_Rsvd:      0
Hugepagesize:     2048 kB
------------

But these tests failed:

------------<log>
hugeshmctl01    1  TBROK  :  couldn't create the shared memory segment
hugeshmctl01    2  TBROK  :  Remaining cases broken
hugeshmctl01    3  TBROK  :  Remaining cases broken
hugeshmctl01    4  TBROK  :  Remaining cases broken
hugeshmctl01    0  TINFO  :  received unexpected signal 15
hugeshmctl01    0  TINFO  :  received unexpected signal 15
hugeshmctl01    0  TINFO  :  received unexpected signal 15
hugeshmctl01    0  TINFO  :  received unexpected signal 15
hugeshmctl02    1  TBROK  :  couldn't create shared memory segment #1 in
setup()
hugeshmctl02    2  TBROK  :  Remaining cases broken
hugeshmctl02    3  TBROK  :  Remaining cases broken
hugeshmctl02    4  TBROK  :  Remaining cases broken
hugeshmctl02    1  TBROK  :  couldn't create shared memory segment #1 in
setup()
hugeshmctl02    2  TBROK  :  Remaining cases broken
hugeshmctl02    3  TBROK  :  Remaining cases broken
hugeshmctl02    4  TBROK  :  Remaining cases broken
hugeshmctl02    1  TBROK  :  couldn't create shared memory segment #1 in
setup()
hugeshmctl02    2  TBROK  :  Remaining cases broken
hugeshmctl02    3  TBROK  :  Remaining cases broken
hugeshmctl02    4  TBROK  :  Remaining cases broken
hugeshmctl01    0  TINFO  :  received unexpected signal 15
hugeshmctl01    0  TINFO  :  received unexpected signal 15
hugeshmctl01    0  TINFO  :  received unexpected signal 15
hugeshmctl03    1  TBROK  :  couldn't create shared memory segment in
setup()
hugeshmctl03    2  TBROK  :  Remaining cases broken
hugeshmctl03    3  TBROK  :  Remaining cases broken
hugeshmctl03    1  TBROK  :  couldn't create shared memory segment in
setup()
hugeshmctl03    2  TBROK  :  Remaining cases broken
hugeshmctl03    3  TBROK  :  Remaining cases broken
hugeshmctl03    1  TBROK  :  couldn't create shared memory segment in
setup()
hugeshmctl03    2  TBROK  :  Remaining cases broken
hugeshmctl03    3  TBROK  :  Remaining cases broken
------------

All these are failures of shmget() .

My systems are RHEL5.4 and RHEL4.8. Architectures are x86, x86_64, and ia64.
In all of these environments, above failures occurred.

I executed "runltp" once. But these tests are executed several times.
And shmget() system-call failed with errno=ENOMEM at last in my system.
In ".../runtest/hugetlb", test commands are as follows:

------------<hugetlb>
hugeshmctl01 hugeshmctl01 -i 5 -c 3
hugeshmctl02 hugeshmctl02 -i 5 -c 3
hugeshmctl03 hugeshmctl03 -i 5 -c 3

hugeshmdt01 hugeshmdt01 -I 5 -c10
------------

If repetition is once, these tests succeed in my system..


I'm grad if I can know a reason of these repetition ("-c" option).
And I want to know whether I can appoint this option freely if machine 
doesn't have enough memory.


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
