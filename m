Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nzvd9-0007oH-W0
	for ltp-list@lists.sourceforge.net; Thu, 08 Apr 2010 17:35:03 +0000
Received: from mail-bw0-f218.google.com ([209.85.218.218])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nzvd8-0005uJ-Uw
	for ltp-list@lists.sourceforge.net; Thu, 08 Apr 2010 17:35:03 +0000
Received: by bwz10 with SMTP id 10so1941535bwz.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 08 Apr 2010 10:34:56 -0700 (PDT)
References: <000301cad6f8$1b9b0c60$52d12520$@co.jp>
Message-Id: <D30EE9FA-D2B3-4292-9571-BEF87442BD30@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <000301cad6f8$1b9b0c60$52d12520$@co.jp>
Mime-Version: 1.0 (iPhone Mail 7E18)
Date: Thu, 8 Apr 2010 10:34:45 -0700
Subject: Re: [LTP] [PATCH] fix "eventfd01" test
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
Cc: "<ltp-list@lists.sourceforge.net>" <ltp-list@lists.sourceforge.net>

On Apr 8, 2010, at 1:47 AM, "Mitani" <mitani@ryobi.co.jp> wrote:

> Hi,
>
>
> I tried "eventfd01" test in my system.
> This test failed with TWARN (return code:4) :
>
> ------------
>  eventfd01    1  TCONF  :  2.6.22 or greater kernel required
>  eventfd01    2  TCONF  :  Remaining cases not appropriate for
> configuration
>  eventfd01    3  TCONF  :  Remaining cases not appropriate for
> configuration
>  eventfd01    4  TCONF  :  Remaining cases not appropriate for
> configuration
>  eventfd01    5  TCONF  :  Remaining cases not appropriate for
> configuration
>  eventfd01    6  TCONF  :  Remaining cases not appropriate for
> configuration
>  eventfd01    7  TCONF  :  Remaining cases not appropriate for
> configuration
>  eventfd01    8  TCONF  :  Remaining cases not appropriate for
> configuration
>  eventfd01    9  TCONF  :  Remaining cases not appropriate for
> configuration
>  eventfd01   10  TCONF  :  Remaining cases not appropriate for
> configuration
>  eventfd01   11  TCONF  :  Remaining cases not appropriate for
> configuration
>  eventfd01   12  TCONF  :  Remaining cases not appropriate for
> configuration
>  eventfd01   13  TCONF  :  Remaining cases not appropriate for
> configuration
>  eventfd01   14  TCONF  :  Remaining cases not appropriate for
> configuration
>  eventfd01   15  TCONF  :  Remaining cases not appropriate for
> configuration
>  eventfd01    0  TWARN  :  tst_rmdir(): TESTDIR was NULL; no removal
> attempted
> ------------
>
> My system's kernel level is 2.6.18-164.el5
> Therefore this test rejected:
>
> ------< eventfd01.c - main() >------
>        if (tst_kvercmp(2, 6, 22) < 0)
>                tst_brkm(TCONF, cleanup, "2.6.22 or greater kernel
> required");
> ------------
>
> But, this "tst_brkm()" called "cleanup()".
> "tst_rmdir()" is called in "cleanup()", and this checked "TESTDIR":
>
> ------< tst_tmpdir.c - tst_rmdir() >------
>   /*
>    * Check that TESTDIR is not NULL.
>    */
>   if ( TESTDIR == NULL ) {
>      tst_resm(TWARN, "%s: TESTDIR was NULL; no removal attempted",
>               FN_NAME);
>      return;
>   }
> ------------
>
> This TWARN caused FAIL.
> "TESTDIR" is NULL because the test didn't start.
>
> I think that "cleanup()" doesn't have to be called in this case.
>
>
> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
>
> ============
> --- a/testcases/kernel/syscalls/eventfd/eventfd01.c     2010-04-01
> 15:23:10.000000000 +0900
> +++ b/testcases/kernel/syscalls/eventfd/eventfd01.c     2010-04-08
> 17:16:35.000000000 +0900
> @@ -728,8 +728,10 @@
>        /* capture signals */
>        tst_sig(FORK, DEF_HANDLER, cleanup);
>
> -       if (tst_kvercmp(2, 6, 22) < 0)
> -               tst_brkm(TCONF, cleanup, "2.6.22 or greater kernel
> required");
> +       if (tst_kvercmp(2, 6, 22) < 0) {
> +               tst_brkm(TCONF, NULL, "2.6.22 or greater kernel  
> required");
> +               tst_exit();
> +       }
>
>        /* Create a temporary directory & chdir there */
>        tst_tmpdir();
> ============

Try tst_exit instead of NULL.
Cheers,
-Garrett

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
