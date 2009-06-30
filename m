Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLYAa-0001Ad-Rq
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:54:24 +0000
Received: from [32.97.110.152] (helo=e34.co.us.ibm.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLYAJ-0001pl-Ci
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:54:08 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5U7lexC013328
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 01:47:40 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5U7ouu0208588
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 01:50:56 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5U7oudp004842
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 01:50:56 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <8368651DACC1964480F951191B94A078BC133A@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A078BC133A@svexch01.mvista.com>
Date: Tue, 30 Jun 2009 13:11:33 +0530
Message-Id: <1246347693.4819.37.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] cacheflush01,
	remove extraneous characters for	mips specific section
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

On Fri, 2009-06-26 at 18:30 -0700, Henry Yei wrote: 
> I am submitting a patch for cacheflush01, it looks like there are unneeded characters before 
> return syscall(__NR_cacheflush, addr, nbytes, cache) inside the mips section.
> 
> Without this patch, the test does not compile with a mips compiler.

Thanks.

Regards--
Subrata

> 
> Henry Yei (QA)
> MontaVista Software, Inc.
> hyei@mvista.com
> 
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
