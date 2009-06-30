Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLbHj-0005m7-5t
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 11:13:59 +0000
Received: from [32.97.182.144] (helo=e4.ny.us.ibm.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLbHf-0002Jv-BK
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 11:13:59 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UB7oiO026525
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 07:07:50 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UBD4Bj183424
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 07:13:04 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UBD4lv003255
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 07:13:04 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810906300042w14bc6a4fp8046160d07d8254e@mail.gmail.com>
References: <f5a7b3810906300042w14bc6a4fp8046160d07d8254e@mail.gmail.com>
Date: Tue, 30 Jun 2009 16:42:13 +0530
Message-Id: <1246360333.4819.53.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCHES] ltp-mq_unlink_speculative_7-2
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
Cc: ltp-list@lists.sourceforge.net, Brandon Philips <bphilips@suse.de>, maxin john <maxinbjohn@gmail.com>, Manas Kumar Nayak <maknayak@in.ibm.com>

Hi Naresh,

On Tue, 2009-06-30 at 13:12 +0530, naresh kamboju wrote:
> Hi,
> 
> I have noticed failure under open_posix_testsuite for
> mq_unlink/speculative/7-2.c and fixed.
> After changing the uninitialized to initialized char array of mqname[]
> test case got PASSED.

Great. Could you also please share with us the test results before and
after this patch ?

Regards--
Subrata

> 
> I have attached patch and below.
> Please review the same.
> 
> 
> Best Regards
> Naresh Kamboju
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


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
