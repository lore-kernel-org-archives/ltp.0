Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NhecC-00062g-V0
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 07:46:32 +0000
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NhecA-0002Rp-6t
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 07:46:32 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id o1H78kgt004866
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 12:38:46 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1H7kBIA897082
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 13:16:11 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1H7kBe0013916
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 18:46:11 +1100
Message-ID: <4B7B9EC2.1010004@linux.vnet.ibm.com>
Date: Wed, 17 Feb 2010 13:16:10 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <4B728073.3070209@cn.fujitsu.com>
In-Reply-To: <4B728073.3070209@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] timers: support clockid of
	CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE
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
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On 02/10/2010 03:16 PM, Shi Weihua wrote:
> mainline commit da15cfdae03351c689736f8d142618592e3cebc3
>   (subject: time: Introduce CLOCK_REALTIME_COARSE)
> added two clocks (CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE) in
> 2.6.32-rc1, but it has not been responded in ltp. then, the following
> error message occured.
> -----
> clock_gettime03    3  TFAIL  :  failed to produce expected error [expected errno = 22 (Invalid argument), TEST_RETURN = 0]: TEST_ERRNO=???(0): Success
> clock_gettime03    4  TFAIL  :  failed to produce expected error [expected errno = 22 (Invalid argument), TEST_RETURN = 0]: TEST_ERRNO=???(0): Success
> timer_create04    1  TFAIL  :  didn't fail as expected [expected errno = 22 (Invalid argument)]: TEST_ERRNO=???(95): Operation not supported
> timer_create04    2  TFAIL  :  didn't fail as expected [expected errno = 22 (Invalid argument)]: TEST_ERRNO=???(95): Operation not supported
> -----
>
> Following patch fixed this bug. and, passed on 2.6.32-rc1, 2.6.33-rc6, 2.6.23.1-42.fc8.
>    

Can anyone provide their review & Acked ?

Thanks "Shi Weihua" for patch.

-Rishi
> Signed-off-by: Shi Weihua<shiwh@cn.fujitsu.com>
> ---
> --- testcases/kernel/timers/include/common_timers.h.orig	2010-02-10 16:44:56.000000000 -0500
> +++ testcases/kernel/timers/include/common_timers.h	2010-02-10 17:33:25.000000000 -0500
> @@ -28,12 +28,20 @@
>   #ifndef CLOCK_MONOTONIC_RAW
>   #define CLOCK_MONOTONIC_RAW 4
>   #endif
> +#ifndef CLOCK_REALTIME_COARSE
> +#define CLOCK_REALTIME_COARSE 5
> +#endif
> +#ifndef CLOCK_MONOTONIC_COARSE
> +#define CLOCK_MONOTONIC_COARSE 6
> +#endif
>   clock_t clock_list[] = {
>   	CLOCK_REALTIME,
>   	CLOCK_MONOTONIC,
>   	CLOCK_PROCESS_CPUTIME_ID,
>   	CLOCK_THREAD_CPUTIME_ID,
>   	CLOCK_MONOTONIC_RAW,
> +	CLOCK_REALTIME_COARSE,
> +	CLOCK_MONOTONIC_COARSE,
>   };
>   #define MAX_CLOCKS (sizeof(clock_list) / sizeof(*clock_list))
>
> @@ -50,6 +58,10 @@ const char *get_clock_str(const int cloc
>   		return "CLOCK_THREAD_CPUTIME_ID";
>   	case CLOCK_MONOTONIC_RAW:
>   		return "CLOCK_MONOTONIC_RAW";
> +	case CLOCK_REALTIME_COARSE:
> +		return "CLOCK_REALTIME_COARSE";
> +	case CLOCK_MONOTONIC_COARSE:
> +		return "CLOCK_MONOTONIC_COARSE";
>   	default:
>   		return "CLOCK_!?!?!?";
>   	}
>
> ------------------------------------------------------------------------------
> SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
> Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
> http://p.sf.net/sfu/solaris-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>    


-- 
Thanks&  Regards
Rishi Kesh K Rajak
IBM LTC, Bangalore
LTP Maintainer
Please join IRC: #ltp @ freenode.net


------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
