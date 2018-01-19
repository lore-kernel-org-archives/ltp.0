From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 Jan 2018 17:03:48 +0100
Subject: [LTP] [PATCH v3] Add regression test for CVE-2017-17052
In-Reply-To: <20180112115952.9287-1-mmoese@suse.de>
References: <20180112115952.9287-1-mmoese@suse.de>
Message-ID: <20180119160347.GB7954@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <unistd.h>
> +#include <pthread.h>
> +#include <sys/wait.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_pthread.h"
> +#include "lapi/syscalls.h"
> +
> +#define RUNS	   4
> +#define EXEC_USEC  400000
> +
> +struct my_shm_data {
> +	int exit;
> +};
> +static struct my_shm_data *shm;

There is no need to pack the the exit into a structure like that, we can
simply do:

static volatile int *do_exit;

...


	do_exit = SAFE_MMAP(...);

And it should be volatile as well, so that it's not optimized-out of the
loops by the compiler.

> +static void setup(void)
> +{
> +	shm = SAFE_MMAP(NULL, sizeof(struct my_shm_data), PROT_READ|PROT_WRITE,
                               ^
			       The system aligns the length to be a
			       multiple of pagesize, so we may as well
			       pass result of getpagesize() here.
> +		    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +
> +	shm->exit = 0;
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_MUNMAP(shm, sizeof(struct my_shm_data));
                          ^
			  Here we must pass length that is multiple of
			  pagesize, at least manual pages says so.

> +}
> +
> +static void *mmap_thread(void *_arg)

Identifiers starting with underscore are reserved for system i.e. libc
we should avoid using these here.

> +{
> +	for (;;) {
> +		SAFE_MMAP(NULL, 0x1000000, PROT_READ,
> +				MAP_POPULATE|MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> +		if (shm->exit)
> +			exit(0);
> +	}

We may as well do:

	return arg;

Which is a nice trick to avoid unused warnings.


Also you are supposed to include stdlib.h for exit(3).

> +}
> +
> +static void *fork_thread(void *_arg)
> +{
> +	if (shm->exit)
> +		exit(0);
> +
> +	usleep(rand() % 10000);
> +	SAFE_FORK();
> +}

Here as well, the arg should not start with underscore and we should add
return to avoid the warnings as well.



Sorry for not pointing these in the previous review, also no need to
respin the patch, I can fix the minor problems before commiting.

-- 
Cyril Hrubis
chrubis@suse.cz
