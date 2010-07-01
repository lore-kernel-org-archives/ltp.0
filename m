Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OUNDk-00066x-3a
	for ltp-list@lists.sourceforge.net; Thu, 01 Jul 2010 17:06:40 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OUNDh-0007bX-Oj
	for ltp-list@lists.sourceforge.net; Thu, 01 Jul 2010 17:06:40 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o61H4gNU015528
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Jul 2010 11:04:42 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o61H6RoM149800
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Jul 2010 11:06:29 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o61H6Qi6002792
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Jul 2010 11:06:26 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1277796676-6407-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
References: <1277796676-6407-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
Date: Thu, 01 Jul 2010 22:36:18 +0530
Message-Id: <1278003979.21642.5.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] realtime: fix min and max calculations in
	matrix	multiplication test
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
To: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Cc: Linux Test Project <ltp-list@lists.sourceforge.net>, gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

On Tue, 2010-06-29 at 13:01 +0530, Gowrishankar wrote: 
> From: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
> 
> In matrix multiplication test, the min and max calculations are done on
> stats_container_t data with its index field never set to the last
> element position. Due to this min and max are always shown with the
> first record value (as index was initiated with -1).
> 
> Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>

Thanks.

Regards--
Subrata

> Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
> Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>
> Acked-by: Darren Hart <dvhltc@us.ibm.com>
> ---
>  testcases/realtime/func/matrix_mult/matrix_mult.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/realtime/func/matrix_mult/matrix_mult.c b/testcases/realtime/func/matrix_mult/matrix_mult.c
> index 419f697..fa0e352 100644
> --- a/testcases/realtime/func/matrix_mult/matrix_mult.c
> +++ b/testcases/realtime/func/matrix_mult/matrix_mult.c
> @@ -222,6 +222,7 @@ void main_thread(void)
> 
>  	/* run matrix mult operation sequentially */
>  	curdat = &sdat;
> +	curdat->index = iterations-1;
>  	printf("\nRunning sequential operations\n");
>  	start = rt_gettime();
>  	for (i = 0; i < iterations; i++)
> @@ -252,6 +253,7 @@ void main_thread(void)
>  	pthread_barrier_init(&mult_start, NULL, numcpus+1);
>  	set_priority(PRIO);
>  	curdat = &cdat;
> +	curdat->index = iterations-1;
>  	online_cpu_id = -1; /* Redispatch cpus */
>  	/* Create numcpus-1 concurrent threads */
>  	for (j = 0; j < numcpus; j++) {


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
