From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Jan 2017 13:19:47 +0100
Subject: [LTP] [PATCH 3/4] getcwd03.c: cleanup && convert to new API
In-Reply-To: <1483949756-8685-3-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1483949756-8685-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1483949756-8685-3-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170117121912.GE10880@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	char buf1[BUFSIZ], buf2[BUFSIZ];
> +	char link[BUFSIZ];
> +	char *res1;
> +	char *res2;
> +
> +	SAFE_CHDIR(dir1);
> +
> +	errno = 0;
> +	res1 = getcwd(buf1, sizeof(buf1));
> +	TEST_ERRNO = errno;
> +	if (res1 == NULL) {
> +		tst_res(TFAIL | TTERRNO, "getcwd() failed to "
> +			"get working directory of a directory");
> +		return;
>  	}
> -	cleanup();
>  
> -	tst_exit();
> -}
> +	SAFE_CHDIR("..");
> +	SAFE_CHDIR(dir2);
>  
> -void setup(void)
> -{
> -	/* FORK is set here because of the popen() call below */
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	errno = 0;
> +	res2 = getcwd(buf2, sizeof(buf2));
> +	TEST_ERRNO = errno;
> +	if (res2 == NULL) {
> +		tst_res(TFAIL | TTERRNO, "getcwd() failed to get "
> +			"working directory of a symbolic link");
> +		return;
> +	}
> +
> +	SAFE_CHDIR("..");
> +	SAFE_READLINK(dir2, link, sizeof(link));
> +
> +	if (strcmp(res1, res2)) {
> +		tst_res(TFAIL, "getcwd() got mismatched strings containing "
> +			"the pathname of the current working directory");
> +		return;
> +	}
>  
> -	TEST_PAUSE;
> +	if (strcmp(buf1, buf2)) {
> +		tst_res(TFAIL, "getcwd() got mismatched working directories");
> +		return;
> +	}
>  
> -	/* create a test directory and cd into it */
> -	tst_tmpdir();
> +	if (strcmp(link, SAFE_BASENAME(buf1))) {
> +		tst_res(TFAIL,
> +			"link information didn't match the working directory");
> +		return;
> +	}
> +
> +	tst_res(TPASS, "getcwd() succeeded");
>  }
>  
> -void cleanup(void)
> +static void setup(void)
>  {
> -	/* remove the test directory */
> -	tst_rmdir();
> +	SAFE_CHDIR("/tmp");

The test must use the test temporary directory to create files and/or
directories no exceptions. If you are afraid that the buffers for
strings will be too small why can't we just let the getcwd() allocate
the buffers dynamically?

-- 
Cyril Hrubis
chrubis@suse.cz
