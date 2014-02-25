Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WIJfX-0006Q7-Jt
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 15:11:39 +0000
Date: Tue, 25 Feb 2014 16:11:25 +0100
From: chrubis@suse.cz
Message-ID: <20140225151125.GA15595@rei>
References: <1385443532.14061.0.camel@G08JYZSD130126>
	<20131210131737.GA25334@rei>
	<1393326701.1952.59.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1393326701.1952.59.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 1/2] fchownat/fchownat01.c: cleanup
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
>  #define _GNU_SOURCE
>  
> @@ -53,38 +33,40 @@
>  #include <errno.h>
>  #include <string.h>
>  #include <signal.h>
> +
>  #include "test.h"
>  #include "usctest.h"
> -#include "linux_syscall_numbers.h"
> -
> -#define TEST_CASES 6
> -#ifndef AT_FDCWD
> -#define AT_FDCWD -100
> -#endif

You should include the "lapi/fcntl.h" instead of the defines.

> -void setup();
> -void cleanup();
> -void setup_every_copy();
> +#include "safe_macros.h"
> +#include "fchownat.h"
> +
> +#define TESTFILE	"testfile"
> +#define TESTFILE2	"testfile2"
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +static int dirfd;
> +static int fd;
> +static int no_fd = -1;
> +static int cu_fd = AT_FDCWD;
> +
> +static struct test_case_t {
> +	int ret;
> +	int flag;
> +	int *fds;
> +	char *filenames;
> +} test_cases[] = {
> +	{0, 0, &dirfd, TESTFILE},
> +	{0, 0, &dirfd, TESTFILE2},

These test are identical, aren't they?

> +	{ENOTDIR, 0, &fd, TESTFILE},
> +	{EBADF, 0, &no_fd, TESTFILE},
> +	{EINVAL, 9999, &dirfd, TESTFILE},
> +	{0, 0, &cu_fd, TESTFILE},
> +};
>  
>  char *TCID = "fchownat01";
> -int TST_TOTAL = TEST_CASES;
> -char pathname[256];
> -char testfile[256];
> -char testfile2[256];
> -char testfile3[256];
> -int dirfd, fd, ret;
> -int fds[TEST_CASES];
> -char *filenames[TEST_CASES];
> -int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, EINVAL, 0 };
> -int flags[TEST_CASES] = { 0, 0, 0, 0, 9999, 0 };
> -
> -uid_t uid;
> -gid_t gid;
> -
> -int myfchownat(int dirfd, const char *filename, uid_t owner, gid_t group,
> -	       int flags)
> -{
> -	return ltp_syscall(__NR_fchownat, dirfd, filename, owner, group, flags);
> -}
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +static void fchownat_verify(const struct test_case_t *);
>  
>  int main(int ac, char **av)
>  {
> @@ -92,153 +74,67 @@ int main(int ac, char **av)
>  	char *msg;
>  	int i;
>  
> -	/* Disable test if the version of the kernel is less than 2.6.16 */
> -	if ((tst_kvercmp(2, 6, 16)) < 0) {
> -		tst_resm(TWARN, "This test can only run on kernels that are ");
> -		tst_resm(TWARN, "2.6.16 and higher");
> -		exit(0);
> -	}
> -
> -	/***************************************************************
> -	 * parse standard options
> -	 ***************************************************************/
>  	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
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
> -
>  		tst_count = 0;
> -
> -		/*
> -		 * Call fchownat
> -		 */
> -		for (i = 0; i < TST_TOTAL; i++) {
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
> -			} else {
> -				TEST_ERROR_LOG(TEST_ERRNO);
> -				tst_resm(TFAIL,
> -					 "fchownat() Failed, errno=%d : %s",
> -					 TEST_ERRNO, strerror(TEST_ERRNO));
> -			}
> -		}
> -
> +		for (i = 0; i < TST_TOTAL; i++)
> +			fchownat_verify(&test_cases[i]);
>  	}
>  
> -	/***************************************************************
> -	 * cleanup and exit
> -	 ***************************************************************/
>  	cleanup();
> -
> -	return (0);
> +	tst_exit();
>  }
>  
> -void setup_every_copy()
> +static void setup(void)
>  {
> -	/* Initialize test dir and file names */
> -	sprintf(pathname, "fchownattestdir%d", getpid());
> -	sprintf(testfile, "fchownattestfile%d.txt", getpid());
> -	sprintf(testfile2, "/tmp/fchownattestfile%d.txt", getpid());
> -	sprintf(testfile3, "fchownattestdir%d/fchownattestfile%d.txt", getpid(),
> -		getpid());
> -
> -	ret = mkdir(pathname, 0700);
> -	if (ret < 0) {
> -		perror("mkdir: ");
> -		exit(-1);
> -	}
> +	if ((tst_kvercmp(2, 6, 16)) < 0)
> +		tst_brkm(TCONF, NULL, "This test needs kernel 2.6.16 or newer");
>  
> -	dirfd = open(pathname, O_DIRECTORY);
> -	if (dirfd < 0) {
> -		perror("open: ");
> -		exit(-1);
> -	}
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>  
> -	fd = open(testfile, O_CREAT | O_RDWR, 0600);
> -	if (fd < 0) {
> -		perror("open: ");
> -		exit(-1);
> -	}
> +	TEST_PAUSE;
>  
> -	fd = open(testfile2, O_CREAT | O_RDWR, 0600);
> -	if (fd < 0) {
> -		perror("open: ");
> -		exit(-1);
> -	}
> +	tst_tmpdir();
>  
> -	fd = open(testfile3, O_CREAT | O_RDWR, 0600);
> -	if (fd < 0) {
> -		perror("open: ");
> -		exit(-1);
> -	}
> +	dirfd = SAFE_OPEN(cleanup, "./", O_DIRECTORY);
>  
> -	fds[0] = fds[1] = fds[4] = dirfd;
> -	fds[2] = fd;
> -	fds[3] = 100;
> -	fds[5] = AT_FDCWD;
> +	SAFE_TOUCH(cleanup, TESTFILE, 0600, NULL);
>  
> -	filenames[0] = filenames[2] = filenames[3] = filenames[4] =
> -	    filenames[5] = testfile;
> -	filenames[1] = testfile2;
> +	SAFE_TOUCH(cleanup, TESTFILE2, 0600, NULL);
> +
> +	fd = SAFE_OPEN(cleanup, "testfile3", O_CREAT | O_RDWR, 0600);
>  }
>  
> -/***************************************************************
> - * setup() - performs all ONE TIME setup for this test.
> - ***************************************************************/
> -void setup()
> +static void fchownat_verify(const struct test_case_t *test)
>  {
> -	/* Set uid and gid */
> -	uid = geteuid();
> -	gid = getegid();
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	TEST(fchownat(*(test->fds), test->filenames, geteuid(),
> +		      getegid(), test->flag));

You are not checking the TEST_RETURN here as well. Given that there are
both possitive and negative testcases it should be 0 if expected errno
is 0 and -1 if expected errno is non-zero.


> +	if (TEST_ERRNO == test->ret) {

Can you also please rename the test->ret to test->exp_errno?

> +		tst_resm(TPASS | TTERRNO,
> +			 "fchownat() returned the expected errno %d: %s",
> +			 TEST_ERRNO, strerror(TEST_ERRNO));
> +	} else {
> +		TEST_ERROR_LOG(TEST_ERRNO);
> +		tst_resm(TFAIL | TTERRNO,
> +			 "fchownat() Failed, errno=%d : %s",
> +			 TEST_ERRNO, strerror(TEST_ERRNO));
> +	}
>  }
>  
> -/***************************************************************
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *		completion or premature exit.
> - ***************************************************************/
> -void cleanup()
> +static void cleanup(void)
>  {
> -	/* Remove them */
> -	char tmppathname[256];
> -	strcpy(tmppathname, pathname);
> -
> -	close(fd);
> -	unlink(testfile);
> -	unlink(testfile2);
> -	unlink(testfile3);
> -	rmdir(pathname);
> -
> -	/*
> -	 * print timing stats if that option was specified.
> -	 * print errno log if that option was specified.
> -	 */
> -	TEST_CLEANUP;
> +	if (fd > 0)
> +		close(fd);
> +
> +	if (dirfd > 0)
> +		close(dirfd);
>  
> +	tst_rmdir();
> +
> +	TEST_CLEANUP;
>  }
> -- 
> 1.8.4.2
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
