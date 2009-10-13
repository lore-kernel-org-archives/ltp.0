Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mxidm-0007x9-2t
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:46:18 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mxidg-0000AL-Nz
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:46:18 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DEixKt012974
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:44:59 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DEjnrW131280
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:45:50 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DEjnCu014017
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:45:49 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200910050857.n958vUO6008098@e32.co.us.ibm.com>
References: <200910050857.n958vUO6008098@e32.co.us.ibm.com>
Date: Tue, 13 Oct 2009 20:14:37 +0530
Message-Id: <1255445077.8438.81.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Use plain open() call for creating
	temporary	files in some Crackerjack tests,
	instead of function setup_file
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2009-07-21 at 15:56 +0200, Jiri Palecek wrote: 
> Hello,
> 
>  This makes the tests create the temporary files in their temporary
>  directory, instead of their program directory; also, it avoids having
>  to track the pathname of the program and the path of the temporary
>  file (it is constant)
> 
>  When applied, it would be possible to delete the setup_file/create_file function altogether.
> 
>  Also, this fixes the signal issue in ppoll01, whose last fix was unfortunately not applied.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

This too fails:

patching file testcases/kernel/syscalls/ppoll/ppoll01.c
patching file testcases/kernel/syscalls/utimes/utimes01.c
Hunk #3 succeeded at 237 (offset -2 lines).
Hunk #5 FAILED at 280.
Hunk #6 succeeded at 314 (offset 2 lines).
1 out of 6 hunks FAILED -- saving rejects to file
testcases/kernel/syscalls/utimes/utimes01.c.rej

So, i did not apply any of these 3 patches.

Regards--
Subrata

> ---
>  testcases/kernel/syscalls/ppoll/ppoll01.c   |   37 ++++++++++++++------------
>  testcases/kernel/syscalls/utimes/utimes01.c |   33 +++++++++++++-----------
>  2 files changed, 38 insertions(+), 32 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
> index f76d61f..87b89f6 100644
> --- a/testcases/kernel/syscalls/ppoll/ppoll01.c
> +++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
> @@ -79,6 +79,16 @@ char *TCID = "ppoll01";  /* Test program identifier.*/
>  int  testno;
>  int  TST_TOTAL = 1;                   /* total number of tests in this file.   */
> 
> +static int fd = -1;
> +static void sighandler(int sig);
> +
> +#define SUCCEED_OR_DIE(syscall, message, ...)														\
> +	(errno = 0,																														\
> +		({int ret=syscall(__VA_ARGS__);																			\
> +			if(ret==-1)																												\
> +				tst_brkm(TBROK, cleanup, message, __VA_ARGS__, strerror(errno)); \
> +			ret;}))
> +
>  /* Extern Global Functions */
>  /******************************************************************************/
>  /*                                                                            */
> @@ -129,6 +139,11 @@ void setup() {
>          /* Create temporary directories */
>          TEST_PAUSE;
>          tst_tmpdir();
> +
> +        tst_sig(FORK, DEF_HANDLER, cleanup);
> +        signal(SIGINT, sighandler);
> +
> +        fd = SUCCEED_OR_DIE(open, "open(%s, %x, %x) failed: %s", "test.file", O_CREAT|O_EXCL|O_RDONLY, 0600);
>  }
> 
> 
> @@ -147,7 +162,6 @@ void setup() {
>   */
>  static int opt_debug;
>  static char *progname;
> -static char *progdir;
> 
>  enum test_type {
>  	NORMAL,
> @@ -263,8 +277,7 @@ static int do_test(struct test_case *tc)
>          int sys_ret;
>          int sys_errno;
>          int result = RESULT_OK;
> -	int fd = -1 , cmp_ok = 1;
> -	char fpath[PATH_MAX];
> +	int cmp_ok = 1;
>  	struct pollfd *p_fds, fds[NUM_TEST_FDS];
>          unsigned int nfds = NUM_TEST_FDS;
>          struct timespec *p_ts, ts;
> @@ -272,9 +285,6 @@ static int do_test(struct test_case *tc)
>          size_t sigsetsize = 0;
>          pid_t pid = 0;
> 
> -	TEST(fd = setup_file(progdir, "test.file", fpath));
> -        if (fd < 0)
> -                return 1;
>          fds[0].fd = fd;
>          fds[0].events = POLLIN | POLLPRI | POLLOUT | POLLRDHUP;
>          fds[0].revents = 0;
> @@ -290,13 +300,12 @@ static int do_test(struct test_case *tc)
>                  p_ts = &ts;
>                  break;
>  	case FD_ALREADY_CLOSED:
> -                TEST(close(fd));
> -                fd = -1;
> -                TEST(cleanup_file(fpath));
> +                fds[0].fd = SUCCEED_OR_DIE(dup, "dup(%d) failed: %s", fd);
> +                SUCCEED_OR_DIE(close, "couldn't close duplicated fd (%d): %s", fds[0].fd);
>                  break;
>          case MASK_SIGNAL:
> -                TEST(sigemptyset(&sigmask));
> -                TEST(sigaddset(&sigmask, SIGINT));
> +                sigemptyset(&sigmask);
> +                sigaddset(&sigmask, SIGINT);
>                  p_sigmask = &sigmask;
>                  //sigsetsize = sizeof(sigmask);
>                  sigsetsize = 8;
> @@ -390,9 +399,6 @@ TEST_END:
>          PRINT_RESULT_CMP(sys_ret >= 0, tc->ret, tc->err, sys_ret, sys_errno,
>                           cmp_ok);
>   cleanup:
> -        if (fd >= 0)
> -                cleanup_file(fpath);
> -
>          sigemptyset(&sigmask);
>          sigprocmask(SIG_SETMASK, &sigmask, NULL);
>          if (pid > 0) {
> @@ -454,9 +460,6 @@ int main(int ac, char **av) {
>  	progname = strchr(av[0], '/');
>          progname = progname ? progname + 1 : av[0];	
> 
> -	progdir = strdup(av[0]);
> -        progdir = dirname(progdir);
> -	
>          /* parse standard options */
>          if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){
>               tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
> diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
> index 390b572..7705269 100644
> --- a/testcases/kernel/syscalls/utimes/utimes01.c
> +++ b/testcases/kernel/syscalls/utimes/utimes01.c
> @@ -74,6 +74,16 @@ char *TCID = "utimes01";  /* Test program identifier.*/
>  int  testno;
>  int  TST_TOTAL = 1;                   /* total number of tests in this file.   */
> 
> +#define FNAME "test.file"
> +#define FNAME_NX "test.file_nonexistant"
> +
> +#define SUCCEED_OR_DIE(syscall, message, ...)														\
> +	(errno = 0,																														\
> +		({int ret=syscall(__VA_ARGS__);																			\
> +			if(ret==-1)																												\
> +				tst_brkm(TBROK, cleanup, message, __VA_ARGS__, strerror(errno)); \
> +			ret;}))
> +
>  /* Extern Global Functions */
>  /******************************************************************************/
>  /*                                                                            */
> @@ -126,6 +136,10 @@ void setup() {
>          /* Create temporary directories */
>          TEST_PAUSE;
>          tst_tmpdir();
> +
> +        SUCCEED_OR_DIE(close, "close(%d): %s",
> +                       SUCCEED_OR_DIE(open, "creating temporary file failed: open(%s, %x, %x): %s",
> +                                      FNAME, O_CREAT|O_EXCL, 0600));
>  }
> 
> 
> @@ -225,18 +239,13 @@ static struct test_case tcase[] = {
>  static int do_test(struct test_case *tc)
>  {
>          int sys_ret;
> -        int sys_errno;
>          int result = RESULT_OK;
>  	struct timeval tv[2];
> -        char fpath[PATH_MAX], c = '\0';
> -        int rc, len, cmp_ok = 1;
> +        const char *fpath = FNAME;
> +        int rc, cmp_ok = 1;
>          struct stat st;
>          uid_t old_uid;
> 
> -        TEST(rc = setup_file(TESTDIR, "test.file", fpath));
> -        if (rc < 0)
> -                return 1;
> -
>  	/*
>           * Change effective user id
>           */
> @@ -252,10 +261,8 @@ static int do_test(struct test_case *tc)
>  	memset(tv, 0, 2 * sizeof(struct timeval));
>          tv[0].tv_sec = tc->a_sec;
>          tv[1].tv_sec = tc->m_sec;
> -        TEST(len = strlen(fpath));
>          if (tc->ttype == FILE_NOT_EXIST) {
> -                c = fpath[len - 1];
> -                fpath[len - 1] = '\0';
> +                fpath=FNAME_NX;
>          }
>          errno = 0;
>          if (tc->ttype == NO_FNAME) {
> @@ -273,15 +280,13 @@ static int do_test(struct test_case *tc)
>  	else
>                  TEST(sys_ret = utimes(fpath, tv));
>          sys_errno = errno;
> -        if (tc->ttype == FILE_NOT_EXIST)
> -                fpath[len - 1] = c;
>          if (sys_ret < 0)
>                  goto TEST_END;
> 
>  	/*
>           * Check test file's time stamp
>           */
> -        rc = stat(fpath, &st);
> +        rc = stat(FNAME, &st);
>          if (rc < 0) {
>                  EPRINTF("stat failed.\n");
>                  result = 1;
> @@ -307,8 +312,6 @@ EXIT1:
>                          return 1;
>          }
>  EXIT2:
> -        TEST(cleanup_file(fpath));
> -
>          return result;
>  }
> 


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
