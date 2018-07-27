From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 27 Jul 2018 11:47:03 +0200
Subject: [LTP] [PATCH] syscalls/execveat01: new test to verify execveat
 unlinked fd
In-Reply-To: <1532678306.28611.1.camel@mtkswgap22>
References: <1532678306.28611.1.camel@mtkswgap22>
Message-ID: <20180727094703.GB914@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/execveat/.gitignore
> b/testcases/kernel/syscalls/execveat/.gitignore
> new file mode 100644
> index 000000000..c0d418603
> --- /dev/null
> +++ b/testcases/kernel/syscalls/execveat/.gitignore
> @@ -0,0 +1,2 @@
> +/execveat01
> +/execveat_child
> diff --git a/testcases/kernel/syscalls/execveat/Makefile
> b/testcases/kernel/syscalls/execveat/Makefile
> new file mode 100644
> index 000000000..0bab6dc83
> --- /dev/null
> +++ b/testcases/kernel/syscalls/execveat/Makefile
> @@ -0,0 +1,23 @@
> +#
> +#  Copyright (C) 2018 MediaTek Inc.  All Rights Reserved.
> +#
> +#  This program is free software;  you can redistribute it and/or
> modify

First of all it looks like evolution line wrapped the patch, you should
turn off that for attachements.

See:

https://www.kernel.org/doc/html/v4.10/process/email-clients.html

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
> +#  along with this program;  if not, write to the Free Software
> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> 02110-1301  USA
> +#
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/execveat/execveat.h
> b/testcases/kernel/syscalls/execveat/execveat.h
> new file mode 100644
> index 000000000..e87974d9c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/execveat/execveat.h
> @@ -0,0 +1,42 @@
> +/*
> + * Copyright (C) 2018 MediaTek Inc.  All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> it
> + * under the terms of version 2 or any later of the GNU General Public
> License
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> is
> + * free of the rightful claim of any third person regarding
> infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program
> with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + */
> +
> +#ifndef EXECVEAT_H
> +#define EXECVEAT_H
> +
> +#include <sys/types.h>
> +#include "config.h"
> +#include "lapi/syscalls.h"
> +
> +#if !defined(HAVE_EXECVEAT)
> +int execveat(int dirfd, const char *pathname,
> +             char *const argv[], char *const envp[],
> +             int flags)
> +{
> +	return tst_syscall(__NR_execveat, dirfd, pathname, argv, envp, flags);
> +}
> +#endif
> +
> +
> +#endif /* EXECVEAT_H */
> \ No newline at end of file
> diff --git a/testcases/kernel/syscalls/execveat/execveat01.c
> b/testcases/kernel/syscalls/execveat/execveat01.c
> new file mode 100644
> index 000000000..fec675fad
> --- /dev/null
> +++ b/testcases/kernel/syscalls/execveat/execveat01.c
> @@ -0,0 +1,142 @@
> +/*
> + * Copyright (C) 2018 MediaTek Inc.  All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> it
> + * under the terms of version 2 or any later of the GNU General Public
> License
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> is
> + * free of the rightful claim of any third person regarding
> infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program
> with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + * Started by Eddie Horng <eddie.horng@mediatek.com>
> + *
> + * DESCRIPTION
> + *     Check if an unlinked executable can run in overlayfs mount.
> + *     The regression is introduced from 8db6c34f1dbc ("Introduce v3 
> + *     namespaced file capabilities"). in security/commoncap.c, 
> + *     cap_inode_getsecurity() use d_find_alias() cause unhashed
> dentry 
> + *     can't be found. The solution could use d_find_any_alias()
> instead of 
> + *     d_find_alias().
> + *
> + *     From kernel 4.14, this case is expected fails, execveat shell
> + *     return EINVAL.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include "config.h"
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <sys/syscall.h>
> +#include <sys/mount.h>
> +#include <fcntl.h>
> +#include "tst_test.h"
> +#include "execveat.h"
> +
> +#define OVL_MNT "ovl"
> +#define TEST_APP "execveat_child"
> +#define TEST_FILE_PATH OVL_MNT"/"TEST_APP
> +
> +static int ovl_mounted;
> +
> +static void do_child(void)
> +{
> +	
> +	char path[PATH_MAX];
> +	char *argv[2] = {TEST_APP, NULL};
> +	int fd;
> +
> +	if (tst_get_path(TEST_APP, path, sizeof(path))) {
> +		tst_brk(TBROK | TERRNO, 
> +		         "Couldn't found "TEST_APP" binary in $PATH");
> +	}
> +	SAFE_CP(path, TEST_FILE_PATH);

We do have a better API for this, have a look at creat07.c

> +	fd = SAFE_OPEN(TEST_FILE_PATH, O_PATH);
> +	SAFE_UNLINK(TEST_FILE_PATH);
> +
> +	argv[0] = TEST_FILE_PATH;
> +	TEST(execveat(fd, "", argv, NULL, AT_EMPTY_PATH));
> +	if (TEST_ERRNO == ENOSYS) {
> +		tst_brk(TCONF,
> +			"execveat is not supported in this kernel.");
> +	}

I suppose that we should handle EINVAL here, I think that we will get
EINVAL rather than ENOSYS when kernel will not recognize __NR_execveat

> +	else if (TEST_RETURN) {
> +		tst_res(TFAIL | TERRNO, 
> +			    "execveat() returned unexpected errno");
> +		close(fd);	
> +		exit(1);

No need for the else branch here, since tst_brk() exits the test
execution.

Also there is no need to propagate the result with the exit value, the
tst_res() already did that for you.

> +	}
> +}

There are several trailing whitespaces and style violations here,
you can check for these with checkpatch.pl that is part of the linux
kernel source tree.

> +static void verify_execveat(void)
> +{
> +	pid_t pid;
> +	int status;
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		do_child();	
> +	}
> +	else {
> +		SAFE_WAITPID(pid, &status, 0);
> +		if (status == 0)
> +			tst_res(TPASS, "execveat() can run an unlinked executable");
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	int ret;
> +
> +	/* Setup an overlay mount with lower file */
> +	SAFE_MKDIR("lower", 0755);
> +	SAFE_MKDIR("upper", 0755);
> +	SAFE_MKDIR("work", 0755);
> +	SAFE_MKDIR(OVL_MNT, 0755);
> +	ret = mount("overlay", OVL_MNT, "overlay", 0,
> +		    "lowerdir=lower,upperdir=upper,workdir=work");
> +	if (ret < 0) {
> +		if (errno == ENODEV) {
> +			tst_brk(TCONF,
> +				"overlayfs is not configured in this kernel.");
> +		} else {
> +			tst_brk(TBROK | TERRNO,
> +				"overlayfs mount failed");
> +		}

here as well no need for the else branch after the tst_brk();

> +	}
> +	ovl_mounted = 1;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (ovl_mounted)
> +		SAFE_UMOUNT(OVL_MNT);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_execveat,
> +};
> +
> diff --git a/testcases/kernel/syscalls/execveat/execveat_child.c
> b/testcases/kernel/syscalls/execveat/execveat_child.c
> new file mode 100644
> index 000000000..b2611dc9b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/execveat/execveat_child.c
> @@ -0,0 +1,32 @@
> +/*
> + *
> + *   Copyright (C) 2018 MediaTek Inc.  All Rights Reserved.
> + *
> + *   This program is free software;  you can redistribute it and/or
> modify
> + *   it under the terms of the GNU General Public License as published
> by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program;  if not, write to the Free Software
> + *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA
> + */
> +
> +/*
> + * execveat_child.c
> + *	dummy program which is used by execveat01.c testcase
> + */
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +
> +int main(void)
> +{
> +	printf("Hello World\n");
> +	exit(0);

You can print the TPASS message from here and the result will be
propagated to the parent program. You just need to call tst_reinit()
that will initialize the test library. See creat07_child.c.

> +}
> -- 
> 2.12.5
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
