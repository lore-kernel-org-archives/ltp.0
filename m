Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MHLTc-0000aO-Ki
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:40 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHLTa-0000HJ-RM
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:40 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5IHRwMT014986
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 13:27:58 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5IHWcSt188472
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 13:32:38 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5IHWb1K007081
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Jun 2009 13:32:38 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810906171318v503b0c77l27a5df2f057fb85c@mail.gmail.com>
References: <f5a7b3810906171318v503b0c77l27a5df2f057fb85c@mail.gmail.com>
Date: Thu, 18 Jun 2009 23:01:55 +0530
Message-Id: <1245346315.5041.42.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCH] ltp-add_key
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
To: naresh kamboju <naresh.kernel@gmail.com>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>, Oleg Nesterov <oleg@redhat.com>, rohit.170309@gmail.com

Great to see you fix these issues and send across the fixes. However, i
remember Kamalesh working on similar type of fixes.

Lets hear from Kamalesh, whether he has something additional from this
series of patches, or, some other fixes in each patch apart from what
you have already provided.

Kamalesh,

Would you like to say something here ?

Another suggestion. Naresh, next time when you send patches pertaining
to one particular issue observed in several tests, then no. the patches,
like [PATCH 00/N] to [PATCH N/N].

Regards--
Subrata

On Thu, 2009-06-18 at 01:48 +0530, naresh kamboju wrote: 
> Hi,
> 
> I have noticed following failures and fixed.
> 1. add_key01.c
> 2. add_key02.c
> 
> 
> Please find the patch below and as attachment.
> 
> Best regards
> Naresh Kamboju
> 
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
> diff -Naurb a/testcases/kernel/syscalls/add_key/add_key01.c
> b/testcases/kernel/syscalls/add_key/add_key01.c
> --- a/testcases/kernel/syscalls/add_key/add_key01.c	2009-05-21
> 23:39:37.000000000 +0530
> +++ b/testcases/kernel/syscalls/add_key/add_key01.c	2009-06-17
> 23:00:15.000000000 +0530
> @@ -125,7 +125,7 @@
>          for (lc = 0; TEST_LOOPING(lc); ++lc) {
>                  Tst_count = 0;
>                  for (testno = 0; testno < TST_TOTAL; ++testno) {
> -                     TEST(result = syscall(286, "keyring", "wjkey",
> NULL, 0, KEY_SPEC_THREAD_KEYRING));     //call add_key()
> +                     TEST(result = syscall(__NR_add_key, "keyring",
> "wjkey", NULL, 0, KEY_SPEC_THREAD_KEYRING));     //call add_key()
>                       if(TEST_RETURN != -1) {
>          		tst_resm(TPASS, "add_key call succeeded");
>                          cleanup();
> @@ -139,4 +139,3 @@
>          }	
>          tst_exit();
>  }
> -
> diff -Naurb a/testcases/kernel/syscalls/add_key/add_key02.c
> b/testcases/kernel/syscalls/add_key/add_key02.c
> --- a/testcases/kernel/syscalls/add_key/add_key02.c	2009-05-21
> 23:40:50.000000000 +0530
> +++ b/testcases/kernel/syscalls/add_key/add_key02.c	2009-06-17
> 23:47:48.000000000 +0530
> @@ -140,7 +140,7 @@
>                  for (testno = 0; testno < TST_TOTAL; ++testno) {
> 
>  		for(i=0; i<test_count; i++) {
> -                	TEST(syscall(286, test_cases[i].type,
> test_cases[i].desc, test_cases[i].payload, test_cases[i].plen,
> KEY_SPEC_USER_KEYRING));    //call add_key()
> +                	TEST(syscall(__NR_add_key, test_cases[i].type,
> test_cases[i].desc, test_cases[i].payload, test_cases[i].plen,
> KEY_SPEC_USER_KEYRING));    //call add_key()
>                  	if(TEST_RETURN != -1){
>                          	tst_resm(TINFO,"call add_key() with wrong
> args succeed, but should fail");
>                          	fail++;
> @@ -170,4 +170,3 @@
>        }	
>          tst_exit();
>  }
> -


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
