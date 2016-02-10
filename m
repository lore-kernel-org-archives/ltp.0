From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Feb 2016 15:12:19 +0100
Subject: [LTP] [PATCH 3/3] llistxattr/llistxattr03.c: add new testcase
In-Reply-To: <1454058489-25625-3-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1454058489-25625-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1454058489-25625-3-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160210141219.GA12894@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr03.c b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
> new file mode 100644
> index 0000000..dd5ab52
> --- /dev/null
> +++ b/testcases/kernel/syscalls/llistxattr/llistxattr03.c
> @@ -0,0 +1,133 @@
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
> +* Test Name: llistxattr03
> +*
> +* Description:
> +* llistxattr(2) with an empty buffer of size zero can return
> +* the current size of the list of extended attribute names.
> +*/
> +
> +#include "config.h"
> +#include <errno.h>
> +#include <sys/types.h>
> +
> +#ifdef HAVE_ATTR_XATTR_H
> +#include <attr/xattr.h>
> +#endif
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "safe_file_ops.h"
> +
> +char *TCID = "llistxattr03";
> +
> +#ifdef HAVE_ATTR_XATTR_H
> +#define SECURITY_KEY	"security.symtest"
> +#define SECURITY_KEY_INIT	"security.selinux"
> +#define VALUE	"test"
> +#define VALUE_SIZE	4
> +#define KEY_SIZE	17
> +
> +static void verify_llistxattr(void);
> +static void setup(void);
> +static void cleanup(void);
> +
> +int TST_TOTAL = 1;
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
> +		tst_count = 0;
> +
> +		verify_llistxattr();
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void verify_llistxattr(void)
> +{
> +	int se = 1;
> +	int n;
> +
> +	/* check selinux initialized attr */
> +	n = lgetxattr("symlink", SECURITY_KEY_INIT, NULL, 0);
> +	if (n == -1) {
> +		if (errno == ENOATTR) {
> +			se = 0;
> +		} else {
> +			tst_brkm(TFAIL | TERRNO, cleanup,
> +				 "lgetxattr() failed");
> +		}
> +	}
> +
> +	TEST(llistxattr("symlink", NULL, 0));
> +	if (TEST_RETURN == -1) {
> +		tst_resm(TFAIL | TTERRNO, "llistxattr() failed");
> +		return;
> +	}
> +
> +	if (TEST_RETURN == KEY_SIZE*(1 + se))
> +		tst_resm(TPASS, "llistxattr() returned the size successfully");
> +	else
> +		tst_resm(TFAIL, "llistxattr() failed to return the size");

Hmm, why don't we just call llistxattr() with zero size and then check
that it succeds with allocated buffer of a size of the return value and
fails for a buffer that is one byte smaller?

There is no need for special cases like this.

> +}
> +
> +static void setup(void)
> +{
> +	int n;
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	SAFE_TOUCH(cleanup, "testfile", 0644, NULL);
> +
> +	SAFE_SYMLINK(cleanup, "testfile", "symlink");
> +
> +	n = lsetxattr("symlink", SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);

Why the symlink here? I understand that in the first test you want to
make sure that the atrribute from symlink is read. (you should probably
add some attributes for the file there, and maybe try with broken
symlink as well)

But here you just check that it returns a size for a suitable buffer.

> +	if (n == -1) {
> +		if (errno == ENOTSUP) {
> +			tst_brkm(TCONF, cleanup, "no xattr support in fs or "
> +				 "mounted without user_xattr option");
> +		} else {
> +			tst_brkm(TFAIL | TERRNO, cleanup, "lsetxattr() failed");
> +		}
> +	}
> +}

-- 
Cyril Hrubis
chrubis@suse.cz
