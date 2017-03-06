From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 6 Mar 2017 07:56:41 -0500 (EST)
Subject: [LTP] [PATCH] madvise09: Add MADV_FREE test
In-Reply-To: <20170202165850.18436-1-chrubis@suse.cz>
References: <20170202165850.18436-1-chrubis@suse.cz>
Message-ID: <627433457.3569706.1488805001164.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> We test the madvise(MADV_FREE) by running a process in a memory cgroup
> with fairly small memory limits. The test process forks a child, moves
> it to the newly created cgroup. The child allocates memory, marks it
> MADV_FREE then forks a memory hungry child that allocates and faults
> memory in a loop. Due to undeterministic nature of the OOM (that kills
> the memory hungry child sooner or later) we have to retry at two levels.
> First problem is that rarely it gets too rogue and both processes in the
> cgroup gets killed.

Hi,

Could we protect "the good child" via oom_adj or similar so OOM doesn't
touch it?

> The second is that sometimes the memory hungry child
> is killed too fast (before the kernel has chance to free the pages), so
> we rerun it a (for a few times) if that happens.

How about we progressively make each retry slower? [1]

> 
> The test expects memory cgroup mounted in the standard /sys/fs/cgroup/
> path, which is OK since the functionality tested was added to kernel
> 4.5 and the test would be skipped on older distros anyway.
> 
> Also the test expects that the MADV_FREE pages will not be freed
> immediatelly hence the test will fail if the whole system is under
> memory pressure.
> 
> The memory limits were choosen to be 2MB and 4MB for memsw limit.

This looks a bit small to me. Have you checked how much is used
just after fork on a system with 64k pages? My concern is that
we hit this limit before we do anything.

<snip>

> +
> +static void memory_pressure_child(void)
> +{
> +	size_t i, page_size = getpagesize();
> +	char *ptr;
> +
> +	for (;;) {
> +		ptr = mmap(NULL, 1000 * page_size, PROT_READ | PROT_WRITE,
> +			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +
> +		for (i = 0; i < 1000 * page_size; i++)
> +			ptr[i] = i % 100;

[1] some kind of sleep here, so that retries will get gradually slower,
    giving kernel more time to free marked pages.

> +	}
> +
> +	abort();
> +}
> +
> +static void setup_cgroup_paths(int pid)
> +{
> +	snprintf(cgroup_path, sizeof(cgroup_path),
> +		 MEMCG_PATH "ltp_madvise09_%i/", pid);
> +	snprintf(tasks_path, sizeof(tasks_path), "%s/tasks", cgroup_path);
> +	snprintf(limit_in_bytes_path, sizeof(limit_in_bytes_path),
> +		 "%s/memory.limit_in_bytes", cgroup_path);
> +	snprintf(memsw_limit_in_bytes_path, sizeof(memsw_limit_in_bytes_path),
> +		 "%s/memory.memsw.limit_in_bytes", cgroup_path);
> +}
> +
> +static void child(void)
> +{
> +	size_t i, page_size = getpagesize();
> +	char *ptr;
> +	unsigned int usage, old_limit, old_memsw_limit;
> +	int status, pid, retries = 10;
> +
> +	SAFE_MKDIR(cgroup_path, 0777);
> +	SAFE_FILE_PRINTF(tasks_path, "%i", getpid());
> +
> +	ptr = SAFE_MMAP(NULL, PAGES * page_size, PROT_READ | PROT_WRITE,
> +	                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +
> +	for (i = 0; i < PAGES * page_size; i++)
> +		ptr[i] = 'a';
> +
> +	if (madvise(ptr, PAGES * page_size, MADV_FREE)) {
> +		if (errno == EINVAL)
> +			tst_brk(TCONF | TERRNO, "MADV_FREE is not supported");
> +
> +		tst_brk(TBROK | TERRNO, "MADV_FREE failed");
> +	}
> +
> +	if (ptr[page_size] != 'a')
> +		tst_res(TFAIL, "MADV_FREE pages were freed immediatelly");

This could be problem on swapless system, from man 2 madvise:
"On a swapless system, freeing pages in a given range happens instantly,
regardless of memory pressure."


> +	else
> +		tst_res(TPASS, "MADV_FREE pages were not freed immediatelly");
> +
> +	ptr[0] = 'b';
> +	ptr[10 * page_size] = 'b';
> +
> +	usage = (1024 * 1024);
> +	tst_res(TINFO, "Setting memory limits to %u %u", 2 * usage, 4 * usage);
> +
> +	SAFE_FILE_SCANF(limit_in_bytes_path, "%u", &old_limit);
> +	SAFE_FILE_SCANF(memsw_limit_in_bytes_path, "%u", &old_memsw_limit);
> +	SAFE_FILE_PRINTF(limit_in_bytes_path, "%u", 2 * usage);
> +	SAFE_FILE_PRINTF(memsw_limit_in_bytes_path, "%u", 4 * usage);
> +
> +	do {
> +		pid = SAFE_FORK();
> +		if (!pid)
> +			memory_pressure_child();
> +
> +		tst_res(TINFO, "Memory hungry child %i started.", pid);
> +
> +		SAFE_WAIT(&status);
> +	} while (--retries > 0 && ptr[page_size]);

Shouldn't this while break if _any_ of the pages is freed. This seems
to check only 2nd one.

Regards,
Jan
