Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1VW0zQ-0003z4-Et
	for ltp-list@lists.sourceforge.net; Tue, 15 Oct 2013 09:32:32 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VW0zO-0006MJ-0s
	for ltp-list@lists.sourceforge.net; Tue, 15 Oct 2013 09:32:32 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9F9WMY3008798
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Oct 2013 17:32:23 +0800
From: "Wang xiaoguang" <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 15 Oct 2013 17:32:20 +0800
Message-ID: <003e01cec989$73304990$5990dcb0$@cn.fujitsu.com>
MIME-Version: 1.0
Content-Language: zh-cn
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
To: ltp-list@lists.sourceforge.net

Here is the log.

<<<test_start>>>
tag=access06 stime=1381829417
cmdline="access06 -D /dev/loop2 -T ext2"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
access06    0  TINFO  :  Formatting /dev/loop2 with ext2 extra opts=''
mke2fs 1.41.12 (17-May-2010)
access06    1  TPASS  :  access failed as expected: TEST_ERRNO=ENOTDIR(20):
Not a directory
access06    2  TPASS  :  access failed as expected: TEST_ERRNO=???(40): Too
many levels of symbolic links
access06    3  TPASS  :  access failed as expected: TEST_ERRNO=EROFS(30):
Read-only file system
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>

Regards,
Xiaoguang, Wang

> -----Original Message-----
> From: Wang xiaoguang [mailto:wangxg.fnst@cn.fujitsu.com]
> Sent: Tuesday, October 15, 2013 5:18 PM
> To: ltp-list@lists.sourceforge.net
> Subject: [LTP] [PATCH] access/access06.c: add ELOOP, ENOTDIR, EROFS error
> number test for access(2)
> 
> create a case to test ELOOP, ENOTDIR, EROFS error number for access(2)
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  runtest/syscalls                            |    1 +
>  testcases/kernel/syscalls/.gitignore        |    1 +
>  testcases/kernel/syscalls/access/access06.c |  245
> +++++++++++++++++++++++++++
>  3 files changed, 247 insertions(+), 0 deletions(-)  create mode 100644
> testcases/kernel/syscalls/access/access06.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls index 09e5f7f..791de7c
100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -9,6 +9,7 @@ access02 access02
>  access03 access03
>  access04 access04
>  access05 access05
> +access06 access06 -D DEVICE -T DEVICE_FS_TYPE
> 
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
> + *   This program is free software;  you can redistribute it and/or
modify
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
> +static const char mntpoint[] = "mntpoint"; static const char *fs_type =
> +"ext3"; static char *fstype; static char *device; static int tflag;
> +static int dflag; static int mount_flag;
> +
> +static option_t options[] = {
> +	{"T:", &tflag, &fstype},
> +	{"D:", &dflag, &device},
> +	{NULL, NULL, NULL}
> +};
> +
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
> +int TST_TOTAL = sizeof(test_cases) / sizeof(*test_cases); static int
> +exp_enos[] = { ENOTDIR, ELOOP, EROFS, 0 };
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
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s",
> msg);
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
> +}
> +
> +static void setup_file(const char *file, mode_t perms) {
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
> +}
> +
> +/*
> + * setup1() -setup to create two regular files: test_file1 and
> +test_file2  */ static void setup1(void) {
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
> +}
> +
> +/*
> + *setup3() -setup to mount a readonly file system  */ static void
> +setup3(void) {
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
> +	tst_rmdir();
> +}
> +
> +static void help(void)
> +{
> +	printf("-T type	 : specifies the type of filesystem to be mounted."
> +	       " Default ext3.\n");
> +	printf("-D device: device used for mounting.\n"); }
> --
> 1.7.1
> 
> Regards,
> Xiaoguang Wang
> 
> 
> 
>
----------------------------------------------------------------------------
--
> October Webinars: Code for Performance
> Free Intel webinars can help you accelerate application performance.
> Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most
> from the latest Intel processors and coprocessors. See abstracts and
register >
> http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clk
> trk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



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
