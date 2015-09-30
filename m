From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Sep 2015 15:08:53 +0200
Subject: [LTP] [PATCH V2] syscall/renameat2: Add tests for renameat2
In-Reply-To: <1443188077-7291-1-git-send-email-chnyda@suse.com>
References: <1443188077-7291-1-git-send-email-chnyda@suse.com>
Message-ID: <20150930130853.GA8256@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void renameat2_verify(const struct test_case *test)
> +{
> +	TEST(renameat2(*(test->olddirfd), test->oldpath,
> +			*(test->newdirfd), test->newpath, test->flags));
> +
> +	if (test->exp_errno && TEST_RETURN != -1) {
> +		tst_resm(TFAIL, "renameat2() succeeded unexpectedly");
> +		return;
> +	}
> +
> +	if (test->exp_errno == 0 && TEST_RETURN != 0) {
> +		tst_resm(TFAIL | TTERRNO, "renameat2() failed unexpectedly");
> +		return;
> +	}
> +
> +	if (test->exp_errno == TEST_ERRNO) {
> +		tst_resm(TPASS | TTERRNO,
> +		"renameat2() returned the expected value");
> +		return;
> +	}
> +
> +	tst_resm(TFAIL | TTERRNO,
> +		"renameat2() got unexpected return value: expected: %d - %s",
> +			test->exp_errno, strerror(test->exp_errno));

We have tst_strerrno() which produces much nicer output than strerror(),
please use it instead. Also printing raw interger errno value is not
really usefull once tst_strerrno() is used.

> +}
> diff --git a/testcases/kernel/syscalls/renameat2/renameat202.c b/testcases/kernel/syscalls/renameat2/renameat202.c
> new file mode 100644
> index 0000000..5838359
> --- /dev/null
> +++ b/testcases/kernel/syscalls/renameat2/renameat202.c
> @@ -0,0 +1,131 @@
> +/*
> + * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it is
> + * free of the rightful claim of any third person regarding infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program with
> + * other software, or any other product whatsoever.
> + */
> +
> + /* Description:
> + *   Calls renameat2(2) with the flag RENAME_EXCHANGE and check that
> + *   the content was swapped
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "lapi/fcntl.h"
> +#include "renameat2.h"
> +
> +#define TEST_DIR "test_dir/"
> +#define TEST_DIR2 "test_dir2/"
> +
> +#define TEST_FILE "test_file"
> +#define TEST_FILE2 "test_file2"
> +
> +char *TCID = "renameat202";
> +
> +static int olddirfd;
> +static int newdirfd;
> +static int fd = -1;
> +
> +static const char content[] = "content";
> +
> +
> +int TST_TOTAL = 1;
> +
> +static void setup(void);
> +static void cleanup(void);
> +static void renameat2_verify(void);
> +
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +
> +		tst_count = 0;
> +
> +		setup();
> +		TEST(renameat2(olddirfd, TEST_FILE,
> +				newdirfd, TEST_FILE2, RENAME_EXCHANGE));
> +
> +		renameat2_verify();
> +		cleanup();

Can we please avoid calling setup() here repeatedly? Because that would
call tst_tmpdir() over and over...

The most elegant solution I can think of would keep track of which test
file currently should contain the content. Then we would just check that
the right file contains the "content" and that the second one is empty
in the verify() function.

> +	}
> +
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	if ((tst_kvercmp(3, 15, 0)) < 0) {
> +		tst_brkm(TCONF, NULL,
> +			"This test can only run on kernels that are 3.15. and higher");
> +	}
> +
> +	tst_tmpdir();
> +
> +	SAFE_MKDIR(cleanup, TEST_DIR, 0700);
> +	SAFE_MKDIR(cleanup, TEST_DIR2, 0700);
> +
> +	SAFE_TOUCH(cleanup, TEST_DIR TEST_FILE, 0600, NULL);
> +	SAFE_TOUCH(cleanup, TEST_DIR2 TEST_FILE2, 0600, NULL);
> +
> +	olddirfd = SAFE_OPEN(cleanup, TEST_DIR, O_DIRECTORY);
> +	newdirfd = SAFE_OPEN(cleanup, TEST_DIR2, O_DIRECTORY);
> +
> +	SAFE_FILE_PRINTF(cleanup, TEST_DIR TEST_FILE, "%s", content);
> +
> +}
> +
> +static void cleanup(void)
> +{
> +	if (olddirfd > 0 && close(olddirfd) < 0)
> +		tst_resm(TWARN | TERRNO, "close olddirfd failed");
> +
> +	if (newdirfd > 0 && close(newdirfd) < 0)
> +		tst_resm(TWARN | TERRNO, "close newdirfd failed");
> +
> +	if (fd > 0 && close(fd) < 0)
> +		tst_resm(TWARN | TERRNO, "close fd failed");
> +
> +	tst_rmdir();
> +
> +}
> +
> +static void renameat2_verify(void)
> +{
> +	char str[sizeof(content)];
> +
> +	if (TEST_RETURN != 0) {
> +		tst_resm(TFAIL, "renameat2() failed unexpectedly");
> +		return;
> +	}
> +
> +	fd = SAFE_OPEN(cleanup, TEST_DIR2 TEST_FILE2, O_RDONLY);
> +
> +	SAFE_READ(cleanup, 0, fd, str, strlen(content) + 10);
> +
> +	if (str[strlen(content)] == '\0' && !strcmp(content, str))
> +		tst_resm(TPASS,
> +			"renameat2() swapped the content of the two files");
> +	else
> +		tst_resm(TFAIL,
> +			"renameat2() didn't swap the content of the two files");

We should really close the fd and set it to 0 here even if it's handled
by cleanup().

-- 
Cyril Hrubis
chrubis@suse.cz
