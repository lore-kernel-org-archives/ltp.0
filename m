Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XjohE-0000MK-I9
	for ltp-list@lists.sourceforge.net; Thu, 30 Oct 2014 12:19:20 +0000
Date: Thu, 30 Oct 2014 13:18:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141030121850.GA14847@rei.suse.de>
References: <1413021389-17387-1-git-send-email-xuw@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1413021389-17387-1-git-send-email-xuw@redhat.com>
Subject: Re: [LTP] [PATCH] fs: Add support for numthreads/numfiles reach os
 rlimit.
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
To: xuw@redhat.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> Try to reset the RLIMIT_NPROC/RLIMIT_NOFILE to satify the test
> option. If fail, just exit the test with warning. Also fix the bug for
> subthreads opening files failed, the main will infinitely wait.

Can you split the patch into two fixes, one for each problem?

> Signed-off-by: George Wang <xuw@redhat.com>
> ---
>  testcases/kernel/fs/openfile/openfile.c | 50 +++++++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/fs/openfile/openfile.c b/testcases/kernel/fs/openfile/openfile.c
> index 8657064..091fb39 100644
> --- a/testcases/kernel/fs/openfile/openfile.c
> +++ b/testcases/kernel/fs/openfile/openfile.c
> @@ -34,6 +34,7 @@
>  #include <stdlib.h>
>  #include <stdint.h>
>  #include <unistd.h>
> +#include <sys/resource.h>
>  
>  #include "test.h"
>  #include "usctest.h"
> @@ -49,11 +50,12 @@ struct cb {
>  	pthread_mutex_t m;
>  	pthread_cond_t init_cv;
>  	pthread_cond_t thr_cv;
> +	pthread_spinlock_t fail_lock;
>  	int thr_sleeping;
>  } c;
>  
>  /* Global Variables */
> -int numthreads = 10, numfiles = 10;
> +int numthreads = 10, numfiles = 10, failedthreads = 0;
>  int debug = 0;
>  char *filename = "FILETOOPEN";
>  
> @@ -68,6 +70,30 @@ void cleanup(void)
>  
>  }
>  
> +int adjust_system_limit(int limit_type, int value)
> +{
> +	struct rlimit limit;
> +
> +	if (getrlimit(limit_type, &limit)) {
> +		/* get limit failed, just return 0 to make the test run */
> +		return 0;
> +	}
> +
> +	if (RLIM_INFINITY == limit.rlim_cur) {
> +		/* unlimited for this resource */

Please avoid adding useless comments like this one,
everybody can see that the the current limit is unlimited
from the if body.

> +		return 0;
> +	}
> +	if (value <= (int)limit.rlim_cur) {
> +		/* current limit can satify the value */

Here as well.

> + 		return 0;
> +	} 
> +
> +
> +	limit.rlim_cur = value < (int)limit.rlim_max ? (int)limit.rlim_max : value;
> +
> +	return setrlimit(limit_type, &limit);
> +}

We have SAFE_SETRLIMIT/SAFE_GETRLIMIT that exit the test automatically
if something went wrong.


>  /* Procedures */
>  void *threads(void *thread_id);
>  
> @@ -125,6 +151,13 @@ int main(int argc, char *argv[])
>  		numthreads = MAXTHREADS;
>  	}
>  
> +	if (adjust_system_limit(RLIMIT_NPROC, numthreads) || 
> +			adjust_system_limit(RLIMIT_NOFILE, numfiles)) {
> +		tst_resm(TWARN, "can not run according to current system limition");
> +		cleanup();
> +		_exit(1);

This should be tst_brkm(TBROK, cleanup, ....);

Moreover the rest of the test uses the tst_ interface incorrectly as
well.

If you look at:

        /* Grab mutex lock */
        if (pthread_mutex_lock(&c.m)) {
                tst_resm(TFAIL, "failed to grab mutex lock");
                fclose(fd);
                unlink(filename);
                cleanup();
        }


The fd should be closed in cleanup(), the unlink() does not neet to be done at
all as the tst_rmdir() removes the directory recursively and the cleanup() does
not exit the test, which it should at this moment.

So it really should be:

        if (pthread_mutex_lock(&c.m))
                tst_brkm(TBROK, cleanup, "failed to grab mutex lock");

And the cleaup should contain:

	if (fd > 0 && close(fd))
		tst_resm(TWARN | TERRNO, "Failed to close(fd));

(the fd variable needs to be global).


Moreover the _exit(0); at the end of the main causes the test not to propagate
the failure to the results. It should be tst_exit().

Can you please fix that (in a separate patch) before we start doing functional
changes in the testcase?

You can also remove useless comments as: OTHER PROCEDURES, /* Open files */
etc. while you are at it.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
