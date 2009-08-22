Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MeqDv-0001BK-TH
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 13:01:35 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MeqDo-0005cV-BB
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 13:01:35 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7MCsjY7027120
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 08:54:45 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7MD1KMk226608
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 09:01:20 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7MD1JX8020410
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 09:01:20 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090817120835.8902.4597.sendpatchset@subratamodak.linux.ibm.com>
References: <20090817120835.8902.4597.sendpatchset@subratamodak.linux.ibm.com>
Date: Sat, 22 Aug 2009 18:31:11 +0530
Message-Id: <1250946071.10642.15.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH v2 00/05] Integration of "Fault Injection
	Framework"	into LTP
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
To: LTP Mailing List <ltp-list@lists.sourceforge.net>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Nate Straz <nate@refried.org>, Paul Larson <paul.larson@ubuntu.com>, Manoj Iyer <manoj.iyer@ubuntu.com>, Balbir Singh <balbir@linux.vnet.ibm.com>

On Mon, 2009-08-17 at 17:38 +0530, Subrata Modak wrote:
> Hi,
> 
> Introducing the "Kernel Fault Injection Framework" generation and testing

This has now become part of LTP. Hope all of you will start using it and
help improve it further.

Regards--
Subrata

> capability in LTP. This is in line with the recent proposal made through
> LTP Paper at OLS 2009:
> "Putting LTP to test - Validating both the Linux kernel and Test-cases"
> (http://ltp.sourceforge.net/documentation/technical_papers/Putting_LTP_to_Test.pdf)
> 
> This infrasturcture will help LTP directly in the following ways:
> 1) Allow test developers to test their new test cases against a faulted kernel,
> and then compare it on stable kernel run, impacting in better test development,
> 2) Allow test engineers to be able to generate more code coverage by traversing
> the rarely touched parts of the kernel code,
> 
> As we move forward in using this, we would definitely find some other
> advantages of this framework. This is V2 of patchset after incorporating
> comments from Mike, Paul & Garret.
> 
> Regards--
> Subrata
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
