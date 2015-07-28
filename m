Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fenggw-fnst@cn.fujitsu.com>) id 1ZJwEx-0002qI-1v
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2015 04:11:43 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZJwEu-0003nn-Vv
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2015 04:11:43 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6S49hh7026477
	for <ltp-list@lists.sourceforge.net>; Tue, 28 Jul 2015 12:09:43 +0800
Message-ID: <55B70134.8030606@cn.fujitsu.com>
Date: Tue, 28 Jul 2015 12:12:36 +0800
From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1438054693-5822-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
	<55B6FD02.2050009@cn.fujitsu.com>
In-Reply-To: <55B6FD02.2050009@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] rename readdir21.c -> readdir03.c
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

Hello,

I just understood it is unnecessary to rename readdir(), please ignore this patch.
Sorry for my neglect.

Best Regards,
Guangwen Feng

On 2015/07/28 11:54, Guangwen Feng wrote:
> Sorry! I forgot something in the patch, please ignore this one, I will email a V2.
> 
> Best Regards,
> Guangwen Feng
> 
> On 2015/07/28 11:38, Guangwen Feng wrote:
>> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
>> ---
>>  testcases/kernel/syscalls/readdir/readdir03.c | 150 ++++++++++++++++++++++++++
>>  testcases/kernel/syscalls/readdir/readdir21.c | 150 --------------------------
>>  2 files changed, 150 insertions(+), 150 deletions(-)
>>  create mode 100644 testcases/kernel/syscalls/readdir/readdir03.c
>>  delete mode 100644 testcases/kernel/syscalls/readdir/readdir21.c
>>
>> diff --git a/testcases/kernel/syscalls/readdir/readdir03.c b/testcases/kernel/syscalls/readdir/readdir03.c
>> new file mode 100644
>> index 0000000..ced8fa7
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/readdir/readdir03.c
>> @@ -0,0 +1,150 @@
>> +/*
>> + * Copyright (c) 2014 Fujitsu Ltd.
>> + * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of version 2 of the GNU General Public License as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it would be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, write the Free Software Foundation, Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + */
>> +/*
>> + * Test Description:
>> + *  Verify that,
>> + *   1. Creat a directory and open it, then delete the directory, ENOENT would
>> + *	return.
>> + *   2. File descriptor does not refer to a directory, ENOTDIR would return.
>> + *   3. Invalid file descriptor fd, EBADF would return.
>> + *   4. Argument points outside the calling process's address space, EFAULT
>> + *	would return.
>> + *
>> + *  PS:
>> + *   This file is for readdir(2) and the other files(readdir01.c and
>> + *   readdir02.c) are for readdir(3).
>> + */
>> +
>> +#define _GNU_SOURCE
>> +
>> +#include <stdio.h>
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +#include <fcntl.h>
>> +#include <errno.h>
>> +#include <unistd.h>
>> +#include <sys/mman.h>
>> +#include "test.h"
>> +#include "safe_macros.h"
>> +#include "linux_syscall_numbers.h"
>> +#include "lapi/readdir.h"
>> +
>> +char *TCID = "readdir21";
>> +
>> +#define TEST_DIR	"test_dir"
>> +#define TEST_DIR4	"test_dir4"
>> +#define TEST_FILE	"test_file"
>> +#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
>> +			 S_IXGRP|S_IROTH|S_IXOTH)
>> +
>> +static unsigned int del_dir_fd, file_fd;
>> +static unsigned int invalid_fd = 999;
>> +static unsigned int dir_fd;
>> +static struct old_linux_dirent dirp;
>> +static void setup(void);
>> +static void cleanup(void);
>> +
>> +static struct test_case_t {
>> +	unsigned int *fd;
>> +	struct old_linux_dirent *dirp;
>> +	unsigned int count;
>> +	int exp_errno;
>> +} test_cases[] = {
>> +	{&del_dir_fd, &dirp, sizeof(struct old_linux_dirent), ENOENT},
>> +	{&file_fd, &dirp, sizeof(struct old_linux_dirent), ENOTDIR},
>> +	{&invalid_fd, &dirp, sizeof(struct old_linux_dirent), EBADF},
>> +#if !defined(UCLINUX)
>> +	{&dir_fd, (struct old_linux_dirent *)-1,
>> +	 sizeof(struct old_linux_dirent), EFAULT},
>> +#endif
>> +};
>> +
>> +int TST_TOTAL = ARRAY_SIZE(test_cases);
>> +static void readdir_verify(const struct test_case_t *);
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	int i, lc;
>> +
>> +	tst_parse_opts(argc, argv, NULL, NULL);
>> +
>> +	setup();
>> +
>> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> +		tst_count = 0;
>> +		for (i = 0; i < TST_TOTAL; i++)
>> +			readdir_verify(&test_cases[i]);
>> +	}
>> +
>> +	cleanup();
>> +	tst_exit();
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> +
>> +	TEST_PAUSE;
>> +
>> +	tst_tmpdir();
>> +
>> +	SAFE_MKDIR(cleanup, TEST_DIR, DIR_MODE);
>> +	del_dir_fd = SAFE_OPEN(cleanup, TEST_DIR, O_RDONLY | O_DIRECTORY);
>> +	SAFE_RMDIR(cleanup, TEST_DIR);
>> +
>> +	file_fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0777);
>> +
>> +	SAFE_MKDIR(cleanup, TEST_DIR4, DIR_MODE);
>> +	dir_fd = SAFE_OPEN(cleanup, TEST_DIR4, O_RDONLY | O_DIRECTORY);
>> +
>> +#if !defined(UCLINUX)
>> +	test_cases[3].dirp = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
>> +				       MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>> +#endif
>> +}
>> +
>> +static void readdir_verify(const struct test_case_t *test)
>> +{
>> +	TEST(ltp_syscall(__NR_readdir, *test->fd, test->dirp, test->count));
>> +
>> +	if (TEST_RETURN != -1) {
>> +		tst_resm(TFAIL, "readdir() succeeded unexpectedly");
>> +		return;
>> +	}
>> +
>> +	if (TEST_ERRNO == test->exp_errno) {
>> +		tst_resm(TPASS | TTERRNO, "readdir() failed as expected");
>> +	} else {
>> +		tst_resm(TFAIL | TTERRNO,
>> +			 "readdir() failed unexpectedly; expected: %d - %s",
>> +			 test->exp_errno, strerror(test->exp_errno));
>> +	}
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (dir_fd > 0)
>> +		close(dir_fd);
>> +
>> +	if (del_dir_fd > 0)
>> +		close(del_dir_fd);
>> +
>> +	if (file_fd > 0)
>> +		close(file_fd);
>> +
>> +	tst_rmdir();
>> +}
>> diff --git a/testcases/kernel/syscalls/readdir/readdir21.c b/testcases/kernel/syscalls/readdir/readdir21.c
>> deleted file mode 100644
>> index ced8fa7..0000000
>> --- a/testcases/kernel/syscalls/readdir/readdir21.c
>> +++ /dev/null
>> @@ -1,150 +0,0 @@
>> -/*
>> - * Copyright (c) 2014 Fujitsu Ltd.
>> - * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
>> - *
>> - * This program is free software; you can redistribute it and/or modify it
>> - * under the terms of version 2 of the GNU General Public License as
>> - * published by the Free Software Foundation.
>> - *
>> - * This program is distributed in the hope that it would be useful, but
>> - * WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> - *
>> - * You should have received a copy of the GNU General Public License along
>> - * with this program; if not, write the Free Software Foundation, Inc.,
>> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> - */
>> -/*
>> - * Test Description:
>> - *  Verify that,
>> - *   1. Creat a directory and open it, then delete the directory, ENOENT would
>> - *	return.
>> - *   2. File descriptor does not refer to a directory, ENOTDIR would return.
>> - *   3. Invalid file descriptor fd, EBADF would return.
>> - *   4. Argument points outside the calling process's address space, EFAULT
>> - *	would return.
>> - *
>> - *  PS:
>> - *   This file is for readdir(2) and the other files(readdir01.c and
>> - *   readdir02.c) are for readdir(3).
>> - */
>> -
>> -#define _GNU_SOURCE
>> -
>> -#include <stdio.h>
>> -#include <sys/types.h>
>> -#include <sys/stat.h>
>> -#include <fcntl.h>
>> -#include <errno.h>
>> -#include <unistd.h>
>> -#include <sys/mman.h>
>> -#include "test.h"
>> -#include "safe_macros.h"
>> -#include "linux_syscall_numbers.h"
>> -#include "lapi/readdir.h"
>> -
>> -char *TCID = "readdir21";
>> -
>> -#define TEST_DIR	"test_dir"
>> -#define TEST_DIR4	"test_dir4"
>> -#define TEST_FILE	"test_file"
>> -#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
>> -			 S_IXGRP|S_IROTH|S_IXOTH)
>> -
>> -static unsigned int del_dir_fd, file_fd;
>> -static unsigned int invalid_fd = 999;
>> -static unsigned int dir_fd;
>> -static struct old_linux_dirent dirp;
>> -static void setup(void);
>> -static void cleanup(void);
>> -
>> -static struct test_case_t {
>> -	unsigned int *fd;
>> -	struct old_linux_dirent *dirp;
>> -	unsigned int count;
>> -	int exp_errno;
>> -} test_cases[] = {
>> -	{&del_dir_fd, &dirp, sizeof(struct old_linux_dirent), ENOENT},
>> -	{&file_fd, &dirp, sizeof(struct old_linux_dirent), ENOTDIR},
>> -	{&invalid_fd, &dirp, sizeof(struct old_linux_dirent), EBADF},
>> -#if !defined(UCLINUX)
>> -	{&dir_fd, (struct old_linux_dirent *)-1,
>> -	 sizeof(struct old_linux_dirent), EFAULT},
>> -#endif
>> -};
>> -
>> -int TST_TOTAL = ARRAY_SIZE(test_cases);
>> -static void readdir_verify(const struct test_case_t *);
>> -
>> -int main(int argc, char **argv)
>> -{
>> -	int i, lc;
>> -
>> -	tst_parse_opts(argc, argv, NULL, NULL);
>> -
>> -	setup();
>> -
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -		tst_count = 0;
>> -		for (i = 0; i < TST_TOTAL; i++)
>> -			readdir_verify(&test_cases[i]);
>> -	}
>> -
>> -	cleanup();
>> -	tst_exit();
>> -}
>> -
>> -static void setup(void)
>> -{
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> -
>> -	TEST_PAUSE;
>> -
>> -	tst_tmpdir();
>> -
>> -	SAFE_MKDIR(cleanup, TEST_DIR, DIR_MODE);
>> -	del_dir_fd = SAFE_OPEN(cleanup, TEST_DIR, O_RDONLY | O_DIRECTORY);
>> -	SAFE_RMDIR(cleanup, TEST_DIR);
>> -
>> -	file_fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0777);
>> -
>> -	SAFE_MKDIR(cleanup, TEST_DIR4, DIR_MODE);
>> -	dir_fd = SAFE_OPEN(cleanup, TEST_DIR4, O_RDONLY | O_DIRECTORY);
>> -
>> -#if !defined(UCLINUX)
>> -	test_cases[3].dirp = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
>> -				       MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>> -#endif
>> -}
>> -
>> -static void readdir_verify(const struct test_case_t *test)
>> -{
>> -	TEST(ltp_syscall(__NR_readdir, *test->fd, test->dirp, test->count));
>> -
>> -	if (TEST_RETURN != -1) {
>> -		tst_resm(TFAIL, "readdir() succeeded unexpectedly");
>> -		return;
>> -	}
>> -
>> -	if (TEST_ERRNO == test->exp_errno) {
>> -		tst_resm(TPASS | TTERRNO, "readdir() failed as expected");
>> -	} else {
>> -		tst_resm(TFAIL | TTERRNO,
>> -			 "readdir() failed unexpectedly; expected: %d - %s",
>> -			 test->exp_errno, strerror(test->exp_errno));
>> -	}
>> -}
>> -
>> -static void cleanup(void)
>> -{
>> -	if (dir_fd > 0)
>> -		close(dir_fd);
>> -
>> -	if (del_dir_fd > 0)
>> -		close(del_dir_fd);
>> -
>> -	if (file_fd > 0)
>> -		close(file_fd);
>> -
>> -	tst_rmdir();
>> -}
>>
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> .
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
