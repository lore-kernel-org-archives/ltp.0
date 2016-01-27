From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jan 2016 16:35:21 +0100
Subject: [LTP] [PATCH 7/7] pi_test: use only available CPUs
In-Reply-To: <1450449335-18223-8-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1450449335-18223-8-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160127153521.GB32032@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifndef CPU_ALLOC
> +#define CPU_ALLOC(ncpus) malloc(sizeof(cpu_set_t)); \
> +if (ncpus > CPU_SETSIZE) { \
> +	EPRINTF("UNRESOLVED: Your libc does not support masks with %ld cpus", \
> +		ncpus); \
> +	exit(UNRESOLVED); \
> +}
> +#endif
> +
> +#ifndef CPU_FREE
> +#define CPU_FREE(ptr) free(ptr)
> +#endif
> +
> +#ifndef CPU_ALLOC_SIZE
> +#define CPU_ALLOC_SIZE(size) sizeof(cpu_set_t)
> +#endif
> +
> +#ifndef CPU_ZERO_S
> +#define CPU_ZERO_S(size, mask) CPU_ZERO(mask)
> +#endif
> +
> +#ifndef CPU_SET_S
> +#define CPU_SET_S(cpu, size, mask) CPU_SET(cpu, mask)
> +#endif
> +
>  struct thread_param {
>  	int index;
>  	volatile int stop;
> @@ -52,7 +77,6 @@ struct sample_param {
>  	int priority;
>  };
>  
> -static int cpus;
>  static volatile int ts_stop;
>  static volatile double base_time;
>  
> @@ -141,21 +165,141 @@ static void do_work(unsigned granularity_top, volatile unsigned *progress)
>  	}
>  }
>  
> +static void *test_calloc(size_t nmemb, size_t size)
> +{
> +	void *r;
> +
> +	r = calloc(nmemb, size);
> +	if (r == NULL) {
> +		EPRINTF("UNRESOLVED: calloc failed");
> +		exit(UNRESOLVED);
> +	}
> +
> +	return r;
> +}
> +
> +static int first_available_cpu(int ncpus_max, size_t mask_size, cpu_set_t *mask)
> +{
> +	int i;
> +
> +	for (i = 0; i < ncpus_max; i++) {
> +		if (CPU_ISSET_S(i, mask_size, mask))
> +			return i;
> +	}
> +	return -1;
> +}
> +
> +/*
> + * Allocates a new array of 'struct thread_param' with
> + * the number of TF entries increased to 'online CPUs - 1'.
> + * All non-TF entries are bind to the first available online CPU,
> + * each TF-entry is bind to its own online CPU.
> + */
> +static void init_tparam(struct thread_param *tpbase, int len,
> +		  struct thread_param **tpnew, int *newlen)
> +{
> +	struct thread_param *tp;
> +	cpu_set_t *mask;
> +	size_t mask_size;
> +	int i, cpu, ncpus_max, ncpus_online;
> +
> +	ncpus_max = sysconf(_SC_NPROCESSORS_CONF);
> +	ncpus_online = sysconf(_SC_NPROCESSORS_ONLN);
> +
> +	if (ncpus_online < 2) {
> +		EPRINTF("UNRESOLVED: we need at least %d online CPUs, got %d",
> +			2, ncpus_online);
> +		exit(UNRESOLVED);
> +	}
> +
> +	*newlen = len - 1 + (ncpus_online - 1);
> +
> +	mask_size = CPU_ALLOC_SIZE(ncpus_max);
> +	mask = CPU_ALLOC(ncpus_max);
> +	if (mask == NULL) {
> +		EPRINTF("UNRESOLVED: failed to allocate a CPU mask");
> +		exit(UNRESOLVED);
> +	}
> +
> +	if (sched_getaffinity(0, mask_size, mask)) {
> +		EPRINTF("UNRESOLVED: sched_getaffinity: %s", strerror(errno));
> +		CPU_FREE(mask);
> +		exit(UNRESOLVED);
> +	}
> +
> +	/* This is the CPU where all non-TF threads will be running */
> +	cpu = first_available_cpu(ncpus_max, mask_size, mask);
> +	if (cpu == -1) {
> +		EPRINTF("UNRESOLVED: first_available_cpu failed");
> +		CPU_FREE(mask);
> +		exit(UNRESOLVED);
> +	}
> +	CPU_CLR_S(cpu, mask_size, mask);
> +
> +	tp = calloc(*newlen, sizeof(struct thread_param));
> +
> +	for (i = 0; i < len - 1; i++) {
> +		tp[i] = tpbase[i];
> +		tp[i].cpu = cpu;
> +	}
> +	for (i = len - 1; i < *newlen; i++) {
> +		tp[i] = tpbase[len - 1];
> +
> +		cpu = first_available_cpu(ncpus_max, mask_size, mask);
> +		if (cpu == -1) {
> +			EPRINTF("UNRESOLVED: first_available_cpu failed");
> +			CPU_FREE(mask);
> +			exit(UNRESOLVED);
> +		}
> +		tp[i].cpu = cpu;
> +		CPU_CLR_S(cpu, mask_size, mask);
> +	}
> +
> +	CPU_FREE(mask);
> +
> +	*tpnew = tp;
> +}
> +
> +static void test_set_affinity(pid_t pid, int cpu)
> +{
> +	cpu_set_t *mask;
> +	size_t mask_size;
> +	int ncpus_max, ncpus_online;
> +
> +	ncpus_max = sysconf(_SC_NPROCESSORS_CONF);
> +	ncpus_online = sysconf(_SC_NPROCESSORS_ONLN);
> +
> +	if (cpu >= ncpus_max) {
> +		EPRINTF("UNRESOLVED: invalid CPU specified: %d", cpu);
> +		exit(UNRESOLVED);
> +	}
> +
> +	mask_size = CPU_ALLOC_SIZE(ncpus_max);
> +	mask = CPU_ALLOC(ncpus_max);
> +	if (mask == NULL) {
> +		EPRINTF("UNRESOLVED: failed to allocate a CPU mask");
> +		exit(UNRESOLVED);
> +	}
> +
> +	CPU_ZERO_S(mask_size, mask);
> +	CPU_SET_S(cpu, mask_size, mask);
> +
> +	if (sched_setaffinity(pid, mask_size, mask)) {
> +		EPRINTF("UNRESOLVED: pid %d: sched_setaffinity failed: %s",
> +			pid, strerror(errno));
> +		CPU_FREE(mask);
> +		exit(UNRESOLVED);
> +	}
> +	CPU_FREE(mask);
> +}

Technically we must not use linux specific calls in the open posix
testsuite without #ifdefing them around.

And we have most of this functionality allready in
open_posix_testsuite/include/affinity.h you should really use or
modify and use functions from there since that makes it the only place
that needs to be ported to other POSIX compatible OSes.

-- 
Cyril Hrubis
chrubis@suse.cz
