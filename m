Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OIQgx-0002WN-KN
	for ltp-list@lists.sourceforge.net; Sat, 29 May 2010 18:23:27 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OIQgw-0002ns-KP
	for ltp-list@lists.sourceforge.net; Sat, 29 May 2010 18:23:27 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o4TI6slU005955
	for <ltp-list@lists.sourceforge.net>; Sat, 29 May 2010 14:06:54 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4TINKBf135948
	for <ltp-list@lists.sourceforge.net>; Sat, 29 May 2010 14:23:20 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4TINKkq031873
	for <ltp-list@lists.sourceforge.net>; Sat, 29 May 2010 14:23:20 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <000001cafc79$7d23c8e0$776b5aa0$@co.jp>
References: <000001cafc79$7d23c8e0$776b5aa0$@co.jp>
Date: Fri, 28 May 2010 13:01:04 +0530
Message-Id: <1275031870.5418.21.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] hugetlb tests failure occurred
Reply-To: subrata@linux.vnet.ibm.com
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

The LTP hugetlb tests are broken. I had earlier suggested to replace
this with the test cases available with the libhugetlbfs releases.
However, we had some problems:

     1. We were not sure whether the libhugetlbfs tests all scenarios as
        done by the LTP tests, 
     2. We had no volunteers who can look into this,

So, if somebody is willing to do this: 
     1. Investigate what exact tests to pick up from LTP, 
     2. which tests to pickup from libhugetlbfs library, 
     3. Merge them to the LTP build/install/run system,

It would be nice, and we would be bothered about these failures time and
again :-(

Regards--
Subrata

On Wed, 2010-05-26 at 11:16 +0900, Mitani wrote: 
> Hi,
> 
> I ran "hugeshmdt01" and "hugeshmctl01" tests.
> 
> At these tests, I set HugePages_Total:
> ------------</proc/meminfo>
> [root@RHEL54-LTP-EM64T ltp]# cat /proc/meminfo
> MemTotal:      2059632 kB
> MemFree:       1392080 kB
> Buffers:        204764 kB
> Cached:         308092 kB
> ...
> VmallocTotal: 34359738367 kB
> VmallocUsed:      1012 kB
> VmallocChunk: 34359736951 kB
> HugePages_Total:     2
> HugePages_Free:      2
> HugePages_Rsvd:      0
> Hugepagesize:     2048 kB
> ------------
> 
> But these tests failed:
> 
> ------------<log>
> hugeshmctl01    1  TBROK  :  couldn't create the shared memory segment
> hugeshmctl01    2  TBROK  :  Remaining cases broken
> hugeshmctl01    3  TBROK  :  Remaining cases broken
> hugeshmctl01    4  TBROK  :  Remaining cases broken
> hugeshmctl01    0  TINFO  :  received unexpected signal 15
> hugeshmctl01    0  TINFO  :  received unexpected signal 15
> hugeshmctl01    0  TINFO  :  received unexpected signal 15
> hugeshmctl01    0  TINFO  :  received unexpected signal 15
> hugeshmctl02    1  TBROK  :  couldn't create shared memory segment #1 in
> setup()
> hugeshmctl02    2  TBROK  :  Remaining cases broken
> hugeshmctl02    3  TBROK  :  Remaining cases broken
> hugeshmctl02    4  TBROK  :  Remaining cases broken
> hugeshmctl02    1  TBROK  :  couldn't create shared memory segment #1 in
> setup()
> hugeshmctl02    2  TBROK  :  Remaining cases broken
> hugeshmctl02    3  TBROK  :  Remaining cases broken
> hugeshmctl02    4  TBROK  :  Remaining cases broken
> hugeshmctl02    1  TBROK  :  couldn't create shared memory segment #1 in
> setup()
> hugeshmctl02    2  TBROK  :  Remaining cases broken
> hugeshmctl02    3  TBROK  :  Remaining cases broken
> hugeshmctl02    4  TBROK  :  Remaining cases broken
> hugeshmctl01    0  TINFO  :  received unexpected signal 15
> hugeshmctl01    0  TINFO  :  received unexpected signal 15
> hugeshmctl01    0  TINFO  :  received unexpected signal 15
> hugeshmctl03    1  TBROK  :  couldn't create shared memory segment in
> setup()
> hugeshmctl03    2  TBROK  :  Remaining cases broken
> hugeshmctl03    3  TBROK  :  Remaining cases broken
> hugeshmctl03    1  TBROK  :  couldn't create shared memory segment in
> setup()
> hugeshmctl03    2  TBROK  :  Remaining cases broken
> hugeshmctl03    3  TBROK  :  Remaining cases broken
> hugeshmctl03    1  TBROK  :  couldn't create shared memory segment in
> setup()
> hugeshmctl03    2  TBROK  :  Remaining cases broken
> hugeshmctl03    3  TBROK  :  Remaining cases broken
> ------------
> 
> All these are failures of shmget() .
> 
> My systems are RHEL5.4 and RHEL4.8. Architectures are x86, x86_64, and ia64.
> In all of these environments, above failures occurred.
> 
> I executed "runltp" once. But these tests are executed several times.
> And shmget() system-call failed with errno=ENOMEM at last in my system.
> In ".../runtest/hugetlb", test commands are as follows:
> 
> ------------<hugetlb>
> hugeshmctl01 hugeshmctl01 -i 5 -c 3
> hugeshmctl02 hugeshmctl02 -i 5 -c 3
> hugeshmctl03 hugeshmctl03 -i 5 -c 3
> 
> hugeshmdt01 hugeshmdt01 -I 5 -c10
> ------------
> 
> If repetition is once, these tests succeed in my system..
> 
> 
> I'm grad if I can know a reason of these repetition ("-c" option).
> And I want to know whether I can appoint this option freely if machine 
> doesn't have enough memory.
> 
> 
> Regards--
> 
> -Tomonori Mitani
> 
> 
> 
> ------------------------------------------------------------------------------
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
