Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nmicl-0000HS-GO
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 07:04:03 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nmick-0005lC-4w
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 07:04:03 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2370IUr030856
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 00:00:18 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2373lKd124552
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 00:03:47 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2373kOx017080
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 00:03:46 -0700
Date: Wed, 3 Mar 2010 12:33:42 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100303070342.GB19084@linux.vnet.ibm.com>
References: <f5a7b3811002250545x3d5288cfqd114d3bcd79581f2@mail.gmail.com>
	<20100302085046.GA27023@linux.vnet.ibm.com>
	<f5a7b3811003020708wdd0710fv4c3e1dcf1992935c@mail.gmail.com>
	<20100303045624.GB10185@linux.vnet.ibm.com>
	<f5a7b3811003022200r32a0e108g8eaf5d9a2ce66b4a@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f5a7b3811003022200r32a0e108g8eaf5d9a2ce66b4a@mail.gmail.com>
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
Cc: ltp-list@lists.sourceforge.net

On Wed, Mar 03, 2010 at 11:30:42AM +0530, naresh kamboju wrote:
> On Wed, Mar 3, 2010 at 10:26 AM, Rishikesh K Rajak
> <risrajak@linux.vnet.ibm.com> wrote:
> > On Tue, Mar 02, 2010 at 08:38:20PM +0530, naresh kamboju wrote:
> >> On Tue, Mar 2, 2010 at 2:20 PM, Rishikesh K Rajak
> >> <risrajak@linux.vnet.ibm.com> wrote:
> >> > I feel before getting semaphore value, we need to sync first so here
> >> > sleep is require,though your point is valid that there is no use of
> >> > using sleep inside while loop.
> >> I agree with you.
> >> AFAIU, we should call sleep() before calling getting semaphore
> >> value.when we don't have while loop here. Because while loop condition
> >> is depends on val so when ever we call sem_getvalue() it will get
> >> latest value of val.
> >> In addition to this, we are ensuring val is decremented before we do
> >> unlock the sem by while loop condition.
> >>
> >> Having sleep() in while loop will not effect the final output. IIUC
> >>
> >
> > Hi Naresh,
> >
> > I am not able to apply your patch against ltp next branch. can you
> > please send me patch against next branch of ltp ?
> Here I have posted and attached to this e-mail.


Apllied to next branch . Thanks for your patch, i will test in
production environment, if it is not creating any regression will merge
with master branch and it will available to next month release.

Thanks
-Rishi
> 
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
> 
> ---
>  testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
> |   15 	8 +	7 -	0 !
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> Index: b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
> ===================================================================
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
> @@ -161,7 +161,6 @@ int main()
>  	}
>  	fprintf(stderr, "P: child_1:%d forked\n", c_1);
>  	
> -	sleep(1);
>  	c_2 = fork();
>  	if (c_2 == 0)
>  	{
> @@ -176,13 +175,13 @@ int main()
>  	}
>  	fprintf(stderr, "P: child_2: %d forked\n", c_2);
> 
> +        /* Step 3 Implementation */
>  	/* Make sure the two children has been waiting */	
> -	/*do {
> -		sleep(1);
> +	do {
>  		sem_getvalue(sem_1, &val);
>  		//printf("val = %d\n", val);
>  	} while (val != 1);
> -	*/
> +
>  	c_3 = fork();
>  	if (c_3 == 0)
>  	{
> @@ -191,13 +190,15 @@ int main()
>  	}
>  	fprintf(stderr, "P: child_3: %d forked\n", c_3);
>  	
> +        /* Step 3 Implementation */
>  	/* Make sure child 3 has been waiting for the lock */	
> -	/*do {
> -		sleep(1);
> +	do {
>  		sem_getvalue(sem_1, &val);
>  		//printf("val = %d\n", val);
>  	} while (val != 0);
> -	*/
> +
> +	/* Synchronization required before release the lock */
> +	sleep(1);
>  	/* Ok, let's release the lock */
>  	fprintf(stderr, "P: release lock\n");
>  	sem_post(sem);
> 
> Best regards
> Naresh Kamboju
> >
> > #git clone -b next
> > git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp
> >
> > And then create your patch and send it to ltp-list@
> >
> > --
> > Thanks & Regards
> > Rishi
> > LTP Maintainer
> > IBM, LTC, Bangalore
> > Please join IRC #ltp @ irc.freenode.net
> >



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
