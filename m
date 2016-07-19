From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Jul 2016 15:53:49 +0200
Subject: [LTP] [PATCH 1/3] syscall/kcmp*: Convert to new API
In-Reply-To: <1467803450-11622-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1467803450-11622-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160719135349.GE6409@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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

This SAFE_OPEN() has to be done in the test setup, otherwise it will
start to fail with large enough iteration (-i) parameter once the
maximal number of open files is reached.


The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
