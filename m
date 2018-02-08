From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 8 Feb 2018 09:21:52 +0800
Subject: [LTP] [PATCH 1/2] syscalls/move_pages: move the common code to
	move_hugepages_support
In-Reply-To: <1512100108-28359-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1512100108-28359-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <5A7BA630.3080701@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Ping. :-)

Thanks,
Xiao Yang
On 2017/12/01 11:48, Xiao Yang wrote:
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/move_pages/Makefile      |   2 +-
>  .../syscalls/move_pages/move_hugepages_support.c   | 131 ++++++++++++++++++++
>  .../syscalls/move_pages/move_hugepages_support.h   |  49 ++++++++
>  .../kernel/syscalls/move_pages/move_pages12.c      | 134 ++-------------------
>  4 files changed, 190 insertions(+), 126 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/move_pages/move_hugepages_support.c
>  create mode 100644 testcases/kernel/syscalls/move_pages/move_hugepages_support.h
>
> diff --git a/testcases/kernel/syscalls/move_pages/Makefile b/testcases/kernel/syscalls/move_pages/Makefile
> index 9892770..17e0f1e 100644
> --- a/testcases/kernel/syscalls/move_pages/Makefile
> +++ b/testcases/kernel/syscalls/move_pages/Makefile
> @@ -26,7 +26,7 @@ INSTALL_TARGETS		:= move_pages.sh
>  
>  MAKE_TARGETS		:= $(patsubst $(abs_srcdir)/%.c,%,$(wildcard $(abs_srcdir)/*[0-9].c))
>  
> -$(MAKE_TARGETS): %: %.o move_pages_support.o
> +$(MAKE_TARGETS): %: %.o move_pages_support.o move_hugepages_support.o
>  
>  LDLIBS			+= -lpthread -lrt
>  
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
> +#endif
> diff --git a/testcases/kernel/syscalls/move_pages/move_hugepages_support.h b/testcases/kernel/syscalls/move_pages/move_hugepages_support.h
> new file mode 100644
> index 0000000..98f357b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/move_pages/move_hugepages_support.h
> @@ -0,0 +1,49 @@
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
> + * along with this program;  if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef MOVE_HUGEPAGES_SUPPORT_H
> +#define MOVE_HUGEPAGES_SUPPORT_H
> +
> +#include "config.h"
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +# if HAVE_NUMA_H
> +#include <numa.h>
> +# endif
> +# if HAVE_NUMAIF_H
> +#include <numaif.h>
> +# endif
> +#include <sys/mman.h>
> +#include "lapi/mmap.h"
> +
> +#define PATH_MEMINFO	"/proc/meminfo"
> +#define PATH_NR_HUGEPAGES	"/proc/sys/vm/nr_hugepages"
> +#define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
> +
> +# ifdef HAVE_NUMA_V2
> +void alloc_free_huge_on_node(unsigned int node, size_t size, int hgpsz);
> +void do_hugepages_move(int count, int hpgsz, int pgsz, void *addr,
> +		       unsigned int node1, unsigned int node2);
> +long modify_node_nr_hgpgs(char *path_hgpgs_node, size_t size,
> +			  unsigned int node, int hgpsz, long add_num);
> +void restore_orig_hgpgs_value(char *path_hgpgs, long orig_value);
> +# endif
> +#endif
> diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
> index 1ac7bc1..9c66304 100644
> --- a/testcases/kernel/syscalls/move_pages/move_pages12.c
> +++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
> @@ -41,14 +41,12 @@
>  
>  #include "tst_test.h"
>  #include "move_pages_support.h"
> +#include "move_hugepages_support.h"
>  #include "lapi/mmap.h"
>  
>  #ifdef HAVE_NUMA_V2
>  
>  #define LOOPS	1000
> -#define PATH_MEMINFO	"/proc/meminfo"
> -#define PATH_NR_HUGEPAGES	"/proc/sys/vm/nr_hugepages"
> -#define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
>  #define TEST_PAGES	2
>  #define TEST_NODES	2
>  
> @@ -61,41 +59,6 @@ static long orig_hugepages_node2 = -1;
>  static unsigned int node1, node2;
>  static void *addr;
>  
> -static void do_child(void)
> -{
> -	int test_pages = TEST_PAGES * hpsz / pgsz;
> -	int i, j;
> -	int *nodes, *status;
> -	void **pages;
> -	pid_t ppid = getppid();
> -
> -	pages = SAFE_MALLOC(sizeof(char *) * test_pages);
> -	nodes = SAFE_MALLOC(sizeof(int) * test_pages);
> -	status = SAFE_MALLOC(sizeof(int) * test_pages);
> -
> -	for (i = 0; i < test_pages; i++)
> -		pages[i] = addr + i * pgsz;
> -
> -	for (i = 0; ; i++) {
> -		for (j = 0; j < test_pages; j++) {
> -			if (i % 2 == 0)
> -				nodes[j] = node1;
> -			else
> -				nodes[j] = node2;
> -			status[j] = 0;
> -		}
> -
> -		TEST(numa_move_pages(ppid, test_pages,
> -			pages, nodes, status, MPOL_MF_MOVE_ALL));
> -		if (TEST_RETURN) {
> -			tst_res(TFAIL | TTERRNO, "move_pages failed");
> -			break;
> -		}
> -	}
> -
> -	exit(0);
> -}
> -
>  static void do_test(void)
>  {
>  	int i;
> @@ -109,7 +72,7 @@ static void do_test(void)
>  
>  	cpid = SAFE_FORK();
>  	if (cpid == 0)
> -		do_child();
> +		do_hugepages_move(TEST_PAGES, hpsz, pgsz, addr, node1, node2);
>  
>  	for (i = 0; i < LOOPS; i++) {
>  		void *ptr;
> @@ -133,51 +96,6 @@ static void do_test(void)
>  	}
>  }
>  
> -static void alloc_free_huge_on_node(unsigned int node, size_t size)
> -{
> -	char *mem;
> -	long ret;
> -	struct bitmask *bm;
> -
> -	tst_res(TINFO, "Allocating and freeing %zu hugepages on node %u",
> -		size / hpsz, node);
> -
> -	mem = mmap(NULL, size, PROT_READ | PROT_WRITE,
> -		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
> -	if (mem == MAP_FAILED) {
> -		if (errno == ENOMEM)
> -			tst_brk(TCONF, "Cannot allocate huge pages");
> -
> -		tst_brk(TBROK | TERRNO, "mmap(..., MAP_HUGETLB, ...) failed");
> -	}
> -
> -	bm = numa_bitmask_alloc(numa_max_possible_node() + 1);
> -	if (!bm)
> -		tst_brk(TBROK | TERRNO, "numa_bitmask_alloc() failed");
> -
> -	numa_bitmask_setbit(bm, node);
> -
> -	ret = mbind(mem, size, MPOL_BIND, bm->maskp, bm->size + 1, 0);
> -	if (ret) {
> -		if (errno == ENOMEM)
> -			tst_brk(TCONF, "Cannot mbind huge pages");
> -
> -		tst_brk(TBROK | TERRNO, "mbind() failed");
> -	}
> -
> -	TEST(mlock(mem, size));
> -	if (TEST_RETURN) {
> -		SAFE_MUNMAP(mem, size);
> -		if (TEST_ERRNO == ENOMEM || TEST_ERRNO == EAGAIN)
> -			tst_brk(TCONF, "Cannot lock huge pages");
> -		tst_brk(TBROK | TTERRNO, "mlock failed");
> -	}
> -
> -	numa_bitmask_free(bm);
> -
> -	SAFE_MUNMAP(mem, size);
> -}
> -
>  static void setup(void)
>  {
>  	int memfree, ret;
> @@ -200,33 +118,8 @@ static void setup(void)
>  	if (4 * hpsz > memfree)
>  		tst_brk(TBROK, "Not enough free RAM");
>  
> -	snprintf(path_hugepages_node1, sizeof(path_hugepages_node1),
> -		 "/sys/devices/system/node/node%u/hugepages/hugepages-%dkB/nr_hugepages",
> -		 node1, hpsz);
> -
> -	snprintf(path_hugepages_node2, sizeof(path_hugepages_node2),
> -		 "/sys/devices/system/node/node%u/hugepages/hugepages-%dkB/nr_hugepages",
> -		 node2, hpsz);
> -
> -	if (!access(path_hugepages_node1, F_OK)) {
> -		SAFE_FILE_SCANF(path_hugepages_node1,
> -				"%ld", &orig_hugepages_node1);
> -		tst_res(TINFO,
> -			"Increasing %dkB hugepages pool on node %u to %ld",
> -			hpsz, node1, orig_hugepages_node1 + 4);
> -		SAFE_FILE_PRINTF(path_hugepages_node1,
> -				 "%ld", orig_hugepages_node1 + 4);
> -	}
> -
> -	if (!access(path_hugepages_node2, F_OK)) {
> -		SAFE_FILE_SCANF(path_hugepages_node2,
> -				"%ld", &orig_hugepages_node2);
> -		tst_res(TINFO,
> -			"Increasing %dkB hugepages pool on node %u to %ld",
> -			hpsz, node2, orig_hugepages_node2 + 4);
> -		SAFE_FILE_PRINTF(path_hugepages_node2,
> -				 "%ld", orig_hugepages_node2 + 4);
> -	}
> +	orig_hugepages_node1 = modify_node_nr_hgpgs(path_hugepages_node1, sizeof(path_hugepages_node1), node1, hpsz, 4);
> +	orig_hugepages_node2 = modify_node_nr_hgpgs(path_hugepages_node2, sizeof(path_hugepages_node2), node2, hpsz, 4);
>  
>  	hpsz *= 1024;
>  
> @@ -237,24 +130,15 @@ static void setup(void)
>  		SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages + 8);
>  	}
>  
> -	alloc_free_huge_on_node(node1, 4L * hpsz);
> -	alloc_free_huge_on_node(node2, 4L * hpsz);
> +	alloc_free_huge_on_node(node1, 4L * hpsz, hpsz);
> +	alloc_free_huge_on_node(node2, 4L * hpsz, hpsz);
>  }
>  
>  static void cleanup(void)
>  {
> -	if (orig_hugepages != -1)
> -		SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
> -
> -	if (orig_hugepages_node1 != -1) {
> -		SAFE_FILE_PRINTF(path_hugepages_node1,
> -				 "%ld", orig_hugepages_node1);
> -	}
> -
> -	if (orig_hugepages_node2 != -1) {
> -		SAFE_FILE_PRINTF(path_hugepages_node2,
> -				 "%ld", orig_hugepages_node2);
> -	}
> +	restore_orig_hgpgs_value(PATH_NR_HUGEPAGES, orig_hugepages);
> +	restore_orig_hgpgs_value(path_hugepages_node1, orig_hugepages_node1);
> +	restore_orig_hgpgs_value(path_hugepages_node2, orig_hugepages_node2);
>  }
>  
>  static struct tst_test test = {



