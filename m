From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Sep 2017 14:10:56 +0200
Subject: [LTP] [PATCH v3] thp01: Find largest arguments size
In-Reply-To: <20170911095535.13663-1-rpalethorpe@suse.com>
References: <20170911095535.13663-1-rpalethorpe@suse.com>
Message-ID: <20170912121005.GA18357@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  testcases/kernel/mem/thp/thp01.c | 96 ++++++++++++++++++++++++++++------------
>  1 file changed, 67 insertions(+), 29 deletions(-)
> 
> diff --git a/testcases/kernel/mem/thp/thp01.c b/testcases/kernel/mem/thp/thp01.c
> index 101a9b5c8..16bd2a8c4 100644
> --- a/testcases/kernel/mem/thp/thp01.c
> +++ b/testcases/kernel/mem/thp/thp01.c
> @@ -30,6 +30,7 @@
>   * ....
>   */
>  
> +#include <errno.h>
>  #include <sys/types.h>
>  #include <sys/resource.h>
>  #include <sys/wait.h>
> @@ -38,56 +39,92 @@
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include "mem.h"
> +#include "tst_minmax.h"
>  
> -#define ARRAY_SZ	256
> +#define ARGS_SZ	(256 * 32)
>  
> -static int ps;
> -static long length;
> -static char *array[ARRAY_SZ];
> +static char *args[ARGS_SZ];
>  static char *arg;
> -static struct rlimit rl = {
> -	.rlim_cur = RLIM_INFINITY,
> -	.rlim_max = RLIM_INFINITY,
> -};
> +static long *arg_count, *change, *arg_count_next;
>  
>  static void thp_test(void)
>  {
> -	int i;
>  	pid_t pid;
>  
> -	switch (pid = SAFE_FORK()) {
> -	case 0:
> -		memset(arg, 'c', length - 1);
> -		arg[length - 1] = '\0';
> -		array[0] = "true";
> -		for (i = 1; i < ARRAY_SZ - 1; i++)
> -			array[i] = arg;
> -		array[ARRAY_SZ - 1] = NULL;
> -		if (setrlimit(RLIMIT_STACK, &rl) == -1) {
> -			perror("setrlimit");
> -			exit(1);
> -		}
> -		if (execvp("true", array) == -1) {
> -			perror("execvp");
> -			exit(1);
> +	while (*change > 0) {
> +		*arg_count = *arg_count_next;
> +		*change /= 2;
> +		*arg_count_next = *arg_count + *change;
> +
> +		pid = SAFE_FORK();
> +		if (!pid) {
> +			args[*arg_count] = NULL;
> +
> +			TEST(execvp("true", args));
> +			if (TEST_ERRNO != E2BIG)
> +				tst_brk(TBROK | TTERRNO, "execvp(\"true\", ...)");
> +
> +			*arg_count_next = *arg_count - *change;
> +			exit(0);
>  		}
> -	default:
> +		tst_res(TINFO, "count: %ld, change: %ld, next: %ld",
> +			*arg_count, *change, *arg_count_next);
>  		tst_reap_children();
>  	}
>  
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		args[*arg_count] = NULL;
> +		do {
> +			TEST(execvp("true", args));
> +			if (TEST_ERRNO != E2BIG)
> +				tst_brk(TBROK | TTERRNO, "execvp(\"true\", ...)");
> +			tst_res(TINFO, "Binary search finished on 2BIG value: %ld",
> +				*arg_count);
> +			args[--(*arg_count)] = NULL;
> +		} while (*arg_count > 0);
> +		exit(0);
> +	}


Why can't we do with a simple bisection:

	left = 0;
	right = ARGS_SZ;

	while (right - left > 1) {
		mid = (left + right) / 2

		pid = SAFE_FORK();
		if (pid == 0) {
			saved_left = left;
			left = mid;

			args[mid] = NULL;

			TEST(execvp("true", args);

			if (TEST_ERRNO == E2BIG) {
				left = saved_left;
				right = mid;
			}
			exit(0);
		}

		tst_reap_children();
	}

	/*
	 * Once we got here the value is either left or left+1 == right
	 * since integer division floors the value down. We already
	 * tried for left and hence we should try for left+1 as well.
	 */
	 pid = SAFE_FORK();
	 if (pid == 0) {
		args[right] = NULL;
		TEST(execvp("true", args);
		exit(0);
	}
	tst_reap_children();

> +	tst_reap_children();
>  	tst_res(TPASS, "system didn't crash, pass.");
>  }
>  
>  static void setup(void)
>  {
> -	ps = sysconf(_SC_PAGESIZE);
> -	length = 32 * ps;
> -	arg = SAFE_MALLOC(length);
> +	struct rlimit rl = {
> +		.rlim_cur = RLIM_INFINITY,
> +		.rlim_max = RLIM_INFINITY,
> +	};
> +	int i;
> +	long arg_len;
> +
> +	arg_count = SAFE_MMAP(NULL, sizeof(*arg_count) * 3,
> +			      PROT_READ | PROT_WRITE,
> +			      MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> +	arg_count_next = arg_count + 1;
> +	change = arg_count + 2;

I would find it a bit more readable if we packed these arguments into a
structure, something as:

static struct bisection {
	long left;
	long right;
	long mid;
} *bisect;

bisection = SAFE_MMAP(..., sizeof(*bisection), ...);


Then we could do:

	bisect->mid = (bisect->right + bisect->left) / 2

> +	arg_len = sysconf(_SC_PAGESIZE);
> +	arg = SAFE_MALLOC(arg_len);
> +	memset(arg, 'c', arg_len - 1);
> +	arg[arg_len - 1] = '\0';
> +
> +	args[0] = "true";
> +	*change = ARGS_SZ / 2;
> +	for (i = 1; i < ARGS_SZ - 1; i++)
> +		args[i] = arg;
> +	*arg_count_next += *change;
> +
> +	SAFE_SETRLIMIT(RLIMIT_STACK, &rl);
>  }
>  
>  static void cleanup(void)
>  {
> -	free(arg);
> +	if (arg)
> +		free(arg);
> +	if (arg_count)
> +		SAFE_MUNMAP(arg_count, sizeof(*arg_count));
>  }
>  
>  static struct tst_test test = {
> @@ -96,4 +133,5 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.test_all = thp_test,
> +	.min_kver = "2.4",
>  };
> -- 
> 2.14.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
