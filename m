Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MYIof-0003PB-4C
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:08:29 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYIoX-0004kV-A5
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:08:29 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n74C2lZx018059
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 08:02:47 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n74C8DLJ248854
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 08:08:13 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n74C8DCt010277
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Aug 2009 08:08:13 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A7772FE.20808@us.ibm.com>
References: <4A7772FE.20808@us.ibm.com>
Date: Tue, 04 Aug 2009 17:38:02 +0530
Message-Id: <1249387682.15587.32.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] realtime measurement tests: approach to criteria
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
To: Darren Hart <dvhltc@us.ibm.com>, linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>, LTP <ltp-list@lists.sourceforge.net>, amrith <amrith@linux.ibm.com>

Hi Darren,

On Mon, 2009-08-03 at 16:30 -0700, Darren Hart wrote: 
> The current ltp/testcases/realtime tests belong to one of func, perf, or 
> stress.  While strict pass/fail criteria make sense for functional tests 
> (did the tasks wake up in priority order?), the others use "arbitrary" 
> values and compare those against the whatever is being measured (wakeup 
> latency, etc.) and then determine pass/fail.  Ideally the tests 
> themselves would not determine the pass/fail criteria, and would instead 
> simply report on their measurements since the criteria will vary in 
> every use-case based on requirements, workload, hardware, etc.
> 
> I'd like to propose an approach where the tests only report their 
> measured values (with the exception of the func/* tests which will 
> maintain their pass/fail criteria).  Users should be able to populate a 
> criteria.conf file that specified the criteria of each test.  The 
> results could then be parsed, compared against the results, and a 
> pass/fail determined from there.  I suspect it would be best for the .c 
> tests to just report the numbers and the statistics in a common format 
> and rely on python parser scripts to read the config file and determine 
> pass/fail from there.
> 
> I'd like users thoughts on this approach before we jump in and start 
> changing things (as this is a fairly invasive change).

This is indeed a good approach. Should we also ask the RT-USERS, who
might be interested to comment on this ?

Regards--
Subrata

> 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
