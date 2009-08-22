Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Meufl-0002je-IB
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 17:46:37 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Meufd-0003NA-9g
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 17:46:37 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7MHelfj020872
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 11:40:47 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7MHkLP5258592
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 11:46:21 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7MHkLcH027815
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 11:46:21 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810908180725l326c08f1l863f8d17c74f0a95@mail.gmail.com>
References: <f5a7b3810908170937u516ee718yd6db8df547752bc4@mail.gmail.com>
	<364299f40908172344o62861d02rc8e0c3f87de80134@mail.gmail.com>
	<f5a7b3810908180725l326c08f1l863f8d17c74f0a95@mail.gmail.com>
Date: Sat, 22 Aug 2009 23:15:45 +0530
Message-Id: <1250963151.10642.28.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCHE]ltp-fix-posix-mq_send_5-1 warning
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Brandon Philips <bphilips@suse.de>

On Tue, 2009-08-18 at 19:55 +0530, naresh kamboju wrote: 
> On Tue, Aug 18, 2009 at 12:14 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> > On Mon, Aug 17, 2009 at 9:37 AM, naresh kamboju<naresh.kernel@gmail.com> wrote:
> >> Hi,
> >>
> >> I have noticed build warnings for the following test case.
> >> This patch will fix warnings by removing unused variables in test code.
> >>
> >> I have attached patch and below
> >> Please review the same
> >
> Hi,
> >    Log before and after?
> 
> Build log
> =========================================
> Before patch:
> ==========
> conformance/interfaces/mq_send/5-1: build: FAILED: Compiler output:
> cc1: warnings being treated as errors
> In file included from conformance/interfaces/mq_send/5-1.c:40:
> include/mq_send.h: In function 'sync_pipe_wait_select':
> include/mq_send.h:49: warning: unused variable 'buf'
> conformance/interfaces/mq_send/5-1.c: In function 'main':
> conformance/interfaces/mq_send/5-1.c:107: warning: unused variable 'r'
> conformance/interfaces/mq_send/5-1.c:105: warning: unused variable 'act'
> 
> ==========
> After patch:
> ==========
> conformance/interfaces/mq_send/5-1: build: PASS
> conformance/interfaces/mq_send/5-1: link: PASS
> =========================================
> Best regards
> Naresh Kamboju

Thanks.

Regards--
Subrata

> 
> > Thanks,
> > -Garrett
> >


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
