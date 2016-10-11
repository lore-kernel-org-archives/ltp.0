From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Oct 2016 12:38:39 +0200
Subject: [LTP] [PATCH v2 2/2] flistxattr and listxattr: added tests
In-Reply-To: <1476114001-24856-3-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1476114001-24856-1-git-send-email-dejan.jovicevic@rt-rk.com>
 <1476114001-24856-3-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <20161011103839.GC14295@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include "config.h"
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <string.h>
> +
> +#ifdef HAVE_SYS_XATTR_H
> +# include <sys/xattr.h>
> +#endif
> +
> +#include "tst_test.h"
> +
> +#ifdef HAVE_SYS_XATTR_H
> +
> +#define SECURITY_KEY1	"security.ltptest1"
> +#define VALUE	"test"
> +#define VALUE_SIZE	4
                        ^
			(sizeof(VALUE) - 1)
> +#define KEY_SIZE    17
                       ^
		       (sizeof(SECURITY_KEY1) - 1)

Let's avoid hardcoded magic constants whenever possible.

> +
> +int fd;

This should be static int fd, but that is minor.

> +static void set_xattr(int fd, const char *key)
> +{
> +	int n;
> +
> +	n = fsetxattr(fd, key, VALUE, VALUE_SIZE, XATTR_CREATE);
> +	if (n == -1) {
> +		if (errno == ENOTSUP) {
> +			tst_brk(TCONF,
> +				 "no xattr support in fs or mounted "
> +				 "without user_xattr option");
> +		}
> +
> +		if (errno == EEXIST) {
> +			tst_brk(TBROK, "exist attribute %s", key);
> +		} else {
> +			tst_brk(TBROK | TERRNO,
> +				 "fsetxattr() failed");
> +		}

Hmm, why do we treat the EEXIST separately here?

Why not just tst_brk(TBROK | TERRNO, "fsetxattr(%s, ...)") ?

Maybe we should SAFE_FSETXATTR() and SAFE_SETXATTR() and use it in all
fooxattr() testcases.

> +	}
> +}
> +
> +static int has_attribute(const char *list, int llen, const char *attr)
> +{
> +	int i;
> +
> +	for (i = 0; i < llen; i += strlen(list + i) + 1) {
> +		if (!strcmp(list + i, attr))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static void verify_flistxattr(void)
> +{
> +	int size = 64;
> +	char buf[size];

Just do char buf[64]; here and pass the sizeof(buf) to the flistxattr()
instead.

> +
> +	TEST(flistxattr(fd, buf, size));
> +	if (TEST_RETURN == -1) {
> +		tst_res(TFAIL | TERRNO, "flistxattr() failed");
                                ^
				TTERRNO would be better here, since we
				use the TEST() macro.

> +		return;
> +	}
> +
> +	if (!has_attribute(buf, size, SECURITY_KEY1)) {
> +		tst_res(TFAIL, "missing attribute %s",
> +			 SECURITY_KEY1);
> +		return;
> +	}
> +
> +	tst_res(TPASS, "flistxattr() succeeded");
> +}
> +
> +static void setup(void)
> +{
> +	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0644);
> +
> +	set_xattr(fd, SECURITY_KEY1);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > 0 && close(fd))
> +		tst_res(TWARN | TERRNO, "failed to close file");
> +}
> +
> +static struct tst_test test = {
> +	.tid = "flistxattr01",
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.test_all = verify_flistxattr,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> +
> +#else
> +	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
> +#endif /* HAVE_SYS_XATTR_H */
> +
> diff --git a/testcases/kernel/syscalls/flistxattr/flistxattr02.c b/testcases/kernel/syscalls/flistxattr/flistxattr02.c
> new file mode 100644
> index 0000000..8402290
> --- /dev/null
> +++ b/testcases/kernel/syscalls/flistxattr/flistxattr02.c
> @@ -0,0 +1,116 @@
> +/*
> +* Copyright (c) 2016 Fujitsu Ltd.
> +* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
     ^
     You should update the copyright as well.

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
> +* Test Name: flistxattr02
> +*
> +* Description:
> +* 1) flistxattr(2) fails if the size of the list buffer is too small
> +* to hold the result.
> +* 2) flistxattr(2) fails if fd is an invalid file descriptor.
> +*
> +* Expected Result:
> +* 1) flistxattr(2) should return -1 and set errno to ERANGE.
> +* 2) flistxattr(2) should return -1 and set errno to EBADF.
> +*/
> +
> +#include "config.h"
> +#include <errno.h>
> +#include <sys/types.h>
> +
> +#ifdef HAVE_SYS_XATTR_H
> +# include <sys/xattr.h>
> +#endif
> +
> +#include "tst_test.h"
> +
> +#ifdef HAVE_SYS_XATTR_H
> +
> +#define SECURITY_KEY	"security.ltptest"
> +#define VALUE	"test"
> +#define VALUE_SIZE	4
                        ^
			(sizeof(VALUE) - 1)

> +static int fd1;
> +static int fd2;
> +
> +static struct test_case {
> +	int *fd;
> +	size_t size;
> +	int exp_err;
> +} tc[] = {
> +	/* test1 */
           ^
	   These comments seem useless to me, I would have removed them.

> +	{&fd1, 1, ERANGE},
> +	/* test2 */
> +	{&fd2, 20, EBADF}
> +};
> +
> +static void verify_flistxattr(unsigned int n)
> +{
> +	struct test_case *t = tc + n;
> +	char buf[t->size];
> +
> +	TEST(flistxattr(*t->fd, buf, t->size));
> +	if (TEST_RETURN != -1) {
             ^
	     TEST_RETURN == 0 is a bit more robust, that would catch if
	     we got any garbage out of the call.

> +		tst_res(TFAIL, "flistxattr() succeeded unexpectedly");

I would add return; here so that the rest of the code does not need to
be in the else branch (that saves a bit of indentation and the result is
IMHO easier to read).

> +	} else {
> +		if (t->exp_err != TEST_ERRNO) {
> +			tst_res(TFAIL | TTERRNO, "flistxattr() failed "
> +				 "unexpectedlly, expected %s",
> +				 tst_strerrno(t->exp_err));
> +		} else {
> +			tst_res(TPASS | TTERRNO,
> +				 "flistxattr() failed as expected");
> +		}
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	int n;
> +
> +	fd1 = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0644);
> +	fd2 = -1;
         ^
	 This should be initialized statically when the variable is
	 declared.

> +	n = fsetxattr(fd1, SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
> +	if (n == -1) {
> +		if (errno == ENOTSUP) {
> +			tst_brk(TCONF, "no xattr support in fs or "
> +				 "mounted without user_xattr option");
> +		} else {
> +			tst_brk(TBROK | TERRNO, "fsetxattr() failed");
> +		}

No need for the else branch here. The tst_brk() exits the test and hence
the call never returns.

> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd1 > 0 && close(fd1))
> +		tst_res(TWARN | TERRNO, "failed to close file");
> +}
> +
> +static struct tst_test test = {
> +	.tid = "flistxattr02",
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.test = verify_flistxattr,
> +	.tcnt = ARRAY_SIZE(tc),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> +
> +#else /* HAVE_SYS_XATTR_H */
> +	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
> +#endif
> diff --git a/testcases/kernel/syscalls/flistxattr/flistxattr03.c b/testcases/kernel/syscalls/flistxattr/flistxattr03.c
> new file mode 100644
> index 0000000..691f869
> --- /dev/null
> +++ b/testcases/kernel/syscalls/flistxattr/flistxattr03.c
> @@ -0,0 +1,111 @@
> +/*
> +* Copyright (c) 2016 Fujitsu Ltd.
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
> +* Test Name: flistxattr03
> +*
> +* Description:
> +* flistxattr is identical to listxattr. an empty buffer of size zero
> +* can return the current size of the list of extended attribute names,
> +* which can be used to estimate a suitable buffer.
> +*/
> +
> +#include "config.h"
> +#include <errno.h>
> +#include <sys/types.h>
> +
> +#ifdef HAVE_SYS_XATTR_H
> +#include <sys/xattr.h>
> +#endif
> +
> +#include "tst_test.h"
> +
> +#ifdef HAVE_SYS_XATTR_H
> +
> +#define SECURITY_KEY	"security.ltptest"
> +#define VALUE	"test"
> +#define VALUE_SIZE	4
                        ^
			(sizeof(VALUE) - 1)
> +
> +static int fd[] = {0, 0};
> +
> +static int check_suitable_buf(const int file, long size)
> +{
> +	int n;
> +	char buf[size];
> +
> +	n = flistxattr(file, buf, size);
                                   ^
				   sizeof(buf) is a bit safe
				   (will stay correct even if somebody
				   changes the code around)
> +	if (n == -1)
> +		return 0;
> +	else
> +		return 1;

return n != -1;

> +}
> +
> +static void verify_flistxattr(unsigned int n)
> +{
> +	const int file = fd[n];

Hmm, why don't you pass the fd[n] directly? It's not that file is that
shorter or easier to read.

> +	TEST(flistxattr(file, NULL, 0));
> +	if (TEST_RETURN == -1) {
> +		tst_res(TFAIL | TERRNO, "flistxattr() failed");
> +		return;
> +	}
> +
> +	if (check_suitable_buf(file, TEST_RETURN))
> +		tst_res(TPASS, "flistxattr() succeed with suitable buffer");
> +	else
> +		tst_res(TFAIL, "flistxattr() failed with small buffer");
> +}
> +
> +static void setup(void)
> +{
> +	int ret;
> +
> +	fd[0] = SAFE_OPEN("testfile1", O_RDWR | O_CREAT, 0644);
> +
> +	fd[1] = SAFE_OPEN("testfile2", O_RDWR | O_CREAT, 0644);
> +
> +	ret = fsetxattr(fd[1], SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
> +	if (ret == -1) {
> +		if (errno == ENOTSUP) {
> +			tst_brk(TCONF, "no xattr support in fs or "
> +				 "mounted without user_xattr option");
> +		} else {
> +			tst_brk(TBROK | TERRNO, "fsetxattr() failed");

Again no need for the else branch.

> +		}
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd[0] > 0 && close(fd[0]))
> +		tst_res(TWARN | TERRNO, "failed to close file");
> +	if (fd[1] > 0 && close(fd[1]))
> +		tst_res(TWARN | TERRNO, "failed to close file");
> +}
> +
> +static struct tst_test test = {
> +	.tid = "flistxattr03",
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.test = verify_flistxattr,
> +	.tcnt = ARRAY_SIZE(fd),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> +
> +#else /* HAVE_SYS_XATTR_H */
> +	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
> +#endif
> diff --git a/testcases/kernel/syscalls/listxattr/Makefile b/testcases/kernel/syscalls/listxattr/Makefile
> new file mode 100644
> index 0000000..ed05a48
> --- /dev/null
> +++ b/testcases/kernel/syscalls/listxattr/Makefile
> @@ -0,0 +1,23 @@
> +#
> +#  Copyright (c) 2016 Fujitsu Ltd.
> +#  Author: Xiao Yang <yangx.jy@cn.fujitsu.com>

Here again, update the copyright line.

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
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/listxattr/listxattr01.c b/testcases/kernel/syscalls/listxattr/listxattr01.c
> new file mode 100644
> index 0000000..3159a7b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/listxattr/listxattr01.c
> @@ -0,0 +1,115 @@
> +/*
> +* Copyright (c) 2016 Fujitsu Ltd.
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
> +* Test Name: listxattr01
> +*
> +* Description:
> +* The testcase checks the basic functionality of the listxattr(2).
> +* listxattr(2) retrieves the list of extended attribute names
> +* associated with the file itself in the filesystem.
> +*
> +*/
> +
> +#include "config.h"
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <string.h>
> +
> +#ifdef HAVE_SYS_XATTR_H
> +# include <sys/xattr.h>
> +#endif
> +
> +#include "tst_test.h"
> +
> +#ifdef HAVE_SYS_XATTR_H
> +
> +#define SECURITY_KEY1	"security.ltptest1"
> +#define VALUE	"test"
> +#define VALUE_SIZE	4
                        ^
			(sizeof(VALUE) - 1)

> +#define KEY_SIZE    17
                       (sizeof(SECURITY_KEY1) - 1)
> +
> +static void set_xattr(const char *path, const char *key)
> +{
> +	int n;
> +
> +	n = setxattr(path, key, VALUE, VALUE_SIZE, XATTR_CREATE);
> +	if (n == -1) {
> +		if (errno == ENOTSUP) {
> +			tst_brk(TCONF,
> +				 "no xattr support in fs or mounted "
> +				 "without user_xattr option");
> +		}
> +
> +		if (errno == EEXIST) {
> +			tst_brk(TBROK, "exist attribute %s", key);
> +		} else {
> +			tst_brk(TBROK | TERRNO,
> +				 "setxattr() failed");
> +		}

Here again, why do we treat EEXIST differently?

> +	}
> +}
> +
> +static int has_attribute(const char *list, int llen, const char *attr)
> +{
> +	int i;
> +
> +	for (i = 0; i < llen; i += strlen(list + i) + 1) {
> +		if (!strcmp(list + i, attr))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static void verify_listxattr(void)
> +{
> +	int size = 64;
> +	char buf[size];
> +
> +	TEST(listxattr("testfile", buf, size));
> +	if (TEST_RETURN == -1) {
> +		tst_res(TFAIL | TERRNO, "listxattr() failed");
> +		return;
> +	}
> +
> +	if (!has_attribute(buf, size, SECURITY_KEY1)) {
> +		tst_res(TFAIL, "missing attribute %s",
> +			 SECURITY_KEY1);
> +		return;
> +	}
> +
> +	tst_res(TPASS, "listxattr() succeeded");
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_TOUCH("testfile", 0644, NULL);
> +
> +	set_xattr("testfile", SECURITY_KEY1);
                    ^
		    This should proabaly be macro:

		    #define TESTFILE "testfile"

> +}
> +
> +static struct tst_test test = {
> +	.tid = "listxattr01",
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.test_all = verify_listxattr,
> +	.setup = setup,
> +};
> +
> +#else
> +	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
> +#endif /* HAVE_SYS_XATTR_H */
> +
> diff --git a/testcases/kernel/syscalls/listxattr/listxattr02.c b/testcases/kernel/syscalls/listxattr/listxattr02.c
> new file mode 100644
> index 0000000..328a08e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/listxattr/listxattr02.c
> @@ -0,0 +1,119 @@
> +/*
> +* Copyright (c) 2016 Fujitsu Ltd.
> +* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>

Here again, copyright.

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
> +* Test Name: listxattr02
> +*
> +* Description:
> +* 1) listxattr(2) fails if the size of the list buffer is too small
> +* to hold the result.
> +* 2) listxattr(2) fails if path is an empty string.
> +* 3) listxattr(2) fails when attempted to read from a invalid address.
> +* 4) listxattr(2) fails if path is longer than allowed.
> +*
> +* Expected Result:
> +* 1) listxattr(2) should return -1 and set errno to ERANGE.
> +* 2) listxattr(2) should return -1 and set errno to ENOENT.
> +* 3) listxattr(2) should return -1 and set errno to EFAULT.
> +* 4) listxattr(2) should return -1 and set errno to ENAMETOOLONG.
> +*/
> +
> +#include "config.h"
> +#include <errno.h>
> +#include <sys/types.h>
> +
> +#ifdef HAVE_SYS_XATTR_H
> +# include <sys/xattr.h>
> +#endif
> +
> +#include "tst_test.h"
> +
> +#ifdef HAVE_SYS_XATTR_H
> +
> +#define SECURITY_KEY	"security.ltptest"
> +#define VALUE	"test"
> +#define VALUE_SIZE	4
                        ^
			(sizeof(VALUE) - 1)

> +char longpathname[PATH_MAX + 2];
> +
> +static struct test_case {
> +	const char *path;
> +	size_t size;
> +	int exp_err;
> +} tc[] = {
> +	/* test1 */
> +	{"testfile", 1, ERANGE},
> +	/* test2 */
> +	{"", 20, ENOENT},
> +	/* test3 */
> +	{(char *)-1, 20, EFAULT},
> +	/* test4 */

Useless comments.

> +	{longpathname, 20, ENAMETOOLONG}
> +};
> +
> +static void verify_listxattr(unsigned int n)
> +{
> +	struct test_case *t = tc + n;
> +	char buf[t->size];
> +
> +	TEST(listxattr(t->path, buf, t->size));
                                       ^
				       sizeof(buf)
> +	if (TEST_RETURN != -1) {
> +		tst_res(TFAIL, "listxattr() succeeded unexpectedly");

Again do a return; here and the rest of the code does not need to be
inside of an else block.

> +	} else {
> +		if (t->exp_err != TEST_ERRNO) {
> +			tst_res(TFAIL | TTERRNO, "listxattr() failed "
> +				 "unexpectedlly, expected %s",
> +				 tst_strerrno(t->exp_err));
> +		} else {
> +			tst_res(TPASS | TTERRNO,
> +				 "listxattr() failed as expected");
> +		}
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	int n;
> +
> +	SAFE_TOUCH("testfile", 0644, NULL);
> +
> +
> +	n = setxattr("testfile", SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
> +	if (n == -1) {
> +		if (errno == ENOTSUP) {
> +			tst_brk(TCONF, "no xattr support in fs or "
> +				 "mounted without user_xattr option");
> +		} else {
> +			tst_brk(TBROK | TERRNO, "setxattr() failed");
> +		}

Again, no need for the else branch.

> +	}
> +
> +	memset(&longpathname, 'a', sizeof(longpathname) - 1);
> +	longpathname[sizeof(longpathname)] = '\0';

Again off-by-one and no needed.

> +}
> +
> +static struct tst_test test = {
> +	.tid = "listxattr02",
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.test = verify_listxattr,
> +	.tcnt = ARRAY_SIZE(tc),
> +	.setup = setup,
> +};
> +
> +#else /* HAVE_SYS_XATTR_H */
> +	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
> +#endif
> diff --git a/testcases/kernel/syscalls/listxattr/listxattr03.c b/testcases/kernel/syscalls/listxattr/listxattr03.c
> new file mode 100644
> index 0000000..91c4876
> --- /dev/null
> +++ b/testcases/kernel/syscalls/listxattr/listxattr03.c
> @@ -0,0 +1,101 @@
> +/*
> +* Copyright (c) 2016 Fujitsu Ltd.
> +* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>

Again, the copyright.

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
> +* Test Name: listxattr03
> +*
> +* Description:
> +* An empty buffer of size zero can return the current size of the list
> +* of extended attribute names, which can be used to estimate a suitable buffer.
> +*/
> +
> +#include "config.h"
> +#include <errno.h>
> +#include <sys/types.h>
> +
> +#ifdef HAVE_SYS_XATTR_H
> +#include <sys/xattr.h>
    ^
    should ideally be indented by single space after the #
> +#endif
> +
> +#include "tst_test.h"
> +
> +#ifdef HAVE_SYS_XATTR_H
> +
> +#define SECURITY_KEY	"security.ltptest"
> +#define VALUE	"test"
> +#define VALUE_SIZE	4
                        ^
			(sizeof(VALUE)-1)

> +static const char * const filename[] = {"testfile1", "testfile2"};
> +
> +static int check_suitable_buf(const char *name, long size)
> +{
> +	int n;
> +	char buf[size];
> +
> +	n = listxattr(name, buf, size);
                                  ^
				  sizeof(buf)
> +	if (n == -1)
> +		return 0;
> +	else
> +		return 1;

return n != -1;

> +}
> +
> +static void verify_listxattr(unsigned int n)
> +{
> +	const char *name = filename[n];
> +
> +	TEST(listxattr(name, NULL, 0));
> +	if (TEST_RETURN == -1) {
> +		tst_res(TFAIL | TERRNO, "listxattr() failed");
> +		return;
> +	}
> +
> +	if (check_suitable_buf(name, TEST_RETURN))
> +		tst_res(TPASS, "listxattr() succeed with suitable buffer");
> +	else
> +		tst_res(TFAIL, "listxattr() failed with small buffer");
> +}
> +
> +static void setup(void)
> +{
> +	int ret;
> +
> +	SAFE_TOUCH(filename[0], 0644, NULL);
> +
> +	SAFE_TOUCH(filename[1], 0644, NULL);
> +
> +	ret = setxattr(filename[1], SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
> +	if (ret == -1) {
> +		if (errno == ENOTSUP) {
> +			tst_brk(TCONF, "no xattr support in fs or "
> +				 "mounted without user_xattr option");
> +		} else {
> +			tst_brk(TBROK | TERRNO, "setxattr() failed");

Again no need for the else block.

> +		}
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.tid = "listxattr03",
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.test = verify_listxattr,
> +	.tcnt = ARRAY_SIZE(filename),
> +	.setup = setup,
> +};
> +
> +#else /* HAVE_SYS_XATTR_H */
> +	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
> +#endif
> -- 
> 1.9.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
