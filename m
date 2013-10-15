Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VW3DO-0003Xq-Sa
	for ltp-list@lists.sourceforge.net; Tue, 15 Oct 2013 11:55:06 +0000
Date: Tue, 15 Oct 2013 13:54:53 +0200
From: chrubis@suse.cz
Message-ID: <20131015115452.GA25867@rei>
References: <003c01cec987$79eb1320$6dc13960$@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <003c01cec987$79eb1320$6dc13960$@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] access/access06.c: add ELOOP, ENOTDIR,
 EROFS error number test for access(2)
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
To: Wang xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>  acct01 acct01
>  acct02 acct02
> diff --git a/testcases/kernel/syscalls/.gitignore
> b/testcases/kernel/syscalls/.gitignore
> index ad23c2e..c005111 100644
> --- a/testcases/kernel/syscalls/.gitignore
> +++ b/testcases/kernel/syscalls/.gitignore
> @@ -6,6 +6,7 @@
>  /access/access03
>  /access/access04
>  /access/access05
> +/access/access06
>  /acct/acct01
>  /acct/acct02
>  /add_key/add_key01
> diff --git a/testcases/kernel/syscalls/access/access06.c
> b/testcases/kernel/syscalls/access/access06.c
> new file mode 100644
> index 0000000..c4a6dff
> --- /dev/null
> +++ b/testcases/kernel/syscalls/access/access06.c
> @@ -0,0 +1,245 @@
> +/*
> + *   Copyright (C) 2013 Fujitsu Ltd.
> + *   Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> + *
> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
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

This line overflows 80 chars and in this case to the next line. It would
be better to remove the two more spaces before before the * and the
text blocks, so that the paragraphs fits to 80 chars.

> + */
> +
> +/*
> + * Test Description:
> + *  Verify that,
> + *   1. access() fails with -1 return value and sets errno to ENOTDIR
> + *	if a component used as a directory in pathname is not a directory.
> + *   2. access() fails with -1 return value and sets errno to ELOOP
> + *	if too many symbolic links were encountered in resolving pathname.
> + *   3. access() fails with -1 return value and sets errno to EROFS
> + *	if write permission was requested for a file on a read-only file
> system

Here overflow again, did your mail client wrapped the lines?

> + */
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <sys/mount.h>
> +#include <pwd.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +static void help(void);
> +static void setup1(void);
> +static void setup2(void);
> +static void setup3(void);
> +
> +#define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
> +#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
> +				S_IXGRP|S_IROTH|S_IXOTH)
> +
> +#define TEST_FILE1	"test_file1/test_file2"
> +#define TEST_FILE2	"test_file3"
> +#define TEST_FILE3	"mntpoint"
> +
> +static const char mntpoint[] = "mntpoint";
> +static const char *fs_type = "ext3";

The rest of the tests use ext2 as a default. We should make this
consistent, or configurable (i.e. either to default to ext2 in all test
or even better define default fs in ltp headers or as a configure
paramterer).

> +static char *fstype;
> +static char *device;
> +static int tflag;
> +static int dflag;
> +static int mount_flag;
> +
> +static option_t options[] = {
> +	{"T:", &tflag, &fstype},
> +	{"D:", &dflag, &device},
> +	{NULL, NULL, NULL}
> +};

There is no need to have tflag and two of fstype pointers. See mount01.c
on how to make this simplier.

> +static struct test_case_t {
> +	char *pathname;
> +	int a_mode;
> +	int exp_errno;
> +	void (*setupfunc) (void);
> +} test_cases[] = {
> +	{TEST_FILE1, R_OK, ENOTDIR, setup1},
> +	{TEST_FILE2, R_OK, ELOOP, setup2},
> +	{TEST_FILE3, W_OK, EROFS, setup3}
> +};
> +
> +char *TCID = "access06";
> +int TST_TOTAL = sizeof(test_cases) / sizeof(*test_cases);

There is a LTP_ARRAY_SIZE() macro for this.

> +static int exp_enos[] = { ENOTDIR, ELOOP, EROFS, 0 };
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	char *msg;
> +	char *file_name;
> +	int access_mode;
> +	int i;
> +
> +	msg = parse_opts(ac, av, options, help);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	/* Check for mandatory option of the testcase */
> +	if (!dflag)
> +		tst_brkm(TBROK, NULL, "you must specify the device used "
> +			 "for mounting with -D option");
> +	if (tflag)
> +		fs_type = fstype;
> +
> +	setup();
> +
> +	TEST_EXP_ENOS(exp_enos);
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; i++) {
> +			file_name = test_cases[i].pathname;
> +			access_mode = test_cases[i].a_mode;
> +
> +			/*
> +			 * Call access(2) to test different test conditions.
> +			 * verify that it fails with -1 return value and
> +			 * sets appropriate errno.
> +			 */

This comment is useless, please remove it.

> +			TEST(access(file_name, access_mode));
> +
> +			if (TEST_RETURN != -1) {
> +				tst_resm(TFAIL, "access(%s, %#o)"
> +					 "succeeded unexpectedly",
> +					 file_name, access_mode);
> +				continue;
> +			}
> +
> +			if (TEST_ERRNO == test_cases[i].exp_errno)
> +				tst_resm(TPASS | TTERRNO,
> +					 "access failed as expected");
> +			else
> +				tst_resm(TFAIL | TTERRNO,
> +					 "access failed unexpectedly;"
> +					 "expected: %d - %s",
> +					 test_cases[i].exp_errno,
> +					 strerror(test_cases[i].exp_errno));

LKML coding style (as well as LTP) prefers curly braces around code that
spawns around multiple lines, even when it's a single function call.

And moving the innter part to a test() function would help too (you are
too deep in the indentation here because of the for loops).

> +		}
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	int i;
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	tst_require_root(NULL);
> +
> +	tst_mkfs(NULL, device, fstype, NULL);
> +
> +	tst_tmpdir();
> +
> +	SAFE_MKDIR(cleanup, mntpoint, DIR_MODE);
> +
> +	TEST_PAUSE;
> +
> +	for (i = 0; i < TST_TOTAL; i++)
> +		if (test_cases[i].setupfunc != NULL)
> +			test_cases[i].setupfunc();

Given that the setup for each test is done only once I would just write
the code to prepare all the tests here. There is no point in storing the
pointer to individual setup functions if they are called only once from
global setup.

> +}
> +
> +static void setup_file(const char *file, mode_t perms)
> +{
> +	int fd = open(file, O_RDWR | O_CREAT, FILE_MODE);
> +
> +	if (fd == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
> +			 file, FILE_MODE);
> +
> +	if (fchmod(fd, perms) < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "fchmod(%s, %#o) failed", file, perms);
> +	if (close(fd) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "close(%s) failed", file);

Is there any reason why the perms couldn't be passed to the open()
instread of doing open and then fchmod?

> +}
> +
> +/*
> + * setup1() -setup to create two regular files: test_file1 and test_file2
> + */
> +static void setup1(void)
> +{
> +	setup_file("test_file1", 0644);
> +	setup_file("test_file2", 0644);
> +}
> +
> +/*
> + *setup2() -setup to create two symbolic links who point to each other.
> + */
> +static void setup2(void)
> +{
> +	if (mkdir("dir1", 0755) < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "create temporary directory dir1 failed");
> +	if (symlink("dir1/test_file3", "test_file3") < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "create symbolink test_file3 to "
> +			 "dir1/test_file3 failed");
> +	if (symlink("../test_file3", "dir1/test_file3") < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "create symbolink test_file3 in dir1 to "
> +			 "../test_file3 failed");

If I'm not mistaken you don't have to create the directory, just symlink
a to b and b to a should do.

Also please make use of safe_macros.h, it will simplify the code
greatly.

> +}
> +
> +/*
> + *setup3() -setup to mount a readonly file system
> + */
> +static void setup3(void)
> +{
> +	if (mount(device, mntpoint, fs_type, MS_RDONLY, NULL) < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "mount device:%s failed", device);
> +	mount_flag = 1;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +
> +	if (mount_flag && umount(mntpoint) < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "umount device:%s failed", device);
> +	mount_flag = 0;

I guess that you don't have to set the flag to zero here, cleanup is
called only once and that is done before the test exits...

> +	tst_rmdir();
> +}
> +
> +static void help(void)
> +{
> +	printf("-T type	 : specifies the type of filesystem to be mounted."
> +	       " Default ext3.\n");
> +	printf("-D device: device used for mounting.\n");
> +}

Also looking at the access testcases, there is allready access05 to test
access failures, I wonder if it would be better to move the ENOTDIR and
ELOOP tests there (after it's cleaned up a bit). But I'm not sure about
this myself...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
