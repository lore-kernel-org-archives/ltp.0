From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Jun 2016 13:59:41 +0200
Subject: [LTP] [PATCH] sched_rr_get_interval: run tests under SCHED_RR
 policy
In-Reply-To: <2acd53b3a170f75ee579e0e6cb694748db755678.1464959671.git.jstancek@redhat.com>
References: <2acd53b3a170f75ee579e0e6cb694748db755678.1464959671.git.jstancek@redhat.com>
Message-ID: <20160606115941.GA20756@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Man page says:
>  The specified process should be running under the SCHED_RR
>  scheduling policy.

There does not seem to be such limitation in POSIX at:

http://pubs.opengroup.org/onlinepubs/9699919799/

But they explain that the the time quantum returned by the call is only
applicable for SCHED_RR in schedulling policies at:

http://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_08_04_01

> sched_rr_get_interval_1-1 can rarely fail if run as
> SCHED_OTHER, because time quantum calculated/returned by
> get_rr_interval_fair() can change between two calls.
> For example it depends on number of running tasks on runq.

So this is fine, acked.

> This patch sets sched policy to SCHED_RR.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  .../conformance/interfaces/sched_rr_get_interval/1-1.c | 15 ++++++++++++---
>  .../conformance/interfaces/sched_rr_get_interval/2-1.c | 15 ++++++++++++---
>  .../conformance/interfaces/sched_rr_get_interval/3-1.c | 18 +++++++++++++-----
>  3 files changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/1-1.c
> index 28ef9eba6ebe..e7a1e846e5a3 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/1-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/1-1.c
> @@ -11,12 +11,13 @@
>   * Test that the current execution time limit is returned for the calling
>   * process when pid = 0.
>   */
> -#include <stdio.h>
> -#include <sched.h>
>  #include <errno.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <time.h>
>  #include <unistd.h>
>  #include "posixtest.h"
> -#include <time.h>
>  
>  int main(void)
>  {
> @@ -25,6 +26,14 @@ int main(void)
>  	struct timespec interval1;
>  	int result0 = -1;
>  	int result1 = -1;
> +	struct sched_param param;
> +
> +	param.sched_priority = sched_get_priority_min(SCHED_RR);
> +	if (sched_setscheduler(0, SCHED_RR, &param) == -1) {
> +		printf("sched_setscheduler failed: %d (%s)\n",
> +			errno, strerror(errno));
> +		return PTS_UNRESOLVED;
> +	}
>  
>  	interval0.tv_sec = -1;
>  	interval0.tv_nsec = -1;
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/2-1.c
> index 0b29586ab3b5..5dedf1f6e7ff 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/2-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/2-1.c
> @@ -10,16 +10,25 @@
>   *
>   * sched_rr_get_interval() returns 0 on success.
>   */
> -#include <stdio.h>
> -#include <sched.h>
>  #include <errno.h>
> -#include "posixtest.h"
> +#include <sched.h>
> +#include <stdio.h>
> +#include <string.h>
>  #include <time.h>
> +#include "posixtest.h"
>  
>  int main(void)
>  {
>  	struct timespec interval;
>  	int result = -2;
> +	struct sched_param param;
> +
> +	param.sched_priority = sched_get_priority_min(SCHED_RR);
> +	if (sched_setscheduler(0, SCHED_RR, &param) == -1) {
> +		printf("sched_setscheduler failed: %d (%s)\n",
> +			errno, strerror(errno));
> +		return PTS_UNRESOLVED;
> +	}
>  
>  	interval.tv_sec = -1;
>  	interval.tv_nsec = -1;
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/3-1.c
> index 75fc5a0a5463..ee421a1973bc 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/3-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_rr_get_interval/3-1.c
> @@ -13,20 +13,28 @@
>   * The test create a child process which exit immediately and call
>   * sched_rr_get_interval with the pid of defunct child.
>   */
> -#include <stdio.h>
> -#include <sched.h>
>  #include <errno.h>
> -#include <unistd.h>
> +#include <sched.h>
> +#include <stdio.h>
>  #include <stdlib.h>
> +#include <string.h>
> +#include <time.h>
> +#include <unistd.h>
>  #include <sys/wait.h>
>  #include "posixtest.h"
> -#include <time.h>
>  
>  int main(void)
>  {
> -
>  	struct timespec interval;
>  	int result = -2, child_pid, stat_loc;
> +	struct sched_param param;
> +
> +	param.sched_priority = sched_get_priority_min(SCHED_RR);
> +	if (sched_setscheduler(0, SCHED_RR, &param) == -1) {
> +		printf("sched_setscheduler failed: %d (%s)\n",
> +			errno, strerror(errno));
> +		return PTS_UNRESOLVED;
> +	}
>  
>  	/* Create a child process which exit immediately */
>  	child_pid = fork();
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
