From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 27 Jan 2021 09:52:11 +0000
Subject: [LTP] [PATCH v2 1/1] fzsync: Add sched_yield for single core
 machine
In-Reply-To: <20210127031853.3485-1-ycliang@andestech.com>
References: <20210127031853.3485-1-ycliang@andestech.com>
Message-ID: <87ft2m906s.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Leo,

Leo Yu-Chi Liang <ycliang@andestech.com> writes:

> Fuzzy sync library uses spin waiting mechanism to implement thread
> barrier behavior, which would cause this test to be time-consuming
> on single core machine.
>
> Fix this by adding sched_yield in the spin waiting loop, so that the
> thread yields cpu as soon as it enters the waiting loop.

Thanks for this, a full review will take some time, but I have some
minor comments already.

>
> Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> ---
>  include/tst_fuzzy_sync.h | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> index 4141f5c64..37f3d06f2 100644
> --- a/include/tst_fuzzy_sync.h
> +++ b/include/tst_fuzzy_sync.h
> @@ -59,12 +59,15 @@
>   * @sa tst_fzsync_pair
>   */
>  
> -#include <sys/time.h>
> -#include <time.h>
>  #include <math.h>
> -#include <stdlib.h>

Please don't sort existing includes. It will apear in git-blame that you
added these. :-)

>  #include <pthread.h>
> +#include <sched.h>
> +#include <stdbool.h>
> +#include <stdlib.h>
> +#include <sys/time.h>
> +#include <time.h>
>  #include "tst_atomic.h"
> +#include "tst_cpu.h"
>  #include "tst_timer.h"
>  #include "tst_safe_pthread.h"
>  
> @@ -180,6 +183,15 @@ struct tst_fzsync_pair {
>  	int exec_loop;
>  	/** Internal; The second thread or 0 */
>  	pthread_t thread_b;
> +	/** 
> +	 * Internal; The flag indicates single core machines or not

Actually I think the user can set this. It does not have to be internal.

> +	 * 
> +	 * If running on single core machines, it would take considerable
> +	 * amount of time to run fuzzy sync library.
> +	 * Thus call sched_yield to give up cpu to decrease the test time.
> +	 */
> +	bool yield_in_wait;
> +
>  };
>  
>  #define CHK(param, low, hi, def) do {					      \
> @@ -206,6 +218,7 @@ static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
>  	CHK(max_dev_ratio, 0, 1, 0.1);
>  	CHK(exec_time_p, 0, 1, 0.5);
>  	CHK(exec_loops, 20, INT_MAX, 3000000);
> +	CHK(yield_in_wait, 0, 1, (tst_ncpus() <= 1));

The CHK macro will override the user if they set yield_in_wait to
zero. This only effects single core machines; so that it is impossible
for the user to disable yield (at least before calling init which is the
"correct way").

It still allows the user to enable yield on multicore which is good.

To avoid confusion I think it should be noted that users can force
enable yield on multicore, but they can not disable it on single core.

-- 
Thank you,
Richard.
