Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kamalesh@linux.vnet.ibm.com>) id 1MLatN-0003EB-4h
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 10:48:49 +0000
Received: from [202.81.31.142] (helo=e23smtp09.au.ibm.com)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLatE-0008Sp-LF
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 10:48:43 +0000
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp09.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5UKbpnb029537
	for <ltp-list@lists.sourceforge.net>; Wed, 1 Jul 2009 06:37:51 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UAkomg901190
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 20:46:50 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UAknYv007272
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 20:46:50 +1000
Date: Tue, 30 Jun 2009 16:16:39 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Message-ID: <20090630104639.GB4682@linux.vnet.ibm.com>
References: <f5a7b3810906300042w14bc6a4fp8046160d07d8254e@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f5a7b3810906300042w14bc6a4fp8046160d07d8254e@mail.gmail.com>
Subject: Re: [LTP] [FIX PATCHES] ltp-mq_unlink_speculative_7-2
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
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
Cc: ltp-list@lists.sourceforge.net, Brandon Philips <bphilips@suse.de>, maxin john <maxinbjohn@gmail.com>, Manas Kumar Nayak <maknayak@in.ibm.com>

* naresh kamboju <naresh.kernel@gmail.com> [2009-06-30 13:12:57]:

> Hi,
> 
> I have noticed failure under open_posix_testsuite for
> mq_unlink/speculative/7-2.c and fixed.
> After changing the uninitialized to initialized char array of mqname[]
> test case got PASSED.
> 
> I have attached patch and below.
> Please review the same.
> 
> 
> Best Regards
> Naresh Kamboju

looks good to me.
> 
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
> 
> 
> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/7-2.c
> b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/7-2.c
> --- a/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/7-2.c
> 2005-06-03 22:00:59.000000000 +0530
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/7-2.c
> 2009-06-30 12:37:35.000000000 +0530
> @@ -28,7 +28,7 @@
> 
>  int main()
>  {
> -       char mqname[50];
> +       char mqname[50]="/123";
> 
>  //     sprintf(mqname, FUNCTION "_" TEST "_%d", getpid());


			
					Kamalesh

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
