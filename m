Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MHLSh-0000UZ-LL
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:31:43 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHLSa-0002Zv-AJ
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:31:43 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5IHR5WN030795
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 13:27:05 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5IHVZk5105910
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 13:31:35 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5IHTGO1020423
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 13:29:16 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1244618075.10778.4.camel@munipradeep-laptop>
References: <1244618075.10778.4.camel@munipradeep-laptop>
Date: Thu, 18 Jun 2009 23:01:27 +0530
Message-Id: <1245346287.5041.32.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH]get_mempolicy01: fix for changing failure due
	to	configuration error
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
To: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi Muni,

On Wed, 2009-06-10 at 12:44 +0530, Munipradeep Beerakam wrote:
> Hi,
> 
> Here is the attachment to fix the configuration error in
> get_mempolicy01.c
> Actually it should not fail due to configuration error. So changed the
> necessary.
> 
> Thanks
> Muni
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (get_mempolicy01.patch)
> 
> 
> ---
> a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c 2009-06-10
> 07:08:08.000000000 -0400
> +++
> b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c 2009-06-10
> 07:12:16.000000000 -0400
> @@ -296,7 +296,7 @@
>                          TEST(rc = syscall(__NR_set_mempolicy,
> tc->policy,&nodemask, maxnode));
> 
>                 if (TEST_RETURN < 0) {
> -                       tst_resm(TFAIL, "set_mempolicy() failed -
> errno = %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +                       tst_resm(TCONF, "set_mempolicy() failed -
> errno = %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>                          result = 1;
>                         cleanup();
>                          tst_exit();
> @@ -307,7 +307,7 @@
>                  // mmap memory
>                  p = mmap(NULL, len, PROT_READ|PROT_WRITE,MAP_PRIVATE|
> MAP_ANONYMOUS, 0, 0);
>                  if (p == (void*)-1) {
> -                       tst_resm(TFAIL, "malloc failed - errno = %d :
> %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +                       tst_resm(TCONF, "malloc failed - errno = %d :
> %s",TEST_ERRNO, strerror(TEST_ERRNO));
>                          result = 1;
>                         cleanup();
>                          tst_exit();

The problem reported on your machine is function not implemented.
However, if you change the FAIL to blindly CONF, that will cause issues
like actual failures reported wrongly.

See, whether you can find out ways to isolate only function not
implemented part.

Regards--
Subrata



------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
