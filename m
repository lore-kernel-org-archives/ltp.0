From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Nov 2015 15:30:31 +0100
Subject: [LTP] [PATCH 1/2] preadv/preadv01.c: add new testcase
In-Reply-To: <1446591451-11075-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1446591451-11075-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20151103143031.GD5795@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/preadv/Makefile b/testcases/kernel/syscalls/preadv/Makefile
> new file mode 100644
> index 0000000..ac9a969
> --- /dev/null
> +++ b/testcases/kernel/syscalls/preadv/Makefile
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

This workaround should be needed at all.

> +%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk

...

> diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
> new file mode 100644
> index 0000000..bb9dca3
> --- /dev/null
> +++ b/testcases/kernel/syscalls/preadv/preadv01.c
> @@ -0,0 +1,163 @@
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
> +* Test Name: preadv01
> +*
> +* Test Description:
> +* Testcase to check the basic functionality of the preadv(2).
> +* Preadv(2) should succeed to read the expected content of data
> +* and after reading the file, the file offset is not changed.
> +*/
> +
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "preadv.h"
> +#include "safe_macros.h"
> +
> +#define CHUNK           64
> +
> +static int fd;
> +
> +static void *s1;
> +static void *s2;
> +static char buf[CHUNK];
> +
> +static struct iovec rd_iovec[] = {
> +	{buf, CHUNK},
> +	{NULL, 0},
> +};
> +
> +static struct test_case_t {
> +	off_t offset_cur;
> +	int count;
> +	off_t offset;
> +	int byte;
> +	char content;
> +} test_cases[] = {
> +	{CHUNK, 0, 0, 0, 0x00},
> +	{CHUNK/2, 1, 0, CHUNK, 0x42},
> +	{CHUNK/4, 2, 0, CHUNK, 0x42},
> +	{CHUNK/8, 1, CHUNK*3/2, CHUNK/2, 0x41},
> +};
> +
> +void verify_preadv(int);
> +void setup(void);
> +void *init_buffers(char, size_t);
> +void l_seek(int, off_t, int, off_t);
> +void cleanup(void);
> +
> +char *TCID = "preadv01";
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
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
> +			verify_preadv(tc);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +void verify_preadv(int i)

It would be a bit easier if you passed a pointer to the testcase here
instead of the integer. That way we could just do:

void verify_preadv(struct tcase *tc)

...
	if (TEST_RETURN < 0) {
		tst_resm(TFAIL | TTERRNO, "preadv() failed");
		return;
	}

	if (TEST_RETURN != tc->size) {
		tst_resm(TFAIL, "preadv() read %li bytes, expected %i",
		         TEST_RETURN, tc->size);
		return;
	}

	for (i = 0; i < tc->size; i++) {
		if (vec[i] != tc->content)
			break;
	}

	if (i < tc->size) {
		tst_resm(TFAIL, "Buffer wrong at %i have %02x expected %02x",
		         i, vec[i], tc->content);
		return;
	}

...

> +{
> +	int c;
> +	int fail = 0;
> +	char *vec;
> +
> +	vec = rd_iovec[0].iov_base;
> +
> +	l_seek(fd, test_cases[i].offset_cur, SEEK_SET,
> +		test_cases[i].offset_cur);

Why do you set different file offset here? What is the motivation?

Why cannot we instead check that after every pread() the file offset is
simply set to 0?

> +	TEST(preadv(fd, rd_iovec, test_cases[i].count, test_cases[i].offset));
> +
> +	if (test_cases[i].byte != TEST_RETURN) {
                           ^
			   This should be named size. Naming it byte is
			   quite confusing since it's actually not a
			   single byte but number of bytes.

> +		tst_resm(TFAIL, "preadv failed reading %d bytes ",
> +			 test_cases[i].byte);

You should test the separate case that preadv() returned -1 and print
errno in that case.

And in the case that preadv() read less than expected number of bytes
you should print both actual and expected value.

> +	} else {
> +		for (c = 0; c < test_cases[i].byte; c++) {
> +			if (vec[c] != test_cases[i].content)
> +				fail++;
> +		}
> +
> +		if (fail) {
> +			tst_resm(TFAIL, "Wrong buffer content");

		It would be a bit better to actually write at least
		first place in the buffer with unexpected value and what
		was expected instead here.

> +		} else {
> +			l_seek(fd, 0, SEEK_CUR, test_cases[i].offset_cur);

                        And here you check that the offset wasn't
			changed. That is fine, but it would be far
			better to actually call the SAFE_LSEEK() here
			and issue better error message when the
			resulting offset is unexpected.

			I.e. "pread() has changed file offset" instead
			of cryptic "lseek() on file failed".

> +			tst_resm(TPASS, "preadv passed reading %d bytes ",
> +				 test_cases[i].byte);
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
> +	s1 = init_buffers(0x42, CHUNK);
> +	s2 = init_buffers(0x41, CHUNK);
> +
> +	fd = SAFE_OPEN(cleanup, "file", O_RDWR | O_CREAT, 0644);
> +
> +	SAFE_WRITE(cleanup, 1, fd, s1, CHUNK);
> +	SAFE_WRITE(cleanup, 1, fd, s2, CHUNK);

You are not freeing the s1 and s2 here. Also there is no reason to make
them global variables if they are used only in the setup(). Moreover 64
bytes is small enough to be declared as an array on the stack.

You can do just:

	char s1[CHUNK];
	char s2[CHUNK];

	memset(s1, 0x42, sizeof(s1));
	memset(s2, 0x41, sizeof(s2));

	fd = SAFE_OPEN(cleanup, "file", O_RDWR | O_CREAT, 0644);

	SAFE_WRITE(cleanup, 1, fd, s1, sizeof(s1));
	SAFE_WRITE(cleanup, 1, fd, s2, sizeof(s2));

Or we can do even better. We allready have tst_fill_file(), if we add
a flag to the function that would allow us to choose between trunc and
append mode we could just do:

	int ret;

	ret = tst_fill_file("file", 0x42, CHUNK, 1, TST_TRUNC);
	ret |= tst_fill_file("file", 0x41, CHUNK, 1, TST_APPEND);

	if (ret)
		tst_brkm(TBROK | TERRNO, "Failed to write test file");

> +}
> +
> +void *init_buffers(char content, size_t SIZE)
                                            ^
					    Upper case names are used
					    for macros mainly. Please
					    use lower case here.

> +{
> +	void *s;
> +
> +	s = SAFE_MALLOC(cleanup, SIZE);
> +	(void)memset(s, content, SIZE);

Why do you cast the result from memset() to (void)? It shouldn't be
needed at all.

> +	return s;
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
