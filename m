From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Mon, 13 Feb 2017 12:11:53 +0800
Subject: [LTP] [PATCH v3] syscalls/move_pages12: Add new regression test
In-Reply-To: <20170209105635.GC12673@rei.lan>
References: <589C1B4A.8020303@cn.fujitsu.com>
 <1486627987-3297-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20170209105635.GC12673@rei.lan>
Message-ID: <58A13209.7010202@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 02/09/2017 06:56 PM, Cyril Hrubis wrote:
> Hi!
>> +#include "tst_test.h"
>> +#include "move_pages_support.h"
>> +
>> +#if HAVE_NUMA_MOVE_PAGES
>> +
>> +#define LOOPS	1000
>> +#define PATH_MEMINFO	"/proc/meminfo"
>> +#define PATH_NR_HUGEPAGES	"/proc/sys/vm/nr_hugepages"
>> +#define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
>> +#define TEST_PAGES	2
>> +#define TEST_NODES	2
>> +
>> +static int pgsz, hpsz;
>> +static long orig_hugepages;
>> +static unsigned int node1, node2;
>> +static void *addr;
>> +
>> +static void do_child(void)
>> +{
>> +	int test_pages = TEST_PAGES * hpsz / pgsz;
>> +	int i, j;
>> +	int *nodes, *status;
>> +	void **pages;
>> +	pid_t ppid = getppid();
>> +
>> +	pages = SAFE_MALLOC(sizeof(char *) * test_pages + 1);
>> +	nodes = SAFE_MALLOC(sizeof(char *) * test_pages + 1);
>> +	status = SAFE_MALLOC(sizeof(char *) * test_pages + 1);
> 
> I know that this is taken from to original reproduced, but these
> allocations appears to be wrong. Both nodes and status are, as far as I
> can tell, arrays of integers, so this should in fact be:
> 
> pages = SAFE_MALLOC(sizeof(char *) * test_pages);
> nodes = SAFE_MALLOC(sizeof(int) * test_pages);
> status = SAFE_MALLOC(sizeof(int) * test_pages);
> 
> I'm not even sure why there is + 1 in the original code, what is that
> extra byte usefull for.
> 
> Does the reproducer still work once we allocate these arrays correctly?

Yes, it works well with the correct allocation,
and it looks like there is no need to add the "+ 1", thanks.

> 
>> +	for (i = 0; i < test_pages; i++)
>> +		pages[i] = addr + i * pgsz;
>> +
>> +	for (i = 0; ; i++) {
>> +		for (j = 0; j < test_pages; j++) {
>> +			if (i % 2 == 0)
>> +				nodes[j] = node1;
>> +			else
>> +				nodes[j] = node2;
>> +			status[j] = 0;
>> +		}
>> +
>> +		TEST(numa_move_pages(ppid, test_pages,
>> +			pages, nodes, status, MPOL_MF_MOVE_ALL));
>> +		if (TEST_RETURN) {
>> +			tst_res(TFAIL | TTERRNO, "move_pages failed");
>> +			break;
>> +		}
>> +	}
>> +
>> +	exit(0);
>> +}
>> +
>> +static void do_test(void)
>> +{
>> +	int i;
>> +	pid_t cpid = -1;
>> +	int status;
>> +
>> +	for (i = 0; i < LOOPS; i++) {
>> +		addr = SAFE_MMAP(NULL, TEST_PAGES * hpsz,
>> +			PROT_READ | PROT_WRITE,
>> +			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
>> +
>> +		memset(addr, 0, TEST_PAGES * hpsz);
>> +
>> +		SAFE_MUNMAP(addr, TEST_PAGES * hpsz);
>> +
>> +		if (i == 0) {
>> +			cpid = SAFE_FORK();
>> +			if (cpid == 0)
>> +				do_child();
>> +		}
>> +	}
>> +
>> +	if (i == LOOPS) {
>> +		SAFE_KILL(cpid, SIGKILL);
>> +		SAFE_WAITPID(cpid, &status, 0);
>> +		if (!WIFEXITED(status))
>> +			tst_res(TPASS, "Bug not reproduced");
>> +	}
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	int memfree, ret;
>> +
>> +	check_config(TEST_NODES);
>> +
>> +	if (access(PATH_HUGEPAGES, F_OK))
>> +		tst_brk(TCONF, "Huge page not supported");
>> +
>> +	pgsz = (int)get_page_size();
>> +	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "Hugepagesize: %d", &hpsz);
>> +	hpsz *= 1024;
>> +
>> +	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "MemFree: %d", &memfree);
>> +	memfree *= 1024;
>> +	if (4 * hpsz > memfree)
>> +		tst_brk(TBROK, "RAM not enough");
>                                    ^
> 				This should rather be "Not enough free RAM"
> 
> Or something similar, but that is minor.
> 

I will modify here as your description, thanks.

Best Regards,
Guangwen Feng 

>> +	SAFE_FILE_SCANF(PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
>> +	SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages + 4);
>> +
>> +	ret = get_allowed_nodes(NH_MEMS, TEST_NODES, &node1, &node2);
>> +	if (ret < 0)
>> +		tst_brk(TBROK | TERRNO, "get_allowed_nodes: %d", ret);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.tid = "move_pages12",
>> +	.min_kver = "2.6.32",
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_all = do_test,
>> +};
>> +
>> +#else
>> +	tst_res(TCONF, "move_pages support not found");
>> +#endif
> 
> The rest looks good.
> 


