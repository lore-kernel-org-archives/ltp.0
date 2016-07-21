From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 21 Jul 2016 16:23:27 +0200
Subject: [LTP] [PATCH] madvise06: wait a bit after madvise() call
In-Reply-To: <20160721110159.GA13274@gmail.com>
References: <8eb6f485a46b9d9fb62eec232bf7bcb2d4cf4215.1468848169.git.jstancek@redhat.com>
 <20160719055844.GA31704@gmail.com>
 <1822250385.6269456.1468911402613.JavaMail.zimbra@redhat.com>
 <20160719085756.GB31704@gmail.com> <578F8CB6.2020602@redhat.com>
 <597691787.18542977.1469097118207.JavaMail.zimbra@redhat.com>
 <20160721110159.GA13274@gmail.com>
Message-ID: <5790DADF.8000506@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/21/2016 01:02 PM, Li Wang wrote:
> On Thu, Jul 21, 2016 at 06:31:58AM -0400, Chunyu Hu wrote:
>>>
>>> If you still have the setup, can you try how reliable is this approach?
>>
>> I also had a try on my desktop. I copied the file as a.c and compiled it in ltp.
>> Result is that if the sys is fresh with low Cache, it can pass rightly. But if 
>> the Cache is before exhausted, it can hit failure, as the thresh_hold is too
>> large to get there. Just FYI. 

I'm not sure I follow here, your /proc/meminfo shows:
Cached:           260124 kB
SwapCached:        38096 kB

That doesn't seem very high to me.

> 
> Yes, Chunyu ran failed the case with his destop(uptime more than 30days) at first,
> after rebooting it could be PASS.

I'm starting to run out of ideas how we can test this somewhat reliably.

Attached is approach v3, which sets up memory cgroup:
- memory.limit_in_bytes is 128M
- we allocate 512M
- as consequence ~384M should be swapped while system should still have
  plenty of free memory, which should be available for cache

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
#include <sys/mount.h>
#include <sys/sysinfo.h>
#include "tst_test.h"

#define CHUNK_SZ (512*1024*1024L)
#define CHUNK_PAGES (CHUNK_SZ / pg_sz)
#define PASS_THRESHOLD (CHUNK_SZ / 4)

static const char drop_caches_fname[] = "/proc/sys/vm/drop_caches";
static int pg_sz;

static void drop_caches(void)
{
	int ret;
	FILE *f;

	f = fopen(drop_caches_fname, "w");
	if (f) {
		ret = fprintf(f, "1");
		fclose(f);
		if (ret < 1)
			tst_brk(TBROK, "Failed to drop caches");
	} else {
		tst_brk(TBROK, "Failed to open drop_caches");
	}
}

static void setup(void)
{
	struct sysinfo sys_buf_start;

	pg_sz = getpagesize();

	if (access(drop_caches_fname, R_OK | W_OK))
		tst_brk(TCONF, "needed: %s\n", drop_caches_fname);
	tst_res(TINFO, "dropping caches");
	drop_caches();

	sysinfo(&sys_buf_start);
	if (sys_buf_start.freeram < 2 * CHUNK_SZ)
		tst_brk(TCONF, "System RAM is too small, skip test");
	if (sys_buf_start.freeswap < 2 * CHUNK_SZ)
		tst_brk(TCONF, "System swap is too small");

	SAFE_MKDIR("memory", 0700);
	SAFE_MOUNT("memory", "memory", "cgroup", 0, "memory");
	if (access("memory/memory.limit_in_bytes", R_OK | W_OK))
		tst_brk(TCONF, "cgroup memory.limit_in_bytes needed");

	SAFE_MKDIR("memory/madvise06", 0700);
	SAFE_FILE_PRINTF("memory/madvise06/memory.limit_in_bytes", "%ld\n",
		PASS_THRESHOLD);
	SAFE_FILE_PRINTF("memory/madvise06/tasks", "%d\n", getpid());
}

static void cleanup(void)
{
	FILE *f = fopen("memory/tasks", "w");

	if (f) {
		fprintf(f, "%d\n", getpid());
		fclose(f);
	}
	rmdir("memory/madvise06");
	umount("memory");
}

static long count_swapped_pages(void *ptr, long pg_count)
{
	int pm;
	long index, ret = 0;
	uint64_t pagemap;
	off_t offset;

	index = ((uintptr_t)ptr / pg_sz) * sizeof(uint64_t);

	pm = open("/proc/self/pagemap", O_RDONLY);
	if (pm == -1) {
		/* In 4.0 and 4.1 opens by unprivileged fail with -EPERM */
		if ((errno == EPERM) && (geteuid() != 0)) {
			tst_brk(TCONF | TERRNO,
				"don't have permission to open dev pagemap");
		} else {
			tst_brk(TFAIL | TERRNO,
				"Open dev pagemap failed");
		}
	}

	offset = lseek(pm, index, SEEK_SET);
	if (offset != index)
		tst_brk(TFAIL | TERRNO, "Reposition offset failed");

	while (pg_count > 0) {
		ret = read(pm, &pagemap, sizeof(uint64_t));
		if (ret < 0)
			tst_brk(TFAIL | TERRNO, "Read pagemap failed");
		if ((pagemap & (1ULL<<62)))
			ret++;
		pg_count--;
	}

	close(pm);
}

static void dirty_pages(char *ptr, long size)
{
	long i;
	long pages = size / pg_sz;

	for (i = 0; i < pages; i++)
		ptr[i * pg_sz] = 'x';
}

static int get_page_fault_num(void)
{
	int pg;

	SAFE_FILE_SCANF("/proc/self/stat",
			"%*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %d",
			&pg);

	return pg;
}

static void test_advice_willneed(void)
{
	int loops = 50;
	char *target;
	long swapcached_start, swapcached;

	target = SAFE_MMAP(NULL, CHUNK_SZ, PROT_READ | PROT_WRITE,
			MAP_SHARED | MAP_ANONYMOUS,
			-1, 0);
	dirty_pages(target, CHUNK_SZ);

	SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld",
		&swapcached_start);
	tst_res(TINFO, "SwapCached (before madvise): %ld", swapcached_start);

	TEST(madvise(target, CHUNK_SZ, MADV_WILLNEED));
	if (TEST_RETURN == -1)
		tst_brk(TBROK | TERRNO, "madvise failed");

	do {
		loops--;
		usleep(100000);
		SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld",
			&swapcached);
	} while (loops > 0 && swapcached < swapcached_start + PASS_THRESHOLD / 1024);

	tst_res(TINFO, "SwapCached (after madvise): %ld", swapcached);
	if (swapcached > swapcached_start + PASS_THRESHOLD / 1024)
		tst_res(TPASS, "Regression test pass");
	else {
		/* looks like we may have hit a bug, try accessing page */
		int page_fault_num_1;
		int page_fault_num_2;

		page_fault_num_1 = get_page_fault_num();
		tst_res(TINFO, "PageFault(madvice / no mem access): %d",
				page_fault_num_1);
		target[0] = 'a';
		page_fault_num_2 = get_page_fault_num();
		tst_res(TINFO, "PageFault(madvice / mem access): %d",
				page_fault_num_2);

		if (page_fault_num_1 != page_fault_num_2)
			tst_res(TFAIL, "Bug has been reproduced");
		else
			tst_res(TPASS, "Regression test pass");
	}

	SAFE_MUNMAP(target, CHUNK_SZ);
}

static struct tst_test test = {
	.tid = "madvise06",
	.test_all = test_advice_willneed,
	.setup = setup,
	.cleanup = cleanup,
	.needs_tmpdir = 1,
	.needs_root = 1,
};
