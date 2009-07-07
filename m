Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MOCf6-0000pC-7w
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:32:52 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOCf1-0002xZ-Jr
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:32:52 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n67FVCAI029738
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 09:31:12 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n67FWbdF143548
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 09:32:41 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n67FWXA1011279
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 09:32:34 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200907071211.49294.sripathik@in.ibm.com>
References: <200907031235.06805.sripathik@in.ibm.com>
	<1246895449.4887.51.camel@subratamodak.linux.ibm.com>
	<200907071211.49294.sripathik@in.ibm.com>
Date: Tue, 07 Jul 2009 21:02:23 +0530
Message-Id: <1246980743.5539.47.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] realtime: Fix the pass criterion of pi_perf test
	case.
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
To: Sripathi Kodi <sripathik@in.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

On Tue, 2009-07-07 at 12:11 +0530, Sripathi Kodi wrote: 
> On Monday 06 July 2009 21:20:49 Subrata Modak wrote:
> > On Fri, 2009-07-03 at 12:35 +0530, Sripathi Kodi wrote:
> > > Hi,
> > >
> > > The pass criterion in pi_perf test case is wrong. It compares the minimum
> > > amount of time taken by the low priority thread with the maximum amount
> > > of time taken by the high priority thread to calculate the PI delay.
> > > Obviously, these min and max don't necessarily happen in the same
> > > iteration, resulting in a number of false failures. The correct way is to
> > > compare the time taken by low and high priority threads in each iteration
> > > and then find the maximum delay experienced by high priority thread
> > > across the iterations. This patch implements the change. Additionally,
> > > this patch removes lock_wait_dat array, which is not needed anymore as
> > > well as makes a couple of messages easier to understand.
> > >
> > > This patch changes the messages displayed by this test case slightly.
> > > They look like the following now:
> > >
> > > Low prio thread started
> > > High prio thread started
> > > Busy 0 started
> > > Busy 1 started
> > > Busy 2 started
> > > Busy 3 started
> > > Time taken for high prio thread to get the lock once released by low prio
> > > thread
> > > Min delay = 10 us
> > > Max delay = 36 us
> > > Average delay = 17.06 us
> > > Standard Deviation = 8.11 us
> > > Quantiles:
> > > 99.0% < 36
> > > Criteria: High prio lock wait time < (Low prio lock held time + 200 us)
> > > Result: PASS
> > >
> > > I have tested this by running 1000 iterations of pi_perf test on a couple
> > > of machines.
> > >
> > > Thanks,
> > > Sripathi.
> > >
> > > ---
> > >
> > > realtime: Fix the pass criterion of pi_perf test case.
> > >
> > > Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>
> >
> > Hi Sri,
> >
> > Is this based on the latest snapshot. I get the following failures:
> >
> > patching file testcases/realtime/func/pi_perf/pi_perf.c
> > Hunk #1 FAILED at 1.
> >
> >
> > Can you please resend ?
> 
> Sorry Subrata, the patch seems to be fine on my machine, but is going bad in my 
> mail client. If you don't mind, I have attached the patch to this mail for 
> now.
> 
> Thanks,
> Sripathi.

Thanks.

Regards--
Subrata

> 
> --
> 
> realtime: Fix the pass criterion of pi_perf test case.
> 
> Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>
> Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>
> Acked-by: Gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
> 
> <snip>


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
