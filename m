From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 1 Sep 2017 12:03:19 +0200
Subject: [LTP] [PATCH] thp01: Find largest arguments size
In-Reply-To: <20170831083407.28402-1-rpalethorpe@suse.com>
References: <20170831083407.28402-1-rpalethorpe@suse.com>
Message-ID: <20170901100319.GA26071@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <errno.h>
>  #include <sys/types.h>
>  #include <sys/resource.h>
>  #include <sys/wait.h>
> @@ -38,56 +39,72 @@
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include "mem.h"
> +#include "tst_minmax.h"
> +#include "tst_safe_sysv_ipc.h"
>  
> -#define ARRAY_SZ	256
> +#define ARGS_SZ	256
>  
> -static int ps;
> -static long length;
> -static char *array[ARRAY_SZ];
> +static int shm_id;
> +static char *args[ARGS_SZ];
>  static char *arg;
> -static struct rlimit rl = {
> -	.rlim_cur = RLIM_INFINITY,
> -	.rlim_max = RLIM_INFINITY,
> -};
> +static long *arg_count;
>  
>  static void thp_test(void)
>  {
> -	int i;
> -	pid_t pid;
> -
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
> -		}
> -	default:
> -		tst_reap_children();
> +	pid_t pid = SAFE_FORK();
> +
> +	if (!arg_count)
> +		tst_brk(TBROK, "No shared memory");
> +
> +	if (!pid) {
> +		args[*arg_count] = NULL;
> +
> +		do {
> +			TEST(execvp("true", args));
> +			args[--(*arg_count)] = NULL;
> +		} while (*arg_count > 0 && TEST_ERRNO == E2BIG);

		Hmm, for how long does this loop runs? If it's more than
		half of a second or so we should consider using binary
		search to reach the maximal size of arguments...

> +		tst_brk(TBROK | TTERRNO, "execvp(\"true\", ...)");
>  	}
>  
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
> +	shm_id = SAFE_SHMGET(IPC_PRIVATE, sizeof(long),
> +				 IPC_CREAT | IPC_EXCL);
> +	arg_count = SAFE_SHMAT(shm_id, NULL, 0);

Can we, pretty please, use mmap() to map a page of shared memory instead
of using the System V shared memory that has ugly API and system
persistence?

> +	arg_len = 32 * sysconf(_SC_PAGESIZE);
> +	arg = SAFE_MALLOC(arg_len);
> +	memset(arg, 'c', arg_len - 1);
> +	arg[arg_len - 1] = '\0';
> +
> +	args[0] = "true";
> +	*arg_count = ARGS_SZ - 1;
> +	for (i = 1; i < *arg_count; i++)
> +		args[i] = arg;
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
> +		SAFE_SHMDT(arg_count);
> +	if (shm_id)
> +		SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
>  }
>  
>  static struct tst_test test = {
> -- 
> 2.14.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
