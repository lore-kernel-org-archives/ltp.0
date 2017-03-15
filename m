From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 15 Mar 2017 09:31:19 -0400 (EDT)
Subject: [LTP] [PATCH] madvise09: Add MADV_FREE test
In-Reply-To: <20170313110636.10803-1-chrubis@suse.cz>
References: <20170313110636.10803-1-chrubis@suse.cz>
Message-ID: <67200919.5693108.1489584679637.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Cc: "Jan Stancek" <jstancek@redhat.com>
> Sent: Monday, 13 March, 2017 12:06:36 PM
> Subject: [PATCH] madvise09: Add MADV_FREE test

Hi,

It worked fine for me with 4.10 and 64k pages on ppc64le.
Couple comments inline:

<snip>

> +
> +static void memory_pressure_child(void)
> +{
> +	size_t i, page_size = getpagesize();
> +	char *ptr;
> +	int sleep = 1;
> +
> +	for (;;) {
> +		ptr = mmap(NULL, 500 * page_size, PROT_READ | PROT_WRITE,
> +			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +
> +		for (i = 0; i < 500; i++) {
> +			ptr[i * page_size] = i % 100;
> +			usleep(sleep);

What I was suggesting was delay between retries. "for" above
won't likely ever finish with 64k pages - it will hit OOM sooner,
so there won't be any delay in subsequent retries.

How about we make "int sleep" global and increase it before
we enter "for" loop? 

> +		}
> +
> +		sleep++;
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
> +static int count_freed(char *ptr)
> +{
> +	int i, ret = 0;
> +
> +	for (i = 0; i < PAGES; i++) {
> +		if (!ptr[i * page_size])
> +			ret++;
> +	}
> +
> +	return ret;
> +}
> +
> +static void child(void)
> +{
> +	size_t i;
> +	char *ptr;
> +	unsigned int usage, old_limit, old_memsw_limit;
> +	int status, pid, retries = 0;
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
> +	else
> +		tst_res(TPASS, "MADV_FREE pages were not freed immediatelly");
> +
> +	ptr[0] = 'b';
> +	ptr[10 * page_size] = 'b';
> +
> +	usage = 8 * 1024 * 1024;
> +	tst_res(TINFO, "Setting memory limits to %u %u", usage, 2 * usage);
> +
> +	SAFE_FILE_SCANF(limit_in_bytes_path, "%u", &old_limit);
> +	SAFE_FILE_SCANF(memsw_limit_in_bytes_path, "%u", &old_memsw_limit);
> +	SAFE_FILE_PRINTF(limit_in_bytes_path, "%u", usage);
> +	SAFE_FILE_PRINTF(memsw_limit_in_bytes_path, "%u", 2 * usage);
> +
> +	do {
> +		pid = SAFE_FORK();
> +		if (!pid)
> +			memory_pressure_child();
> +
> +		tst_res(TINFO, "Memory hungry child %i started, try %i", pid, retries);
> +
> +		SAFE_WAIT(&status);
> +	} while (retries++ < 10 && count_freed(ptr) == 0);
> +
> +	if (ptr[0] == 0 || ptr[10 * page_size] == 0)

Would it make sense to make this more strict by checking also expected value?
Just in case we get some non-zero garbage.

if (ptr[0] == 'b' || ptr[10 * page_size] == 'b')
  PASS
else
  FAIL


> +		tst_res(TFAIL, "Page modified after MADV_FREE was freed");
> +	else
> +		tst_res(TPASS, "Page modified after MADV_FREE was not freed");
> +
> +	char map[PAGES+1];
> +	unsigned int freed = 0;
> +
> +	for (i = 0; i < PAGES; i++) {
> +		if (ptr[i * page_size]) {

Same here, should we check that entire array contains only [ab0]?
Otherwise FAIL.

> +			map[i] = 'p';
> +		} else {
> +			map[i] = '_';
> +			freed++;
> +		}
> +	}
> +	map[PAGES] = '\0';
> +
> +	tst_res(TINFO, "Memory map: %s", map);
> +
> +	if (freed)
> +		tst_res(TPASS, "Pages MADV_FREE were freed on low memory");
> +	else
> +		tst_res(TFAIL, "No MADV_FREE page was freed on low memory");
> +
> +	SAFE_FILE_PRINTF(memsw_limit_in_bytes_path, "%u", old_memsw_limit);
> +	SAFE_FILE_PRINTF(limit_in_bytes_path, "%u", old_limit);
> +
> +	SAFE_MUNMAP(ptr, PAGES);
> +
> +	exit(0);
> +}

Otherwise it looks good to me.

Regards,
Jan
