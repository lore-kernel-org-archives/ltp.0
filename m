From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Nov 2015 15:46:14 +0100
Subject: [LTP] [PATCH 2/2] pwritev/pwritev01.c: add new testcase
In-Reply-To: <1446591451-11075-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1446591451-11075-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1446591451-11075-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20151103144613.GE5795@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pwritev/Makefile
> @@ -0,0 +1,31 @@
> +#
> +#  Copyright (c) 2015 Fujitsu Ltd.
> +#  Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> +#
> +#  This program is free software;  you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program.
> +#
> +#
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(abs_srcdir)/../utils/newer_64.mk
> +
> +# FIXME (garrcoop): more messy format strings.
> +CPPFLAGS		+= -Wno-error

Here as well.

> +%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk

...

> diff --git a/testcases/kernel/syscalls/pwritev/pwritev01.c b/testcases/kernel/syscalls/pwritev/pwritev01.c
> new file mode 100644
> index 0000000..ce75552
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pwritev/pwritev01.c
> @@ -0,0 +1,149 @@
> +/*
> +* Copyright (c) 2015 Fujitsu Ltd.
> +* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> +*
> +* This program is free software; you can redistribute it and/or modify it
> +* under the terms of version 2 of the GNU General Public License as
> +* published by the Free Software Foundation.
> +*
> +* This program is distributed in the hope that it would be useful, but
> +* WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> +*
> +* You should have received a copy of the GNU General Public License
> +* alone with this program.
> +*/
> +
> +/*
> +* Test Name: pwritev01
> +*
> +* Test Description:
> +* Testcase to check the basic functionality of the pwritev(2).
> +* pwritev(2) should succeed to write the expected content of data
> +* and after writing the file, the file offset is not changed.
> +*/
> +
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "pwritev.h"
> +#include "safe_macros.h"
> +
> +#define	CHUNK		64
> +
> +static char buf[CHUNK];
> +
> +static char preadbuf[CHUNK*2];
> +
> +static struct iovec wr_iovec[] = {
> +	{buf, CHUNK},
> +	{NULL, 0},
> +};
> +
> +static struct test_case_t {
> +	off_t offset_cur;
> +	int count;
> +	off_t offset;
> +	int byte;
> +} test_cases[] = {
> +	{CHUNK, 0, 0, 0},
> +	{CHUNK/2, 1, 0, CHUNK},
> +	{CHUNK/4, 1, CHUNK, CHUNK},
> +	{CHUNK/8, 2, 0, CHUNK},
> +};
> +
> +static int fd;
> +
> +void verify_pwritev(int);
> +void check_file_contents(int, char *, int, off_t, char *);
> +void setup(void);
> +void l_seek(int, off_t, int, off_t);
> +void cleanup(void);
> +
> +char *TCID = "pwritev01";
> +int TST_TOTAL =  ARRAY_SIZE(test_cases);
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int tc;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (tc = 0; tc < TST_TOTAL; tc++)
> +			verify_pwritev(tc);
> +	}
> +	cleanup();
> +	tst_exit();
> +}
> +
> +void verify_pwritev(int i)
> +{
> +	l_seek(fd, test_cases[i].offset_cur, SEEK_SET,
> +		test_cases[i].offset_cur);

So you are changing the file offset in order to trick pwritev() to write
to a differnt part of the file. Ok, then, it's the same for preadv I
guess.

But you really shouldn't do wrappers to SAFE_LSEEK() and name it
l_seek(). At least call it do_seek() so it does not look like a library
function.

> +	TEST(pwritev(fd, wr_iovec, test_cases[i].count, test_cases[i].offset));
> +	if (test_cases[i].byte != TEST_RETURN) {
> +		tst_resm(TFAIL, "pwritev failed unexpectedly");

Here again, differentiate between failure and partial write.

> +	} else {
> +		l_seek(fd, 0, SEEK_CUR, test_cases[i].offset_cur);

Here we should really say that pwritev() changed file offset.

> +		check_file_contents(fd, preadbuf, test_cases[i].byte,
> +			test_cases[i].offset, buf);
> +	}
> +}
> +
> +void check_file_contents(int fdes1, char *pread_buf, int pread_byte,
> +			 off_t pread_offset, char *iov_buf)

Again byte does mean something different than size. Also there is
absolutely no nedd to pass the buffer to the function if you aren't
using it in the caller.

So the function should have parameters named as:

void check_file_content(int fd, int size, off_t off, char *iov_buf)

> +{
> +	if (SAFE_PREAD(cleanup, 1, fdes1, preadbuf, pread_byte,
> +		       pread_offset) != pread_byte) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "pread failed reading %d bytes ", pread_byte);

The SAFE_PREAD() has len_strict parameter. If that is set to non-zero
the call will exit the test unless exactly requested number of bytes was
read. Hence it cannot fail here at all.

> +	} else {

There is no need for the else branch since the tst_brkm() would have
actually exit the test execution.

> +		if (memcmp(iov_buf, pread_buf, pread_byte) != 0) {
> +			tst_resm(TFAIL, "pwritev failed reading %d bytes ",
> +				 pread_byte);

Again, please be more specific on what have failed. In this case you
should at least say that the buffer had unexpected value and ideally
print first place when it was wrong.

> +		} else {
> +			tst_resm(TPASS, "pwritev passed reading %d bytes ",
> +				 pread_byte);
> +		}
> +	}
> +}
> +
> +void setup(void)
> +{
> +	if ((tst_kvercmp(2, 6, 30)) < 0) {
> +		tst_brkm(TCONF, NULL, "This test can only run on kernels "
> +			"that are 2.6.30 and higher");
> +	}
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	(void)memset(&buf, 0x42, CHUNK);

Drop the (void) here.

> +	fd = SAFE_OPEN(cleanup, "file", O_RDWR | O_CREAT, 0644);
> +}
> +
> +void l_seek(int fdes, off_t offset, int whence, off_t checkoff)
> +{
> +	if (SAFE_LSEEK(cleanup, fdes, offset, whence) != checkoff)
> +		tst_brkm(TBROK | TERRNO, cleanup, "lseek() on file failed");
> +}
> +
> +void cleanup(void)
> +{
> +	if (fd > 0 && close(fd))
> +		tst_resm(TWARN | TERRNO, "Failed to close file");
> +
> +	tst_rmdir();
> +}
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: http://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
