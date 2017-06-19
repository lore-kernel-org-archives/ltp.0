From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Jun 2017 19:09:28 +0200
Subject: [LTP] [PATCH 2/2] syscalls/lseek0[2-5]: cleanup && convert to
 new API
In-Reply-To: <1497848431-30404-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1497848431-30404-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1497848431-30404-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170619170928.GC29153@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <stdio.h>
> +#include "tst_test.h"
> +
> +static char fname[255], pname[255];
> +static int bad_fd = -1;
> +static int fd, pfd;
> +static int pfds[2];
> +
> +static struct tcase {
> +	int *fd;
> +	int whence;
> +	int exp_err;
> +} tcases[] = {
> +	{&bad_fd, SEEK_SET, EBADF},
> +	{&bad_fd, SEEK_CUR, EBADF},
> +	{&bad_fd, SEEK_END, EBADF},
> +	{&fd, 5, EINVAL},
> +	{&fd, -1, EINVAL},
> +	{&fd, 7, EINVAL},
> +	{&pfd, SEEK_SET, ESPIPE},
> +	{&pfd, SEEK_CUR, ESPIPE},
> +	{&pfd, SEEK_END, ESPIPE},
> +	{&pfds[0], SEEK_SET, ESPIPE},
> +	{&pfds[0], SEEK_CUR, ESPIPE},
> +	{&pfds[0], SEEK_END, ESPIPE},
> +};
> +
> +static void verify_lseek(unsigned int n)
>  {
> -	int lc;
> -
> -    /***************************************************************
> -     * parse standard options
> -     ***************************************************************/
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -    /***************************************************************
> -     * perform global setup for test
> -     ***************************************************************/
> -	setup();
> -
> -    /***************************************************************
> -     * check looping state if -c option given
> -     ***************************************************************/
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/*
> -		 *  Call lseek(2)
> -		 */
> -		TEST(lseek(-1, (long)1, SEEK_SET));
> -
> -		/* check return code */
> -		if (TEST_RETURN == -1) {
> -			if (TEST_ERRNO == EBADF)
> -
> -				tst_resm(TPASS,
> -					 "lseek(-1, 1, SEEK_SET) Failed, errno=%d : %s",
> -					 TEST_ERRNO,
> -					 strerror(TEST_ERRNO));
> -			else
> -				tst_resm(TFAIL,
> -					 "lseek(-1, 1, SEEK_SET) Failed, errno=%d : %s, expected %d(EBADF)",
> -					 TEST_ERRNO,
> -					 strerror(TEST_ERRNO), EBADF);
> -		} else {
> -
> -			tst_resm(TFAIL, "lseek(-1, 1, SEEK_SET) returned %ld",
> -				 TEST_RETURN);
> -		}
> +	struct tcase *tc = &tcases[n];
>  
> +	TEST(lseek(*tc->fd, (off_t) 1, tc->whence));
> +	if (TEST_RETURN != (off_t) -1) {
> +		tst_res(TFAIL, "lseek(%d, 1, %d) succeeded unexpectedly",
> +			*tc->fd, tc->whence);
> +			return;
>  	}
>  
> -	cleanup();
> -	tst_exit();
> +	if (TEST_ERRNO == tc->exp_err) {
> +		tst_res(TPASS | TTERRNO, "lseek(%d, 1, %d) failed as expected",
> +			*tc->fd, tc->whence);
> +	} else {
> +		tst_res(TFAIL | TTERRNO, "lseek(%d, 1, %d) failed "
> +			"unexpectedly, expected %s", *tc->fd, tc->whence,
> +			tst_strerrno(tc->exp_err));
> +	}
>  }
>  
> -/***************************************************************
> - * setup() - performs all ONE TIME setup for this test.
> - ***************************************************************/
> -void setup(void)
> +static void setup(void)
>  {
> +	sprintf(fname, "tfile_%d", getpid());
> +	sprintf(pname, "tpipe_%d", getpid());

Well there is no need to "randomize" the file names since the test has
it's own temporary directory...

> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> +	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0777);
> +	SAFE_MKFIFO(pname, 0777);
> +	pfd = SAFE_OPEN(pname, O_RDWR, 0777);
> +	SAFE_PIPE(pfds);
>  }

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
