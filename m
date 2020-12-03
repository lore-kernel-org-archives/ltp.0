From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Dec 2020 15:48:18 +0100
Subject: [LTP] [PATCH v2] overcommit_memory: Fix unstable subtest
In-Reply-To: <20201118102022.898238-1-lkml@jv-coder.de>
References: <20201118102022.898238-1-lkml@jv-coder.de>
Message-ID: <20201203144818.GD5809@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The test sets overcommit policy to never overcommit and then tries
> to allocate the commit limit reported by /proc/meminfo. This value is an exact
> value (at least at that point in time) of memory, that can be allocated
> according to the policy and ratio settings. This should fail, since there
> is already some memory allocated for running the test programm, but due to
> inaccurate memory accounting in mm/util.c __vm_enough_memory(), the allocation
> can still succeed.
> 
> The commited memory is stored in a percpu counter, that counts in 1 + ncpu
> variables. For small allocations and deallocations, the memory is counted
> in a counter per cpu, without locking. If this counter reaches a threshold,
> the value is committed to a global counter. Due to this the global counter
> can become negative. This global counter is the only thing taken into
> account in __vm_enough_memory, propably for performance reasons, because
> otherwise a lock is required.
> 
> Because of the inaccuracy the system can overcommit a bit by number of cpus
> times threshold value. By adding this value to the exact commit limit
> reported by /proc/meminfo, we can be sure, that we really always hit the
> memory limit.
> 
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> ---
>  .../kernel/mem/tunable/overcommit_memory.c    | 56 +++++++++++++------
>  1 file changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
> index f77939908..8f05a3f70 100644
> --- a/testcases/kernel/mem/tunable/overcommit_memory.c
> +++ b/testcases/kernel/mem/tunable/overcommit_memory.c
> @@ -1,18 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Copyright (c) Linux Test Project, 2012-2020
> - * Copyright (C) 2012-2017  Red Hat, Inc.
> - *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * Descriptions:
> + * Copyright (c) 2012-2020 Linux Test Project
> + * Copyright (c) 2012-2017 Red Hat, Inc.
>   *
>   * There are two tunables overcommit_memory and overcommit_ratio under
>   * /proc/sys/vm/, which can control memory overcommitment.
> @@ -53,12 +42,16 @@
>   * the system is limited to CommitLimit(Swap+RAM*overcommit_ratio)
>   * commit_left(allocatable memory) = CommitLimit - Committed_AS
>   * a. less than commit_left:    commit_left / 2, alloc should pass
> - * b. greater than commit_left: commit_left * 2, alloc should fail
> - * c. overcommit limit:         CommitLimit,     alloc should fail
> + * b. overcommit limit:         CommitLimit + TotalBatchSize, should fail
> + * c. greater than commit_left: commit_left * 2, alloc should fail
>   * *note: CommitLimit is the current overcommit limit.
>   *        Committed_AS is the amount of memory that system has used.
>   * it couldn't choose 'equal to commit_left' as a case, because
>   * commit_left rely on Committed_AS, but the Committed_AS is not stable.
> + * *note2: TotalBatchSize is the total number of bytes, that can be
> + *         accounted for in the per cpu counters for the vm_committed_as
> + *         counter. Since the check used by malloc only looks at the
> + *         global counter of vm_committed_as, it can overallocate a bit.
>   *
>   * References:
>   * - Documentation/sysctl/vm.txt
> @@ -94,6 +87,7 @@ static int heavy_malloc(long size);
>  static void alloc_and_check(long size, int expect_result);
>  static void update_mem(void);
>  static void update_mem_commit(void);
> +static long get_total_batch_size_bytes(void);
>  
>  static void setup(void)
>  {
> @@ -154,7 +148,8 @@ static void overcommit_memory_test(void)
>  
>  	update_mem_commit();
>  	alloc_and_check(commit_left * 2, EXPECT_FAIL);
> -	alloc_and_check(commit_limit, EXPECT_FAIL);
> +	alloc_and_check(commit_limit
> +					+ get_total_batch_size_bytes(), EXPECT_FAIL);

Can we please call the get_total_back_size_bytes() in the test setup and
store the value. The overcommit_memory_test() function can be looped
over and there is no need to recompute it on each iteration.

>  	update_mem_commit();
>  	alloc_and_check(commit_left / 2, EXPECT_PASS);
>  
> @@ -232,6 +227,8 @@ static void update_mem_commit(void)
>  	committed = SAFE_READ_MEMINFO("Committed_AS:");
>  	commit_left = commit_limit - committed;
>  
> +	get_total_batch_size_bytes();

Why do we call the function here? We do not store the value and, as far
as I can tell, there are no side efect either.

>  	if (commit_left < 0) {
>  		tst_res(TINFO, "CommitLimit is %ld, Committed_AS is %ld",
>  			commit_limit, committed);
> @@ -247,6 +244,31 @@ static void update_mem_commit(void)
>  	}
>  }
>  
> +static long get_total_batch_size_bytes(void)
> +{
> +	struct sysinfo info;
> +	long ncpus = tst_ncpus_conf();
> +	long pagesize = getpagesize();
> +	SAFE_SYSINFO(&info);
> +
> +	/* see linux source mm/mm_init.c mm_compute_batch() (This is in pages) */
> +	long batch_size = MAX(
> +			ncpus * 2,
> +			MAX(
> +				32,
> +				MIN(
> +					INT32_MAX,
> +					(long)(info.totalram / pagesize) / ncpus / 256
> +				)
> +			)
> +		);

Why don't we put the first arguemnt on the same line as the MAX( or MIN(
here? That would be much more compact but still nicely readable.

	MAX(ncpus * 2,
	    MAX(32,
	        MIN(INT32_MAX,
		    ...
		)
	    )
	);

> +	/* there are ncpu separate counters, that can all grow up to
> +	 * batch_size. So the maximum error for __vm_enough_memory is
> +	 * batch_size * ncpus. */
> +	return batch_size * ncpus * pagesize;

I do wonder, are the counters flushed if task is migrated between CPUs?
If so we wouldn't need the multiplication by bcpus.

> +}
> +
>  static struct tst_test test = {
>  	.needs_root = 1,
>  	.options = options,
> -- 
> 2.25.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
