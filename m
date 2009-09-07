Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mkcd9-0001gA-7L
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:43:31 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mkcd3-0007B6-7M
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:43:31 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n87Bgql1028934
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 07:42:52 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n87BhJjL248582
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 07:43:19 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n87BhJrL032594
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 07:43:19 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810908310502h61d97cafv770e664d4becb4a1@mail.gmail.com>
References: <f5a7b3810908310502h61d97cafv770e664d4becb4a1@mail.gmail.com>
Date: Mon, 07 Sep 2009 17:12:46 +0530
Message-Id: <1252323777.4922.35.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] LTP-LDFLAGS-enable
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>, Brandon Philips <bphilips@suse.de>, Geert.Uytterhoeven@sonycom.com

On Mon, 2009-08-31 at 17:32 +0530, naresh kamboju wrote: 
> Hi,
> 
> To make use of full testsuite of open_posix_testsuite we need to
> enable LDFLAGS. It is file used by the Makefile to link to what you
> specify in it. e.g. if you want to link with lpthread. By using these
> Flags can build up to 1888 test case with out the flags can build up
> to 486.
> 
> However, the Best practice is to use posix test suite with the LDFLAGS.
> 
> I have attached patch and below, please review the same
> 
> Best regards,
> Naresh Kamboju
> 
> /************************************************************/
> Before patch:
> With out LDFLAGS:
> 
> 		***************************
> 		 CONFORMANCE TEST RESULTS
> 		***************************
> 		* TOTAL:   486
> 		* PASSED:  449
> 		* FAILED:  12
> 		* UNRESOLVED:  7
> 		* UNSUPPORTED:  10
> 		* UNTESTED:  4
> 		* INTERRUPTED:  0
> 		* HUNG:  0
> 		* SEGV:  0
> 		* OTHERS:  4
> 		***************************
> 
> After patch:
> With LDFLAGS:
>                 ***************************
>                  CONFORMANCE TEST RESULTS
>                 ***************************
>                 * TOTAL:   1888
>                 * PASSED:  1731
>                 * FAILED:  26
>                 * UNRESOLVED:  14
>                 * UNSUPPORTED:  22
>                 * UNTESTED:  94
>                 * INTERRUPTED:  0
>                 * HUNG:  1
>                 * SEGV:  0
>                 * OTHERS:  0
>                 ***************************
> 
> /************************************************************/
> 
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

Ok. Thanks.

Regards--
Subrata

> 
> 
> diff -Naurb a/testcases/open_posix_testsuite/LDFLAGS
> b/testcases/open_posix_testsuite/LDFLAGS
> --- a/testcases/open_posix_testsuite/LDFLAGS	2005-06-03 21:59:49.000000000 +0530
> +++ b/testcases/open_posix_testsuite/LDFLAGS	2009-08-31 16:22:57.000000000 +0530
> @@ -8,7 +8,7 @@
>  #-lpthread -D_GNU_SOURCE
>  #
>  #Recommended flags:
> -#-D_XOPEN_SOURCE=600 -lpthread -lrt -lm
> +-D_XOPEN_SOURCE=600 -lpthread -lrt -lm
>  #
>  # For use with Linux, you may try the following flags to
>  # allow for the NPTL-specific compilation (used in some test cases)


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
