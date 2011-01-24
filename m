Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PhJCh-0008Hj-9d
	for ltp-list@lists.sourceforge.net; Mon, 24 Jan 2011 09:59:19 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PhJCe-0000J0-Dl
	for ltp-list@lists.sourceforge.net; Mon, 24 Jan 2011 09:59:19 +0000
Message-ID: <4D3D4D36.1030002@cn.fujitsu.com>
Date: Mon, 24 Jan 2011 17:58:14 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
References: <000001cb96a5$12026c30$36074490$@co.jp>
In-Reply-To: <000001cb96a5$12026c30$36074490$@co.jp>
Subject: Re: [LTP] [PATCH] fix "sched_getparam/6-1" and
 "sched_getscheduler/7-1" tests
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net, =?UTF-8?B?55W25bqnIOWBpeW4gg==?= <toza@ryobi.co.jp>



Mitani wrote:
> Hi,
> 
> 
> Following POSIX testsets failed:
> ------------
> conformance/interfaces/sched_getparam/6-1: execution: FAILED: Output:
> Testing with user 'bin' (euid: 1)(uid: 1)
> The function sched_getparam has successed.
> ------------
> 
> ------------
> conformance/interfaces/sched_getscheduler/7-1: execution: FAILED: Output:
> Testing with user 'bin' (uid: 1)
> The function sched_getscheduler has successed.
> ------------
> 
> The environments are as follows:
>   - RHEL4.8 --- (x86, x86_64, ia64)
>   - kernel  --- kernel-2.6.9-89.EL
>   - glibc   --- glibc-2.3.4-2.43
> 
>   - RHEL5.5 --- (x86, x86_64, ia64)
>   - kernel  --- kernel-2.6.18-194.el5
>   - glibc   --- glibc-2.5-49
> 
> 
> They are permission tests.
> 
> The comment of "sched_getparam/6-1" testset source is as follows:
> ------------
>   * On Linux, e.g, the kernel makes no check on user permission to call this
>   * API. So basically we don't know on what condition a system should return
>   * EPERM. It is implementation defined.
> ------------
> 

Hi Garrett,

 I think it's better to report UNRESOLVED, whatever the os is.

Regards
 Bian

> 
> Therefore I revised their results to "UNRESOLVED" by judging linux
> environment.
> 
> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
> ============
> ---
> a/testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/6-1.c
> 2010-12-08 15:39:45.000000000 +0900
> +++
> b/testcases/open_posix_testsuite/conformance/interfaces/sched_getparam/6-1.c
> 2010-12-08 13:48:51.000000000 +0900
> @@ -65,6 +65,11 @@
>  	struct sched_param param;
>  	int result = -1;
>  
> +#ifdef __linux__
> +	printf("We don't know on what condition a system should return
> EPERM.\n");
> +        return PTS_UNRESOLVED;
> +#endif
> +
>  	/* We assume process Number 1 is created by root */
>  	/* and can only be accessed by root */ 
>  	/* This test should be run under standard user permissions */
> ============
> 
> ============
> ---
> a/testcases/open_posix_testsuite/conformance/interfaces/sched_getscheduler/7
> -1.c	2010-11-12 02:19:16.000000000 +0900
> +++
> b/testcases/open_posix_testsuite/conformance/interfaces/sched_getscheduler/7
> -1.c	2010-12-08 15:42:23.000000000 +0900
> @@ -55,6 +55,11 @@
>  
>  	int result = -1;
>  
> +#ifdef __linux__
> +	printf("We don't know on what condition a system should return
> EPERM.\n");
> +	return PTS_UNRESOLVED;
> +#endif
> +
>  	/* We assume process Number 1 is created by root */
>  	/* and can only be accessed by root */ 
>  	/* This test should be run under standard user permissions */
> ============
> 
> 
> 
> Regards--
> 
> -Tomonori Mitani
> 
> 
> ------------------------------------------------------------------------
> 
> ------------------------------------------------------------------------------
> What happens now with your Lotus Notes apps - do you make another costly 
> upgrade, or settle for being marooned without product support? Time to move
> off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
> use, and manage than apps on traditional platforms. Sign up for the Lotus 
> Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
