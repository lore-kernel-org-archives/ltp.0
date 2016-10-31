From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 31 Oct 2016 12:35:05 +0100
Subject: [LTP] [PATCH 2/3] syscalls/umask02: Cleanup && Convert to new
	API
In-Reply-To: <1477882478-30693-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1477882478-30693-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1477882478-30693-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20161031113505.GH30590@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	for (umask(mskval++); mskval < 01000; mskval++) {
> +		TEST(umask(mskval));
> +		if (TEST_RETURN < 0) {
> +			tst_res(TFAIL | TTERRNO,
> +				"umask(%o) failed unexpectedly", mskval);
> +			return;
> +		}

Again umask() cannot fail this way. I guess that what we can do here is
to check that the return value is in a valid range, i.e.

if (TEST_RETURN < 0 || TEST_RETURN > 0777)
	tst_brk(TFAIL, "umask result outside range %i", TEST_RETURN);

> -		for (umask(++mskval), i = 1; mskval < 01000;
> -		     uret = umask(++mskval), i++) {
> -			if ((uret != mskval - 1) && (mskval != 0000)) {
> -				failcnt = 1;
> -				tst_resm(TFAIL, "umask(%d) returned bad mask "
> -					 "value %d.", mskval, uret);
> -			}
> +		if (TEST_RETURN != mskval - 1) {
> +			failflag = 1;
> +			tst_res(TFAIL, "umask(%o) returned %ld, expected %d",
> +				mskval, TEST_RETURN, mskval - 1);
>  		}
> -		if (!failcnt)
> -			tst_resm(TPASS, "All umask values return correct "
> -				 "values");
>  	}
> -	cleanup();
> -	tst_exit();
> -
> -}

-- 
Cyril Hrubis
chrubis@suse.cz
