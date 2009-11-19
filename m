Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NBASo-0005pb-4G
	for ltp-list@lists.sourceforge.net; Thu, 19 Nov 2009 17:06:34 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NBASg-00006P-SS
	for ltp-list@lists.sourceforge.net; Thu, 19 Nov 2009 17:06:34 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAJGvuLm018327
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Nov 2009 11:57:56 -0500
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAJH6K4I121350
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Nov 2009 12:06:20 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAJH6FH6007636
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Nov 2009 10:06:16 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4B02107B.10604@cn.fujitsu.com>
References: <4B02107B.10604@cn.fujitsu.com>
Date: Thu, 19 Nov 2009 22:36:11 +0530
Message-Id: <1258650371.4904.3.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] mem/hugeshmget: fix failure of hugeshmget01
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
To: liubo <liubo2009@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2009-11-17 at 10:54 +0800, liubo wrote: 
> During hugeshmget01 testcase, we got the following:
> hugeshmget01    1  TFAIL  :  seqment size is not correct
> hugeshmget01    1  TFAIL  :  hugeshmget01 call failed - errno = 17 :
> File exists
>                 ......
> 
> In shmget call,
> "buf.shm_segsz" had been set to "huge_pages_shm_to_be_allocated", 
> but the code still used old macro "HUGE_SHM_SIZE", and this 
> leaded to error "seqment size is not correct".
> 
> So do the following change:
> 1) s/HUGE_SHM_SIZE/huge_pages_shm_to_be_allocated
> 2) Delete unused macro "HUGE_SHM_SIZE" defination
> 
> This patch fixed the failure.
> 
> 
> Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>

Thanks.

Regards--
Subrata

> ---
>  .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c   |    2 +-
>  testcases/kernel/mem/hugetlb/lib/ipcshm.h          |    1 -
>  2 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
> index 0486dc3..10f29d3 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
> @@ -109,7 +109,7 @@ int main(int ac, char **av)
>  					continue;
>  				}
>  				/* check the seqment size */
> -				if (buf.shm_segsz != HUGE_SHM_SIZE) {
> +				if (buf.shm_segsz != huge_pages_shm_to_be_allocated) {
>  					tst_resm(TFAIL, "seqment size is not "
>  						 "correct");
>  					continue;
> diff --git a/testcases/kernel/mem/hugetlb/lib/ipcshm.h b/testcases/kernel/mem/hugetlb/lib/ipcshm.h
> index 5b92530..caac9af 100644
> --- a/testcases/kernel/mem/hugetlb/lib/ipcshm.h
> +++ b/testcases/kernel/mem/hugetlb/lib/ipcshm.h
> @@ -42,7 +42,6 @@ void setup(void);
>  #define SHM_HUGETLB   04000    /* segment is mapped via hugetlb */
>  #endif
> 
> -#define HUGE_SHM_SIZE	(256UL*1024UL*1024UL)	/* a resonable size for a large page segment */
> 
>  #define MODE_MASK	0x01FF			/* to get the lower nine permission bits */
>  						/* from shmid_ds.ipc_perm.mode		 */


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
