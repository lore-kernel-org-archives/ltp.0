Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Qu0hp-0002sb-9w
	for ltp-list@lists.sourceforge.net; Thu, 18 Aug 2011 11:24:13 +0000
Date: Thu, 18 Aug 2011 13:28:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110818112847.GB19491@saboteur.suse.cz>
References: <4E151B53.4050207@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E151B53.4050207@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX] [PATCH] sched_setscheduler/17-5.c: Add the
 missing scheduling policies.
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
To: tangchen <tangchen@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> On linux, I found the scheduling policies are defined as follow:
> 
> in /usr/include/bits/sched.h
> 
> /* Scheduling algorithms.  */
> #define SCHED_OTHER             0
> #define SCHED_FIFO              1
> #define SCHED_RR                2
> #ifdef __USE_GNU
> # define SCHED_BATCH            3
> # define SCHED_IDLE             5
> 
> # define SCHED_RESET_ON_FORK    0x40000000
> #endif
> 
> So besides SCHED_OTHER, SCHED_FIFO and SCHED_RR, there are another 
> two policies, SCHED_BATCH and SCHED_IDLE. And 3 is a valid value 
> for the scheduling policy, which causes the test returns UNSOLVED 
> on linux system.
>  
> Here is the patch, please comment!
> Thanks.:)
> 
> 
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> ---
>  .../interfaces/sched_setscheduler/17-5.c           |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/17-5.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/17-5.c
> index b4f90b3..652db27 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/17-5.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/17-5.c
> @@ -17,6 +17,11 @@
>   *   2. Call sched_setscheduler with invalid args.
>   *   3. Check that the policy and priority have not changed.
>   */
> +
> +#ifdef __linux__
> +#define _GNU_SOURCE
> +#endif
> +
>  #include <sched.h>
>  #include <stdio.h>
>  #include <errno.h>
> @@ -31,6 +36,10 @@ int main() {
>  	invalid_policy = 0;
>  	/* Linux does not treat minus value as invalid for policy */
>  	while (invalid_policy == SCHED_OTHER ||
> +#ifdef _GNU_SOURCE
> +		invalid_policy == SCHED_BATCH ||
> +		invalid_policy == SCHED_IDLE ||
> +#endif
>  		invalid_policy == SCHED_FIFO ||
>  		invalid_policy == SCHED_RR)
>  	invalid_policy++;
> @@ -78,4 +87,4 @@ int main() {
>  		printf("The policy has changed\n");
>  	}
>  	return PTS_FAIL;
> -}
> \ No newline at end of file
> +}

Meanwhile we changed the invalid policy to INT_MAX, which seems to work
fine. Thanks anyway.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
