Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1YhUJC-00043R-6b
	for ltp-list@lists.sourceforge.net; Mon, 13 Apr 2015 02:41:10 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YhUJ9-0007AU-Us
	for ltp-list@lists.sourceforge.net; Mon, 13 Apr 2015 02:41:10 +0000
Message-ID: <552B2AFF.20107@cn.fujitsu.com>
Date: Mon, 13 Apr 2015 10:33:35 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1428672725-13538-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1428672725-13538-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] syscalls/fallocate04: add new fallocate() test
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi,

On 04/10/2015 09:32 PM, Alexey Kodanev wrote:
> This is a new functional test of fallocate() syscall with the focus on
> FALLOC_FL_ZERO_RANGE (since Linux 3.14) and FALLOC_FL_COLLAPSE_RANGE
> (since Linux 3.15) modes.
> 
> Steps of test-cases:
>   * make a hole in the middle of the file with FALLOC_FL_PUNCH_HOLE;
>   * fill the hole and adjacent space with FALLOC_FL_ZERO_RANGE;
>   * remove a block from a file with FALLOC_FL_COLLAPSE_RANGE
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  runtest/syscalls                                  |    1 +
>  testcases/kernel/syscalls/.gitignore              |    1 +
>  testcases/kernel/syscalls/fallocate/fallocate04.c |  282 +++++++++++++++++++++
>  3 files changed, 284 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/fallocate/fallocate04.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 7703825..126f46f 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -154,6 +154,7 @@ faccessat01 faccessat01
>  fallocate01 fallocate01
>  fallocate02 fallocate02
>  fallocate03 fallocate03
> +fallocate04 fallocate04
>  
>  #posix_fadvise test cases
>  posix_fadvise01                      posix_fadvise01
> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
> index f10e85e..afe7f3b 100644
> --- a/testcases/kernel/syscalls/.gitignore
> +++ b/testcases/kernel/syscalls/.gitignore
> @@ -135,6 +135,7 @@
>  /fallocate/fallocate01
>  /fallocate/fallocate02
>  /fallocate/fallocate03
> +/fallocate/fallocate04
>  /fchdir/fchdir01
>  /fchdir/fchdir02
>  /fchdir/fchdir03
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
> new file mode 100644
> index 0000000..ccad3f2
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
> @@ -0,0 +1,282 @@
> +/*
> + * Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.
> + *
> + * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +
> +#define SEEK_HOLE			4
> +#define FALLOC_FL_KEEP_SIZE		0x01
> +#define FALLOC_FL_PUNCH_HOLE		0x02
> +#define FALLOC_FL_COLLAPSE_RANGE	0x08
> +#define FALLOC_FL_ZERO_RANGE		0x10

What about something like this:
#ifndef	FALLOC_FL_KEEP_SIZE	4
#define	 FALLOC_FL_KEEP_SIZE	4
#endif
In case, glibc have already defines these macro now or in future.
We could put these definitions in testcases/kernel/syscalls/fallocate/fallocate.h.
And what about we test this case in a specific file system, such
as ext4 or xfs. Many fs do not support these operations.
	
> +
> +char *TCID = "fallocate04";
> +int TST_TOTAL = 3;
> +
> +static int fd;
> +static const char fname[] = "fallocate04.txt";
> +static size_t block_size;
> +static size_t buf_size;
> +enum { NUM_OF_BLOCKS = 3 };

Why type is enum? I'm not sure, a simple '#define NUM_OF_BLOCKS 3' would be OK.

> +static int verbose;
> +static const option_t options[] = {
> +	{"v", &verbose, NULL},
> +	{NULL, NULL, NULL}
> +};
> +
> +static void help(void)
> +{
> +	printf("  -v      Verbose\n");
> +}
> +
> +static void cleanup(void)
> +{
> +	close(fd);
> +	tst_rmdir();
> +}
> +
> +static void get_blocksize(void)
> +{
> +	struct stat file_stat;
> +
> +	if (fstat(fd, &file_stat) == -1)
> +		tst_brkm(TFAIL | TERRNO, cleanup, "fstat() failed");

We have SAFE_FSTAT().
> +
> +	block_size = file_stat.st_blksize;
> +	buf_size = NUM_OF_BLOCKS * block_size;
> +}
> +
> +static size_t get_allocsize(void)
> +{
> +	struct stat file_stat;
> +
> +	if (fstat(fd, &file_stat) == -1)
> +		tst_brkm(TFAIL | TERRNO, cleanup, "fstat() failed");
> +
> +	return file_stat.st_blocks * 512;
> +}
> +
> +static void fill_tst_buf(char buf[])
> +{
> +	/* fill the buffer with a, b, c, ... letters on each block */
> +	int i;
> +
> +	for (i = 0; i < NUM_OF_BLOCKS; ++i)
> +		memset(buf + i * block_size, 'a' + i, block_size);
> +}
> +
> +static void setup(void)
> +{
> +	tst_tmpdir();
> +
> +	fd = open(fname, O_RDWR | O_CREAT, 0700);
> +	if (fd == -1)
> +		tst_brkm(TBROK | TERRNO, NULL, "open(%s) failed", fname);

We also have SAFE_CREAT().
> +
> +	get_blocksize();
> +
> +	if (fallocate(fd, 0, 0, buf_size) == -1) {
> +		if (errno == ENOSYS)
> +			tst_brkm(TCONF, cleanup, "fallocate() not supported");
> +		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate() failed");
> +	}
> +
> +	char buf[buf_size];
> +
> +	fill_tst_buf(buf);
> +
> +	if (write(fd, buf, buf_size) != (ssize_t)buf_size)
> +		tst_brkm(TFAIL | TERRNO, cleanup, "can't fill the file");
> +}
> +
> +static void check_file_data(const char exp_buf[])
> +{
> +	size_t size = sizeof(exp_buf);
> +	char rbuf[size];
> +
> +	tst_resm(TINFO, "reading the file, compare with expected buffer");
> +
> +	if (lseek(fd, 0, SEEK_SET) != 0)
> +		tst_brkm(TFAIL | TERRNO, cleanup, "lseek() failed");
> +	if (read(fd, rbuf, size) != (ssize_t)size)
> +		tst_brkm(TFAIL | TERRNO, cleanup, "can't read file");
> +
> +	if (memcmp(exp_buf, rbuf, size)) {
> +		if (verbose) {
> +			tst_resm_hexd(TINFO, exp_buf, size, "expected:");
> +			tst_resm_hexd(TINFO, rbuf, size, "but read:");
> +		}
> +		tst_brkm(TFAIL, cleanup, "not expected file data");
> +	}
> +}
> +
> +static void test01(void)
> +{
> +	size_t alloc_size0 = get_allocsize();
> +
> +	tst_resm(TINFO, "read allocated file size '%zu'", alloc_size0);
> +	tst_resm(TINFO, "make a hole with FALLOC_FL_PUNCH_HOLE");
> +
> +	if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +	    block_size, block_size) == -1) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brkm(TCONF, cleanup, "operation not supported");
> +		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate() failed");
> +	}
> +
> +	tst_resm(TINFO, "check that file has a hole with lseek(,,SEEK_HOLE)");
> +	ssize_t ret = lseek(fd, 0, SEEK_HOLE);
The prototype for 'lseek' is:
	off_t lseek(int fd, off_t offset, int whence);
so it seems that we should define 'ret' to 'off_t' type.

> +
> +	if (ret != (ssize_t)block_size) {
> +		/* exclude error when kernel doesn't have SEEK_HOLE support */
> +		if (errno != EINVAL) {
> +			tst_brkm(TFAIL | TERRNO, cleanup,
> +				 "fallocate() or lseek() failed");
> +		} else {
> +			tst_resm(TWARN | TERRNO, "lseek() failed");
> +		}
> +	}
> +	tst_resm(TINFO, "found a hole at '%d' offset", ret);
Also '%d' should be '%ld'.


> +
> +	size_t alloc_size1 = get_allocsize();
> +
> +	tst_resm(TINFO, "allocated file size before '%zu' and after '%zu'",
> +		alloc_size0, alloc_size1);
> +	if ((alloc_size0 - block_size) != alloc_size1)
> +		tst_brkm(TFAIL, cleanup, "not expected allocated size");
> +
> +	char exp_buf[buf_size];
> +
> +	fill_tst_buf(exp_buf);
> +	memset(exp_buf + block_size, 0, block_size);
> +
> +	check_file_data(exp_buf);
> +
> +	tst_resm(TPASS, "test succeeded");
> +}
> +
> +static void test02(void)
> +{
> +	tst_resm(TINFO, "zeroing file space with FALLOC_FL_ZERO_RANGE");
> +
> +	if (tst_kvercmp(3, 14, 0) < 0) {
> +		tst_brkm(TCONF, NULL,
> +			 "Test must be run with kernel 3.14 or newer");

Here a cleanup is needed, otherwise you will fail to call tst_rmdir()
to remove the created temporary directory created by tst_tmpdir().
> +	}
> +
> +	size_t alloc_size0 = get_allocsize();
> +
> +	tst_resm(TINFO, "read current allocated file size '%zu'", alloc_size0);
> +
> +	if (fallocate(fd, FALLOC_FL_ZERO_RANGE, block_size - 1,
> +		block_size + 2) == -1) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brkm(TCONF, cleanup, "operation not supported");
> +		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate failed");
> +	}
> +
> +	/* The file hole in the specified range must be allocated and
> +	 * filled with zeros. Check it.
> +	 */
> +	size_t alloc_size1 = get_allocsize();
> +
> +	tst_resm(TINFO, "allocated file size before '%zu' and after '%zu'",
> +		alloc_size0, alloc_size1);
> +	if ((alloc_size0 + block_size) != alloc_size1)
> +		tst_brkm(TFAIL, cleanup, "not expected allocated size");
> +
> +	char exp_buf[buf_size];
> +
> +	fill_tst_buf(exp_buf);
> +	memset(exp_buf + block_size - 1, 0, block_size + 2);
> +
> +	check_file_data(exp_buf);
> +
> +	tst_resm(TPASS, "test succeeded");
> +}
> +
> +static void test03(void)
> +{
> +	tst_resm(TINFO, "collapsing file space with FALLOC_FL_COLLAPSE_RANGE");
> +
> +	if (tst_kvercmp(3, 15, 0) < 0) {
> +		tst_brkm(TCONF, NULL,
> +			 "Test must be run with kernel 3.15 or newer");
Here also a cleanup needed.

Regards,
Xiaoguang Wang
> +	}
> +
> +	size_t alloc_size0 = get_allocsize();
> +
> +	tst_resm(TINFO, "read current allocated file size '%zu'", alloc_size0);
> +
> +	if (fallocate(fd, FALLOC_FL_COLLAPSE_RANGE, block_size,
> +		block_size) == -1) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brkm(TCONF, cleanup, "operation not supported");
> +		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate failed");
> +	}
> +
> +	size_t alloc_size1 = get_allocsize();
> +
> +	tst_resm(TINFO, "allocated file size before '%zu' and after '%zu'",
> +		alloc_size0, alloc_size1);
> +	if ((alloc_size0 - block_size) != alloc_size1)
> +		tst_brkm(TFAIL, cleanup, "not expected allocated size");
> +
> +	size_t size = buf_size - block_size;
> +	char tmp_buf[buf_size];
> +	char exp_buf[size];
> +
> +	fill_tst_buf(tmp_buf);
> +
> +	memcpy(exp_buf, tmp_buf, block_size);
> +	memcpy(exp_buf + block_size, tmp_buf + size, block_size);
> +
> +	check_file_data(exp_buf);
> +
> +	tst_resm(TPASS, "test succeeded");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +
> +	tst_parse_opts(argc, argv, options, help);
> +
> +	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> +
> +		setup();
> +
> +		test01();
> +		test02();
> +		test03();
> +
> +		cleanup();
> +	}
> +
> +	tst_exit();
> +}
> 


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
