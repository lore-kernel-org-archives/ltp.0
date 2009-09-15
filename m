Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MnRDd-0006ab-8A
	for ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 06:08:49 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MnRDV-0008Na-JB
	for ltp-list@lists.sourceforge.net; Tue, 15 Sep 2009 06:08:49 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8F67q2N012554
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Sep 2009 02:07:52 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8F68ZkB247012
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Sep 2009 02:08:35 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8F68ZPl013222
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Sep 2009 02:08:35 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AAD88CB.8090403@jp.fujitsu.com>
References: <4AAD88CB.8090403@jp.fujitsu.com>
Date: Tue, 15 Sep 2009 11:38:29 +0530
Message-Id: <1252994909.5874.10.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] build rule for t0 in open_posix_testsuite
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
To: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Mon, 2009-09-14 at 09:05 +0900, Seiichi Ikarashi wrote: 
> Hi,
> 
> I propose two patches (two patterns of fix) for an issue of open_posix_testsuite.
> I hope either one of them (or more better one someone will write) is committed.
> 
> You need to do three steps below in order to run execute.sh of open_posix_testsuite:
>  1) make build-tests
>  2) cc -O2 -o t0 t0.c

I prefer the first patch, as, all build items should be combined and
completed before any actual execution.

Regards--
Subrata

> 3) ./execute.sh
> 
> I think it's better to include step 2 into step 1 or 3 for convenience.
> So I wrote two different patches for these cases.
> 
> Signed-off-by: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
> 
> Regards,
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
