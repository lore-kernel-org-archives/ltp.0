From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 May 2019 15:55:20 +0200
Subject: [LTP] [PATCH 1/2] syscalls/move_pages: move the common code to
 move_hugepages_support
In-Reply-To: <1512100108-28359-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1512100108-28359-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20190520135520.GA28976@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/move_pages/move_hugepages_support.c b/testcases/kernel/syscalls/move_pages/move_hugepages_support.c
> new file mode 100644
> index 0000000..096d91a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/move_pages/move_hugepages_support.c
> @@ -0,0 +1,131 @@
> +/*
> + * Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> + *
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "move_hugepages_support.h"
> +
> +#ifdef HAVE_NUMA_V2
> +void alloc_free_huge_on_node(unsigned int node, size_t size, int hgpsz)
> +{
> +	char *mem;
> +	long ret;
> +	struct bitmask *bm;
> +
> +	tst_res(TINFO, "Allocating and freeing %zu hugepages on node %u",
> +		size / hgpsz, node);
> +
> +	mem = mmap(NULL, size, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
> +	if (mem == MAP_FAILED) {
> +		if (errno == ENOMEM)
> +			tst_brk(TCONF, "Cannot allocate huge pages");
> +
> +		tst_brk(TBROK | TERRNO, "mmap(..., MAP_HUGETLB, ...) failed");
> +	}
> +
> +	bm = numa_bitmask_alloc(numa_max_possible_node() + 1);
> +	if (!bm)
> +		tst_brk(TBROK | TERRNO, "numa_bitmask_alloc() failed");
> +
> +	numa_bitmask_setbit(bm, node);
> +
> +	ret = mbind(mem, size, MPOL_BIND, bm->maskp, bm->size + 1, 0);
> +	if (ret) {
> +		if (errno == ENOMEM)
> +			tst_brk(TCONF, "Cannot mbind huge pages");
> +
> +		tst_brk(TBROK | TERRNO, "mbind() failed");
> +	}
> +
> +	TEST(mlock(mem, size));
> +	if (TEST_RETURN) {
> +		SAFE_MUNMAP(mem, size);
> +		if (TEST_ERRNO == ENOMEM || TEST_ERRNO == EAGAIN)
> +			tst_brk(TCONF, "Cannot lock huge pages");
> +		tst_brk(TBROK | TTERRNO, "mlock failed");
> +	}
> +
> +	numa_bitmask_free(bm);
> +
> +	SAFE_MUNMAP(mem, size);
> +}
> +
> +void do_hugepages_move(int count, int hpgsz, int pgsz, void *addr,
> +		       unsigned int node1, unsigned int node2)
> +{
> +	int test_pages = count * hpgsz / pgsz;
> +	int i, j;
> +	int *nodes, *status;
> +	void **pages;
> +	pid_t ppid = getppid();
> +
> +	pages = SAFE_MALLOC(sizeof(char *) * test_pages);
> +	nodes = SAFE_MALLOC(sizeof(int) * test_pages);
> +	status = SAFE_MALLOC(sizeof(int) * test_pages);
> +
> +	for (i = 0; i < test_pages; i++)
> +		pages[i] = addr + i * pgsz;
> +
> +	for (i = 0; ; i++) {
> +		for (j = 0; j < test_pages; j++) {
> +			if (i % 2 == 0)
> +				nodes[j] = node1;
> +			else
> +				nodes[j] = node2;
> +			status[j] = 0;
> +		}
> +
> +		TEST(numa_move_pages(ppid, test_pages,
> +			pages, nodes, status, MPOL_MF_MOVE_ALL));
> +		if (TEST_RETURN) {
> +			tst_res(TFAIL | TTERRNO, "move_pages failed");
> +			break;
> +		}
> +	}
> +
> +	exit(0);
> +}
> +
> +long modify_node_nr_hgpgs(char *path_hgpgs_node, size_t size,
> +			  unsigned int node, int hgpsz, long add_num)
> +{
> +	long orig_hgpgs_node = -1;
> +
> +	snprintf(path_hgpgs_node, size,
> +		 "/sys/devices/system/node/node%u/hugepages/hugepages-%dkB/nr_hugepages",
> +		 node, hgpsz);
> +
> +	if (!access(path_hgpgs_node, F_OK)) {
> +		SAFE_FILE_SCANF(path_hgpgs_node, "%ld", &orig_hgpgs_node);
> +		tst_res(TINFO,
> +			"Increasing %dkB hugepages pool on node %u to %ld",
> +			hgpsz, node, orig_hgpgs_node + add_num);
> +		SAFE_FILE_PRINTF(path_hgpgs_node, "%ld",
> +				 orig_hgpgs_node + add_num);
> +	}
> +
> +	return orig_hgpgs_node;
> +}
> +
> +void restore_orig_hgpgs_value(char *path_hgpgs, long orig_value)
> +{
> +	if (orig_value != -1)
> +		SAFE_FILE_PRINTF(path_hgpgs, "%ld", orig_value);
> +}

I guess that it would be a bit easier just to put these three functions
into the header as well....

Other than that it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz
