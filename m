Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1ME60a-0006WI-1j
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:25:16 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1ME60Y-0002E3-72
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:25:16 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n59IKsR8019369
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 14:20:54 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n59IPDl4251092
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 14:25:13 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n59IPD9i008402
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 14:25:13 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A2CABFB.3010207@cn.fujitsu.com>
References: <4A2CABFB.3010207@cn.fujitsu.com>
Date: Tue, 09 Jun 2009 23:54:47 +0530
Message-Id: <1244571889.5497.19.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 1/2] chmod05: fix to modify the group ownership
	before	do dir chmod
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

On Mon, 2009-06-08 at 14:13 +0800, Wei Yongjun wrote: 
> Refer to the manpage:
> 
>   # man 2 chmod
>   If the calling process is not privileged (Linux: does not have the
>   CAP_FSETID capability), and the group of the file does not match
>   the effective group ID of the process or one of its supplementary
>   group IDs, the S_ISGID bit will be turned off, but this will not
>   cause an error to be returned.
> 
> So, if we want S_ISGID bit be turned off after chmod(), we can not have
> the CAP_FSETID capability and not match the effective group ID. The 'bin'
> group always has the CAP_FSETID capability, so we can not change the own
> of the TESTDIR to 'bin' group, instead, 'nobody' can be used.
> 
> This patch fixed the problem by change gid of chown to 'nobody' group and
> change the gid of setegid() to 'bin' group.
> 
> Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/chmod/chmod05.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
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
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
