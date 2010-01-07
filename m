Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NSqCP-0004Wi-Cx
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:06:41 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSqCO-0000KL-JR
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:06:41 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o07B0cEU001865
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 06:00:38 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o07B6X7h1741018
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 06:06:33 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o07B6XXq002322
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 06:06:33 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <2FB9CEFCF4B24FC7AE1D718C54B63F55@jacksimba>
References: <2FB9CEFCF4B24FC7AE1D718C54B63F55@jacksimba>
Date: Thu, 07 Jan 2010 16:36:20 +0530
Message-Id: <1262862380.12213.23.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] disktest question
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
To: Yongjian Zhang <brianzhang2007@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Brent Yardley <yardleyb@us.ibm.com>

On Tue, 2010-01-05 at 10:23 -0700, Yongjian Zhang wrote: 
> Hi all,
> 
> I'm trying to use disktest to measure the performance of an iSCSI device but 
> get extremely low throughput...
> 

How about the following manpage inside LTP source:

# man ./testcases/kernel/io/disktest/man1/disktest.1

Regards--
Subrata

> For example, I did
> 
> disktest -w -S0:1k -B 1024 /dev/sdb (/dev/sdb is the iSCSI device file, no 
> partition or file system on it)
> 
> And the result was:
> | 2010/01/05-02:58:26 | START | 27293 | v1.4.2 | /dev/sdb | Start
> args: -w -S0:1024k -B 1024 -PA (-I b) (-N 8385867) (-K 4) (-c) (-p R)
> (-L 1048577) (-D 0:100) (-t 0:2m) (-o 0)
> | 2010/01/05-02:58:26 | INFO  | 27293 | v1.4.2 | /dev/sdb | Starting
> pass
> ^C| 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
> bytes written in 85578 transfers: 87631872
> | 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
> write throughput: 701055.0B/s (0.67MB/s), IOPS 684.6/s.
> | 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
> Write Time: 125 seconds (0d0h2m5s)
> | 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
> overall runtime: 152 seconds (0d0h2m32s)
> | 2010/01/05-03:00:58 | END   | 27293 | v1.4.2 | /dev/sdb | User
> Interrupt: Test Done (Passed)
> 
> As you can see, the throughput was only 0.67MB/s and only 85578
> written in 87631872 transfers...
> I also tweaked the options with "-p l" and/or "-I bd" (change seek
> pattern to linear and/or speficy IO type as block and direct IO) but
> no improvement happened...
> 
> I thought this low throughput could be caused by the link rate or disk 
> problem, but dd ruled it out..
> 
> $ dd if=/dev/zero of=/dev/sdb bs=1024 count=1048576
> 
> The throughput is 7.2 MB/s.
> 
> There must be something I've done wrong with disktest... Could anyone maybe 
> help me out here?
> 
> Thanks a lot!
> 
> jack 
> 
> 
> ------------------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
