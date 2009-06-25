Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJm0d-0004oH-6d
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:16:47 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJm0c-0000gv-5v
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:16:47 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5PABbud024560
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 06:11:37 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5PAGjoj257150
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 06:16:45 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5PAGiBV028183
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 06:16:44 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <8368651DACC1964480F951191B94A078BC0F2A@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A078BC0F2A@svexch01.mvista.com>
Date: Thu, 25 Jun 2009 14:40:58 +0530
Message-Id: <1245921058.5542.50.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] splice01: check prerequisite of filesystem
	in	actual test/tmp directory rather than current directory
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, 2009-06-24 at 17:32 -0700, Henry Yei wrote: 
> Hello,
> 
> I accidentally submitted this patch previously without a subject, not sure if it gwoudl get on the radar, hence the resubmission.
> 
> This is a patch for the splice01 test. Previously the test was checking if the current working directory was NFS based as which the test. The patch changes this test to check whether the test directory is on NFS, as that is actually where the test gets run. 

Great. Thanks.

Regards--
Subrata

> 
> Henry Yei (QA)
> MontaVista Software, Inc.
> hyei@mvista.com
> 
>  
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
