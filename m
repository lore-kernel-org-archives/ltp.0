From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Jul 2016 14:22:48 +0200
Subject: [LTP] [PATCH 1/2] lgetxattr/lgetxattr01.c: add new testcase
In-Reply-To: <1466149404-22555-1-git-send-email-huangjb.jy@cn.fujitsu.com>
References: <1466149404-22555-1-git-send-email-huangjb.jy@cn.fujitsu.com>
Message-ID: <20160713122247.GA2232@rei.scz.novell.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -0,0 +1,119 @@
> +/*
> +* Copyright (c) 2016 Fujitsu Ltd.
> +* Author: Jinbao Huang <huangjb.jy@cn.fujitsu.com>
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
> +* Test Name: lgetxattr01
> +*
> +* Description:
> +* The testcase checks the basic functionality of the lgetxattr(2).
> +* In the case of a symbolic link, we only get the value of the
> +* extended attribute related to the link itself by name.
> +*/
> +
> +#include "config.h"
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <string.h>
> +
> +#ifdef HAVE_ATTR_XATTR_H
> +#include <attr/xattr.h>
> +#endif
> +
> +#include "tst_test.h"
> +
> +#ifdef HAVE_ATTR_XATTR_H
> +#define SECURITY_KEY1   "security.ltptest1"
> +#define SECURITY_KEY2   "security.ltptest2"
> +#define VALUE1   "test1"
> +#define VALUE2   "test2"
> +#define VALUE_SIZE      5
> +
> +static void set_xattr(char *path, char *key, void *value)
> +{
> +	int res;
> +
> +	res = lsetxattr(path, key, value, VALUE_SIZE, XATTR_CREATE);
                                           ^
                                          Should be either defined to
					  sizeof() or we can do strlen()
					  on the value as well.


I would either add size parameter to this function so that it could be
called in setup as:

set_xattr("testfile", SECURITY_KEY1, VALUE1, sizeof(VALUE1));

Which will include the terminating null character at the end, but I
doubt that we care about if it's there or not.

Or we can alternatively get the size with strlen(value) since it's a
string.

> +	if (res == -1) {
> +		if (errno == ENOTSUP) {
> +			tst_brk(TCONF,
> +				"no xattr support in fs or mounted "
> +				"without user_xattr option");
> +		}
> +
> +		if (errno == EEXIST)
> +			tst_brk(TBROK, "exist attribute %s", key);
> +		else
> +			tst_brk(TBROK | TERRNO, "lsetxattr() failed");

Why do we have special branch for the EEXIST case here?

We can just instead do:

	tst_brk(TBROK | TERRNO, "lsetxattr(%s)", key);

> +	}
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_TOUCH("testfile", 0644, NULL);
> +	SAFE_SYMLINK("testfile", "symlink");
> +
> +	set_xattr("testfile", SECURITY_KEY1, VALUE1);
> +	set_xattr("symlink", SECURITY_KEY2, VALUE2);
> +}
> +
> +static void verify_lgetxattr(void)
> +{
> +	int size = 64;
> +	char buf[size];
> +
> +	TEST(lgetxattr("symlink", SECURITY_KEY2, buf, size));
> +	if (TEST_RETURN == -1) {
> +		tst_res(TFAIL | TTERRNO, "lgetxattr() failed");
> +		return;
> +	}
> +
> +	if (TEST_RETURN != VALUE_SIZE) {
> +		tst_res(TFAIL, "lgetxattr() got unexpected value size");

We may as well try to print the buffer here somehow, possibly as
hexadecimal data, since when we fail we will get pretty much random data
. Unfortunately the tst_resm_hexd() is not implemented in the new
library yet.

> +		return;
> +	}

Well we can possibly do goto next; here instead of the return so that we
do not skipp the next test if the first one fails, but I'm fine with
code as it is as well.

> +	if (!strncmp(buf, VALUE2, TEST_RETURN))
> +		tst_res(TPASS, "lgetxattr() get expect value");
> +	else
> +		tst_res(TFAIL, "lgetxattr() got unexpected value");
> +
> +	TEST(lgetxattr("symlink", SECURITY_KEY1, buf, size));
> +
> +	if (TEST_RETURN != -1) {
> +		tst_res(TFAIL, "lgetxattr() succeeded unexpectedly");
> +		return;
> +	}
> +
> +	if (TEST_ERRNO == ENODATA) {
> +		tst_res(TPASS | TTERRNO, "lgetxattr() failed as expected");
> +	} else {
> +		tst_res(TFAIL | TTERRNO,
> +			"lgetxattr() failed unexpectedly,"
> +			"expected %s", tst_strerrno(ENODATA));
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.tid = "lgetxattr01",
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.test_all = verify_lgetxattr,
> +	.setup = setup,
> +};
> +
> +#else
> +	TST_TEST_TCONF("<attr/xattr.h> does not exist.");
> +#endif /* HAVE_ATTR_XATTR_H */

Otherwise this looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
