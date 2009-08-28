Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MgyQ2-0005VD-7a
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:10:54 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgyPo-00005Q-SU
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 10:10:49 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7SA9Xm6030386
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:09:33 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7SAAQu0251042
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:10:26 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7SAAQ2D007579
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:10:26 -0600
Received: from [9.124.158.42] (localhost-009124158042.in.ibm.com
	[9.124.158.42])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n7SAAOVn007423
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 04:10:25 -0600
From: poornima nayak <mpnayak@linux.vnet.ibm.com>
Date: Fri, 28 Aug 2009 15:40:22 +0530
Message-Id: <1251454222.9869.83.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [LTP] [Patch 0/8]Patchsets to integrate Ideal Load Balancer
 testcases to LTP
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

Hi All

To test ILB feature in Power management a set of testcases has been
developed. These patches tests ILB with respect to different test
variables sched_mc, sched_smt and workload. The patches sent has been
tested on Quad core machine.

Regards
Poornima 
 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
