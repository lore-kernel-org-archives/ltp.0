Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Md11M-0005op-Px
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 12:09:04 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Md11G-00045w-PM
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 12:09:04 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7HC0sUg025171
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 08:00:54 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7HC8rcT247200
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 08:08:53 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7HC60hV019053
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 08:06:00 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 17 Aug 2009 17:38:37 +0530
Message-Id: <20090817120835.8902.4597.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH v2 00/05] Integration of "Fault Injection Framework"
	into LTP
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
To: LTP Mailing List <ltp-list@lists.sourceforge.net>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Nate Straz <nate@refried.org>, Paul Larson <paul.larson@ubuntu.com>, Manoj Iyer <manoj.iyer@ubuntu.com>, Balbir Singh <balbir@linux.vnet.ibm.com>

Hi,

Introducing the "Kernel Fault Injection Framework" generation and testing
capability in LTP. This is in line with the recent proposal made through
LTP Paper at OLS 2009:
"Putting LTP to test - Validating both the Linux kernel and Test-cases"
(http://ltp.sourceforge.net/documentation/technical_papers/Putting_LTP_to_Test.pdf)

This infrasturcture will help LTP directly in the following ways:
1) Allow test developers to test their new test cases against a faulted kernel,
and then compare it on stable kernel run, impacting in better test development,
2) Allow test engineers to be able to generate more code coverage by traversing
the rarely touched parts of the kernel code,

As we move forward in using this, we would definitely find some other
advantages of this framework. This is V2 of patchset after incorporating
comments from Mike, Paul & Garret.

Regards--
Subrata


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
