From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Feb 2017 10:44:43 +0100
Subject: [LTP] [PATCH v4] syscalls/move_pages12: Add new regression test
In-Reply-To: <1486959263-31051-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <58A13209.7010202@cn.fujitsu.com>
 <1486959263-31051-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20170213094443.GC16973@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void do_test(void)
> +{
> +	int i;
> +	pid_t cpid = -1;
> +	int status;
> +
> +	for (i = 0; i < LOOPS; i++) {
> +		addr = SAFE_MMAP(NULL, TEST_PAGES * hpsz,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
> +
> +		memset(addr, 0, TEST_PAGES * hpsz);
> +
> +		SAFE_MUNMAP(addr, TEST_PAGES * hpsz);
> +
> +		if (i == 0) {
> +			cpid = SAFE_FORK();
> +			if (cpid == 0)
> +				do_child();
> +		}
> +	}

Looking at this piece of code there was a reason the test was using
fixed address. Since once the child forks the addr in parent returned by
mmap() may change and the child would not be working with the same
memory at all. And while this would be probably working fine most of the
time as the kernel will likely return the same address over and over
we may as well fix this by doing one mmap() munmap() cycle to get an
address to pass to the mmap() in this loop.

i.e.
	...

	addr = SAFE_MMAP(NULL, TEST_PAGES * hpsz,
			PROT_READ | PROT_WRITE,
			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
	SAFE_MUNMAP(addr, TEST_PAGES * hpsz);

	cpid = SAFE_FORK();
	if (cpid == 0)
		do_child();

	for (i = 0; i < LOOPS; i++) {
		void *ptr;

		ptr = SAFE_MMAP(addr, TEST_PAGES * hpsz,
		                PROT_READ | PROT_WRITE,
			        MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);

		if (ptr != addr)
			tst_brk(...);

		memset(addr);

		SAFE_UNMAP(addr, TEST_PAGES * hpsz)
	}

This would ensure that both parent and child are working on the same
address.


> +	if (i == LOOPS) {
> +		SAFE_KILL(cpid, SIGKILL);
> +		SAFE_WAITPID(cpid, &status, 0);
> +		if (!WIFEXITED(status))
> +			tst_res(TPASS, "Bug not reproduced");
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	int memfree, ret;
> +
> +	check_config(TEST_NODES);
> +
> +	if (access(PATH_HUGEPAGES, F_OK))
> +		tst_brk(TCONF, "Huge page not supported");
> +
> +	pgsz = (int)get_page_size();
> +	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "Hugepagesize: %d", &hpsz);
> +	hpsz *= 1024;
> +
> +	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "MemFree: %d", &memfree);
> +	memfree *= 1024;
> +	if (4 * hpsz > memfree)
> +		tst_brk(TBROK, "Not enough free RAM");
> +
> +	SAFE_FILE_SCANF(PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
> +	SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages + 4);
> +
> +	ret = get_allowed_nodes(NH_MEMS, TEST_NODES, &node1, &node2);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "get_allowed_nodes: %d", ret);
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
> +}
> +
> +static struct tst_test test = {
> +	.tid = "move_pages12",
> +	.min_kver = "2.6.32",
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = do_test,
> +};
> +
> +#else
> +	tst_res(TCONF, "move_pages support not found");
> +#endif
> -- 
> 1.8.4.2
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
