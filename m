Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N8Y8D-0008JB-Kt
	for ltp-list@lists.sourceforge.net; Thu, 12 Nov 2009 11:46:29 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N8Y86-00015s-7L
	for ltp-list@lists.sourceforge.net; Thu, 12 Nov 2009 11:46:29 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nACBpnGD006327
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Nov 2009 06:51:49 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nACBkGcP098492
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Nov 2009 06:46:16 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nACBkGY6017486
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Nov 2009 06:46:16 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40911120319w1701c177o90a18bf56b99a0ca@mail.gmail.com>
References: <364299f40911120319w1701c177o90a18bf56b99a0ca@mail.gmail.com>
Date: Thu, 12 Nov 2009 17:16:11 +0530
Message-Id: <1258026371.4866.2.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [RFC] proc01 : add flag to read /proc/irq ;
	skip by	default
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Thu, 2009-11-12 at 03:19 -0800, Garrett Cooper wrote:
> Hi all,
>     To provide some background, my group is working on several
> evaluation boards and one of the boards we have unfortunately has
> issues with its usb driver, where the proc01 testcase gets stuck
> trying to poll the /proc/irq file with the corresponding device.
>     I was wondering whether or not this could be removed by default,
> and /proc/irq reading could be enabled by a -i option (say, in the
> crashme test suite) to ensure that systems with faulty hardware /
> drivers don't hang indefinitely and this testcase can still be run on

Run without hanging.

Regards--
Subrata

> those platforms.
> Thanks!
> -Garrett
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
