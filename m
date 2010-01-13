Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NV44U-0006hV-2a
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 14:19:42 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NV44S-0005fC-Ui
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 14:19:41 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0DEGtIw011546
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Jan 2010 07:16:55 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o0DEJQkr044950
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Jan 2010 07:19:26 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0DEJOmg027370
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Jan 2010 07:19:24 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <OF06E672E4.7EA44CCB-ON882576A4.00564158-882576A5.00082637@us.ibm.com>
References: <2FB9CEFCF4B24FC7AE1D718C54B63F55@jacksimba>
	<1262862380.12213.23.camel@subratamodak.linux.ibm.com>
	<OF06E672E4.7EA44CCB-ON882576A4.00564158-882576A5.00082637@us.ibm.com>
Date: Wed, 13 Jan 2010 19:49:18 +0530
Message-Id: <1263392358.5591.25.camel@subratamodak.linux.ibm.com>
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

Hello Yongjian Zhang,

On Thu, 2010-01-07 at 18:29 -0700, Brent Yardley wrote:
> 
> Here are a couple of thoughts. 
> 
> Disktest will force a sync at the end of all write IO operations, when
> not raw / directio, this sync can take quite a bit of time depending
> on how full the buffer cache is.  This additional time to sync the IO
> to the disk is added to the overall IO time, it assumes that
> performance is to measure the time it takes to get the data to the
> disk, and this may be what is causing the difference between what you
> are seeing between dd and disktest.  Also, dd will perform a
> sequential copy, the default for disktest is to perform random seeks,
> so you will need to add a -pl to the command line to compare disktest
> with dd. 
> 
> I have been working on an experimental patch to time IOs in disktest
> at the usec level and to only include the time when IO was actually in
> flight, ie. from the start to end of each write/read command this will
> also exclude an time it takes to sync to the disk.  This is more
> in-line I believe with how dd measures the throughput.  I have
> included the patch here if you would like to try it out, and see if
> the numbers more closely match what you are seeing in dd. 
> 
> 
> 
> If you want to specifically understand the performance of the device
> your testing, I would recommend using the -Ibd option.  This will
> force the bypass of kernel buffer caching and will be testing the
> performance of the device and transport only. 
> 
> Another test that is useful and tests the specific performance of the
> transport for devices that have caching enabled, is to use the -S0:0
> option with the -Ibd options.  This forces disktest to always request
> the block data from the same block.  When used with a high -B and -K,
> this should give you your max throughput, and used with a small -B and
> high -K, this will give you your make IOPS. 
> 
> Let me know how things go or if you have further questions.

Did you get an opportunity to test this patch ? Kindly let us know, i
would then check this in.

Regards--
Subrata

> Thanks,
> Brent 
> 
> 
> 
> From: 
> Subrata Modak
> <subrata@linux.vnet.ibm.com> 
> To: 
> Yongjian Zhang
> <brianzhang2007@gmail.com> 
> Cc: 
> ltp-list@lists.sourceforge.net,
> Brent Yardley/Beaverton/IBM@IBMUS 
> Date: 
> 01/07/2010 03:06 AM 
> Subject: 
> Re: [LTP] disktest question
> 
> 
> ______________________________________________________________________
> 
> 
> 
> 
> On Tue, 2010-01-05 at 10:23 -0700, Yongjian Zhang wrote: 
> > Hi all,
> > 
> > I'm trying to use disktest to measure the performance of an iSCSI
> device but 
> > get extremely low throughput...
> > 
> 
> How about the following manpage inside LTP source:
> 
> # man ./testcases/kernel/io/disktest/man1/disktest.1
> 
> Regards--
> Subrata
> 
> > For example, I did
> > 
> > disktest -w -S0:1k -B 1024 /dev/sdb (/dev/sdb is the iSCSI device
> file, no 
> > partition or file system on it)
> > 
> > And the result was:
> > | 2010/01/05-02:58:26 | START | 27293 | v1.4.2 | /dev/sdb | Start
> > args: -w -S0:1024k -B 1024 -PA (-I b) (-N 8385867) (-K 4) (-c) (-p
> R)
> > (-L 1048577) (-D 0:100) (-t 0:2m) (-o 0)
> > | 2010/01/05-02:58:26 | INFO  | 27293 | v1.4.2 | /dev/sdb | Starting
> > pass
> > ^C| 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
> > bytes written in 85578 transfers: 87631872
> > | 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
> > write throughput: 701055.0B/s (0.67MB/s), IOPS 684.6/s.
> > | 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
> > Write Time: 125 seconds (0d0h2m5s)
> > | 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
> > overall runtime: 152 seconds (0d0h2m32s)
> > | 2010/01/05-03:00:58 | END   | 27293 | v1.4.2 | /dev/sdb | User
> > Interrupt: Test Done (Passed)
> > 
> > As you can see, the throughput was only 0.67MB/s and only 85578
> > written in 87631872 transfers...
> > I also tweaked the options with "-p l" and/or "-I bd" (change seek
> > pattern to linear and/or speficy IO type as block and direct IO) but
> > no improvement happened...
> > 
> > I thought this low throughput could be caused by the link rate or
> disk 
> > problem, but dd ruled it out..
> > 
> > $ dd if=/dev/zero of=/dev/sdb bs=1024 count=1048576
> > 
> > The throughput is 7.2 MB/s.
> > 
> > There must be something I've done wrong with disktest... Could
> anyone maybe 
> > help me out here?
> > 
> > Thanks a lot!
> > 
> > jack 
> > 
> > 
> >
> ------------------------------------------------------------------------------
> > This SF.Net email is sponsored by the Verizon Developer Community
> > Take advantage of Verizon's best-in-class app development support
> > A streamlined, 14 day to market process makes app distribution fast
> and easy
> > Join now and get one step closer to millions of Verizon customers
> > http://p.sf.net/sfu/verizon-dev2dev
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 
> 


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
