Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OUNDx-0001wf-70
	for ltp-list@lists.sourceforge.net; Thu, 01 Jul 2010 17:06:53 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OUNDw-0007fR-EP
	for ltp-list@lists.sourceforge.net; Thu, 01 Jul 2010 17:06:53 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o61H4uVd015730
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Jul 2010 11:04:56 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o61H6bXK243696
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Jul 2010 11:06:42 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o61H6Wkw009351
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Jul 2010 11:06:33 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1277796706-6450-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
References: <1277796706-6450-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
Date: Thu, 01 Jul 2010 22:36:21 +0530
Message-Id: <1278003981.21642.6.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] realtime: rearrange the pthread attr functions
	order	in librttest
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
> In the recent pthread libraries, order of calling pthread_attr_setschedpolicy
> and pthread_attr_setschedparam plays important role in a way that, former
> should always be called followed by later.
> 
> Otherwise, pthread_attr_setschedparam always ends with error 22 (EINVAL).
> This patch fixes the create_thread() in librttest library.
> 
> Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>

Thanks.

Regards--
Subrata

> Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
> Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>
> Acked-by: Darren Hart <dvhltc@us.ibm.com>
> ---
>  testcases/realtime/lib/librttest.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/realtime/lib/librttest.c b/testcases/realtime/lib/librttest.c
> index e092f35..49fec29 100644
> --- a/testcases/realtime/lib/librttest.c
> +++ b/testcases/realtime/lib/librttest.c
> @@ -295,8 +295,8 @@ int create_thread(void*(*func)(void*), void *arg, int prio, int policy)
> 
>  	pthread_attr_init(&thread->attr);
>  	pthread_attr_setinheritsched(&thread->attr, PTHREAD_EXPLICIT_SCHED);
> -	pthread_attr_setschedparam(&thread->attr, &param);
>  	pthread_attr_setschedpolicy(&thread->attr, thread->policy);
> +	pthread_attr_setschedparam(&thread->attr, &param);
> 
>  	if ((ret = pthread_create(&thread->pthread, &thread->attr, func, (void*)thread))) {
>  		printf("pthread_create failed: %d (%s)\n", ret, strerror(ret));


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
