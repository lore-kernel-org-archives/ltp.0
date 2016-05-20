From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 20 May 2016 05:25:55 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] lib/tst_test.c: Run test in child process
In-Reply-To: <20160519151746.GA2772@rei>
References: <20160519151746.GA2772@rei>
Message-ID: <1671077356.4707701.1463736355683.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Thursday, 19 May, 2016 5:17:47 PM
> Subject: [LTP] [RFC] [PATCH] lib/tst_test.c: Run test in child process
> 
> This commit moves the actuall test to a child process. The parent
> process now serves two purposes. It sets up an alarm timer that kills
> the test on a timeout and also does the library setup and cleanup which
> means that the test temporary directory is removed even if the test
> crased in one of the functions exported in tst_test structure.
> 
> The timeout is defined per test run, which is either one execution of
> test_all() function or single loop over the test() function. The default
> timeout is 1 second and can be overrided by tst_test->timeout variable.
> 
> The overhead of the fork() + wait() does not seem to be measurable.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_test.h          |  3 ++
>  lib/newlib_tests/.gitignore |  3 ++
>  lib/newlib_tests/test10.c   | 32 ++++++++++++++++++
>  lib/newlib_tests/test11.c   | 34 +++++++++++++++++++
>  lib/newlib_tests/test12.c   | 32 ++++++++++++++++++
>  lib/tst_test.c              | 80
>  +++++++++++++++++++++++++++++++++++++--------
>  6 files changed, 171 insertions(+), 13 deletions(-)
>  create mode 100644 lib/newlib_tests/test10.c
>  create mode 100644 lib/newlib_tests/test11.c
>  create mode 100644 lib/newlib_tests/test12.c
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 88b46d6..ddd9060 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -84,6 +84,9 @@ struct tst_test {
>  	int needs_device:1;
>  	int needs_checkpoints:1;
>  
> +	/* override default timeout per test run */
> +	unsigned int timeout;
> +
>  	void (*setup)(void);
>  	void (*cleanup)(void);
>  
> diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
> index e3ec6aa..dccf4c8 100644
> --- a/lib/newlib_tests/.gitignore
> +++ b/lib/newlib_tests/.gitignore
> @@ -7,3 +7,6 @@ test06
>  test07
>  test08
>  test09
> +test10
> +test11
> +test12
> diff --git a/lib/newlib_tests/test10.c b/lib/newlib_tests/test10.c
> new file mode 100644
> index 0000000..0b2d3ac
> --- /dev/null
> +++ b/lib/newlib_tests/test10.c
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright (c) 2016 Linux Test Project
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +/*
> + * Test for watchdog timeout.
> + */
> +
> +#include "tst_test.h"
> +
> +
> +static void do_test(void)
> +{
> +	sleep(10);
> +	tst_res(TPASS, "Not reached");
> +}
> +
> +static struct tst_test test = {
> +	.tid = "test10",
> +	.test_all = do_test,
> +};
> diff --git a/lib/newlib_tests/test11.c b/lib/newlib_tests/test11.c
> new file mode 100644
> index 0000000..1354f52
> --- /dev/null
> +++ b/lib/newlib_tests/test11.c
> @@ -0,0 +1,34 @@
> +/*
> + * Copyright (c) 2016 Linux Test Project
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +/*
> + * Test for segfault.
> + */
> +
> +#include "tst_test.h"
> +
> +static void do_test(void)
> +{
> +	volatile char *ptr = NULL;
> +
> +	*ptr = 0;
> +
> +	tst_res(TPASS, "Not reached");
> +}
> +
> +static struct tst_test test = {
> +	.tid = "test11",
> +	.test_all = do_test,
> +};
> diff --git a/lib/newlib_tests/test12.c b/lib/newlib_tests/test12.c
> new file mode 100644
> index 0000000..7bacf9f
> --- /dev/null
> +++ b/lib/newlib_tests/test12.c
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright (c) 2016 Linux Test Project
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +/*
> + * Test for timeout override.
> + */
> +
> +#include "tst_test.h"
> +
> +static void do_test(void)
> +{
> +	sleep(2);
> +	tst_res(TPASS, "Passed!");
> +}
> +
> +static struct tst_test test = {
> +	.tid = "test12",
> +	.timeout = 3,
> +	.test_all = do_test,
> +};
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index b8ec246..3b3dc0d 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -220,17 +220,19 @@ void tst_vres_(const char *file, const int lineno, int
> ttype,
>  void tst_vbrk_(const char *file, const int lineno, int ttype,
>                 const char *fmt, va_list va) __attribute__((noreturn));
>  
> -static void do_cleanup(void);
> +static void do_test_cleanup(void)
> +{
> +	if (tst_test->cleanup)
> +		tst_test->cleanup();
> +}
>  
>  void tst_vbrk_(const char *file, const int lineno, int ttype,
>                 const char *fmt, va_list va)
>  {
>  	print_result(file, lineno, ttype, fmt, va);
>  
> -	if (getpid() == main_pid) {
> -		do_cleanup();
> -		cleanup_ipc();
> -	}
> +	if (getpid() == main_pid)
> +		do_test_cleanup();
>  
>  	exit(TTYPE_RESULT(ttype));
>  }
> @@ -550,7 +552,10 @@ static void do_setup(int argc, char *argv[])
>  
>  	if (tst_test->resource_files)
>  		copy_resources();
> +}
>  
> +static void do_test_setup(void)
> +{
>  	main_pid = getpid();
>  
>  	if (tst_test->setup)
> @@ -562,9 +567,6 @@ static void do_setup(int argc, char *argv[])
>  
>  static void do_cleanup(void)
>  {
> -	if (tst_test->cleanup)
> -		tst_test->cleanup();
> -
>  	if (tst_test->needs_device && tdev.dev)
>  		tst_release_device(tdev.dev);
>  
> @@ -619,16 +621,13 @@ static unsigned long long get_time_ms(void)
>  	return tv.tv_sec * 1000 + tv.tv_usec / 1000;
>  }
>  
> -void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
> +static void testrun(void)
>  {
>  	unsigned int i = 0;
>  	unsigned long long stop_time = 0;
>  	int cont = 1;
>  
> -	tst_test = self;
> -	TCID = tst_test->tid;
> -
> -	do_setup(argc, argv);
> +	do_test_setup();
>  
>  	if (duration > 0)
>  		stop_time = get_time_ms() + (unsigned long long)(duration * 1000);
> @@ -650,6 +649,61 @@ void tst_run_tcases(int argc, char *argv[], struct
> tst_test *self)
>  		run_tests();
>  	}
>  
> +	do_test_cleanup();
> +	exit(0);
> +}
> +
> +static pid_t test_pid;
> +
> +static void alarm_handler(int sig LTP_ATTRIBUTE_UNUSED)
> +{
> +	kill(test_pid, SIGKILL);
> +}
> +
> +#define MAX(a,b) ((a) > (b) ? (a) : (b))
> +
> +void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
> +{
> +	int status;
> +	unsigned int timeout, timeout_per_run = 1;

1s seems very low to me as default. ~18% of (mostly syscall) testcases 
I run on s390 have duration >= 1 reported. 

If our goal is to not hang indefinitely, then even a timeout of 5 minutes
doesn't look as bad to me. And it also gives kernel time to report a potential
soft lockup before we kill the test.

> +
> +	tst_test = self;
> +	TCID = tst_test->tid;
> +
> +	do_setup(argc, argv);
> +
> +	if (tst_test->timeout)
> +		timeout_per_run = tst_test->timeout;
> +
> +	timeout = timeout_per_run * iterations;
> +
> +	if (duration > 0)
> +		timeout = MAX(timeout, duration + 2 * timeout_per_run);
> +
> +	tst_res(TINFO, "Timeout is %us", timeout);
> +
> +	SAFE_SIGNAL(SIGALRM, alarm_handler);
> +	alarm(timeout);
> +
> +	test_pid = fork();

Should we care about child processes too? We could make new process group
and then send signal to entire process group.

> +	if (test_pid < 0)
> +		tst_brk(TBROK | TERRNO, "fork()");
> +
> +	if (!test_pid)
> +		testrun();
> +
> +	SAFE_WAITPID(test_pid, &status, 0);
> +
>  	do_cleanup();
> +
> +	if (WIFEXITED(status) && WEXITSTATUS(status))
> +		exit(WEXITSTATUS(status));
> +
> +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL)
> +		tst_brk(TBROK, "Test killed! (timeout?)");
> +
> +	if (WIFSIGNALED(status))
> +		tst_brk(TBROK, "Test killed by %s!", tst_strsig(WTERMSIG(status)));
> +
>  	do_exit();
>  }
> --
> 2.7.3
> 
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
