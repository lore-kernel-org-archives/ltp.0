From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 8 Jun 2016 04:17:44 -0400 (EDT)
Subject: [LTP] [PATCH v2] lib/tst_test.c: Run test in child process
In-Reply-To: <20160607115806.GA1740@rei.lan>
References: <20160607115806.GA1740@rei.lan>
Message-ID: <969277405.4512739.1465373864678.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Tuesday, 7 June, 2016 1:58:07 PM
> Subject: [LTP] [PATCH v2] lib/tst_test.c: Run test in child process
> 
> This commit moves the actuall test to a child process. The parent process now
> serves two purposes. It sets up an alarm timer that kills the test on a
> timeout
> and also does the library setup and cleanup which means that the test
> temporary
> directory is removed even if the test crashed in one of the functions
> exported
> in tst_test structure.
> 
> The timeout is defined per test run, which is either one execution of
> test_all() function or single loop over the test() function. The timeout is
> reset after each test run by the test library by sending SIGUSR1 to the
> parent.
> 
> The default timeout is set to 300 seconds and can be overriden by setting
> tst_test->timeout variable.
> 
> There is also LTP_TIMEOUT_MUL env variable that, if set to float > 1, is used
> to multiply the timeout before the start of a test. This is especially
> intended
> for slow machines where the default timeout may not be enough. In that
> case you can double all timeouts just by exporting LTP_TIMEOUT_MUL=2
> before starting the testrun.

Looks good to me, ACK. Couple notes below.

<snip>

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index b8ec246..eef54e4 100644
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

Not directly related to this patch, but I noticed that we don't
seem to cleanup_ipc if we hit TBROK outside of main test pid.

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
> @@ -648,8 +647,81 @@ void tst_run_tcases(int argc, char *argv[], struct
> tst_test *self)
>  			break;
>  
>  		run_tests();
> +
> +		kill(getppid(), SIGUSR1);
>  	}
>  
> +	do_test_cleanup();
> +	exit(0);
> +}
> +
> +static pid_t test_pid;
> +static unsigned int timeout = 300;
> +
> +static void alarm_handler(int sig LTP_ATTRIBUTE_UNUSED)
> +{
> +	kill(test_pid, SIGKILL);
> +}
> +
> +static void heartbeat_handler(int sig LTP_ATTRIBUTE_UNUSED)
> +{
> +	alarm(timeout);
> +}
> +
> +void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
> +{
> +	int status;
> +	char *mul;
> +
> +	tst_test = self;
> +	TCID = tst_test->tid;
> +
> +	do_setup(argc, argv);
> +
> +	if (tst_test->timeout)
> +		timeout = tst_test->timeout;

Can you think of a testcase where we would want to disable timeout?

Regards,
Jan
