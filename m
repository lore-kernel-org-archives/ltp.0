From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Oct 2015 15:01:35 +0200
Subject: [LTP] [PATCH] syscall/kcmp: Add tests for kcmp
In-Reply-To: <1444293886-10391-1-git-send-email-chnyda@suse.com>
References: <1444293886-10391-1-git-send-email-chnyda@suse.com>
Message-ID: <20151008130135.GB8947@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/m4/ltp-kcmp_type.m4 b/m4/ltp-kcmp_type.m4
> new file mode 100644
> index 0000000..f4d7e2d
> --- /dev/null
> +++ b/m4/ltp-kcmp_type.m4
> @@ -0,0 +1,23 @@
> +dnl
> +dnl Copyright (c) Linux Test Project, 2015
> +dnl
> +dnl This program is free software;  you can redistribute it and/or modify
> +dnl it under the terms of the GNU General Public License as published by
> +dnl the Free Software Foundation; either version 2 of the License, or
> +dnl (at your option) any later version.
> +dnl
> +dnl This program is distributed in the hope that it will be useful,
> +dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +dnl the GNU General Public License for more details.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program;  if not, write to the Free Software Foundation,
> +dnl Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +dnl
> +dnl Author: Cedric Hnyda <chnyda@suse.com>
> +dnl
> +
> +AC_DEFUN([LTP_CHECK_KCMP_TYPE],[
> +AC_CHECK_TYPES([enum kcmp_type],,)
> +])

We should pass the third parameter as [#include <linux/kcmp.h>] (which
is the place the enum will be defined in new enough kernel headers
package). Otherwise this will always report that the enum is missing as
by default it only uses a few system includes (see:
https://www.gnu.org/software/autoconf/manual/autoconf-2.64/html_node/Default-Includes.html#Default-Includes)


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

This is GPLv2 header, can we please use GPLv2+ instead?

Have a look at: include/lapi/fcntl.h for instance.

And it looks like I've missed that in the renameat2 case as well,
sorry. Can you please fix these as well?

> +#ifndef KCMP_H
> +#define KCMP_H
> +
> +#include <sys/types.h>
> +#include "config.h"
> +#include "linux_syscall_numbers.h"
> +
> +#if !defined(HAVE_ENUM_KCMP_TYPE)
> +
> +enum kcmp_type {
> +	KCMP_FILE,
> +	KCMP_VM,
> +	KCMP_FILES,
> +	KCMP_FS,
> +	KCMP_SIGHAND,
> +	KCMP_IO,
> +	KCMP_SYSVSEM,
> +	KCMP_TYPES,
> +};
> +
> +#endif

Here should be an #else branch that includes the <linux/kcmp.h> in case
that the enum is defined there. Otherwise the definitions would be
missing when the header actuall exists and the code will fail to
compile.

> +#if !defined(HAVE_KCMP)
> +
> +int kcmp(int pid1, int pid2, int type, int fd1, int fd2)
> +{
> +	return ltp_syscall(__NR_kcmp, pid1, pid2, type, fd1, fd2);
> +}
> +
> +#endif
> +
> +#endif /* KCMP_H */

And this file may be moved to include/lapi/ so that we have all fallback
definitions in one place. However in this case I doubt that we will want
to reuse it, so it can also stay in the kcmp directory as well.

> diff --git a/testcases/kernel/syscalls/kcmp/kcmp01.c b/testcases/kernel/syscalls/kcmp/kcmp01.c
> new file mode 100644
> index 0000000..585e89e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/kcmp/kcmp01.c
> @@ -0,0 +1,143 @@
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
> + *   Verify that:
> + *		1) kcmp returns 0 with two process and two fd refering to the
> + *			same fd
                             ^
			     open file would be less confusing in this
			     context

> + *		2) kcmp doesn't return 0 with two process and two fd refering
> + *		    to the same fd
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "lapi/fcntl.h"
> +#include "kcmp.h"
> +
> +#define TEST_FILE "test_file"
> +#define TEST_FILE2 "test_file2"
> +
> +
> +static int fd1;
> +static int fd2;
> +static int fd3;
> +static int pid1;
> +static int pid2;
> +
> +char *TCID = "kcmp01";
> +
> +static struct test_case {
> +	int *pid1;
> +	int *pid2;
> +	int type;
> +	int *fd1;
> +	int *fd2;
> +	int exp_fail;
> +} test_cases[] = {
> +	{&pid1, &pid2, KCMP_FILE, &fd1, &fd2, 0},
> +	{&pid1, &pid2, KCMP_FILE, &fd1, &fd3, 1},
> +};
> +
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +
> +static void cleanup(void);
> +static void setup(void);
> +static void do_child(const struct test_case *test);
> +static void cleanup_child(void);
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int i;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; ++i) {
> +			pid2 = tst_fork();

Unline SAFE_MACROS() the tst_fork() may still fail, it's unlikely but
possible (for isntance it may fail if there is not enough system memory
left).

So we need to check the return value from the function and call
tst_brkm() if it failed.

Or we can add SAFE_FORK() that would call tst_fork() and make use of it
here.

> +			if (!pid2)
> +				do_child(&test_cases[i]);
> +			else
> +				tst_record_childstatus(cleanup, pid2);
> +			tst_count++;
> +		}
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void do_child(const struct test_case *test)
> +{
> +	pid2 = getpid();
> +	fd2 = dup(fd1);
> +	fd3 = SAFE_OPEN(cleanup_child, TEST_FILE2, O_CREAT | O_RDWR, 0666);
> +
> +	TEST(kcmp(*(test->pid1), *(test->pid2), test->type,
> +			  *(test->fd1), *(test->fd2)));
> +	cleanup_child();

Well, these file descriptors will be closed when the child exits (when
tst_exit() calls exit() file descriptors are closed, etc.). So this is
not strictly needed...

The reason why we strictly close all remaining file descriptors before
we call tst_rmdir() in cleanup() is "nfs silly rename" which breaks the
cleanup in case that file was unlinked but there is open file descriptor
pointing to the file (in this case NFS keeps the file as .nfsXXXXX which
couldn't be deleted). Which caused test failures if TMPDIR points to NFS
mounts.

> +	if (TEST_RETURN == -1)
> +		tst_resm(TFAIL | TTERRNO, "kcmp() failed unexpectedly");
> +
> +	if ((test->exp_fail && TEST_RETURN == 0)
> +		|| (test->exp_fail == 0 && TEST_RETURN))
                           ^
			   This should rather be exp_different or
			   something similar. As it is it's quite
			   confusing since the call actually haven't
			   failed but reported that resources are
			   different.
> +		tst_resm(TFAIL, "kcmp() didn't return the expected value");

                                     ^
				     Can we be a litte more specific
				     here? Can we print hat have we
				     expected and what was the result?

> +	if ((test->exp_fail == 0 && TEST_RETURN == 0)
> +		|| (test->exp_fail && TEST_RETURN))
> +		tst_resm(TPASS, "kcmp() returned the expected value");
> +
> +	tst_exit();
> +}
> +
> +static void cleanup_child(void)
> +{
> +	if (fd2 > 0 && close(fd2) < 0)
> +		tst_resm(TWARN | TERRNO, "close fd2 failed");
> +	fd2 = 0;
> +	if (fd3 > 0 && close(fd3) < 0)
> +		tst_resm(TWARN | TERRNO, "close fd3 failed");
> +	fd3 = 0;
> +}
> +
> +static void setup(void)
> +{
> +	if ((tst_kvercmp(3, 5, 0)) < 0) {
> +		tst_brkm(TCONF, NULL,
> +			"This test can only run on kernels that are 3.5. and higher");
> +	}
> +
> +	tst_tmpdir();
> +
> +	pid1 = getpid();
> +	fd1 = SAFE_OPEN(cleanup, TEST_FILE, O_CREAT | O_RDWR | O_TRUNC);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd1 > 0 && close(fd1) < 0)
> +		tst_resm(TWARN | TERRNO, "close fd1 failed");
> +	tst_rmdir();
> +}
> diff --git a/testcases/kernel/syscalls/kcmp/kcmp02.c b/testcases/kernel/syscalls/kcmp/kcmp02.c
> new file mode 100644
> index 0000000..0d734ad
> --- /dev/null
> +++ b/testcases/kernel/syscalls/kcmp/kcmp02.c
> @@ -0,0 +1,137 @@
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
> + *   Verify that:
> + *		1) kcmp fails with bad pid
> + *		2) kcmp fails with invalid flag
> + *		3) kcmp fails with invalid fd
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "lapi/fcntl.h"
> +#include "kcmp.h"
> +
> +#define TEST_FILE "test_file"
> +#define TEST_FILE2 "test_file2"
> +
> +static int fd1;
> +static int fd2;
> +static int fd_fake;
> +static int pid1;
> +static int pid_fake = -1;
> +static int fd_fake = -1;
> +
> +char *TCID = "kcmp02";
> +
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +
> +static struct test_case {
> +	int *pid1;
> +	int *pid2;
> +	int type;
> +	int *fd1;
> +	int *fd2;
> +	int exp_errno;
> +} test_cases[] = {
> +	{&pid1, &pid_fake, KCMP_FILE, &fd1, &fd2, ESRCH},

We have tst_get_unused_pid() please make use of it.

> +	{&pid1, &pid1, EINVAL, &fd1, &fd2, EINVAL},
                         ^
			Why? It fails only by chance since EINVAL is 22
			and KCMP_TYPES is less than 22. Good values for
			this are >= KCMP_TYPES and < 0 since enum starts
			on 0 by definition.

			So I would test with KCMP_TYPES, KCMP_TYPES + 1,
			INT_MAX, -1, and INT_MIN, which should be enough
			to cover most of the possibilities.

> +	{&pid1, &pid1, KCMP_FILE, &fd1, &fd_fake, EBADF}
> +};
> +
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +
> +static void cleanup(void);
> +static void setup(void);
> +static void kcmp_verify(const struct test_case *test);
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int i;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; i++)
> +			kcmp_verify(&test_cases[i]);
> +
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void kcmp_verify(const struct test_case *test)
> +{
> +	TEST(kcmp(*(test->pid1), *(test->pid2), test->type,
> +			  *(test->fd1), *(test->fd2)));
> +
> +	if (test->exp_errno && TEST_RETURN != -1) {
> +		tst_resm(TFAIL, "kcmp() succeeded unexpectedly");
> +		return;
> +	}
> +
> +	if (!test->exp_errno && !TEST_RETURN) {
> +		tst_resm(TFAIL | TTERRNO, "kcmp() failed unexpectedly");
> +		return;
> +	}

We do not have possitive testcases in this tests -> this branch is never
called.

> +	if (test->exp_errno == TEST_ERRNO) {
> +		tst_resm(TPASS | TTERRNO, "kcmp() returned the expected value");
> +		return;
> +	}
> +
> +	tst_resm(TFAIL | TTERRNO,
> +		"kcmp() got unexpected return value: expected: %d - %s",
> +			test->exp_errno, tst_strerrno(test->exp_errno));
> +}
> +
> +static void setup(void)
> +{
> +	if ((tst_kvercmp(3, 5, 0)) < 0) {
> +		tst_brkm(TCONF, NULL,
> +			"This test can only run on kernels that are 3.5. and higher");
> +	}
> +
> +	tst_tmpdir();
> +
> +	pid1 = getpid();
> +	fd1 = SAFE_OPEN(cleanup, TEST_FILE, O_CREAT | O_RDWR | O_TRUNC);
> +	fd2 = SAFE_OPEN(cleanup, TEST_FILE2, O_CREAT | O_RDWR | O_TRUNC);
> +
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd1 > 0 && close(fd1) < 0)
> +		tst_resm(TWARN | TERRNO, "close fd1 failed");
> +
> +	if (fd2 > 0 && close(fd2) < 0)
> +		tst_resm(TWARN | TERRNO, "close fd2 failed");
> +	tst_rmdir();
> +
> +}
> -- 
> 2.1.4
> 
> 
> -- 
> Mailing list info: http://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
