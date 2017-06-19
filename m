From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Jun 2017 18:51:59 +0200
Subject: [LTP] [PATCH 1/2] syscalls/lseek01,
 06: cleanup && convert to new API
In-Reply-To: <1497848431-30404-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1497848431-30404-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170619165158.GB29153@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static int fd;
> +static struct tcase {
> +	off_t off;
> +	int whence;
> +	off_t exp_off;
> +	char *exp_data;
> +} tcases[] = {
> +	{4, SEEK_SET, 4, "efg"},
> +	{-2, SEEK_CUR, 5, "fg"},

This part actually depends on the fact that the file has been seeked and
read in the previous test. I wonder if it would be less confusing if we
reset the offset to a defined position (start of the file) before the
the test.

> +	{-4, SEEK_END, 3, "defg"},
> +};
> +
> +static void verify_lseek(unsigned int n)
>  {
> -	int lc;
> -
> -	int ind;
> -	int offset;
> +	char read_buf[64];
> +	struct tcase *tc = &tcases[n];
>  
> -    /***************************************************************
> -     * parse standard options
> -     ***************************************************************/
> -	tst_parse_opts(ac, av, NULL, NULL);
> +	memset(read_buf, 0, sizeof(read_buf));
>  
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
> -		offset = (lc % 100) * 4096;	/* max size is 100 blocks */
> -
> -		for (ind = 0; Whence[ind] >= 0; ind++) {
> +	TEST(lseek(fd, tc->off, tc->whence));
> +	if (TEST_RETURN == (off_t) -1) {
> +		tst_res(TFAIL | TTERRNO, "lseek(%d, %ld, %d) failed", fd,
> +			tc->off, tc->whence);
> +		return;
> +	}
>  
> -			/*
> -			 *  Call lseek(2)
> -			 */
> -			TEST(lseek(Fd, (long)offset, Whence[ind]));
> +	if (TEST_RETURN != tc->exp_off) {
> +		tst_res(TFAIL, "lseek(%d, %ld, %d) returned %ld, expected %ld",
> +			fd, tc->off, tc->whence, TEST_RETURN, tc->exp_off);
> +		return;
> +	}
>  
> -			/* check return code */
> -			if (TEST_RETURN == -1) {
> -				tst_resm(TFAIL,
> -					 "lseek(%s, %d, 0) Failed, errno=%d : %s",
> -					 Fname, offset, TEST_ERRNO,
> -					 strerror(TEST_ERRNO));
> -			} else {
> -				tst_resm(TPASS,
> -					 "lseek(%s, %d, %d) returned %ld",
> -					 Fname, offset, Whence[ind],
> -					 TEST_RETURN);
> -			}
> -		}
> +	SAFE_READ(0, fd, &read_buf, sizeof(read_buf));
>  
> +	if (strcmp(read_buf, tc->exp_data)) {
> +		tst_res(TFAIL, "lseek(%d, %ld, %d) read incorrect data", fd,
> +			tc->off, tc->whence);
> +	} else {
> +		tst_res(TPASS, "lseek(%d, %ld, %d) read correct data", fd,
> +			tc->off, tc->whence);

I guess that the fd here is not that useful and it may be a bit better
to to translate the whence to its name, but that is very minor.

>  	}
> -
> -	cleanup();
> -	tst_exit();
>  }
>  
> -/***************************************************************
> - * setup() - performs all ONE TIME setup for this test.
> - ***************************************************************/
> -void setup(void)
> +static void setup(void)
>  {
> +	char write_buf[64];
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	strcpy(write_buf, "abcdefg");

There is no need for that. Just define the string and use sizeof instead
of strlen, i.e.

#define WRITE_STR "abcdefg"

...
	SAFE_WRITE(1, fd, WRITE_STR, sizeof(WRITE_STR) - 1);
...

Or use SAFE_FILE_PRINTF(), then open() the fd.

> -	TEST_PAUSE;
> +	fd = SAFE_OPEN("tmp_file", O_RDWR | O_CREAT, 0644);
>  
> -	tst_tmpdir();
> -
> -	sprintf(Fname, "tfile_%d", getpid());
> -	if ((Fd = open(Fname, O_RDWR | O_CREAT, 0700)) == -1) {
> -		tst_brkm(TBROK, cleanup,
> -			 "open(%s, O_RDWR|O_CREAT,0700) Failed, errno=%d : %s",
> -			 Fname, errno, strerror(errno));
> -	}
> +	SAFE_WRITE(1, fd, write_buf, strlen(write_buf));
>  }

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
