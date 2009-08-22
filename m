Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Meuf8-0003BM-OG
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 17:45:58 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Meuf0-0003bO-IE
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 17:45:58 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7MHiYKC029985
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 13:44:34 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7MHjfd5256110
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 13:45:41 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7MHjfLe010943
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 13:45:41 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <8368651DACC1964480F951191B94A078010C61D2@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A078010C61D2@svexch01.mvista.com>
Date: Sat, 22 Aug 2009 23:15:36 +0530
Message-Id: <1250963137.10642.26.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] open10, use tst_tmpdir and tst_rmdir functions
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
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Mon, 2009-08-17 at 16:52 -0700, Henry Yei wrote: 
> This patch adds functions to create and cleanup temporary test
> directories, code style changes to match other open tests.
> 
> Signed-off-by: Henry Yei<hyei@mvista.com>

Thanks.

Regards--
Subrata

> 
>  
> 
> diff -Nurp -x CVS ltp-20090531/testcases/kernel/syscalls/open/open10.c
> ltp-wdir/testcases/kernel/syscalls/open/open10.c
> 
> --- ltp-20090531/testcases/kernel/syscalls/open/open10.c    2009-03-23
> 06:35:58.000000000 -0700
> 
> +++ ltp-wdir/testcases/kernel/syscalls/open/open10.c  2009-08-17
> 16:41:41.008259471 -0700
> 
> @@ -74,6 +74,8 @@ int local_flag;
> 
>  #define ROOT_SETGID    "root_setgid"
> 
>  #define    MSGSIZE           150
> 
>  
> 
> +void cleanup(void);
> 
> +
> 
>  char progname[] = "open10()";
> 
>  
> 
>  int issu()
> 
> @@ -121,13 +123,14 @@ int main(int ac, char *av[])
> 
>        * parse standard options
> 
>        */
> 
>       if ((msg = parse_opts(ac, av, (option_t *) NULL, NULL)) != (char
> *)NULL) {
> 
> -           tst_resm(TBROK, "OPTION PARSING ERROR - %s", msg);
> 
> -           tst_exit();
> 
> +           tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s",
> msg);
> 
>        /*NOTREACHED*/}
> 
>  
> 
> +     tst_tmpdir();
> 
> +
> 
>       if (issu() != 0) {
> 
>             tst_resm(TINFO, "Must be root to run this test.");
> 
> -           tst_exit();
> 
> +           cleanup();
> 
>       }
> 
>       for (lc = 0; TEST_LOOPING(lc); lc++) {
> 
>  
> 
> @@ -145,8 +148,7 @@ int main(int ac, char *av[])
> 
>  
> 
>             /* Get the uid of user1 */
> 
>             if ((user1 = getpwnam("nobody")) == NULL) {
> 
> -                 tst_resm(TBROK, "nobody not in /etc/passwd");
> 
> -                 tst_exit();
> 
> +                 tst_brkm(TBROK, cleanup, "nobody not
> in /etc/passwd");
> 
>             }
> 
>             user1_uid = user1->pw_uid;
> 
>  
> 
> @@ -155,14 +157,13 @@ int main(int ac, char *av[])
> 
>              */
> 
>             if ((group = getgrnam("nobody")) == NULL) {
> 
>                   if ((group = getgrnam("nogroup")) == NULL) {
> 
> -                       tst_resm(TBROK,
> 
> +                       tst_brkm(TBROK, cleanup,
> 
>                                "nobody/nogroup not in /etc/group");
> 
> -                       tst_exit();
> 
>                   }
> 
>             }
> 
>             group1_gid = group->gr_gid;
> 
>             if ((group = getgrnam("bin")) == NULL) {
> 
> -                 tst_resm(TBROK, "bin not in /etc/group");
> 
> +                 tst_brkm(TBROK, cleanup, "bin not in /etc/group");
> 
>             }
> 
>             group2_gid = group->gr_gid;
> 
>  
> 
> @@ -510,6 +511,21 @@ int main(int ac, char *av[])
> 
>             }
> 
>  
> 
>       }
> 
> -     tst_exit();
> 
> +     cleanup();
> 
>       return 0;
> 
>  }
> 
> +
> 
> +void cleanup(void)
> 
> +{
> 
> +     /*
> 
> +     * print timing status if that option was specified.
> 
> +     * print errno log if that option was specified
> 
> +     */
> 
> +     TEST_CLEANUP;
> 
> +
> 
> +     /* Remove tmp dir and all files in it */
> 
> +     tst_rmdir();
> 
> +
> 
> +     /* exit with return code appropriate for results */
> 
> +     tst_exit();
> 
> +}
> 
>  
> 
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
