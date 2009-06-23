Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7TN-0008Df-Se
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:59:45 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7TL-0003rr-HW
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:59:45 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NEtp1j013157
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 08:55:51 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NExRA7076034
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 08:59:29 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NExRBI024880
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 08:59:27 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906220117.n5M1HTVJ004183@e2.ny.us.ibm.com>
References: <200906220117.n5M1HTVJ004183@e2.ny.us.ibm.com>
Date: Tue, 23 Jun 2009 20:19:03 +0530
Message-Id: <1245768543.4860.65.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix cleanup procedure in the setuid04 test
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2009-05-12 at 19:06 +0200, Jiri Palecek wrote: 
> Cleanup has to be made only once in the parent process; when the
>  child makes the cleanup itself, the parent has nothing to cleanup,
>  which makes him sad.
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/setuid/setuid04.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setuid/setuid04.c b/testcases/kernel/syscalls/setuid/setuid04.c
> index 18f1d90..26a3868 100644
> --- a/testcases/kernel/syscalls/setuid/setuid04.c
> +++ b/testcases/kernel/syscalls/setuid/setuid04.c
> @@ -114,7 +114,7 @@ void do_master_child()
>  	int status;
> 
>  	if (setuid(ltpuser->pw_uid) == -1) {
> -		tst_brkm(TBROK, cleanup,
> +		tst_brkm(TBROK, tst_exit,
>  			 "setuid failed to set the effective uid to %d",
>  			 ltpuser->pw_uid);
>  	}
> @@ -143,7 +143,7 @@ void do_master_child()
> 
>  		pid = FORK_OR_VFORK();
>  		if (pid < 0)
> -			tst_brkm(TBROK, cleanup, "Fork failed");
> +			tst_brkm(TBROK, tst_exit, "Fork failed");
> 
>  		if (pid == 0) {
>  			int tst_fd2;
> @@ -160,13 +160,12 @@ void do_master_child()
> 
>  			if (TEST_ERRNO == EACCES) {
>  				tst_resm(TPASS, "open returned errno EACCES");
> -				exit(0);
>  			} else {
>  				tst_resm(TFAIL,
>  					 "open returned unexpected errno - %d",
>  					 TEST_ERRNO);
> -				exit(-1);
>  			}
> +			tst_exit();
>  		} else {
>  			/* Wait for son completion */
>  			waitpid(pid, &status, 0);


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
