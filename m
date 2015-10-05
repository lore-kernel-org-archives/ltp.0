From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Oct 2015 17:34:16 +0200
Subject: [LTP] [PATCH V3] syscall/renameat2: Add tests for renameat2
In-Reply-To: <1443692785-3862-1-git-send-email-chnyda@suse.com>
References: <1443692785-3862-1-git-send-email-chnyda@suse.com>
Message-ID: <20151005153415.GA21607@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with small adjustements, thanks.

* Fixed the Signed-off-by line (to contain your full name)

* Fixed merge for kernel/include/sparc* that were modified meanwhile

* Changed the runtest/syscall record for renameat202 to do 10 iterations
  by default (so that we stress the kernel a bit by)

* A few fixed in renameat202.c, see below.

> diff --git a/testcases/kernel/syscalls/renameat2/renameat202.c b/testcases/kernel/syscalls/renameat2/renameat202.c
> new file mode 100644
> index 0000000..46430d8
> --- /dev/null
> +++ b/testcases/kernel/syscalls/renameat2/renameat202.c
> @@ -0,0 +1,156 @@
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
> +static int cnt;
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
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +
> +		tst_count = 0;
> +
> +		TEST(renameat2(olddirfd, TEST_FILE,
> +				newdirfd, TEST_FILE2, RENAME_EXCHANGE));
> +
> +		cnt++;
> +
> +		renameat2_verify();
> +	}
> +
> +	cleanup();
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
> +	cnt = 0;

The cnt is global variable and therefore initialized to 0 automatically.

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
> +	struct stat st;
> +	char *emptyfile;
> +	char *contentfile;
> +
> +	if (TEST_RETURN != 0) {
> +		tst_resm(TFAIL, "renameat2() failed unexpectedly");
> +		return;
> +	}
> +
> +	if (cnt % 2 == 1) {
> +		emptyfile = TEST_DIR TEST_FILE;
> +		contentfile = TEST_DIR2 TEST_FILE2;
> +	} else {
> +		emptyfile = TEST_DIR2 TEST_FILE2;
> +		contentfile = TEST_DIR TEST_FILE;
> +	}
> +
> +	fd = SAFE_OPEN(cleanup, contentfile, O_RDONLY);
> +
> +	if (stat(emptyfile, &st) < 0)
> +		tst_brkm(TERRNO | TFAIL, cleanup, "stat failed");

Changed this to use SAFE_STAT() instead.

> +	SAFE_READ(cleanup, 0, fd, str, strlen(content) + 10);
> +
> +	if (fd > 0 && close(fd) < 0)
> +		tst_brkm(TERRNO | TFAIL, cleanup, "close fd failed");
> +	fd = 0;

Dropped the fd > 0 from the if, since if SAFE_READ returns, the fd points
to opened file and therefore is > 0.

> +	if (str[strlen(content)] == '\0' && !strcmp(content, str)
> +		&& !st.st_size)
> +		tst_resm(TPASS,
> +			"renameat2() swapped the content of the two files");
> +	else
> +		tst_resm(TFAIL,
> +			"renameat2() didn't swap the content of the two files");
> +}

-- 
Cyril Hrubis
chrubis@suse.cz
