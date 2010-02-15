Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NgtrX-0001VN-7Z
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 05:51:15 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NgtrW-0007CO-93
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 05:51:15 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1F5lkpx031390
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Feb 2010 00:47:46 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1F5p83M1560722
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Feb 2010 00:51:08 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1F5p78G032114
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Feb 2010 03:51:07 -0200
Date: Mon, 15 Feb 2010 11:21:02 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100215055102.GA21277@rishikesh.in.ibm.com>
References: <5a774f4c1002060734v174f790ah976977edf6aa50a4@mail.gmail.com>
	<4B6FA757.2010309@linux.vnet.ibm.com>
	<5a774f4c1002072302n4eaf5c6fycbabbbe4524a483d@mail.gmail.com>
	<4B6FBD49.6050605@linux.vnet.ibm.com>
	<5a774f4c1002141937n4eb1033bx3c64ed5618869716@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5a774f4c1002141937n4eb1033bx3c64ed5618869716@mail.gmail.com>
Subject: Re: [LTP] about "hugetlbshmget03"
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
To: shenghui <crosslonelyover@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Feb 15, 2010 at 11:37:03AM +0800, shenghui wrote:
> 2010/2/8 Rishikesh <risrajak@linux.vnet.ibm.com>
> 
> > Hi Rishi,
> >
> >        Please refer to the following for my error info. And will you please
> > try it on your workstation and send me
> > your result?
> >
> > Hi Shengui,
> >
> > Yes i am also facing this different issue on my TP. Let me investigate more
> > on that. Meanwhile if you know the solution can you please post your thought
> > on this problem ?
> >
> > Thanks
> > Rishi
> >
> >
> >
> >        Thanks!
> >
> >
> > ===============================================================================
> >
> > root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
> > ls
> > hugeshmget01    hugeshmget02    hugeshmget03    hugeshmget05    Makefile
> > hugeshmget01.c  hugeshmget02.c  hugeshmget03.c  hugeshmget05.c
> >
> > root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
> > echo 10 > /proc/sys/vm/nr_hugepages
> >
> > root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
> > cat /proc/meminfo
> > MemTotal:        4048440 kB
> > MemFree:         1576656 kB
> > Buffers:          122652 kB
> > Cached:          1487772 kB
> > SwapCached:            0 kB
> > Active:          1225860 kB
> > Inactive:        1043268 kB
> > Active(anon):     684228 kB
> > Inactive(anon):       16 kB
> > Active(file):     541632 kB
> > Inactive(file):  1043252 kB
> > Unevictable:           0 kB
> > Mlocked:               0 kB
> > HighTotal:       3211696 kB
> > HighFree:        1044060 kB
> > LowTotal:         836744 kB
> > LowFree:          532596 kB
> > SwapTotal:       3903752 kB
> > SwapFree:        3903752 kB
> > Dirty:               204 kB
> > Writeback:             0 kB
> > AnonPages:        658692 kB
> > Mapped:           239928 kB
> > Slab:             109460 kB
> > SReclaimable:      93676 kB
> > SUnreclaim:        15784 kB
> > PageTables:         8332 kB
> > NFS_Unstable:          0 kB
> > Bounce:                0 kB
> > WritebackTmp:          0 kB
> > CommitLimit:     5917732 kB
> > Committed_AS:    1389392 kB
> > VmallocTotal:     122880 kB
> > VmallocUsed:       44644 kB
> > VmallocChunk:      75956 kB
> > HugePages_Total:      10
> > HugePages_Free:       10
> > HugePages_Rsvd:        0
> > HugePages_Surp:        0
> > Hugepagesize:       2048 kB
> > DirectMap4k:        8184 kB
> > DirectMap2M:      903168 kB
> >
> > root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
> > ./hugeshmget03
> > hugeshmget03    0  TINFO  :  errno = 12 : Cannot allocate memory
> > hugeshmget03    1  TBROK  :  Didn't get ENOSPC in test setup
> >
> > root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
> > echo 32 > /proc/sys/vm/nr_hugepages
> >
> > root@crossover-laptop:/home/crossover/repository/ltp-intermediate-20100119/testcases/kernel/mem/hugetlb/hugeshmget#
> > ./hugeshmget03
> > hugeshmget03    0  TINFO  :  errno = 12 : Cannot allocate memory
> > hugeshmget03    1  TBROK  :  Didn't get ENOSPC in test setup
> >
> >
> > --
> >
> >
> > Thanks and Best Regards,
> > shenghui
> >
> >
> >
> Hi Rishi,
> 
>       I found hugetlbshmget01 has the same problem. Seems we need do
> further investigation on these two programs. :)

Hi Shenghui,
Sure i will have a look into it soon. 
Thanks
Rishi
> 
> 
> -- 
> 
> 
> Thanks and Best Regards,
> shenghui

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
