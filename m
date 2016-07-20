From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 20 Jul 2016 16:37:42 +0200
Subject: [LTP] [PATCH] madvise06: wait a bit after madvise() call
In-Reply-To: <20160719085756.GB31704@gmail.com>
References: <8eb6f485a46b9d9fb62eec232bf7bcb2d4cf4215.1468848169.git.jstancek@redhat.com>
 <20160719055844.GA31704@gmail.com>
 <1822250385.6269456.1468911402613.JavaMail.zimbra@redhat.com>
 <20160719085756.GB31704@gmail.com>
Message-ID: <578F8CB6.2020602@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/19/2016 10:57 AM, Li Wang wrote:
>>
>> My impression was that kernel bug was consistently reproducible,
>> if not then let's replace the loop with one bigger sleep.
> 
> Sorry, I remember it's not, from what I test on an bad (unfix) kernel.
> it always report PASS with this patch.

Attached is a different approach, that watches progress of SwapCached
from /proc/meminfo and as soon as it sees 128M increase it takes that
as PASS or gives up after 5 seconds with FAIL.

GOOD kernel:
tst_test.c:701: INFO: Timeout per run is 300s
madvise06.c:98: INFO: SwapCached (before madvise): 53576
madvise06.c:113: INFO: SwapCached (after madvise): 568080
madvise06.c:115: PASS: Regression test pass

BAD kernel:
# ./madvise06
tst_test.c:701: INFO: Timeout per run is 300s
madvise06.c:98: INFO: SwapCached (before madvise): 43712
madvise06.c:113: INFO: SwapCached (after madvise): 45636
madvise06.c:117: FAIL: Bug has been reproduced

If you still have the setup, can you try how reliable is this approach?

Regards,
Jan
-------------- next part --------------
/*
 * Copyright (c) 2016 Red Hat, Inc.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * DESCRIPTION
 *
 *   Page fault occurs in spite that madvise(WILLNEED) system call is called
 *   to prefetch the page. This issue is reproduced by running a program
 *   which sequentially accesses to a shared memory and calls madvise(WILLNEED)
 *   to the next page on a page fault.
 *
 *   This bug is present in all RHEL7 versions. It looks like this was fixed in
 *   mainline kernel > v3.15 by the following patch:
 *
 *   commit 55231e5c898c5c03c14194001e349f40f59bd300
 *   Author: Johannes Weiner <hannes@cmpxchg.org>
 *   Date:   Thu May 22 11:54:17 2014 -0700
 *
 *       mm: madvise: fix MADV_WILLNEED on shmem swapouts
 */

#include <errno.h>
#include <stdio.h>
#include <sys/sysinfo.h>
#include "tst_test.h"

#define CHUNK_SZ  (512*1024*1024L)
#define MAX_ALLOC_CHUNKS 200L
#define PASS_THRESHOLD_KB (CHUNK_SZ / 1024 / 4)

static int pg_sz;
struct sysinfo sys_buf_start;

static void setup(void)
{
	sysinfo(&sys_buf_start);

	if (sys_buf_start.totalram > (MAX_ALLOC_CHUNKS - 1) * CHUNK_SZ)
		tst_brk(TCONF, "System RAM is too large, skip test");
	if (sys_buf_start.freeswap < 2 * CHUNK_SZ)
		tst_brk(TCONF, "System swap is too small");

	pg_sz = getpagesize();
}


static void test_advice_willneed(void)
{
	int i;
	char *src;
	char *dst[MAX_ALLOC_CHUNKS];
	long swapcached_start, swapcached;
	struct sysinfo sys_buf;

	/* allocate source memory */
	src = SAFE_MMAP(NULL, CHUNK_SZ, PROT_READ | PROT_WRITE,
			MAP_SHARED | MAP_ANONYMOUS,
			-1, 0);

	/* allocate destination memory (array) */
	for (i = 0; i < MAX_ALLOC_CHUNKS; ++i)
		dst[i] = SAFE_MMAP(NULL, CHUNK_SZ,
				PROT_READ | PROT_WRITE,
				MAP_SHARED | MAP_ANONYMOUS,
				-1, 0);

	/* memmove source to each destination memories (for SWAP-OUT) */
	i = 0;
	while (i < MAX_ALLOC_CHUNKS) {
		memmove(dst[i], src, CHUNK_SZ);
		i++;

		sysinfo(&sys_buf);
		if (sys_buf.freeswap + CHUNK_SZ < sys_buf_start.freeswap)
			break;
	}

	SAFE_MUNMAP(src, CHUNK_SZ);
	sync();

	SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld",
		&swapcached_start);
	tst_res(TINFO, "SwapCached (before madvise): %ld", swapcached_start);

	/* Do madvise() to dst[0] */
	TEST(madvise(dst[0], CHUNK_SZ, MADV_WILLNEED));
	if (TEST_RETURN == -1)
		tst_brk(TBROK | TERRNO, "madvise failed");

	i = 0;
	do {
		i++;
		usleep(100000);
		SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld",
			&swapcached);
	} while (i < 50 && swapcached < swapcached_start + PASS_THRESHOLD_KB);

	tst_res(TINFO, "SwapCached (after madvise): %ld", swapcached);
	if (swapcached > swapcached_start + PASS_THRESHOLD_KB)
		tst_res(TPASS, "Regression test pass");
	else
		tst_res(TFAIL, "Bug has been reproduced");

	for (i = 0; i < MAX_ALLOC_CHUNKS; ++i)
		SAFE_MUNMAP(dst[i], CHUNK_SZ);
}

static struct tst_test test = {
	.tid = "madvise06",
	.test_all = test_advice_willneed,
	.setup = setup,
};
