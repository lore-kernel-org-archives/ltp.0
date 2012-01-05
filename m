Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rimmo-0004xf-5n
	for ltp-list@lists.sourceforge.net; Thu, 05 Jan 2012 12:51:14 +0000
Date: Thu, 5 Jan 2012 14:02:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120105130209.GC17273@saboteur.suse.cz>
References: <1A42CE6F5F474C41B63392A5F80372B212E02C9595@shsmsx501.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1A42CE6F5F474C41B63392A5F80372B212E02C9595@shsmsx501.ccr.corp.intel.com>
Subject: Re: [LTP] [Ltp-commits] [patches 1/3]perfcounter api updates
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
To: "Xu, Anhua" <anhua.xu@intel.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, "Song,  Youquan" <youquan.song@intel.com>

Hi!
> Hi, I'm newbie to LTP and I have some patches to submit. Not sure if it is OK to post here.
> Since perfcounter associated test cases had been out of date. I updated data structures used by new apis. 
> And add a header file for both perfcounter01 and perfcounter02

As already said, please send patches to ltp-list next time.

> Signed-off-by: Xu,Anhua <anhua.xu@intel.com>
> ---
>  testcases/kernel/performance_counters/perf.h |  107 ++++++++++++++++++++++++++
>  1 files changed, 107 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/performance_counters/perf.h
> 
> diff --git a/testcases/kernel/performance_counters/perf.h b/testcases/kernel/performance_counters/perf.h
> new file mode 100644
> index 0000000..af2e540
> --- /dev/null
> +++ b/testcases/kernel/performance_counters/perf.h
> @@ -0,0 +1,107 @@
> +#include <stdint.h>
> +enum perf_hw_id {                                                                                                                                                     
> +    /*   
> +     * Common hardware events, generalized by the kernel:
> +     */
> +    PERF_COUNT_HW_CPU_CYCLES                = 0, 
> +    PERF_COUNT_HW_INSTRUCTIONS              = 1, 
> +    PERF_COUNT_HW_CACHE_REFERENCES          = 2, 
> +    PERF_COUNT_HW_CACHE_MISSES              = 3, 
> +    PERF_COUNT_HW_BRANCH_INSTRUCTIONS       = 4, 
> +    PERF_COUNT_HW_BRANCH_MISSES             = 5, 
> +    PERF_COUNT_HW_BUS_CYCLES                = 6, 
> +    PERF_COUNT_HW_STALLED_CYCLES_FRONTEND   = 7, 
> +    PERF_COUNT_HW_STALLED_CYCLES_BACKEND    = 8, 
> +
> +    PERF_COUNT_HW_MAX,                      /* non-ABI */
> +};
> +
> +enum perf_sw_ids {
> +    PERF_COUNT_SW_TASK_CLOCK		     =1,
> +};
> +
> +enum perf_type_id {
> +    PERF_TYPE_HARDWARE                      = 0, 
> +    PERF_TYPE_SOFTWARE                      = 1, 
> +    PERF_TYPE_TRACEPOINT                    = 2, 
> +    PERF_TYPE_HW_CACHE                      = 3, 
> +    PERF_TYPE_RAW                           = 4, 
> +    PERF_TYPE_BREAKPOINT                    = 5, 
> +
> +    PERF_TYPE_MAX,                          /* non-ABI */
> +};
> +
> +typedef unsigned int	   __u32;
> +typedef unsigned long long __u64;
> +
> +struct perf_event_attr {
> +
> +	/*
> +	 * Major type: hardware/software/tracepoint/etc.
> +	 */
> +	__u32			type;
> +
> +	/*
> +	 * Size of the attr structure, for fwd/bwd compat.
> +	 */
> +	__u32			size;
> +
> +	/*
> +	 * Type specific configuration information.
> +	 */
> +	__u64			config;
> +
> +	union {
> +		__u64		sample_period;
> +		__u64		sample_freq;
> +	};
> +
> +	__u64			sample_type;
> +	__u64			read_format;
> +
> +	__u64			disabled       :  1, /* off by default        */
> +				inherit	       :  1, /* children inherit it   */
> +				pinned	       :  1, /* must always be on PMU */
> +				exclusive      :  1, /* only group on PMU     */
> +				exclude_user   :  1, /* don't count user      */
> +				exclude_kernel :  1, /* ditto kernel          */
> +				exclude_hv     :  1, /* ditto hypervisor      */
> +				exclude_idle   :  1, /* don't count when idle */
> +				mmap           :  1, /* include mmap data     */
> +				comm	       :  1, /* include comm data     */
> +				freq           :  1, /* use freq, not period  */
> +				inherit_stat   :  1, /* per task counts       */
> +				enable_on_exec :  1, /* next exec enables     */
> +				task           :  1, /* trace fork/exit       */
> +				watermark      :  1, /* wakeup_watermark      */
> +				/*
> +				 * precise_ip:
> +				 *
> +				 *  0 - SAMPLE_IP can have arbitrary skid
> +				 *  1 - SAMPLE_IP must have constant skid
> +				 *  2 - SAMPLE_IP requested to have 0 skid
> +				 *  3 - SAMPLE_IP must have 0 skid
> +				 *
> +				 *  See also PERF_RECORD_MISC_EXACT_IP
> +				 */
> +				precise_ip     :  2, /* skid constraint       */
> +				mmap_data      :  1, /* non-exec mmap data    */
> +				sample_id_all  :  1, /* sample_type all events */
> +
> +				__reserved_1   : 45;
> +
> +	union {
> +		__u32		wakeup_events;	  /* wakeup every n events */
> +		__u32		wakeup_watermark; /* bytes before wakeup   */
> +	};
> +
> +	__u32			bp_type;
> +	union {
> +		__u64		bp_addr;
> +		__u64		config1; /* extension of config */
> +	};
> +	union {
> +		__u64		bp_len;
> +		__u64		config2; /* extension of config1 */
> +	};
> +};

That sounds like system header duplication, quick glance shows that I
have something similar under /usr/include/linux/perf_counter.h.

Are these different from the header supplied by distro?

And if this is really needed you should explain why in the patch
description.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
