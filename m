Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TMc6R-0002z3-Sq
	for ltp-list@lists.sourceforge.net; Fri, 12 Oct 2012 10:04:23 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TMc6L-00026L-D9
	for ltp-list@lists.sourceforge.net; Fri, 12 Oct 2012 10:04:23 +0000
Message-ID: <5077EABB.9030204@cn.fujitsu.com>
Date: Fri, 12 Oct 2012 18:02:35 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1349771952.git.jstancek@redhat.com>
	<c6a1c467241421bb8c28eea8236d00e4af6d64fa.1349771952.git.jstancek@redhat.com>
In-Reply-To: <c6a1c467241421bb8c28eea8236d00e4af6d64fa.1349771952.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2 2/2] new syscall test: readahead02
Reply-To: gaowanlong@cn.fujitsu.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 10/09/2012 04:51 PM, Jan Stancek wrote:
> Use readahead() syscall and check if subsequent
> read saves some I/O and if cache size increased.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  runtest/syscalls                                  |    1 +
>  testcases/kernel/syscalls/readahead/readahead02.c |  371 +++++++++++++++++++++
>  2 files changed, 372 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/readahead/readahead02.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index e754c60..6973aaa 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -768,6 +768,7 @@ read03 read03
>  read04 read04
>  
>  readahead01 readahead01
> +readahead02 readahead02
>  
>  readdir01 readdir01
>  readdir02 readdir02
> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
> new file mode 100644
> index 0000000..d49b369
> --- /dev/null
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -0,0 +1,371 @@
> +/*
> + * Copyright (C) 2012 Linux Test Project, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> + * is free of the rightful claim of any third person regarding
> + * infringement or the like.  Any license provided herein, whether
> + * implied or otherwise, applies only to this software file.  Patent
> + * licenses, if any, provided herein do not apply to combinations of
> + * this program with other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + */
> +
> +/*
> + * functional test for readahead() syscall
> + *
> + * This test is measuring effects of readahead syscall.
> + * It mmaps/reads a test file with and without prior call to readahead.
> + *
> + */
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/syscall.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/time.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include "config.h"
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +#include "linux_syscall_numbers.h"
> +
> +char *TCID = "readahead02";
> +int  TST_TOTAL = 1;
> +
> +#if defined(__NR_readahead)
> +static const char testfile[] = "testfile";
> +static const char drop_caches_fname[] = "/proc/sys/vm/drop_caches";
> +static const char meminfo_fname[] = "/proc/meminfo";
> +static size_t testfile_size = 64*1024*1024;
> +static int opt_fsize;
> +static char *opt_fsizestr;
> +static int pagesize;
> +
> +option_t options[] = {
> +	{ "s:", &opt_fsize, &opt_fsizestr},
> +	{ NULL, NULL, NULL }
> +};
> +
> +static void setup(char *argv[]);

The same as PATCH 1/2 here.

> +static void cleanup(void);
> +
> +static void help(void)
> +{
> +	printf("  -s x    testfile size (default 64MB)\n");
> +}
> +
> +static int check_ret(long expected_ret)
> +{
> +	if (expected_ret == TEST_RETURN) {
> +		tst_resm(TPASS, "expected ret success - "
> +			"returned value = %ld", TEST_RETURN);
> +		return 0;
> +	}
> +	tst_resm(TFAIL, "unexpected failure - "
> +			"returned value = %ld, expected: %ld",
> +			TEST_RETURN, expected_ret);
> +	return 1;
> +}
> +
> +static int has_file(const char *fname, int required)
> +{
> +	int ret;
> +	struct stat buf;
> +	ret = stat(fname, &buf);
> +	if (ret == -1) {
> +		if (errno == ENOENT)
> +			if (required)
> +				tst_brkm(TCONF, cleanup, "%s not available",
> +					fname);
> +			else
> +				return 0;
> +		else
> +			tst_brkm(TBROK|TERRNO, cleanup, "stat %s", fname);
> +	}
> +	return 1;
> +}
> +
> +static void drop_caches(void)
> +{
> +	int ret;
> +	FILE *f;
> +
> +	f = fopen(drop_caches_fname, "w");
> +	if (f) {
> +		ret = fprintf(f, "1");
> +		fclose(f);
> +		if (ret < 1)
> +			tst_brkm(TBROK, cleanup, "Failed to drop caches");
> +	} else
> +		tst_brkm(TBROK, cleanup, "Failed to open drop_caches");

the else block also need parentheses.

> +}
> +
> +static long parse_entry(const char *fname, const char *entry)
> +{
> +	FILE *f;
> +	long value = -1;
> +	int ret;
> +	char *line = NULL;
> +	size_t linelen;
> +
> +	f = fopen(fname, "r");
> +	if (f) {
> +		do {
> +			ret = getline(&line, &linelen, f);
> +			if (sscanf(line, entry, &value) == 1)
> +				break;
> +		} while (ret != -1);
> +		fclose(f);
> +	}
> +	return value;
> +}
> +
> +static long get_bytes_read(void)
> +{
> +	char fname[128];
> +	char entry[] = "read_bytes: %ld";
> +	sprintf(fname, "/proc/%u/io", getpid());
> +	return parse_entry(fname, entry);
> +}
> +
> +static long get_cached_size(void)
> +{
> +	char entry[] = "Cached: %ld";
> +	return parse_entry(meminfo_fname, entry);
> +}
> +
> +static void create_testfile(void)
> +{
> +	FILE *f;
> +	char *tmp;
> +	int i;
> +
> +	tst_resm(TINFO, "creating test file of size: %ld", testfile_size);
> +	tmp = SAFE_MALLOC(cleanup, pagesize);
> +
> +	/* round to page size */
> +	testfile_size = testfile_size & ~((long)pagesize - 1);
> +
> +	f = fopen(testfile, "w");
> +	if (!f)
> +		tst_brkm(TBROK|TERRNO, cleanup, "Failed to create %s",
> +			testfile);

I'm afraid that tst_brkm will cause *tmp* memory leak.
How about free tmp memory before tst_brkm?
Or, you think the memory will be reclaimed when exit()?

> +
> +	for (i = 0; i < testfile_size; i += pagesize)
> +		if (fwrite(tmp, pagesize, 1, f) < 1)
> +			tst_brkm(TBROK, cleanup, "Failed to create %s",
> +				testfile);

Ditto?

> +	fflush(f);
> +	fsync(fileno(f));
> +	fclose(f);
> +	free(tmp);
> +}
> +
> +/* read_testfile - mmap testfile and read every page.
> + * This functions measures how many I/O and time it takes to fully
> + * read contents of test file.
> + *
> + * @do_readahead: call readahead prior to reading file content?
> + * @fname: name of file to test
> + * @fsize: how many bytes to read/mmap
> + * @read_bytes: returns difference of bytes read, parsed from /proc/<pid>/io
> + * @usec: returns how many microsecond it took to go over fsize bytes
> + * @cached: returns cached kB from /proc/meminfo
> + */
> +static void read_testfile(int do_readahead, const char *fname, size_t fsize,
> +	long *read_bytes, long *usec, long *cached)
> +{
> +	int fd, i;
> +	long read_bytes_start;
> +	unsigned char *p, tmp;
> +	unsigned long time_start_usec, time_end_usec;
> +	off_t offset;
> +	struct timeval now;
> +
> +	fd = open(fname, O_RDONLY);
> +	if (fd < 0)
> +		tst_brkm(TBROK|TERRNO, cleanup, "Failed to open %s",
> +			fname);
> +
> +	if (do_readahead) {
> +		TEST(syscall(__NR_readahead, fd, (off64_t)0, (size_t)fsize));
> +		check_ret(0);
> +		*cached = get_cached_size();
> +
> +		/* offset of file shouldn't change after readahead */
> +		offset = lseek(fd, 0, SEEK_CUR);
> +		if (offset == (off_t) -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "lseek failed");
> +		if (offset == 0)
> +			tst_resm(TPASS, "offset is still at 0 as expected");
> +		else
> +			tst_resm(TFAIL, "offset has changed to: %lu", offset);
> +	}
> +
> +	if (gettimeofday(&now, NULL) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "gettimeofday failed");
> +	time_start_usec = now.tv_sec * 1000000 + now.tv_usec;
> +	read_bytes_start = get_bytes_read();
> +
> +	p = mmap(NULL, fsize, PROT_READ, MAP_SHARED|MAP_POPULATE, fd, 0);
> +	if (p == MAP_FAILED)
> +		tst_brkm(TBROK|TERRNO, cleanup, "mmap failed");
> +
> +	/* for old kernels, where MAP_POPULATE doesn't work, touch each page */
> +	tmp = 0;
> +	for (i = 0; i < fsize; i += pagesize)
> +		tmp = tmp ^ p[i];
> +	/* prevent gcc from optimizing out loop above */
> +	if (tmp != 0)
> +		tst_brkm(TBROK, NULL, "This line should not be reached");
> +
> +	if (!do_readahead)
> +		*cached = get_cached_size();
> +
> +	if (munmap(p, fsize) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "munmap failed");
> +
> +	*read_bytes = get_bytes_read() - read_bytes_start;
> +	if (gettimeofday(&now, NULL) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "gettimeofday failed");
> +	time_end_usec = now.tv_sec * 1000000 + now.tv_usec;
> +	*usec = time_end_usec - time_start_usec;
> +
> +	if (close(fd) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "close failed");
> +}
> +
> +static void test_readahead(void)
> +{
> +	long read_bytes, read_bytes_ra;
> +	long usec, usec_ra;
> +	long cached_max, cached_low, cached, cached_ra;
> +	char proc_io_fname[128];
> +	sprintf(proc_io_fname, "/proc/%u/io", getpid());
> +
> +	/* find out how much can cache hold if we read whole file */
> +	read_testfile(0, testfile, testfile_size, &read_bytes,
> +		&usec, &cached);
> +	cached_max = get_cached_size();
> +	sync();
> +	drop_caches();
> +	cached_low = get_cached_size();
> +	cached_max = cached_max - cached_low;
> +
> +	tst_resm(TINFO, "read_testfile(0)");
> +	read_testfile(0, testfile, testfile_size, &read_bytes,
> +		&usec, &cached);
> +	cached = cached - cached_low;
> +
> +	sync();
> +	drop_caches();
> +	cached_low = get_cached_size();
> +	tst_resm(TINFO, "read_testfile(1)");
> +	read_testfile(1, testfile, testfile_size, &read_bytes_ra,
> +		&usec_ra, &cached_ra);
> +	cached_ra = cached_ra - cached_low;
> +
> +	tst_resm(TINFO, "read_testfile(0) took: %ld usec", usec);
> +	tst_resm(TINFO, "read_testfile(1) took: %ld usec", usec_ra);
> +	if (has_file(proc_io_fname, 0)) {
> +		tst_resm(TINFO, "read_testfile(0) read: %ld bytes",
> +				read_bytes);
> +		tst_resm(TINFO, "read_testfile(1) read: %ld bytes",
> +				read_bytes_ra);
> +		/* actual number of read bytes depends on total RAM */
> +		if (read_bytes_ra < read_bytes)
> +			tst_resm(TPASS, "readahead saved some I/O");
> +		else
> +			tst_resm(TFAIL, "readahead failed to save any I/O");
> +	} else
> +		tst_resm(TCONF, "Your system doesn't have /proc/pid/io,"
> +			" unable to determine read bytes during test");

parentheses?

> +
> +	tst_resm(TINFO, "cache can hold at least: %ld kB", cached_max);
> +	tst_resm(TINFO, "read_testfile(0) used cache: %ld kB", cached);
> +	tst_resm(TINFO, "read_testfile(1) used cache: %ld kB", cached_ra);
> +
> +	if (cached_max*1024 >= testfile_size) {
> +		/*
> +		 * if cache can hold ~testfile_size then cache increase
> +		 * for readahead should be at least testfile_size/2
> +		 */
> +		if (cached_ra*1024 > testfile_size/2)
> +			tst_resm(TPASS, "using cache as expected");
> +		else
> +			tst_resm(TWARN, "using less cache than expected");
> +	} else
> +		tst_resm(TCONF, "Page cache on your system is too small "
> +				"to hold whole testfile.");

parentheses?

> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char *msg;
> +	int lc;
> +
> +	msg = parse_opts(argc, argv, options, help);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	if (opt_fsize)
> +		testfile_size = atoi(opt_fsizestr);
> +
> +	setup(argv);
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +		test_readahead();
> +	}
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(char *argv[])

No need arguments?

Thanks,
Wanlong Gao

> +{
> +	tst_require_root(NULL);
> +	tst_tmpdir();
> +	TEST_PAUSE;
> +
> +	has_file(drop_caches_fname, 1);
> +	has_file(meminfo_fname, 1);
> +
> +	/* check if readahead is supported */
> +	syscall(__NR_readahead, 0, 0, 0);
> +
> +	pagesize = getpagesize();
> +	create_testfile();
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +	unlink(testfile);
> +	tst_rmdir();
> +}
> +
> +#else /* __NR_readahead */
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "System doesn't support __NR_readahead");
> +}
> +#endif
> +
> 


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
