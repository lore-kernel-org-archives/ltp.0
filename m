Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MGHh3-00089t-MA
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:18:09 +0000
Received: from [32.97.110.160] (helo=e39.co.us.ibm.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGHgz-0002f5-RC
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:18:09 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e39.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5FJDJrx016653
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 13:13:19 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5FJHLSo101032
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 13:17:21 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5FJHKqg009686
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 13:17:20 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A3085B9.40707@cn.fujitsu.com>
References: <4A3085B9.40707@cn.fujitsu.com>
Date: Tue, 16 Jun 2009 00:46:34 +0530
Message-Id: <1245093394.4871.51.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] fchmod05: fix to the group ownership
	and	the	effective user
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
To: Wei Yongjun <yjwei@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, 2009-06-11 at 12:19 +0800, Wei Yongjun wrote: 
> This patch fixed the modify of the group ownership before
> do dir chmod and fixed the effective user when do cleanup.
> Those problems cause the test failed with the following
> error message:
> 
>   fchmod05    1  FAIL  :  testdir: Incorrect modes 043777, Expected 0777
>   fchmod05    0  WARN  :  tst_rmdir(): rmobj(/tmp/fchUout8n) failed: \
>     remove(/tmp/fchUout8n) failed; errno=1: Operation not permitted
> 
> Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/fchmod/fchmod05.c |   13 ++++++++-----
>  1 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
> index 3573f65..5226858 100644
> --- a/testcases/kernel/syscalls/fchmod/fchmod05.c
> +++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
> @@ -154,10 +154,10 @@ int main(int ac, char **av)
>  			if ((PERMS & ~S_ISGID) != dir_mode) {
>  				tst_resm(TFAIL, "%s: Incorrect modes 0%03o, "
>  					 "Expected 0%03o",
> -					 TESTDIR, PERMS, MODE_RWX);
> +					 TESTDIR, dir_mode, PERMS & ~S_ISGID);
>  			} else {
>  				tst_resm(TPASS, "Functionality of fchmod(%d, "
> -					 "%#o) successful", fd, PERMS);
> +					 "%#o) successful", fd, PERMS & ~S_ISGID);
>  			}
>  		} else {
>  			tst_resm(TPASS, "call succeeded");
> @@ -218,12 +218,12 @@ void setup()
>  		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", TESTDIR);
>  	}
> 
> -	if (chown(TESTDIR, nobody_u->pw_uid, bin_group->gr_gid) == -1)
> +	if (chown(TESTDIR, nobody_u->pw_uid, nobody_u->pw_gid) == -1)
>  		tst_brkm(TBROK, cleanup, "Couldn't change owner of testdir: %s",
>  				strerror(errno));
> 
> -	/* change to nobody:nobody */
> -	if (setegid(nobody_u->pw_gid) == -1 || seteuid(nobody_u->pw_uid) == -1)
> +	/* change to nobody:bin */
> +	if (setegid(bin_group->gr_gid) == -1 || seteuid(nobody_u->pw_uid) == -1)
>  		tst_brkm(TBROK, cleanup, "Couldn't switch to nobody:nobody: %s",
>  				strerror(errno));
> 
> @@ -258,6 +258,9 @@ void cleanup()
>  			 TESTDIR, errno, strerror(errno));
>  	}
> 
> +	setegid(0);
> +	seteuid(0);
> +
>  	/* Remove tmp dir and all files in it */
>  	tst_rmdir();
> 


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
