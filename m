Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sharyath@in.ibm.com>) id 1MTDZ6-000886-E1
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 11:31:24 +0000
Received: from e28smtp09.in.ibm.com ([59.145.155.9])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MTDZ1-0001sB-4o
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 11:31:24 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp09.in.ibm.com (8.13.1/8.13.1) with ESMTP id n6LAcWpB026776
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jul 2009 16:08:32 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6LBV9ib4477150
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jul 2009 17:01:09 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n6LBV8Ld022151
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jul 2009 17:01:08 +0530
Message-ID: <4A65A6FB.2020901@in.ibm.com>
Date: Tue, 21 Jul 2009 17:01:07 +0530
From: Sharyathi Nagesh <sharyath@in.ibm.com>
MIME-Version: 1.0
References: <1248168950.13756.7.camel@munipradeep-laptop>
In-Reply-To: <1248168950.13756.7.camel@munipradeep-laptop>
Subject: Re: [LTP] Issue observed with chmod05, fchmod05 test cases
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
Cc: ltp-list@lists.sourceforge.net, sharyath@linux.vnet.ibm.com

Muni
  What I am trying to say is, this fix assumes that
Bin->GID is part of supplementary group IDs of root and nobody->GID is not.
There is no basis for this assumption. If nobody->GID is part of supplementary group ID than 
it will fail again.
  So instead specifically set the supplementary group ID of the process to avoid confusion
Thanks
Yeehaw
> 
> diff --git a/testcases/kernel/syscalls/chmod/chmod05.c b/testcases/kernel/syscalls/chmod/chmod05.c
> index 4504aaa..c6f1225 100644
> --- a/testcases/kernel/syscalls/chmod/chmod05.c
> +++ b/testcases/kernel/syscalls/chmod/chmod05.c
> @@ -177,7 +177,7 @@ int main(int ac, char **av)
>  			if ((PERMS & ~S_ISGID) != dir_mode) {
>  				tst_resm(TFAIL, "%s: Incorrect modes 0%03o, "
>  					 "Expected 0%03o", TESTDIR, dir_mode,
> -					 PERMS);
> +					 PERMS & ~S_ISGID);
>  			} else {
>  				tst_resm(TPASS,
>  					 "Functionality of chmod(%s, %#o) successful",
> @@ -241,12 +241,12 @@ void setup()
>  				strerror(errno));
>  	}

> 
> -	if (chown(TESTDIR, nobody_u->pw_uid, bin_group->gr_gid) == -1)
> +	if (chown(TESTDIR, nobody_u->pw_uid, nobody_u->pw_gid) == -1)
>  		tst_brkm(TBROK, cleanup, "Couldn't change owner of testdir: %s",
>  				strerror(errno));
> 
> -	/* change to nobody:nobody */
> -	if (setegid(nobody_u->pw_gid) == -1 ||
> +	/* change to nobody:bin */
> +	if (setegid(bin_group->gr_gid) == -1 ||
>  		 seteuid(nobody_u->pw_uid) == -1)
>  		tst_brkm(TBROK, cleanup, "Couldn't switch to nobody:nobody: %s",
>  				strerror(errno));


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
