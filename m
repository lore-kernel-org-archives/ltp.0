Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Meufr-00055V-EU
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 17:46:43 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Meufk-0003Nz-76
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 17:46:43 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7MHglTP007790
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 11:42:47 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7MHkSXB156706
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 11:46:28 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7MHkSfp022538
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 11:46:28 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810908180727i7ddbcab4t3b0d74c2f1ac0e6@mail.gmail.com>
References: <f5a7b3810908170941n6885b036ub45f9d14ec5c3768@mail.gmail.com>
	<364299f40908172345o21a2d7a8j11a41eeb8455f596@mail.gmail.com>
	<f5a7b3810908180727i7ddbcab4t3b0d74c2f1ac0e6@mail.gmail.com>
Date: Sat, 22 Aug 2009 23:16:14 +0530
Message-Id: <1250963174.10642.29.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCH] ltp-fix-posix-sched_setparam_26-1 warning fix
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

On Tue, 2009-08-18 at 19:57 +0530, naresh kamboju wrote: 
> On Tue, Aug 18, 2009 at 12:15 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> > On Mon, Aug 17, 2009 at 9:41 AM, naresh kamboju<naresh.kernel@gmail.com> wrote:
> >> Hi,
> >>
> >> I have noticed build warnings for the following test case.
> >> This patch will fix warnings by adding <string.h> header file.
> >>
> >> I have attached patch and below
> >> Please review the same
> >
> Hi,
> >    Log before and after?
> 
> Build log:
> ========================================
> Before patch:
> ==========
> conformance/interfaces/sched_setparam/26-1: build: FAILED: Compiler output:
> cc1: warnings being treated as errors
> conformance/interfaces/sched_setparam/26-1.c: In function 'set_nonroot':
> conformance/interfaces/sched_setparam/26-1.c:30: warning: implicit
> declaration of function 'strcmp'
> ============
> After patch:
> ============
> conformance/interfaces/sched_setparam/26-1: build: PASS
> conformance/interfaces/sched_setparam/26-1: link: PASS
> 
> ========================================
> 
> Best regards
> Naresh Kamboju

Thanks.

Regards--
Subrata

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
