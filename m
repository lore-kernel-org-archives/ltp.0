From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Nov 2017 16:20:06 +0100
Subject: [LTP] [PATCH] syscalls/migrate_pages03.c: Add new regression
	test
In-Reply-To: <1511863675-13716-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1511863675-13716-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20171130152005.GH2924@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <errno.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#if HAVE_NUMA_H
> +#include <numa.h>
> +#endif
> +#if HAVE_NUMAIF_H
> +#include <numaif.h>
> +#endif
> +
> +#include "config.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/mmap.h"
> +#include "tst_test.h"
> +#include "numa_helper.h"
> +#include "migrate_pages_common.h"
> +
> +#if defined(HAVE_NUMA_V2) && defined(__NR_migrate_pages)
                                       ^
				The lapi/syscalls.h defines fallback for
				this one, hence this macro is always
				defined. And the tst_syscall() will just
				do tst_brk(TCONF, ...) if the syscall
				number is not defined for a particular
				arch.
> +
> +#define KSM_RUN_PATH "/sys/kernel/mm/ksm/run"
> +#define N_PAGES 20
> +#define N_LOOPS 100
> +#define TEST_NODES 2
> +
> +static int orig_ksm_value;
> +static int restore_ksm_run;
> +static unsigned int page_size;
> +static void *test_pages[N_PAGES];
> +static int node1, node2;
> +static int num_nodes;
> +static int *nodes;
> +
> +static void setup(void)
> +{
> +	int n, ret;
> +
> +	if (access(KSM_RUN_PATH, F_OK)) {
> +		tst_brk(TCONF, "KSM configuration was not enabled");
> +	} else {

No need for else branch after tst_brk();

> +		SAFE_FILE_SCANF(KSM_RUN_PATH, "%d", &orig_ksm_value);
> +		restore_ksm_run = 1;
> +		SAFE_FILE_PRINTF(KSM_RUN_PATH, "%d", 1);
> +	}
> +
> +	ret = get_allowed_nodes_arr(NH_MEMS, &num_nodes, &nodes);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "get_allowed_nodes() failed");
> +
> +	if (num_nodes < TEST_NODES) {
> +		tst_brk(TCONF, "requires NUMA with at least %d node",
> +			TEST_NODES);
> +	}
> +
> +	ret = get_allowed_nodes(NH_MEMS, TEST_NODES, &node1, &node2);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "get_allowed_nodes() failed");

We already got array of nodes from the get_allowed_nodes_arr(), we can
just use nodes[0] and nodes[1] instead of calling this again.

Or drop the get_allowed_nodes_arr() because get_allowed_nodes() returns
negative number if number of nodes was less than count anyway.

> +	page_size = getpagesize();
> +
> +	for (n = 0; n < N_PAGES; n++) {
> +		test_pages[n] = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE | PROT_EXEC,
> +					  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +		memset(test_pages[n], 0, page_size);
> +		errno = 0;

Do we really have to reset the errno here?

> +		if (madvise(test_pages[n], page_size, MADV_MERGEABLE)) {
> +			if (errno == EINVAL) {
> +				tst_brk(TCONF, "madvise() didn't support "
                                        ^ | TERRNO here please
> +					"MADV_MERGEABLE");
> +			}
> +
> +			tst_brk(TBROK | TERRNO,
> +				"madvise(MADV_MERGEABLE) failed");
> +		}
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	int n;
> +
> +	for (n = 0; n < N_PAGES; n++) {
> +		if (test_pages[n])
> +			SAFE_MUNMAP(test_pages[n], page_size);
> +	}
> +
> +	if (restore_ksm_run)
> +		SAFE_FILE_PRINTF(KSM_RUN_PATH, "%d", orig_ksm_value);
> +}
> +
> +static void migrate_test(void)
> +{
> +	int i, loop, max_node;
> +	int ret1, ret2;
> +	unsigned long *old_nodes, *new_node1, *new_node2;
> +	unsigned long nodemask_size;
> +
> +	max_node = LTP_ALIGN(get_max_node(), sizeof(unsigned long) * 8);
> +	nodemask_size = max_node / 8;
> +
> +	old_nodes = SAFE_MALLOC(nodemask_size);
> +	new_node1 = SAFE_MALLOC(nodemask_size);
> +	new_node2 = SAFE_MALLOC(nodemask_size);

I guess that we can allocate and free the nodemasks in the test setup()
and cleanup() as well, but that is minor.

> +	memset(old_nodes, 0, nodemask_size);
> +	memset(new_node1, 0, nodemask_size);
> +	memset(new_node2, 0, nodemask_size);
> +
> +	for (i = 0; i < num_nodes; i++)
> +		set_bit(old_nodes, nodes[i], 1);
> +	set_bit(new_node1, node1, 1);
> +	set_bit(new_node2, node2, 1);
> +
> +	for (loop = 0; loop < N_LOOPS; loop++) {
> +		ret1 = tst_syscall(__NR_migrate_pages, 0, max_node,
> +				   old_nodes, new_node1);
> +		ret2 = tst_syscall(__NR_migrate_pages, 0, max_node,
> +				   old_nodes, new_node2);
> +		if (ret1 < 0 || ret2 < 0) {
> +			tst_res(TFAIL | TERRNO, "migrate_pages() failed");
> +			free(old_nodes);
> +			free(new_node1);
> +			free(new_node2);
> +			return;
> +		}
> +	}
> +
> +	tst_res(TPASS, "migrate_pages() passed");
> +
> +	free(old_nodes);
> +	free(new_node1);
> +	free(new_node2);
> +}
> +
> +static struct tst_test test = {
> +	.min_kver = "2.6.32",
> +	.needs_root = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = migrate_test,
> +};
> +
> +#else
> +	TST_TEST_TCONF("System doesn't support __NR_migrate_pages or libnuma "
> +		       "or libnuma development packages are not available");
> +#endif
> -- 
> 1.8.3.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
