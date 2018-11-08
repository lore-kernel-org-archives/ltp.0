From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Nov 2018 15:22:43 +0100
Subject: [LTP] [PATCH v3] Testing statx syscall Timestamp fields
In-Reply-To: <20181008135416.31833-1-subash@zilogic.com>
References: <20181008135416.31833-1-subash@zilogic.com>
Message-ID: <20181108142242.GA28258@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The time before and after the execution of the corresponding
> system call is noted.
> 
> It is checked whether the time returned by statx lies in this range.
> 
> open syscall with O_CREAT flag for birth time.
> write syscall for modified time.
> read syscall for access time.
> chmod syscall for status change time.
> 
> Signed-off-by: Subash <subash@zilogic.com>
> Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
> ---
>  include/safe_macros_fn.h                   |   4 +
>  include/tst_safe_macros.h                  |   5 +
>  lib/safe_macros.c                          |  23 ++++
>  runtest/syscalls                           |   1 +
>  testcases/kernel/syscalls/statx/.gitignore |   1 +
>  testcases/kernel/syscalls/statx/statx06.c  | 168 +++++++++++++++++++++++++++++
>  6 files changed, 202 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/statx/statx06.c
> 
> diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
> index 3df952811..f66c5e5a9 100644
> --- a/include/safe_macros_fn.h
> +++ b/include/safe_macros_fn.h
> @@ -183,5 +183,9 @@ struct dirent *safe_readdir(const char *file, const int lineno,
>  int safe_closedir(const char *file, const int lineno,
>                    void (cleanup_fn)(void),
>                    DIR *dirp);
> +void safe_clock_getres(const char *file, const int lineno,
> +		       clockid_t clk_id, struct timespec *res);
>  
> +void safe_clock_gettime(const char *file, const int lineno,
> +			clockid_t clk_id, struct timespec *tp);
>  #endif /* SAFE_MACROS_FN_H__ */
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 413226eaf..e2d0e6419 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -516,5 +516,10 @@ int safe_personality(const char *filename, unsigned int lineno,
>  			name, value, overwrite);		\
>  	}							\
>  	} while (0)
> +#define SAFE_CLOCK_GETRES(clk_id, res)\
> +	safe_clock_getres(__FILE__, __LINE__, (clk_id), (res))
> +
> +#define SAFE_CLOCK_GETTIME(clk_id, tp)\
> +	safe_clock_gettime(__FILE__, __LINE__, (clk_id), (tp))
>  
>  #endif /* SAFE_MACROS_H__ */
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index bac34cdb7..b94e17270 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -1076,3 +1076,26 @@ int safe_mincore(const char *file, const int lineno, void *start,
>  
>  	return rval;
>  }
> +
> +void safe_clock_getres(const char *file, const int lineno,
> +	clockid_t clk_id, struct timespec *res)
> +{
> +	int rval;
> +
> +	rval = clock_getres(clk_id, res);
> +	if (rval == -1)
> +		tst_brkm(TBROK | TERRNO, NULL,
> +			"%s:%d:, clock_getres() failed", file, lineno);
> +
> +}
> +
> +void safe_clock_gettime(const char *file, const int lineno,
> +	clockid_t clk_id, struct timespec *tp)
> +{
> +	int rval;
> +
> +	rval = clock_gettime(clk_id, tp);
> +	if (rval == -1)
> +		tst_brkm(TBROK | TERRNO, NULL, 
> +			"%s:%d:, clock_gettime() failed", file, lineno);
> +}

There is a reason why clock_* functions are not in safe macros like
this, on some distributions these needs to be linked with -lrt.

What we can do is to introduce tst_safe_clocks.h header and put the
functions there as a static inline, see tst_safe_macros.h, there are
some static inline functions there (for a different reasons). If that is
done we can include the header only in tests that would use the safe
clocks.

And you have to add the linker flags:

statx06: LDLIBS += -lrt

to the Makefile.

> diff --git a/runtest/syscalls b/runtest/syscalls
> index 53a4a427e..1f76cd9de 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1514,3 +1514,4 @@ statx02 statx02
>  statx03 statx03
>  statx04 statx04
>  statx05 statx05
> +statx06 statx06
> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
> index 209fc3a33..c129d99e9 100644
> --- a/testcases/kernel/syscalls/statx/.gitignore
> +++ b/testcases/kernel/syscalls/statx/.gitignore
> @@ -3,3 +3,4 @@
>  /statx03
>  /statx04
>  /statx05
> +/statx06
> \ No newline at end of file

Please make sure there are newlines at the end of the files, otherwise
next patch that will add lines to these files will end up to be
unnecessary ugly.

> diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
> new file mode 100644
> index 000000000..6b11ae927
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/statx06.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0 or later
> +/*
> + *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
> + *  Email : code@zilogic.com
> + */
> +
> +/*
> + * DESCRIPTION :
> + *
> + * Test-Case 1 : Testing btime
> + * flow :       The time before and after the execution of the create
> + *              system call is noted.
> + *		It is checked whether the birth time returned by statx lies in
> + *              this range.
> + *
> + * Test-Case 2 : Testing mtime
> + * flow :       The time before and after the execution of the write
> + *              system call is noted.
> + *              It is checked whether the modification time returned
> + *              by statx lies in this range.
> + *
> + * Test-Case 3 : Testing atime
> + * flow :       The time before and after the execution of the read
> + *              system call is noted.
> + *              It is checked whether the access time returned by statx lies in
> + *              this range.
> + *
> + * Test-Case 4 : Testing ctime
> + * flow :	The time before and after the execution of the chmod
> + *              system call is noted.
> + *              It is checked whether the status change time returned by statx
> + *              lies in this range.
> + *
> + */
> +
> +#include <stdio.h>
> +#include "tst_test.h"
> +#include "lapi/stat.h"
> +#include "tst_safe_macros.h"
> +#include "tst_timer.h"
> +#include <sys/mount.h>
> +#include <time.h>
> +
> +#define MOUNT_POINT "mount_ext"
> +#define TEST_FILE MOUNT_POINT"/test_file.txt"
> +#define SIZE 2
> +
> +static int test_file_fd;

We can call this just fd, it's not like we do have any other file
descriptor in this source code anyways.

> +static void statx_timestamp_to_timespec(const struct statx_timestamp *timestamp,
> +				 struct timespec *timespec)

Given that this is a local functions, I would have given it a shorter
name, maybe just timestamp_to_timespec()

> +{
> +	timespec->tv_sec = timestamp->tv_sec;
> +	timespec->tv_nsec = timestamp->tv_nsec;
> +}
> +
> +static void clock_wait_tick(void)
> +{
> +	struct timespec res;
> +	unsigned int usecs;
> +
> +	SAFE_CLOCK_GETRES(CLOCK_REALTIME_COARSE, &res);
> +	usecs = ((res.tv_sec * 1000000) + (res.tv_nsec / 1000)) * 1.5;

We do have tst_timespec_to_us() exactly for this purpose in the test
library, see include/tst_timers.h.

> +	usleep(usecs);
> +}
> +
> +static void create_file(void)
> +{

To make this test work for the -i flag (test runs several iterations) we
have to check if the file have been opened already and if so close and
unlink it here. So we have to do:

	if (fd > 0) {
		SAFE_CLOSE(fd);
		SAFE_UNLINK(TEST_FILE);
	}

> +	test_file_fd = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR, 0666);
> +}
> +
> +static void write_file(void)
> +{
> +	char data[SIZE] = "hi";
> +
> +	SAFE_WRITE(0, test_file_fd, data, sizeof(data));
> +}
> +
> +static void read_file(void)
> +{
> +	char data[SIZE];
> +
> +	SAFE_READ(0, test_file_fd, data, sizeof(data));
> +}
> +
> +static void change_mode(void)
> +{
> +	SAFE_CHMOD(TEST_FILE, 0777);
> +}
> +
> +static struct test_case {
> +	void (*operation)(void);
> +	char *op_name;
> +} tcases[] = {
> +	{.operation = create_file,
> +	 .op_name = "Birth time"},
> +	{.operation = write_file,
> +	 .op_name = "Modified time"},
> +	{.operation = read_file,
> +	 .op_name = "Access time"},
> +	{.operation = change_mode,
> +	 .op_name = "Change time"}
> +};
> +
> +static void test_statx(unsigned int test_nr)
> +{
> +	struct statx buff;
> +	struct timespec before_time;
> +	struct timespec after_time;
> +	struct timespec statx_time = {0, 0};
> +
> +	struct test_case *tc = &tcases[test_nr];
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &before_time);
> +	clock_wait_tick();
> +	tc->operation();
> +	clock_wait_tick();
> +	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);
> +
> +	TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_ALL, &buff));
> +	if (TST_RET != 0)
> +		tst_brk(TFAIL | TTERRNO,
> +			"statx(AT_FDCWD, %s, 0, STATX_ALL, &buff)",
> +			TEST_FILE);
> +
> +	switch (test_nr) {
> +	case 0:
> +		statx_timestamp_to_timespec(&buff.stx_btime, &statx_time);
> +		break;
> +	case 1:
> +		statx_timestamp_to_timespec(&buff.stx_mtime, &statx_time);
> +		break;
> +	case 2:
> +		statx_timestamp_to_timespec(&buff.stx_atime, &statx_time);
> +		break;
> +	case 3:
> +		statx_timestamp_to_timespec(&buff.stx_ctime, &statx_time);
> +		break;
> +	}
> +	if (tst_timespec_lt(statx_time, before_time))
> +		tst_res(TFAIL, "%s < before time", tc->op_name);
> +	else if (tst_timespec_lt(after_time, statx_time))
> +		tst_res(TFAIL, "%s > after_time", tc->op_name);
> +	else
> +		tst_res(TPASS, "%s Passed\n", tc->op_name);
> +}
> +
> +
> +static void cleanup(void)
> +{
> +	SAFE_CLOSE(test_file_fd);

This should be:

	if (fd > 0)
		SAFE_CLOSE(fd);

Just in case that the callback will be called before we happened to open
the file.

> +	SAFE_UNLINK(TEST_FILE);

No need to unlink the test file here, the test library will do the clean
up.

> +}
> +
> +static struct tst_test test = {
> +	.cleanup = cleanup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = test_statx,
> +	.min_kver = "4.11",
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.mntpoint = MOUNT_POINT,
> +	.mount_device = 1,
> +	.dev_fs_type = "ext4",
> +	.dev_min_size = 512,

Why do wee need minimal size for the fs here?

> +	.mnt_flags = MS_STRICTATIME,
> +};


Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
