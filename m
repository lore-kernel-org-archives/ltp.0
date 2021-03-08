From: Leo Liang <ycliang@andestech.com>
Date: Mon, 8 Mar 2021 19:33:32 +0800
Subject: [LTP] [PATCH 6/6] fzsync: Check processor affinity
In-Reply-To: <20210305155123.18199-7-rpalethorpe@suse.com>
References: <20210305155123.18199-1-rpalethorpe@suse.com>
 <20210305155123.18199-7-rpalethorpe@suse.com>
Message-ID: <20210308113332.GB622@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Mar 05, 2021 at 11:51:23PM +0800, Richard Palethorpe wrote:
> It is useful for testing Fuzzy Sync itself to set the CPU affinity to
> a single core. The current processes affinity does not effect
> tst_ncpus(), but we can get the affinity separately.
> 
> Note that checking this still does not guarantee we will use yield
> when restricted to only one core. We would have to periodically probe
> which CPUs threads are running on until we detect more than one CPU.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  include/tst_fuzzy_sync.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> index 36a604e13..ea356ab44 100644
> --- a/include/tst_fuzzy_sync.h
> +++ b/include/tst_fuzzy_sync.h
> @@ -59,9 +59,11 @@
>   * @sa tst_fzsync_pair
>   */
>  
> +#define _GNU_SOURCE
> +
>  #include <math.h>
>  #include <pthread.h>
> -#include <sched.h>
> +#include "lapi/cpuset.h"
>  #include <stdbool.h>
>  #include <stdlib.h>
>  #include <sys/time.h>
> @@ -213,12 +215,26 @@ struct tst_fzsync_pair {
>   */
>  static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
>  {
> +	long ncpus = tst_ncpus();
> +#ifdef CPU_COUNT
> +	size_t cpusz = CPU_ALLOC_SIZE(ncpus);
> +	cpu_set_t *cpus = CPU_ALLOC(ncpus);
> +
> +	if (sched_getaffinity(0, cpusz, cpus)) {
> +		tst_res(TWARN | TERRNO, "sched_getaffinity(0, %zu, %zx)",
> +			cpusz, (size_t)cpus);
> +	} else {
> +		ncpus = CPU_COUNT(cpus);
> +	}
> +	free(cpus);
> +#endif
> +
>  	CHK(avg_alpha, 0, 1, 0.25);
>  	CHK(min_samples, 20, INT_MAX, 1024);
>  	CHK(max_dev_ratio, 0, 1, 0.1);
>  	CHK(exec_time_p, 0, 1, 0.5);
>  	CHK(exec_loops, 20, INT_MAX, 3000000);
> -	CHK(yield_in_wait, 0, 1, (tst_ncpus() <= 1));
> +	CHK(yield_in_wait, 0, 1, (ncpus <= 1));
>  }
>  #undef CHK
>  
> -- 
> 2.30.1
>

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
