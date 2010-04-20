Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1O4AFl-0000t7-Dq
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 10:00:25 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O4AFh-0006UR-HX
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 10:00:25 +0000
Date: Tue, 20 Apr 2010 06:00:13 -0400 (EDT)
From: Caspar ZHANG <czhang@redhat.com>
Message-ID: <1706047941.560391271757613100.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20100219123501.19085.64668.sendpatchset@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix MSGCTL10() to avoid un-necessary cluttering
 of whole system with all PIDs
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>



----- "Subrata Modak" <subrata@linux.vnet.ibm.com> wrote:

> Hi,
> 
> msgctl10() un-necessarily eats up all the PIDs of the system leading
> to
> system becoming un-responsive. The changed no.s would better do the
> job.

Hi, I see this patch is not included in ltp-full-20100331, will it be 
accepted in the future? 

I tested msgctl10 testcase on RHEL5(2.6.18) and RHEL6(>2.6.31),
Since /proc/sys/kernel/msgmni has increased from 10 (RHEL5) to 
thousands (RHEL6), the testing time will be several hours long.
Applied this patch, the testing time can be lowed down to minutes.

Thanks,
Caspar

> 
> Signed-off-by: Subrata Modak<subrata@linux.vnet.ibm.com>
> ---
> 
> ---
> ltp-full-20100131/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c.orig
> 2010-02-19 17:59:23.000000000 +0530
> +++ ltp-full-20100131/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
> 2010-02-19 18:01:13.000000000 +0530
> @@ -65,12 +65,8 @@ extern int Tst_count;		/* Test Case coun
>  
>  int exp_enos[] = { 0 };		/* List must end with 0 */
>  
> -#ifndef CONFIG_COLDFIRE
> -#define MAXNPROCS	1000000	/* This value is set to an arbitrary high
> limit. */
> -#else
> -#define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
> -#endif
> -#define MAXNREPS	100000
> +#define MAXNPROCS	10000 	/*These should be sufficient*/
> +#define MAXNREPS	10000	/*Else they srewup the system
> un-necessarily*/
>  #define FAIL		1
>  #define PASS		0
>  
> 
> ---
> Regards--
> Subrata
> 
> 
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
/---------------------------------------\
| Name: Caspar Zhang                    |
| Team: Kernel-QE                       |
| IRC: czhang @ #kernel-qe, #eng-china  |
| Phone: +86-10-6260-8150               |
| Cellphone: +86-1381-073-0090          |
\---------------------------------------/


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
