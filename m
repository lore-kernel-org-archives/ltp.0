Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NmNog-0004ZZ-9O
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 08:50:58 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NmNof-0001Ec-9t
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 08:50:58 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o228iNBD024403
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 01:44:23 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o228opkJ133392
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 01:50:51 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o221ooqa006307
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Mar 2010 18:50:51 -0700
Date: Tue, 2 Mar 2010 14:20:46 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100302085046.GA27023@linux.vnet.ibm.com>
References: <f5a7b3811002250545x3d5288cfqd114d3bcd79581f2@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f5a7b3811002250545x3d5288cfqd114d3bcd79581f2@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Synchronization required before release the lock:
 sem_post/8-1.c
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, linux-kernel@vger.kernel.org

On Thu, Feb 25, 2010 at 07:15:42PM +0530, naresh kamboju wrote:
> Hi,
> 
> I have found abnormal behavior of sem_post/8-1.c test case under posix.
> This test case passes in some times and failed in many times :-(
> 
> After my investigation found synchronization is missing between the
> child processes.
> Made a patch to fix this issue.
> 
> Patch includes
> 1.	Reverting back changes made by mreed on Sep 25 2006. Making sure
> child has been waiting for the lock (below Refs).
> 2.	using sleep in while loop is not a good idea, so sleep is removed
> from while loop
> 3.	For the synchronization I have added sleep before releasing the lock.
> 
> 
> After applying this patch I have tested this test case 1000 times continuously.
> All the times test case reported as Test Pass :-)
> 
> 
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

Looks good to me though i needed few clarification below.

Acked-By: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>

> ---
>  testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
> |   15    8 +     7 -     0 !
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> Index: b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
> ===================================================================
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
> @@ -161,7 +161,6 @@ int main()
>         }
>         fprintf(stderr, "P: child_1:%d forked\n", c_1);
> 
> -       sleep(1);
>         c_2 = fork();
>         if (c_2 == 0)
>         {
> @@ -176,13 +175,13 @@ int main()
>         }
>         fprintf(stderr, "P: child_2: %d forked\n", c_2);
> 
> +        /* Step 3 Implementation */
>         /* Make sure the two children has been waiting */
> -       /*do {
> -               sleep(1);
I feel before getting semaphore value, we need to sync first so here
sleep is require,though your point is valid that there is no use of
using sleep inside while loop.

> +       do {
>                 sem_getvalue(sem_1, &val);
>                 //printf("val = %d\n", val);
>         } while (val != 1);
> -       */
> +
>         c_3 = fork();
>         if (c_3 == 0)
>         {
> @@ -191,13 +190,15 @@ int main()
>         }
>         fprintf(stderr, "P: child_3: %d forked\n", c_3);
> 
> +        /* Step 3 Implementation */
>         /* Make sure child 3 has been waiting for the lock */
> -       /*do {
> -               sleep(1);
> +       do {
>                 sem_getvalue(sem_1, &val);
>                 //printf("val = %d\n", val);
>         } while (val != 0);
> -       */
> +
> +       /* Synchronization required before release the lock */
> +       sleep(1);
>         /* Ok, let's release the lock */
>         fprintf(stderr, "P: release lock\n");
>         sem_post(sem);
> 
> 
> Test script to test 1000 times:
> /*****************************************************/
> #!/bin/sh
> 
> for ((  i = 0 ;  i < 1000;  i++  ))
> 
> do
> 
> ./8-1.test >> /tmp/sem-post-8-1.log
> done
> /*****************************************************/
> 
> Refs:
> http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c?view=log
> 
> Please review this patch and let me know if you have any issues.
> 
> Best regards
> Naresh Kamboju


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
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

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
