Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OUNE9-0008A4-UC
	for ltp-list@lists.sourceforge.net; Thu, 01 Jul 2010 17:07:05 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OUNE9-0004wb-2w
	for ltp-list@lists.sourceforge.net; Thu, 01 Jul 2010 17:07:05 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o61H3X9k015020
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Jul 2010 11:03:33 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o61H6mSP050928
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Jul 2010 11:06:52 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o61H6i3t032202
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Jul 2010 11:06:44 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <000001cb1810$23753ba0$6a5fb2e0$@co.jp>
References: <000001cb1810$23753ba0$6a5fb2e0$@co.jp>
Date: Thu, 01 Jul 2010 22:36:26 +0530
Message-Id: <1278003986.21642.8.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] fix hugetlb tests
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net, kamimura@ryobi.co.jp

On Wed, 2010-06-30 at 13:53 +0900, Mitani wrote: 
> Hi,
> 
> I want to suggest a patch for hugetlb tests.
> 
> There are "-c" options in this "${LTPROOT}/runtest/hugetlb" file:
> ------------
> hugeshmat01 hugeshmat01 -i 5
> hugeshmat02 hugeshmat02 -i 5
> hugeshmat03 hugeshmat03 -i 5
> 
> hugeshmctl01 hugeshmctl01 -i 5 -c 3
> hugeshmctl02 hugeshmctl02 -i 5 -c 3
> hugeshmctl03 hugeshmctl03 -i 5 -c 3
> 
> hugeshmdt01 hugeshmdt01 -I 5 -c10
> 
> hugeshmget01 hugeshmget01 -c 10 -i 10
> hugeshmget02 hugeshmget02 -c 10 -i 10
> hugeshmget03 hugeshmget03 -c 10 -i 10
> hugeshmget05 hugeshmget05 -c 10 -i 10
> 
> ------------
> 
> But I think that these "-c" options have not important meanings.
> I think that the test for several times may not be necessary.
> For example, the purpose of "hugeshmget02" is the error case test of 
> shmget(). In this case, if the expected failure occurred once, it is 
> enough, and the repetition of test is unnecessary anymore, I think.
> And, depending on a case, there may be a system without enough memory 
> for these repetition tests.
> Therefore I want to suggest reducing the "-c" option.
> 
> I got an answer that these "hugetlb" tests were not complete test programs.
> --> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10171.html
> Therefore, this revision is a temporary.
> 
> 
> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

Ok. Thanks.

Regards--
Subrata

> 
> ============
> --- a/runtest/hugetlb	2010-06-14 21:29:09.000000000 +0900
> +++ b/runtest/hugetlb	2010-06-30 09:32:01.000000000 +0900
> @@ -7,14 +7,14 @@
>  hugeshmat02 hugeshmat02 -i 5
>  hugeshmat03 hugeshmat03 -i 5
> 
> -hugeshmctl01 hugeshmctl01 -i 5 -c 3
> -hugeshmctl02 hugeshmctl02 -i 5 -c 3
> -hugeshmctl03 hugeshmctl03 -i 5 -c 3
> +hugeshmctl01 hugeshmctl01 -i 5
> +hugeshmctl02 hugeshmctl02 -i 5
> +hugeshmctl03 hugeshmctl03 -i 5
> 
> -hugeshmdt01 hugeshmdt01 -I 5 -c10
> +hugeshmdt01 hugeshmdt01 -I 5
> 
> -hugeshmget01 hugeshmget01 -c 10 -i 10
> -hugeshmget02 hugeshmget02 -c 10 -i 10
> -hugeshmget03 hugeshmget03 -c 10 -i 10
> -hugeshmget05 hugeshmget05 -c 10 -i 10
> +hugeshmget01 hugeshmget01 -i 10
> +hugeshmget02 hugeshmget02 -i 10
> +hugeshmget03 hugeshmget03 -i 10
> +hugeshmget05 hugeshmget05 -i 10
> 
> --- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	2010-06-14
> 21:29:09.000000000 +0900
> +++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	2010-06-30
> 09:12:00.000000000 +0900
> @@ -78,14 +78,14 @@
>  		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
>  	}
> 
> -	setup();			/* global setup */
> -
>  	/* The following loop checks looping state if -i option given */
>          if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
>               tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
>          else             
>                huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
>          
> +	setup();			/* global setup */
> +
>          for (lc = 0; TEST_LOOPING(lc); lc++) {
>  		/* reset Tst_count in case we are looping */
>  		Tst_count = 0;
> ============
> 
> 
> 
> Regards--
> 
> -Tomonori Mitani
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by Sprint
> What will you do first with EVO, the first 4G phone?
> Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
