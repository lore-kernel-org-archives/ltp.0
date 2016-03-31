From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 31 Mar 2016 13:55:47 +0200
Subject: [LTP] [PATCH V2] madvice: new case for madvise(WILLNEED)
In-Reply-To: <1459245344-5983-1-git-send-email-liwang@redhat.com>
References: <1459245344-5983-1-git-send-email-liwang@redhat.com>
Message-ID: <20160331115547.GA21298@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * Copyright (c) 2016 Red Hat, Inc.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 3 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * DESCRIPTION
> + *
> + *   Page fault occurs in spite that madvise(WILLNEED) system call is called
> + *   to prefetch the page. This issue is reproduced by running a program
> + *   which sequentially accesses to a shared memory and calls madvise(WILLNEED)
> + *   to the next page on a page fault.
> + *
> + *   This bug is present in all RHEL7 versions. It looks like this was fixed in
> + *   mainline kernel > v3.15 by the following patch:
> + *
> + *   commit 55231e5c898c5c03c14194001e349f40f59bd300
> + *   Author: Johannes Weiner <hannes@cmpxchg.org>
> + *   Date:   Thu May 22 11:54:17 2014 -0700
> + *
> + *       mm: madvise: fix MADV_WILLNEED on shmem swapouts
> + */
> +
> +#include <stdio.h>
> +#include <sys/shm.h>

We don't need this header now, right?

> +#include <errno.h>
> +#include <sys/sysinfo.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +
> +char *TCID = "madvise06";
> +int TST_TOTAL = 3;
> +
> +#ifdef __x86_64__
> +
> +#define GB_SZ  (1024*1024*1024)
> +#define PG_SZ  (4*1024)
> +
> +static long dst_num;
> +
> +static void setup(void);
> +static int  get_page_fault_num(void);
> +static void test_advice_willneed(void);
> +
> +int main(int argc, char *argv[])
> +{
> +	int i, lc;
> +
> +	tst_parse_opts(argc, argv, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for(i = 0; i < TST_TOTAL; i++)
> +			test_advice_willneed();

So we do three iterations of the test to increase the likehood of
hitting the bug, right? In that case we should just add -i 3 to the
runtest file.

> +	}
> +
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	struct sysinfo sys_buf;
> +
> +	sysinfo(&sys_buf);
> +
> +	dst_num = sys_buf.totalram / GB_SZ;
> +	tst_resm(TINFO, "dst_num =  %ld", dst_num);

The variable should be named as dst_max instead of dst_num. Which would
make the message more understandable...

> +	tst_sig(NOFORK, DEF_HANDLER, NULL);
> +	if (tst_kvercmp(3, 9, 0) < 0)
> +		tst_brkm(TCONF, NULL, "madvise(MADV_WILLNEED) swap file"
> +			"prefetch available only since 3.9");
> +
> +	if (sys_buf.totalram < 2L * GB_SZ)
> +		tst_brkm(TCONF, NULL, "Test requires more than 2GB of RAM.");
> +	if (sys_buf.totalram > 100L * GB_SZ)
> +		tst_brkm(TCONF, NULL, "System RAM is too large, skip this test.");
> +
> +	TEST_PAUSE;
> +}
> +
> +static int get_page_fault_num(void)
> +{
> +	int pg;
> +
> +	SAFE_FILE_SCANF(NULL, "/proc/self/stat",
> +			"%*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %d",
> +			&pg);
> +
> +	return pg;
> +}
> +
> +static void test_advice_willneed(void)
> +{
> +	int i;
> +	char *src_1gb;
> +	char *dst[100];
> +	int page_fault_num1;
> +	int page_fault_num2;
> +
> +	/* allocate source memory (1GB only) */
> +	src_1gb = mmap(NULL, 1 * GB_SZ, PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_ANONYMOUS,
> +			-1, 0);
> +	if (src_1gb == MAP_FAILED)
> +		tst_brkm(TFAIL | TERRNO, NULL, "mmap failed");

Use SAFE_MMAP()

> +	/* allocate destination memory (array) */
> +	for (i = 0; i < dst_num; ++i) {
> +		dst[i] = mmap(NULL, 1 * GB_SZ, PROT_READ | PROT_WRITE,
> +				MAP_SHARED | MAP_ANONYMOUS,
> +				-1, 0);
> +		if (dst[i] == MAP_FAILED)
> +			tst_brkm(TFAIL | TERRNO, NULL, "mmap failed");

Here as well.

> +	}
> +
> +	/* memmove  source to each destination memories (for SWAP-OUT) */
> +	for (i = 0; i < dst_num; ++i)
> +		memmove(dst[i], src_1gb, 1 * GB_SZ);
> +
> +	tst_resm(TINFO, "PageFault(before madvice): %d", get_page_fault_num());
> +
> +	/* Do madvice() to dst[0] */
> +	TEST(madvise(dst[0], PG_SZ, MADV_WILLNEED));
> +	if (TEST_RETURN == -1)
> +		tst_brkm(TBROK | TERRNO, NULL, "madvise failed");
> +	usleep(1000);  /* wait for read from SWAP */

Again, what exactly do we wait here for?

"wait for read from SWAP" is a bit too vague.

> +	page_fault_num1 = get_page_fault_num();
> +	tst_resm(TINFO, "PageFault(after madvice / before Mem Access): %d", page_fault_num1);

This line is over 80 chars. Try making the message shorter.

You can use checkpatch.pl (shipped with Linux kernel) to check patches
before submission.

> +	*dst[0] = 'a';
> +	page_fault_num2 = get_page_fault_num();
> +	tst_resm(TINFO, "PageFault(after madvice / after Mem Access): %d", page_fault_num2);

Here as well.

> +
> +	if (page_fault_num1 != page_fault_num2)
> +		tst_resm(TFAIL, "Bug has been reproduced!");
> +	else
> +		tst_resm(TPASS, "Regression test pass!");

No need for the ! in the TPASS message.

> +	if (munmap(src_1gb, 1 * GB_SZ) == -1)
> +		tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");

Use SAFE_MUNMAP()

> +	for (i = 0; i < dst_num; ++i) {
> +		if (munmap(dst[i], 1 * GB_SZ) == -1)
> +			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");

Here as well.

> +	}
> +}
> +
> +
> +#else
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "Only test on x86_64.");
> +}
> +#endif
> -- 
> 1.8.3.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
