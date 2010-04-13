Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rdunlap@xenotime.net>) id 1O1hed-0005UD-1a
	for ltp-list@lists.sourceforge.net; Tue, 13 Apr 2010 15:03:55 +0000
Received: from xenotime.net ([72.52.64.118])
	by sfi-mx-2.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1O1heb-0001cE-TC
	for ltp-list@lists.sourceforge.net; Tue, 13 Apr 2010 15:03:54 +0000
Received: from chimera.site ([71.245.98.113]) by xenotime.net for
	<ltp-list@lists.sourceforge.net>; Tue, 13 Apr 2010 08:03:37 -0700
Message-ID: <4BC487C9.9080300@xenotime.net>
Date: Tue, 13 Apr 2010 08:03:37 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
References: <000001cadad6$c061c590$412550b0$@co.jp>
In-Reply-To: <000001cadad6$c061c590$412550b0$@co.jp>
Subject: Re: [LTP] [PATCH] fix "hugetlb" several tests
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
Cc: ltp-list@lists.sourceforge.net

On 04/12/10 23:58, Mitani wrote:
> ------------
>  a) All tests:
> "TBROK  :  Test cannot be continued owning to sufficient availability of
> Hugepages on the system"
> 
>  b) 2), 3), 5), 6), 8), 10), 11) tests:
> "TWARN  :  tst_rmdir(): TESTDIR was NULL; no removal attempted"
> ------------
> 
> Both case a) and case b) are caused by the same reason.
> 
> All of case a) failures occured at the following points (for example 
> hugemmap04):
> ------------<hugemmap04.c - main()>
>         /* Check number of hugepages */
>         if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
>                 tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
> \
>                                 sufficient availability of Hugepages on the
> system");
> ------------
> 
> I found out that "HugePages_Total" parameter of "/proc/meminfo" file 
> is set to "0". This caused above TBROK failure. It is environment problem.
> 
> But, in this case, tests must not return with TBROK, but with TCONF, 
> I think.

That makes sense to me.

> And, in case b), these tests try to delete "TESTDIR" directory by 
> calling "tst_rmdir()" function in "cleanup()" function.
> But, "TESTDIR" never set if "tst_tmpdir()" function isn't called.
> I think that case b)'s tests must not call cleanup() function.
> 
> 
> I want to suggest following patch.
> 
> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
> 
> ============
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c	2010-04-01
> 15:23:09.000000000 +0900
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c	2010-04-13
> 11:23:33.000000000 +0900
> @@ -127,7 +127,7 @@
>  
>  	/* Check number of hugepages */
>  	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
> -		tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
> \
> +		tst_brkm(TCONF, cleanup, "Test cannot be continued owning to
> \
>  				sufficient availability of Hugepages on the
> system");
>  
>  	/* Perform global setup for test */

Not caused by your patch, but all of those "owning to" should be "owing to"
or even better, "due to".

-- 
~Randy

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
