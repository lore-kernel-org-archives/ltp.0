Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VqNCX-0000zb-3h
	for ltp-list@lists.sourceforge.net; Tue, 10 Dec 2013 13:18:13 +0000
Date: Tue, 10 Dec 2013 14:17:37 +0100
From: chrubis@suse.cz
Message-ID: <20131210131737.GA25334@rei>
References: <1385443532.14061.0.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385443532.14061.0.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] fchownat/fchownat01.c: cleanup
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
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> -uid_t uid;
> -gid_t gid;
> -
> -int myfchownat(int dirfd, const char *filename, uid_t owner, gid_t group,
> -	       int flags)
> -{
> -	return ltp_syscall(__NR_fchownat, dirfd, filename, owner, group, flags);
> -}

Hmm, glibc 2.4 (first one with fchownat() support) has been released in
2006. I wonder if seven years is long enough and if we can get rid of
the wrapper now... Moreover I'm not sure what is the status of
alternative libc implementations.

There still may be enterprise distributions that still have older glibc
than that. Anybody out there?

> +int TST_TOTAL = ARRAY_SIZE(test_cases);
>  
>  int main(int ac, char **av)
>  {
>  	int lc;
> -	char *msg;
>  	int i;
>  
> -	/* Disable test if the version of the kernel is less than 2.6.16 */
> -	if ((tst_kvercmp(2, 6, 16)) < 0) {
> -		tst_resm(TWARN, "This test can only run on kernels that are ");
> -		tst_resm(TWARN, "2.6.16 and higher");
> -		exit(0);
> -	}

This should not be removed but rather moved to the first lines of
setup() function and the TWARN should be changed to TCONF as:

tst_brkm(TCONF, NULL, "This test needs kernel 2.6.16 or newer"

> -	/***************************************************************
> -	 * parse standard options
> -	 ***************************************************************/
> -	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
> -		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);

Do not remove the option parsing code.

> -
> -	/***************************************************************
> -	 * perform global setup for test
> -	 ***************************************************************/
>  	setup();
>  
> -	/***************************************************************
> -	 * check looping state if -c option given
> -	 ***************************************************************/
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		setup_every_copy();
>  
>  		tst_count = 0;
>  
> -		/*
> -		 * Call fchownat
> -		 */
>  		for (i = 0; i < TST_TOTAL; i++) {
> -			TEST(myfchownat
> -			     (fds[i], filenames[i], uid, gid, flags[i]));
> -
> -			/* check return code */
> -			if (TEST_ERRNO == expected_errno[i]) {
> -
> -				/***************************************************************
> -				 * only perform functional verification if flag set (-f not given)
> -				 ***************************************************************/
> -				if (STD_FUNCTIONAL_TEST) {
> -					/* No Verification test, yet... */
> -					tst_resm(TPASS,
> -						 "fchownat() returned the expected  errno %d: %s",
> -						 TEST_ERRNO,
> -						 strerror(TEST_ERRNO));
> -				}
> +			TEST(fchownat(*test_cases[i].fds,
> +				      test_cases[i].filenames, uid, gid,
> +				      test_cases[i].flag));
> +
> +			if (TEST_ERRNO == test_cases[i].ret) {
> +				tst_resm(TPASS,
> +					 "fchownat() returned the expected "
> +					 "errno %d: %s", TEST_ERRNO,
> +					 strerror(TEST_ERRNO));
>  			} else {
>  				TEST_ERROR_LOG(TEST_ERRNO);
>  				tst_resm(TFAIL,
> @@ -148,97 +119,55 @@ int main(int ac, char **av)
>  
>  	}
>  
> -	/***************************************************************
> -	 * cleanup and exit
> -	 ***************************************************************/
>  	cleanup();
>  
> -	return (0);
> +	tst_exit();
>  }
>  
> -void setup_every_copy()
> +void setup()

static void setup(void) here please.

>  {
> -	/* Initialize test dir and file names */
> +	uid = geteuid();
> +	gid = getegid();
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
>  	sprintf(pathname, "fchownattestdir%d", getpid());
> -	sprintf(testfile, "fchownattestfile%d.txt", getpid());
> -	sprintf(testfile2, "/tmp/fchownattestfile%d.txt", getpid());
> -	sprintf(testfile3, "fchownattestdir%d/fchownattestfile%d.txt", getpid(),
> -		getpid());
>  
> -	ret = mkdir(pathname, 0700);
> -	if (ret < 0) {
> -		perror("mkdir: ");
> -		exit(-1);
> -	}
> +	SAFE_MKDIR(cleanup, pathname, 0700);

Make use of tst_tmpdir() here instead. And also drop the pid from the
test file names as the directory made by tst_tmpdir() is unique
allready.

> -	dirfd = open(pathname, O_DIRECTORY);
> -	if (dirfd < 0) {
> -		perror("open: ");
> -		exit(-1);
> -	}
> +	dirfd = SAFE_OPEN(cleanup, pathname, O_DIRECTORY);
>  
> -	fd = open(testfile, O_CREAT | O_RDWR, 0600);
> -	if (fd < 0) {
> -		perror("open: ");
> -		exit(-1);
> -	}
> +	sprintf(testfile, "fchownattestfile%d.txt", getpid());
>  
> -	fd = open(testfile2, O_CREAT | O_RDWR, 0600);
> -	if (fd < 0) {
> -		perror("open: ");
> -		exit(-1);
> -	}
> +	SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0600);
>  
> -	fd = open(testfile3, O_CREAT | O_RDWR, 0600);
> -	if (fd < 0) {
> -		perror("open: ");
> -		exit(-1);
> -	}
> +	sprintf(testfile2, "/tmp/fchownattestfile%d.txt", getpid());
>  
> -	fds[0] = fds[1] = fds[4] = dirfd;
> -	fds[2] = fd;
> -	fds[3] = 100;
> -	fds[5] = AT_FDCWD;
> +	SAFE_OPEN(cleanup, testfile2, O_CREAT | O_RDWR, 0600);
>  
> -	filenames[0] = filenames[2] = filenames[3] = filenames[4] =
> -	    filenames[5] = testfile;
> -	filenames[1] = testfile2;
> -}
> +	sprintf(testfile3, "fchownattestdir%d/fchownattestfile%d.txt", getpid(),
> +		getpid());
>  
> -/***************************************************************
> - * setup() - performs all ONE TIME setup for this test.
> - ***************************************************************/
> -void setup()
> -{
> -	/* Set uid and gid */
> -	uid = geteuid();
> -	gid = getegid();
> +	fd = SAFE_OPEN(cleanup, testfile3, O_CREAT | O_RDWR, 0600);
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	no_fd = 100;
>  
> -	TEST_PAUSE;
> +	cu_fd = AT_FDCWD;
>  }
>  
> -/***************************************************************
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *		completion or premature exit.
> - ***************************************************************/
>  void cleanup()
>  {
> -	/* Remove them */
> -	char tmppathname[256];
> -	strcpy(tmppathname, pathname);
> -
> -	close(fd);
> -	unlink(testfile);
> -	unlink(testfile2);
> -	unlink(testfile3);
> +	SAFE_CLOSE(NULL, fd);
> +
> +	SAFE_UNLINK(NULL, testfile);
> +
> +	SAFE_UNLINK(NULL, testfile2);
> +
> +	SAFE_UNLINK(NULL, testfile3);
> +
>  	rmdir(pathname);

Make use of tst_rmdir() here instead of the unlink and rmdir.

> -	/*
> -	 * print timing stats if that option was specified.
> -	 * print errno log if that option was specified.
> -	 */
>  	TEST_CLEANUP;
> -
>  }

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
