From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 6 Jul 2016 19:05:03 +0800
Subject: [LTP] [PATCH 1/3] syscall/kcmp*: Convert to new API
In-Reply-To: <1467802133-9882-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1467802133-9882-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <577CE5DF.7030306@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sorry, Please ignore these patches. I will resend.
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/kcmp/kcmp.h   |   2 +-
>  testcases/kernel/syscalls/kcmp/kcmp01.c | 119 ++++++++++++++------------------
>  testcases/kernel/syscalls/kcmp/kcmp02.c |  85 ++++++++---------------
>  3 files changed, 82 insertions(+), 124 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/kcmp/kcmp.h b/testcases/kernel/syscalls/kcmp/kcmp.h
> index 513af39..ab50d4b 100644
> --- a/testcases/kernel/syscalls/kcmp/kcmp.h
> +++ b/testcases/kernel/syscalls/kcmp/kcmp.h
> @@ -46,7 +46,7 @@ enum kcmp_type {
>  
>  int kcmp(int pid1, int pid2, int type, int fd1, int fd2)
>  {
> -	return ltp_syscall(__NR_kcmp, pid1, pid2, type, fd1, fd2);
> +	return tst_syscall(__NR_kcmp, pid1, pid2, type, fd1, fd2);
>  }
>  
>  #endif
> diff --git a/testcases/kernel/syscalls/kcmp/kcmp01.c b/testcases/kernel/syscalls/kcmp/kcmp01.c
> index 96d6b07..3be3948 100644
> --- a/testcases/kernel/syscalls/kcmp/kcmp01.c
> +++ b/testcases/kernel/syscalls/kcmp/kcmp01.c
> @@ -26,23 +26,19 @@
>  
>  #define _GNU_SOURCE
>  
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
>  #include "lapi/fcntl.h"
>  #include "kcmp.h"
>  
>  #define TEST_FILE "test_file"
>  #define TEST_FILE2 "test_file2"
>  
> -
>  static int fd1;
>  static int fd2;
>  static int fd3;
>  static int pid1;
>  static int pid2;
>  
> -char *TCID = "kcmp01";
> -
>  static struct test_case {
>  	int *pid1;
>  	int *pid2;
> @@ -58,92 +54,79 @@ static struct test_case {
>  	{&pid1, &pid2, KCMP_FILE, &fd1, &fd3, 1},
>  };
>  
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -
> -static void cleanup(void);
> -static void setup(void);
> -static void do_child(const struct test_case *test);
> -static void cleanup_child(void);
> -
> -int main(int ac, char **av)
> +static void cleanup(void)
>  {
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; ++i) {
> -			pid2 = tst_fork();
> -
> -			if (pid2 == -1)
> -				tst_brkm(TBROK, cleanup, "fork failed");
> +	if (fd1 > 0 && close(fd1) < 0)
> +		tst_res(TWARN | TERRNO, "close fd1 failed");
> +}
>  
> -			if (!pid2)
> -				do_child(&test_cases[i]);
> -			else
> -				tst_record_childstatus(cleanup, pid2);
> -			tst_count++;
> -		}
> -	}
> +static void cleanup_child(void)
> +{
> +	if (fd2 > 0 && close(fd2) < 0)
> +		tst_res(TWARN | TERRNO, "close fd2 failed");
> +	fd2 = 0;
>  
> -	cleanup();
> -	tst_exit();
> +	if (fd3 > 0 && close(fd3) < 0)
> +		tst_res(TWARN | TERRNO, "close fd3 failed");
> +	fd3 = 0;
>  }
>  
>  static void do_child(const struct test_case *test)
>  {
>  	pid2 = getpid();
> +
> +	fd3 = SAFE_OPEN(TEST_FILE2, O_CREAT | O_RDWR, 0666);
> +
>  	fd2 = dup(fd1);
> -	fd3 = SAFE_OPEN(cleanup_child, TEST_FILE2, O_CREAT | O_RDWR, 0666);
> +	if (fd2 == -1) {
> +		tst_res(TFAIL | TERRNO, "dup() failed unexpectedly");
> +		goto end;
> +	}
>  
>  	TEST(kcmp(*(test->pid1), *(test->pid2), test->type,
> -			  *(test->fd1), *(test->fd2)));
> +		  *(test->fd1), *(test->fd2)));
>  
> -	if (TEST_RETURN == -1)
> -		tst_resm(TFAIL | TTERRNO, "kcmp() failed unexpectedly");
> +	if (TEST_RETURN == -1) {
> +		tst_res(TFAIL | TTERRNO, "kcmp() failed unexpectedly");
> +		goto end;
> +	}
>  
>  	if ((test->exp_different && TEST_RETURN == 0)
> -		|| (test->exp_different == 0 && TEST_RETURN))
> -		tst_resm(TFAIL, "kcmp() returned %lu instead of %d",
> -				TEST_RETURN, test->exp_different);
> +		|| (test->exp_different == 0 && TEST_RETURN)) {
> +		tst_res(TFAIL, "kcmp() returned %lu instead of %d",
> +			TEST_RETURN, test->exp_different);
> +		goto end;
> +	}
>  
>  	if ((test->exp_different == 0 && TEST_RETURN == 0)
>  		|| (test->exp_different && TEST_RETURN))
> -		tst_resm(TPASS, "kcmp() returned the expected value");
> +		tst_res(TPASS, "kcmp() returned the expected value");
>  
> -	tst_exit();
> +end:
> +	cleanup_child();
>  }
>  
> -static void cleanup_child(void)
> +static void verify_kcmp(unsigned int n)
>  {
> -	if (fd2 > 0 && close(fd2) < 0)
> -		tst_resm(TWARN | TERRNO, "close fd2 failed");
> -	fd2 = 0;
> -	if (fd3 > 0 && close(fd3) < 0)
> -		tst_resm(TWARN | TERRNO, "close fd3 failed");
> -	fd3 = 0;
> -}
> +	struct test_case *tc = &test_cases[n];
>  
> -static void setup(void)
> -{
> -	if ((tst_kvercmp(3, 5, 0)) < 0) {
> -		tst_brkm(TCONF, NULL,
> -			"This test can only run on kernels that are 3.5. and higher");
> -	}
> +	pid1 = getpid();
>  
> -	tst_tmpdir();
> +	fd1 = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR | O_TRUNC);
>  
> -	pid1 = getpid();
> -	fd1 = SAFE_OPEN(cleanup, TEST_FILE, O_CREAT | O_RDWR | O_TRUNC);
> +	pid2 = SAFE_FORK();
> +	if (!pid2)
> +		do_child(tc);
> +	else
> +		SAFE_WAITPID(pid2, NULL, 0);
>  }
>  
> -static void cleanup(void)
> -{
> -	if (fd1 > 0 && close(fd1) < 0)
> -		tst_resm(TWARN | TERRNO, "close fd1 failed");
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.tid = "kcmp01",
> +	.tcnt = ARRAY_SIZE(test_cases),
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +	.test = verify_kcmp,
> +	.min_kver = "3.5.0",
> +	.needs_tmpdir = 1,
> +};
> diff --git a/testcases/kernel/syscalls/kcmp/kcmp02.c b/testcases/kernel/syscalls/kcmp/kcmp02.c
> index fb651d0..943c084 100644
> --- a/testcases/kernel/syscalls/kcmp/kcmp02.c
> +++ b/testcases/kernel/syscalls/kcmp/kcmp02.c
> @@ -28,8 +28,7 @@
>  
>  #define _GNU_SOURCE
>  
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
>  #include "lapi/fcntl.h"
>  #include "kcmp.h"
>  
> @@ -43,10 +42,9 @@ static int pid1;
>  static int pid_unused;
>  static int fd_fake = -1;
>  
> -char *TCID = "kcmp02";
> -
>  #include <sys/types.h>
>  #include <sys/wait.h>
> +#include <limits.h>
>  
>  static struct test_case {
>  	int *pid1;
> @@ -64,75 +62,52 @@ static struct test_case {
>  	{&pid1, &pid1, KCMP_FILE, &fd1, &fd_fake, EBADF}
>  };
>  
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -
> -static void cleanup(void);
> -static void setup(void);
> -static void kcmp_verify(const struct test_case *test);
> -
> -int main(int ac, char **av)
> +static void setup(void)
>  {
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> +	pid1 = getpid();
> +	pid_unused = tst_get_unused_pid();
>  
> -		for (i = 0; i < TST_TOTAL; i++)
> -			kcmp_verify(&test_cases[i]);
> +	fd1 = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR | O_TRUNC);
> +	fd2 = SAFE_OPEN(TEST_FILE2, O_CREAT | O_RDWR | O_TRUNC);
> +}
>  
> -	}
> +static void cleanup(void)
> +{
> +	if (fd1 > 0 && close(fd1) < 0)
> +		tst_res(TWARN | TERRNO, "close fd1 failed");
>  
> -	cleanup();
> -	tst_exit();
> +	if (fd2 > 0 && close(fd2) < 0)
> +		tst_res(TWARN | TERRNO, "close fd2 failed");
>  }
>  
> -static void kcmp_verify(const struct test_case *test)
> +static void verify_kcmp(unsigned int n)
>  {
> +	struct test_case *test =  &test_cases[n];
> +
>  	TEST(kcmp(*(test->pid1), *(test->pid2), test->type,
> -			  *(test->fd1), *(test->fd2)));
> +		  *(test->fd1), *(test->fd2)));
>  
>  	if (TEST_RETURN != -1) {
> -		tst_resm(TFAIL, "kcmp() succeeded unexpectedly");
> +		tst_res(TFAIL, "kcmp() succeeded unexpectedly");
>  		return;
>  	}
>  
>  	if (test->exp_errno == TEST_ERRNO) {
> -		tst_resm(TPASS | TTERRNO, "kcmp() returned the expected value");
> +		tst_res(TPASS | TTERRNO, "kcmp() returned the expected value");
>  		return;
>  	}
>  
> -	tst_resm(TFAIL | TTERRNO,
> +	tst_res(TFAIL | TTERRNO,
>  		"kcmp() got unexpected return value: expected: %d - %s",
>  			test->exp_errno, tst_strerrno(test->exp_errno));
>  }
>  
> -static void setup(void)
> -{
> -	if ((tst_kvercmp(3, 5, 0)) < 0) {
> -		tst_brkm(TCONF, NULL,
> -			"This test can only run on kernels that are 3.5. and higher");
> -	}
> -
> -	tst_tmpdir();
> -
> -	pid1 = getpid();
> -	pid_unused = tst_get_unused_pid(cleanup);
> -	fd1 = SAFE_OPEN(cleanup, TEST_FILE, O_CREAT | O_RDWR | O_TRUNC);
> -	fd2 = SAFE_OPEN(cleanup, TEST_FILE2, O_CREAT | O_RDWR | O_TRUNC);
> -
> -}
> -
> -static void cleanup(void)
> -{
> -	if (fd1 > 0 && close(fd1) < 0)
> -		tst_resm(TWARN | TERRNO, "close fd1 failed");
> -
> -	if (fd2 > 0 && close(fd2) < 0)
> -		tst_resm(TWARN | TERRNO, "close fd2 failed");
> -	tst_rmdir();
> -
> -}
> +static struct tst_test test = {
> +	.tid = "kcmp02",
> +	.tcnt = ARRAY_SIZE(test_cases),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = verify_kcmp,
> +	.min_kver = "3.5.0",
> +	.needs_tmpdir = 1
> +};



