From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 Jun 2019 13:49:56 +0200
Subject: [LTP] [PATCH v2 2/2] syscalls/fstat{03,05}: rewrote testcases
In-Reply-To: <20190606090009.31124-2-camann@suse.com>
References: <20190606090009.31124-1-camann@suse.com>
 <20190606090009.31124-2-camann@suse.com>
Message-ID: <20190606114956.GA27083@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
>  {
> -	struct stat stat_buf;	/* stat structure buffer */
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	/*
> -	 * Invoke setup function to create a testfile under temporary
> -	 * directory.
> -	 */
> -	setup();
> +	tst_res(TPASS, "fstat() failed as expected with SIGSEGV");
> +	exit(0);
> +}

Technically you should not use anything but signal-async-safe functions
in signal handlers and while this would work fine most of the time it
may deadlock the process under certain circumstatnces.

So the best way how to handle this is to let the child segfault then do
SAFE_WAITPID() and examine the status value.

> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +static void check_fstat(unsigned int tc_num)
> +{
> +	struct tcase *tc = &tcases[tc_num];
>  
> -		tst_count = 0;
> -		/*
> -		 * Call fstat(2) to get the status information
> -		 * of a closed testfile pointed to by 'fd'.
> -		 * verify that fstat fails with -1 return value and
> -		 * sets appropriate errno.
> -		 */
> -		TEST(fstat(fildes, &stat_buf));
> +	if (tc_num == 1)
> +		signal(SIGSEGV, &sighandler);
>  
> -		/* Check return code from fstat(2) */
> -		if (TEST_RETURN == -1) {
> -			if (TEST_ERRNO == EBADF) {
> -				tst_resm(TPASS,
> -					 "fstat() fails with expected error EBADF");
> -			} else {
> -				tst_resm(TFAIL | TTERRNO,
> -					 "fstat() did not fail with EBADF");
> -			}
> +	TEST(fstat(*tc->fd, tc->stat_buf));
> +	if (TST_RET == -1) {
> +		if (tc->exp_err == TST_ERR) {
> +			tst_res(TPASS,
> +				 "fstat() fails with expected error %s",
> +				 tst_strerrno(tc->exp_err));
>  		} else {
> -			tst_resm(TFAIL, "fstat() returned %ld, expected -1",
> -				 TEST_RETURN);
> +			tst_res(TFAIL | TTERRNO,
> +				 "fstat() did not fail with %s, but with",
> +				 tst_strerrno(tc->exp_err));
>  		}
> +	} else {
> +		tst_res(TFAIL, "fstat() returned %ld, expected -1",
> +			 TST_RET);
>  	}
> -
> -	/*
> -	 * Invoke cleanup() to delete the test directory/file(s) created
> -	 * in the setup().
> -	 */
> -	cleanup();
> -
> -	tst_exit();
>  }
>  
> -/*
> - * void
> - * setup(void) - performs all ONE TIME setup for this test.
> - *	Exit the test program on receipt of unexpected signals.
> - *	Create a temporary directory and change directory to it.
> - *      Create a testfile under temporary directory.
> - *      Close the testfile.
> - */
> -void setup(void)
> +static void run(unsigned int tc_num)
>  {
> -	/* Capture unexpected signals */
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	/* Make a temp dir and cd to it */
> -	tst_tmpdir();
> +	pid_t pid;
>  
> -	/* Create a testfile under temporary directory */
> -	fildes = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0666);
> -
> -	SAFE_CLOSE(cleanup, fildes);
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		check_fstat(tc_num);
> +		return;
> +	}
> +	tst_reap_children();
>  }
>  
> -/*
> - * void
> - * cleanup() - Performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - *	Print test timing stats and errno log if test executed with options.
> - *	Close the testfile if still opened.
> - *	Remove temporary directory and sub-directories/files under it
> - *	created during setup().
> - *	Exit the test program with normal exit code.
> - */
> -void cleanup(void)
> +static void setup(void)
>  {
> +	fd_ebadf = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
> +	SAFE_CLOSE(fd_ebadf);

Actually this is kind of useless since the SAFE_CLOSE() sets the
fd_ebadfd to -1.

And we even have tst_get_unused_pid() function exactly for this.

> +	fd_ok = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
> +}
>  
> -	tst_rmdir();
> -

-- 
Cyril Hrubis
chrubis@suse.cz
