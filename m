Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PX3A7-0005vI-Lz
	for ltp-list@lists.sourceforge.net; Mon, 27 Dec 2010 02:50:15 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PX3A6-0007TH-Mo
	for ltp-list@lists.sourceforge.net; Mon, 27 Dec 2010 02:50:15 +0000
Received: by pvd12 with SMTP id 12so1692746pvd.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 26 Dec 2010 18:50:09 -0800 (PST)
References: <AANLkTi=bW=XkPHSqDFmChHYKDjbszCOpfSry+OGvyPX0@mail.gmail.com>
In-Reply-To: <AANLkTi=bW=XkPHSqDFmChHYKDjbszCOpfSry+OGvyPX0@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 8C148)
Message-Id: <A0B36E20-052A-43A7-A463-10DB36B33A8F@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Date: Sun, 26 Dec 2010 18:49:47 -0800
Subject: Re: [LTP] Bug report and fix patch for mount03
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
To: Aaron Wu <aaronwu06@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

I'll look at this later on tonight. Thanks.

Sent from my iPhone

On Dec 26, 2010, at 6:45 PM, Aaron Wu <aaronwu06@gmail.com> wrote:

> Hello Sir,
>  
> For ltp-full-20101031, met a failure for the mount03 test, following is the failure log, followed by my fix.
>  
> root:/> mount03 -D /dev/sdb1
> mount03     1  TBROK  :  stat for setuid_test failed
> mount03     2  TBROK  :  Remaining cases broken
> mount03     3  TBROK  :  Remaining cases broken
> mount03     4  TBROK  :  Remaining cases broken
> mount03     5  TBROK  :  Remaining cases broken
> mount03     6  TBROK  :  Remaining cases broken
>  
> 
> Best regards,
> Aaron Wu
>  
>  
> --- testcases/kernel/syscalls/mount/mount03.c   2010-12-17 18:46:35.493493377 +0800
> +++ testcases/kernel/syscalls/mount/mount03.new.c       2010-12-20 10:57:22.593492676 +0800
> @@ -496,7 +496,11 @@
>                          "errno = %d : %s", DIR_MODE, TEST_ERRNO,
>                          strerror(TEST_ERRNO));
>         }
> -       snprintf(file, PATH_MAX, "%ssetuid_test", Path_name);
> +
> +       strcpy(testhome_path, test_home);
> +       strcat(testhome_path, "/setuid_test");
> +
> +       snprintf(file, PATH_MAX, "%s", testhome_path);
>         if (stat(file, &setuid_test_stat) < 0) {
>                 tst_brkm(TBROK, cleanup, "stat for setuid_test failed");
>         } else {
> @@ -518,9 +522,6 @@
>          */
>         snprintf(Path_name, PATH_MAX, "%s/%s/", Path_name, mntpoint);
> -       strcpy(testhome_path, test_home);
> -
> -       strcat(testhome_path, "/setuid_test");
>         /* Pause if that option was specified */
>         TEST_PAUSE;
> ------------------------------------------------------------------------------
> Learn how Oracle Real Application Clusters (RAC) One Node allows customers
> to consolidate database storage, standardize their database environment, and, 
> should the need arise, upgrade to a full multi-node Oracle RAC database 
> without downtime or disruption
> http://p.sf.net/sfu/oracle-sfdevnl
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
